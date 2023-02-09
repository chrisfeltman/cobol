       >>source format is free
identification division.
    program-id. alter-x.

procedure division.

    main.
        go to initial-target
    .

    alter-stuff.
        alter initial-target to proceed to yet-another-target
        go to  initial-target
    .

    initial-target.
        go to alternate-target
    .


    alternate-target.
        display "Alternate target"
        go to alter-stuff
    .


    yet-another-target.
        display "Yet another target"
        alter initial-target to proceed to the-exit
        go to initial-target
    .

    the-exit.
        display "Whew! Reached the exit!"
        stop run
    .

