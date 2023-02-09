       >>source format is free
identification division.
    program-id. query-vsam-stdin.

environment division.
    configuration section.
        repository.
            function all intrinsic.

    input-output section.
        file-control.	
            select names
            assign to './datafiles/names-vsam.dat'
            organization is indexed
            access mode is dynamic
            record key is names-id.

data division.
    file section.
        fd names.
            01 names-record.
                05 names-id pic 9(10).
                05 names-name pic X(20).
            
     working-storage section.
        01 user-input pic X(10).
        01 out-id pic Z(9)9.
        78 NOT-FOUND value -1.
     
procedure division.
    
    main.
        perform read-and-validate-input

        open input names    
        move user-input to names-id

        read names
            not invalid key
                perform rec-found
            invalid key
                perform rec-not-found       
        end-read
    
        close names
        goback
    .

    read-and-validate-input.
        accept user-input from argument-value
       
        if user-input equals spaces or trim(user-input) is not numeric 
            perform rec-not-found
            goback 
        end-if
        exit paragraph
    .

    rec-found.
         move names-id to out-id
         display "{" '"' "recId" '"' ":" trim(out-id) "," '"' "name" '"' ":" '"' trim(names-name) '"' "}" upon stdout   
         exit paragraph
    .

    rec-not-found.
        display '"null"' upon stdout
        move NOT-FOUND to return-code 
        exit paragraph
    .
