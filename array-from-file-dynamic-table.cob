       >>source format is free
identification division.
    program-id. array-from-file-dynamic.

environment division.
    input-output section.
        file-control.
            *> declare a file handle to read from 	
            select names
            assign to './names.dat'
            organization is line sequential.

data division.
    file section.

        *> file descriptor for names.dat
	    fd names.
	        01 name-from-file pic X(20).
            
     working-storage section.

        01 the-rec based.           *> value we will store in mem
            05 the-name pic X(20). 

        01 rec-count pic 9(9) value zero. *> # of records in the file
        01 array-base usage pointer value null.  *> start of mem buffer 
        01 rec-pointer usage pointer value null. *> scratchpad pointer
           
procedure division.

    main.
        perform init-array

        move array-base to rec-pointer     
        call "hello" using by content rec-pointer, by content rec-count end-call
        display spaces
        display "After call, rec-pointer is at " rec-pointer

        display spaces

        display "freeing memory at " array-base  
        free array-base         *> not strictly necessary
        
        exit program
    .

    init-array. *> init dynamic array from text file 

        *> pass one - just read file to end and count recs
        perform get-rec-count

        *> pass two - reopen file, allocate and populate the array 
        *> we need size of rec * rec-count bytes to hold the data

        allocate rec-count * length of the-rec characters 
            returning array-base

        *> use another pointer for working, we need to keep array-base
        set rec-pointer to array-base

        open input names

        perform until exit
            read names
                at end  
                    close names
                    exit perform
                not at end
                    *> dereference pointer
                    set address of the-rec to rec-pointer
                    *> copy value to mem buffer
                    move name-from-file to the-name
                    *> advance pointer to next rec slot
                    set rec-pointer up by length of the-rec      
            end-read

        end-perform

        exit paragraph
    .

    get-rec-count. *> must be a better way, this is quick and dirty
        
        move 0 to rec-count
        open input names

        perform until exit
            read names
                at end
                    close names
                    exit perform
                not at end
                    add 1 to rec-count
            end-read
        end-perform
        exit paragraph
    .

end program array-from-file-dynamic.

*>**********************************************************************
*> Sub-program to test processing dynamic array passed via a pointer 
*> and the length of the memory buffer
*>**********************************************************************

identification division.
    program-id. talker.
environment division.
    configuration section.
        repository.
            function all intrinsic.  *> for trim() function

data division.

    working-storage section.

      

        01 the-rec based.               *> represents record in mem
            05 the-name pic X(20) occurs 0 to 1000000 times 
                depending on rec-count indexed by rec-idx.
        
    linkage section.  *> here is where the passed params end up 

        01 rec-pointer usage pointer. *> passed pointer to data
        01 rec-count pic 9(9).        *> passed buffer length

procedure division using rec-pointer, rec-count.

    entry "hello" using rec-pointer, rec-count.

        perform foreach-loop
        goback
    .

    foreach-loop.

        *> just display some diagnostics for debug
       perform show-call-diagnostics

        *> set up to process mem array sequentially

        
        *> dereference the pointer
        set address of the-rec to rec-pointer 
        set rec-idx to 1

        *> foreaech
        perform rec-count times

            perform do-a-thing-with-each
            set rec-idx up by 1

        end-perform
        accept omitted
        exit paragraph
    .


    *> here is where you would do someting real with the data
    *> this is just a trivial example
    do-a-thing-with-each.
        
        display rec-pointer " -> Hello " trim(the-name(rec-idx)) "!" 
        exit paragraph
    .

    show-call-diagnostics.

        display spaces
        display "rec pointer: " rec-pointer
        display "rec-count: " rec-count
        display spaces
        exit paragraph
    .

end program talker.
