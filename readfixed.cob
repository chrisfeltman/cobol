       >>source format is free
identification division.
    program-id. readfixed.

environment division.
 configuration section.
        repository.
            function all intrinsic.
    input-output section.
        file-control.	
            select myfile
            assign to 'fixedwidth.txt'
            organization is line sequential.

            select recfile
            assign to 'fixedwidth.rec'
            organization is line sequential.

data division.
	file section.
	    fd myfile.
	    01 my-rec.
		    02 my-id pic X(37).
            02 my-age pic X(3).
            02 my-initial pic X(4).
            02 my-description pic X(40).
            02 my-nimbus pic X(6).

        fd recfile.
        01 recfile-rec pic X(256).


working-storage section.
    01 rec-count pic 9(5) value 0.
    01 argv pic X(4).
    01 recs-to-read pic 9(4).
    01 command pic X(300).
    01 sys-response pic X(1024).

    01 file-info.
        05 File-Size-In-Bytes PIC 9(18) COMP.
        05 Mod-DD PIC 9(2) COMP. *> Modification Time
        05 Mod-MO PIC 9(2) COMP.
        05 Mod-YYYY PIC 9(4) COMP. *> Modification Date
        05 Mod-HH PIC 9(2) COMP.
        05 Mod-MM PIC 9(2) COMP.
        05 Mod-SS PIC 9(2) COMP.
        05 FILLER PIC 9(2) COMP. *> Always 00
		
procedure division.

main.
    display "fixed file reader starting..."
    accept argv from argument-value
    move argv to recs-to-read
    if recs-to-read is not numeric
        display "Error:" space argv space "is not a number"
        stop run
    end-if

    open input myfile
    display "file open"
		
    perform until exit
        read myfile
		    not at end 
                add 1 to rec-count
                *>perform display-output
                *>perform put-to-redis-hash
                *>perform write-recfile-rec
                *>perform insert-sqlite-record
                perform insert-mongodb-record
                if rec-count greater than recs-to-read
                    exit perform
                end-if
            at end
                display "done"
                exit perform
	        end-read
    end-perform

	display "read " rec-count " records"			
	close myfile
    *>close recfile
				
    stop run
    .

    display-output.
        display "Record #" space rec-count
        display "Id: " my-id 
        display "Age: " my-age 
        display "Initial: " my-initial 
        display "Description: " my-description 
        display "Nimbus: " my-nimbus
        display " "
        exit paragraph
    .

    put-to-redis-hash.
        move spaces to command
        string "redis-cli hset cobol." my-id space "age" space "'"my-age"'" space "initial" space "'"my-initial"'" space
            "description" space "'"my-description"'" space "nimbus" space "'"my-nimbus"'" 
        into command

		call "SYSTEM" using command	 end-call
       
        exit paragraph
    .

    write-recfile-rec.
        move spaces to recfile-rec
        string "id: " trim(my-id) into recfile-rec
        write recfile-rec
        move spaces to recfile-rec
        string "age: " trim(my-age) into recfile-rec
        write recfile-rec
        move spaces to recfile-rec
        string "initial: " trim(my-initial) into recfile-rec
        write recfile-rec
        move spaces to recfile-rec
        string "description: " trim(my-description) into recfile-rec
        write recfile-rec
        move spaces to recfile-rec
        string "nimbus: " trim(my-nimbus) into recfile-rec
        write recfile-rec
        move spaces to recfile-rec
        string trim(" ") into recfile-rec
        write recfile-rec
        exit paragraph
    .

    confirm-sqlite-table-exists.
        move spaces to command
        string "sqlite3 fixedwidth.db ""create table if not exists cobol_norple(id text, age text, initial text, description text, nimbus text)"""
        into command
        call "SYSTEM" using command end-call
        exit paragraph
    .

    insert-sqlite-record.
        move spaces to command
        string "sqlite3 fixedwidth.db " """insert into cobol_norple(id, age, initial, description, nimbus) values"
        "('"my-id"','"my-age"','"my-initial"','"trim(my-description)"','"my-nimbus"')"""
        into command
        display command
        call "SYSTEM" using command end-call
        exit paragraph
    .

    insert-mongodb-record.
        move spaces to command
        string "mongo --quiet --eval 'db.norple.insertOne({_id: """my-id""", age: """my-age""", initial:"""my-initial""","
        "description:"""trim(my-description)""", nimbus:"""my-nimbus"""})' cobol"
        into command
        display command
        call "SYSTEM" using command end-call
        exit paragraph
    .

    check-recfile-exists.
        call "CBL_CHECK_FILE_EXIST" using 'fixedwidth.rec', file-info end-call
        if return-code not equal to 0
            display "recfile does not exist, creating it"
            open output recfile
            move "%rec: cobol_norple" to recfile-rec
            write recfile-rec 
        else
            open extend recfile
            display "recfile exists, will append to it"
        end-if
    exit paragraph
    .






