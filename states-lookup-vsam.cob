       >>source format is free
identification division.
    program-id. states-lookup-vsam.

environment division.
    input-output section.
        file-control.	
          
            select states
            assign to '/mnt/x/states-lookup.db'
            organization is indexed
            access mode is dynamic
            record key is state-code.

data division.
    file section.

        fd states.
            01 states-rec.
                05 state-code pic X(2).
                05 state-name pic X(20). 

     

    working-storage section.
        01 state-abbr pic X(2).  
        01 user-input pic X(4096).

    linkage section.
        01 retval pic X(20). 
          

procedure division.

    main.
        open input states
        accept user-input from argument-value
        move user-input (1:2) to state-code
        
        read states
            invalid key
                move 1 to return-code 
            not invalid key
                display function trim(state-name) upon stdout
                *>move state-name to retval
        
        end-read
        close states
     
        goback
    .

