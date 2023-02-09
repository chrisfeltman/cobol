       >>source format is free
identification division.
    program-id. array-from-file.

environment division.
    input-output section.
        file-control.	
            select names
            assign to './names.dat'
            organization is line sequential.

data division.
    file section.

	    fd names.
	        01 name-from-file pic X(20).
            
     working-storage section.

        *> this is dumb, the array is not really dynamic because it expects the worst-case scenario, 
        *> and allocates enough memory to hold it
        *> only way to really be dynamic is to read from the file and store values in a linked list
        *> on the heap .. I will do that next 

        01 people-table.
            05 the-name pic X(20) 
                occurs 0 to 13421772 times  *> max table size allowed / 20 byte rec size
                depending on rec-count. 

        01 rec-count pic 9(3) value zero.
           

procedure division.

    main.
        perform init-array
        call "talker" using by reference people-table, rec-count end-call
        display spaces
        call "goodbye" using  by reference people-table, rec-count end-call
        accept omitted
        exit program
    .

    init-array. *> init dynamic array from text file 

        open input names

        perform until exit
            read names
                at end  
                     close names
                    exit perform
                not at end
                    add 1 to rec-count
                    move name-from-file to the-name(rec-count)
            end-read

        end-perform

        exit paragraph
    .
end program array-from-file.


identification division.
    program-id. talker.
environment division.
    configuration section.
        repository.
            function all intrinsic.

data division.
    linkage section.

        *> using an index for the table here for speed, extra overhead 
        *> of managing the index maybe not justified in the caller since we had to already calc rec-count
        01 people-table.
            05 the-name pic X(20)  occurs 0 to 13421772 times  *> max table size allowed
                depending on rec-count  
                indexed by idx.  

        01 rec-count pic 9(3).

procedure division using people-table, rec-count.

    entry "hello" using people-table.
        perform varying idx from 1 by 1 until idx is greater than rec-count
            display "Hello, " trim(the-name(idx)) "!"
        end-perform
        exit paragraph
    .

    entry "goodbye" using people-table, rec-count.  
         perform varying idx from 1 by 1 until idx is greater than rec-count
            display "Goodbye, " trim(the-name(idx)) "!"
        end-perform
        exit paragraph
    .
end program talker.
