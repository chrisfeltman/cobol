       >>source format is free
identification division.
    program-id. query-vsam.

environment division.
    configuration section.
        repository.
            function all intrinsic.

    input-output section.
        file-control.	
            select names-vsam
            assign to './datafiles/names-vsam.dat'
            organization is indexed
            access mode is dynamic
            record key is names-id.

data division.
    file section.
        fd names-vsam.
            01 vsam-rec.
                05 names-id pic 9(10).
                05 out-name pic X(20).
            
     working-storage section.
        01 user-input pic X(10).
        01 out-id pic Z(10).

         01 WS-CURRENT-DATE-DATA.
           05  WS-CURRENT-DATE.
               10  WS-CURRENT-YEAR         PIC 9(04).
               10  WS-CURRENT-MONTH        PIC 9(02).
               10  WS-CURRENT-DAY          PIC 9(02).
           05  WS-CURRENT-TIME.
               10  WS-CURRENT-HOURS        PIC 9(02).
               10  WS-CURRENT-MINUTE       PIC 9(02).
               10  WS-CURRENT-SECOND       PIC 9(02).
               10  WS-CURRENT-MILLISECONDS PIC 9(02).

            
       
procedure division.

    main.
        open input names-vsam
        perform forever
            display "Enter a rec id (x to exit): " with no advancing
            accept user-input
           
            if trim(user-input) equals 'x'
               exit perform
            end-if
            
            if  trim(user-input) is numeric
                
                move user-input to names-id
                move current-date to ws-current-date-data
                display "Before read: " ws-current-time
                
                read names-vsam
                    invalid key
                        display "key: " names-id " not found!"
                    not invalid key
                        display "key: " names-id " name: " out-name
                        *> output JSON
                        move current-date to WS-CURRENT-DATE-DATA
                        display "After read: " ws-current-time
                        move names-id to out-id
                        display "JSON Value: " "{" '"' "recId" '"' ":" trim(out-id) "," '"' "name" '"' ":" '"' trim(out-name) '"' "}" upon stdout   
                end-read
               
            else
                display "key is not numeric!"
            end-if
        end-perform
        close names-vsam
        goback
    .

