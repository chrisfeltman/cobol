       >>source format is free
identification division.
    program-id. readitemsnaive.

environment division.
 configuration section.
        repository.
            function all intrinsic.
    input-output section.
        file-control.	
            select itemfile
            assign to '../items.dat'
            organization is line sequential.
            select outputfile
            assign to '../output.dat'
            organization is line sequential.

data division.
	file section.
	    fd itemfile.
	    01 item-rec.
		    02 nsn pic X(13).
            02 tamcn pic X(12).
            02 serial pic X(18).
            02 nomen pic X(19).
            02 commodity pic X(10).
            02 rate pic 9(10).

        fd outputfile.
        01 output-rec.
            02 output-text pic X(128).
            
working-storage section.
    01 rec-count pic 9(5) value 0.
    01 tamcn-count pic 9(5) value 0.
    01 current-tamcn pic X(12) value spaces.
    01 rate-total pic 9(10)  value 0.
    01 output-total pic 9(8).99 usage display.

    01 tamcn-flag pic 9(1) value 0.
        88 tamcn-found value 1 false 0.
    
        
    
    01 tamcn-table occurs 10000 times indexed by tamcn-idx.
        02 nsn pic X(13).
        02 tamcn pic X(12).
        02 serial pic X(18).
        02 nomen pic X(19).
        02 commodity pic X(10).
        02 rate pic 9(10).

 		
procedure division.

main.
    
   
    

    if tamcn-found
        display "found tamcn in table!"
    end-if

    display "Item reader starting..."
   
    open input itemfile
    display "input file open"
    open output outputfile
    display "output file open"

    read itemfile
        not at end
            move tamcn in item-rec to current-tamcn 
            add rate  in item-rec to rate-total  
        at end
            display "no records to read!"
            stop run
    end-read

    add 1 to rec-count
    add 1 to tamcn-count
		
    perform until exit
        read itemfile
		    not at end 
                if tamcn in item-rec not equal to current-tamcn 
                    display "new tamcn, writing total for tamcn " current-tamcn " " tamcn-count " $" rate-total
                    perform write-tally-rec
                    move tamcn in item-rec to current-tamcn
                    move 0 to tamcn-count
                    move 0 to rate-total 
                    
                end-if

            at end
                exit perform
	        end-read
            add 1 to rec-count
            add 1 to tamcn-count
            add rate in item-rec to rate-total
    end-perform

    display "writing total for tamcn " current-tamcn " " tamcn-count " $" rate-total
    perform write-tally-rec

    display "done"
	display "read " rec-count " records"			
	close itemfile
    close outputfile			
    stop run
.

display-output.
    display "Record #" space rec-count
    display "nsn: " trim(nsn in item-rec) 
    display "tamcn: " trim(tamcn in item-rec) 
    display "serial: " trim(serial in item-rec) 
    display "nomen: " trim(nomen in item-rec) 
    display "commodity: " trim(commodity in item-rec)
    display "rate:" rate in item-rec
    display " "
    exit paragraph
.

write-tally-rec.
    move spaces to output-text
    move rate-total to output-total
    string current-tamcn X'09' tamcn-count  X'09' output-total into output-text
    write output-rec  
.

*> Have we seen this tamcn before? 
seek-tamcn.
    set tamcn-found to false
    perform varying tamcn-idx from 1 by 1 until tamcn in tamcn-table(tamcn-idx) equals spaces 
        if tamcn of tamcn-table(tamcn-idx) equals tamcn in item-rec
            set tamcn-found to true
            exit perform
        end-if
    end-perform
.

  






