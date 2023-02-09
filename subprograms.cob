       >>source format is free
identification division.
    program-id. sub-driver.

data division.
     working-storage section.
        01 people-table.
            05 the-name pic X(20) occurs 10 times indexed by idx.

procedure division.

    main.
        perform init-array
        call "talker" using by reference people-table end-call
        display spaces
        call "goodbye" using  by reference people-table end-call
        exit program
    .

    init-array.

        set idx to 1

        move "Kevin" to the-name(idx)
        set idx up by 1
    
        move "Susan" to the-name(idx)
        set idx up by 1
    
        move "Fred" to the-name(idx)
        set idx up by 1
   
        move "Steve" to the-name(idx)
        set idx up by 1

        move "Belinda" to the-name(idx)
        set idx up by 1

        move "Rohit" to the-name(idx)
        set idx up by 1

        move "Mary" to the-name(idx)
        set idx up by 1

        move "Kyle" to the-name(idx)
        set idx up by 1

        move "Ashley" to the-name(idx)
        set idx up by 1

        move "Petunia" to the-name(idx)
        exit paragraph
    .
end program sub-driver.


identification division.
    program-id. talker.
environment division.
    configuration section.
        repository.
            function all intrinsic.

data division.
    linkage section.
        01 people-table.
            05 the-name pic X(20) occurs 10 times indexed by idx.

procedure division using people-table.

    entry "hello" using people-table.
        perform varying idx from 1 by 1 until idx is greater than 10
            display "Hello, " trim(the-name(idx)) "!"
        end-perform
        exit paragraph
    .

    entry "goodbye" using people-table.  
         perform varying idx from 1 by 1 until idx is greater than 10
            display "Goodbye, " trim(the-name(idx)) "!"
        end-perform
        exit paragraph
    .
end program talker.
