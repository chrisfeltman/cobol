       >>source format is free
identification division.
    program-id. linkedlistbetter.

environment division.
 configuration section.
        repository.
            function all intrinsic.
 data division.
     working-storage section.

		01 the-rec based.  									*> based indeed, LOL... can change address 
            05 the-name pic X(15) value is spaces.
            05 the-count pic 9(4) value is zero.
            05 next-rec usage pointer value is null.
		
		01 rec-size pic 9(4) value is length of the-rec.   *> # of bytes to allocate for each node
        01 list-head usage pointer value is null.			*> pointer to head of list
        01 rec-pointer usage pointer value is null.			*> used to capture return value from create-list-node
		
		01 sum-of-count pic 9(4) value is zero.				*> used to calculate the sum of counts when walking the list

        procedure division.

        main.

			display "Adding nodes to the list..."
			display spaces
			
			perform allocate-list          *> allocate-list creates the inital node and sets list-head to its address
			move "Mumbles" to the-name
			move 7 to the-count

			perform create-list-node		*> create-list-node sets next-rec of current the-rec to the address of new node before setting the-rec to it
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
            move 1 to the-count

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
            move 1 to the-count

            perform create-list-node
            move "Frank" to the-name
            move 200 to the-count
            
			display spaces
            perform walk-list   *> let's try walking the dawg here and adding up them counts
            perform free-list

            display spaces
            display "All nodes freed, exiting run"
            stop run
        .

        allocate-list.		*> create the initial node
           
            allocate rec-size characters initialized returning list-head
			display "Allocated " rec-size " bytes @" list-head 
			set address of the-rec to list-head
            exit paragraph
        .

        create-list-node.	*> create a new node and save the address in the previous node
           
            allocate rec-size characters initialized returning rec-pointer
			display "Allocated " rec-size " bytes @" rec-pointer
            move rec-pointer to next-rec
			set address of the-rec to rec-pointer
            exit paragraph
        .

        walk-list.    *> walk the linked list and sum the counts
		
            display "walking the list and summing counts..."
            display spaces
     
            set address of the-rec to list-head
			move zero to sum-of-count
			
            perform until exit            
                display "Name: " the-name " Count: " the-count " Next rec @" next-rec
				add the-count to sum-of-count
                if next-rec equals null
					display "End of list"
                    exit perform
                end-if
                set address of the-rec to next-rec   
            end-perform
			
			display spaces
			display "sum of counts was " sum-of-count
            exit paragraph
        .

        free-list.             *> free the memory we have allocated
		
            display spaces
            display "freeing the list..."
            display spaces
           
            move list-head to rec-pointer
            set address of the-rec to rec-pointer
			
            perform until exit 
			
				if rec-pointer equals null    
					display "End of list"
                    exit perform
                end-if
				
                display "Freeing Node @" rec-pointer": Name: " the-name " Count: " the-count " Next rec @" next-rec
				
				*> important! must save address of the next record before freeing the node, accessing it after free is undefined behavior
				*> and may cause a segmentation fault, even though the address of the-rec hasn't moved yet! 
				*> the entire block might be overwritten by the OS with garbage between the time free completes and you try to read it!
				
                move next-rec to rec-pointer 
                free the-rec
                set address of the-rec to rec-pointer  *> move the-rec to the next node address
				
            end-perform
            exit paragraph
        .

