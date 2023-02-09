       >>source format is free
identification division.
    program-id. stackeater.

environment division.
 configuration section.
        repository.
            function all intrinsic.
data division.
     working-storage section.

        01 rec-pointer usage pointer value null.

procedure division.

        main.

            display "I am the Stackasaurus! I'm going to eat your entire stack!"
            display spaces
            call "C$SLEEP" using 2 end-call

            perform eatstack
            goback
        .

        eatstack.
            display "Eating the stack... YUM!"
            perform eatstack
        .

           

