       >>source format is free
identification division.
    program-id. sequenntial-to-index.

environment division.
    input-output section.
        file-control.	
            select names
            assign to './names.dat'
            organization is line sequential.

            select names-vsam
            assign to './datafiles/names-vsam.dat'
            organization is indexed
            access mode is sequential
            record key is names-id.

data division.
    file section.

	    fd names.
	        01 name-from-file pic X(20).

        fd names-vsam.
            01 vsam-rec.
                05 names-id pic 9(10).
                05 out-name pic X(20).
            
     working-storage section.
        01 sequence-num pic 9(10) value zero.
           

procedure division.

    main.
      open input names
      open output names-vsam
      perform until exit
        read names
            at end
                close names
                close names-vsam
                exit perform
            not at end
                move sequence-num to names-id
                move name-from-file to out-name
                write vsam-rec
                add 1 to sequence-num
        end-read

      end-perform
      stop run
    .

