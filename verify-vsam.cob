       >>source format is free
identification division.
    program-id. verify-vsam.

environment division.
    input-output section.
        file-control.	
            select names-vsam
            assign to './datafiles/names-vsam.dat'
            organization is indexed
            access mode is sequential
            record key is names-id.

data division.
    file section.

        fd names-vsam.
            01 vsam-rec.
                05 names-id pic 9(10).
                05 out-name pic X(20).
            
     working-storage section.
       
procedure division.

    main.
   
        open input names-vsam
        perform until exit
            read names-vsam
                at end
                    close names-vsam
                    exit perform
                not at end
                    display "key: " names-id " name: " out-name
            end-read

        end-perform
        goback
    .

