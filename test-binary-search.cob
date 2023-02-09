       >>source format is free
identification division.
    program-id. test-binary-search.

environment division.
 configuration section.
        repository.
         
            function all intrinsic.
            
data division.
     working-storage section.
        01 WS-start-time.
           05  WS-CURRENT-DATE.
               10  WS-CURRENT-YEAR         PIC 9(04).
               10  WS-CURRENT-MONTH        PIC 9(02).
               10  WS-CURRENT-DAY          PIC 9(02).
           05  WS-CURRENT-TIME.
               10  WS-CURRENT-HOURS        PIC 9(02).
               10  WS-CURRENT-MINUTE       PIC 9(02).
               10  WS-CURRENT-SECOND       PIC 9(02).
               10  WS-CURRENT-MILLISECONDS PIC 9(02).

         01 WS-stop-time.
           05  WS-CURRENT-DATE.
               10  WS-CURRENT-YEAR         PIC 9(04).
               10  WS-CURRENT-MONTH        PIC 9(02).
               10  WS-CURRENT-DAY          PIC 9(02).
           05  WS-CURRENT-TIME.
               10  WS-CURRENT-HOURS        PIC 9(02).
               10  WS-CURRENT-MINUTE       PIC 9(02).
               10  WS-CURRENT-SECOND       PIC 9(02).
               10  WS-CURRENT-MILLISECONDS PIC 9(02).


        01 state-code-param pic X(2). 
        01 return-value pic X(20) value spaces. 
        01 loop-count pic 9(13) value zero. 

        01 test-iterations pic 9(13) value 10000000. 
        01 time-elapsed-seconds pic 9(13) usage comp.

procedure division.

        main.
           
           
            call "states-lookup-module" end-call  *> just to initialize the module

            move current-date to ws-start-time
            move 0 to loop-count
            perform table-lookup test-iterations times   *> do the table lookup test
            move current-date to ws-stop-time

            compute time-elapsed-seconds = 

             ((ws-current-minute of ws-stop-time * 60) + 
                (ws-current-second of ws-stop-time))
                - 
                ((ws-current-minute of ws-start-time * 60) + 
                (ws-current-second of ws-start-time))
                
               
            display "table lookup done. Performed " loop-count space "iterations."
            display "Time elapsed (s) " time-elapsed-seconds
            
           
            
            move 0 to loop-count
            move current-date to ws-start-time
           
            perform vsam-lookup test-iterations times     *> do the VSAM file in RAMDisk test
            move current-date to ws-stop-time
            compute time-elapsed-seconds = 

             ((ws-current-minute of ws-stop-time * 60) + 
                (ws-current-second of ws-stop-time))
                - 
                ((ws-current-minute of ws-start-time * 60) + 
                (ws-current-second of ws-start-time))
                
            display "RAMdisk lookup done. Performed " loop-count space "iterations."
    
            display "Time elapsed (s) " time-elapsed-seconds
            
            call "release-module"   *> just so we can close the VSAM file cleanly 
            goback
        .

        table-lookup.
             
             move spaces to return-value
             move "WY" to state-code-param
             call "states-lookup" using by content state-code-param, by reference return-value end-call
             *>display "Return value: " return-value

             if trim(return-value) not equal to "Wyoming"
                display "got bad value on WY"
             end-if

             move spaces to return-value
             move "KY" to state-code-param
             call "states-lookup"  using by content state-code-param, by reference return-value end-call
             *>display "Return value: " return-value
             if trim(return-value) not equal to "Kentucky"
                display "got bad value on KY"
             end-if
        
             move spaces to return-value
             move "WI" to state-code-param
             call "states-lookup"  using by content state-code-param, by reference return-value end-call
             *>display "Return value: " return-value
             if trim(return-value) not equal to "Wisconsin"
                display "got bad value on WI"
             end-if

             move spaces to return-value
             move "AK" to state-code-param
             call "states-lookup"  using by content state-code-param, by reference return-value end-call
             if trim(return-value) not equal to "Alaska"
                display "got bad value on AK"
             end-if
             *>display "Return value: " return-value

             move spaces to return-value
             move "VV" to state-code-param
             call "states-lookup"  using by content state-code-param, by reference return-value end-call

             if return-value not equal to spaces 
                display "got bad value on VV"
             end-if

             add 1 to loop-count
             
             exit paragraph
        .

        vsam-lookup.   
                
            move spaces to return-value
            move "WY" to state-code-param
            call "states-lookup-vsam" using by content state-code-param, by reference return-value end-call
            *>display "Return value: " return-value
             if trim(return-value) not equal to "Wyoming"
                display "got bad value on WY"
             end-if

            move spaces to return-value
            move "KY" to state-code-param
            call "states-lookup-vsam"  using by content state-code-param, by reference return-value end-call
            *>display "Return value: " return-value
            if trim(return-value) not equal to "Kentucky"
                display "got bad value on KY"
             end-if
        
            move spaces to return-value
            move "WI" to state-code-param
            call "states-lookup-vsam"  using by content state-code-param, by reference return-value end-call
            *>display "Return value: " return-value
            if trim(return-value) not equal to "Wisconsin"
                display "got bad value on WI"
             end-if

            move spaces to return-value
            move "AK" to state-code-param
            call "states-lookup-vsam"  using by content state-code-param, by reference return-value end-call
            *>display "Return value: " return-value
            if trim(return-value) not equal to "Alaska"
                display "got bad value on AK"
             end-if

            move spaces to return-value
            move "VV" to state-code-param   *> deliberate bad value
            call "states-lookup-vsam"  using by content state-code-param, by reference return-value end-call
            if return-value not equal to spaces 
                display "got bad value on VV"
            end-if

            add 1 to loop-count
            exit paragraph
        .

           

        

       
           

