       >>source format is free

       identification division.
       program-id. readfifo.

       environment division.
	    input-output section.
	    file-control.	
		select fifo
		assign to '/usr/pipes/cobolin'
		organization is line sequential.

        select fifo-out
        assign to '/usr/pipes/cobolout'
        organization is line sequential.

        data division.
	file section.

	    fd fifo.
	    01 pipe-rec.
		    02 the-data pic X(256).

        	fd fifo-out.
        	01 pipe-out-rec.
            		02 the-output-data pic X(128).

        working-storage section.
		01 number-of-records pic 9(3) value 0.
		
          

        procedure division.

	    display "Pipe reader starting..."
		
	        perform forever
            
                display "sending command"
                move "lrange mylist 0 -1" to pipe-out-rec
				open output fifo-out
                write pipe-out-rec
				close fifo-out
              


				open input fifo
				
                display "waiting for data..."
				read fifo
				display "I read" the-data
				move the-data to number-of-records
				
				
				display "reading " number-of-records " records"
                perform number-of-records times
                    read fifo
		                not at end
                            display "received data"
                            display function trim(the-data)
							

                        at end
							
                            display "got EOF"
                            exit perform
	                end-read

                end-perform
				display "closing fifo"
				*>close fifo
				
            end-perform
            
           
        stop run
        .

