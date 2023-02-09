       >>source format is free
identification division.
    program-id. procedurepointer.

environment division.
 configuration section.
        repository.
            function all intrinsic.
 data division.
     working-storage section.

		01 proc-pointer usage is procedure-pointer.
     
      procedure division.
		
		main.
			set proc-pointer to entry "called-proc"
			display "calling proc @" proc-pointer
			display spaces
			
			perform 10 times
				call "called-proc" using proc-pointer
			end-perform
			
			display spaces
			
			set proc-pointer to entry "alternate"
			display "calling proc @" proc-pointer
			display spaces
			
			perform 10 times
				call "alternate" using proc-pointer
			end-perform
		.
	
end program procedurepointer.
		
		
identification division.
    program-id. called-proc.
	
procedure division.
		main.
		
			display "I've been called by a procedure pointer"
			exit paragraph
		.
		
		
		entry "alternate".
			display "I've also been called by a procedure pointer"
			exit paragraph
		.
		
		
end program called-proc.