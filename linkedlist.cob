       >>source format is free
identification division.
    program-id. linkedlist.

environment division.
 configuration section.
        repository.
            function all intrinsic.
 data division.
     working-storage section.

		01 the-rec based.  *> based indeed, LOL... can change address 
            05 the-name pic X(15).
            05 the-count pic 9(4).
            05 next-rec usage pointer value null.
		 
        01 list-head usage pointer value null.
        01 the-next-rec usage pointer value null.
        01 rec-pointer usage pointer value null.

        procedure division.

        main.

            perform allocate-list

            display "Adding nodes to the list..."
            display " "

            move "Anthony" to the-name
            move 1 to the-count

            perform create-list-node
            move "Susan" to the-name
            move 3 to the-count

            perform create-list-node
            Move "Billiam" to the-name
            move 17 to the-count

            perform create-list-node
            move "Melissa" to the-name
            move 31 to the-count

            perform create-list-node
            move "Scott" to the-name
            move 1 to the-count

            perform create-list-node
            move "Evangeline" to the-name
            move 12 to the-count

            perform create-list-node
            move "Peter" to the-name
            move 0 to the-count

            perform create-list-node
            move "Jennifer" to the-name
            move 69 to the-count

            perform create-list-node
            move "Stephen" to the-name
            move 40 to the-count

            perform create-list-node
            move "Crystal" to the-name
            move 22 to the-count

            perform create-list-node
            move "Mathias" to the-name
            move 58 to the-count

            perform create-list-node
            move "Linda" to the-name
            move 0 to the-count

            perform create-list-node
            move "Frank" to the-name
            move 200 to the-count
            
            perform walk-list   *> let's try walking the dawg here
            perform free-list

            display " "
            display "All nodes freed, exiting run"
            stop run
        .

        allocate-list.
            *> create the initial node
            allocate the-rec returning list-head
            move list-head to rec-pointer
            display "List head @" list-head
            display " "
            exit paragraph
        .

        create-list-node.
            *> create a new node and save the address in the previous node
            allocate the-rec returning the-next-rec
            set address of the-rec to rec-pointer
            move the-next-rec to next-rec
            set address of the-rec to the-next-rec
            move the-next-rec to rec-pointer
            exit paragraph
        .


        walk-list.
            display "walking the list..."
            display " "
     
            set address of the-rec to list-head
            perform until exit            
                display "Name: " the-name " Count: " the-count " Next rec @" next-rec
                if next-rec equals null
                    exit perform
                end-if
                set address of the-rec to next-rec   
            end-perform
            exit paragraph
        .

        free-list.
            display " "
            display "freeing the list..."
            display " "
           
            move list-head to rec-pointer
            set address of the-rec to rec-pointer
            perform until exit            
                display "Freeing Node @" rec-pointer": Name: " the-name " Count: " the-count " Next rec @" next-rec
                move next-rec  to the-next-rec
                free rec-pointer
            
                set address of the-rec to the-next-rec
                
                 if next-rec equals null    
                    exit perform
                end-if
               
                move the-next-rec to rec-pointer
            end-perform
            exit paragraph
        .

