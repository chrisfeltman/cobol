       >>source format is free
identification division.
    program-id. heapgobblin.

environment division.
 configuration section.
        repository.
            function all intrinsic.
data division.
     working-storage section.

        01 rec-pointer usage pointer value null.

procedure division.

        main.

            display "I am the heap goblin... I'm gonna gobble up your heap!"
            display spaces
            call "C$SLEEP" using 2 end-call

            perform until exit
                allocate 1024 * 1024 * 100 characters returning rec-pointer
                if rec-pointer equals null
                    display "MWAHAHAHA! Your heap is all gone!"
                    exit perform
                end-if
                display "OMNOMNOM! Gobbled 100MB of the heap @" rec-pointer
            end-perform

        .

           

