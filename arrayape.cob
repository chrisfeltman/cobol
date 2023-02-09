       >>source format is free
identification division.
    program-id. arrayape.

environment division.
 configuration section.
        repository.
            function all intrinsic.
data division.
     working-storage section.
        *>01 idx pic 9(9).
        01 latrine-table. 
            05 latrine pic X(30) occurs 10 times indexed by idx.

procedure division.
    main.
        move 1 to idx
        display "OOK! OOK! I am the Array Ape! I'm going to poop all over working storage!"
        display spaces
        call "C$SLEEP" using 2 end-call

        *>move 1 to idx
        
        perform forever
            move "GIANTTURDGIANTTURDGIANTTURD" to latrine(idx)
            display "OOK! OOOK! Dropped a Duke! @ array index " idx
            set idx up by 1
        end-perform
    .

       
           

