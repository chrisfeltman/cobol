       >>source format is free
identification division.
    program-id. states-lookup-module.
environment division.
    input-output section.
        file-control.	
          
          *>  File is on RamDisk
            select states 
            assign to '/mnt/ramdisk/states-lookup.db'
            organization is indexed
            access mode is dynamic
            record key is state-code.

data division.
     file section.

        fd states is external.
            01 vsam-states-rec.
                05 state-code pic X(2).
                05 state-name pic X(20). 
  
    working-storage section.

        01 states-table is external.
            05 states-rec occurs 51 times 
                ascending key is state-code
                indexed by states-idx.

                10 state-code pic X(2).
                10 state-name pic X(20).
                10 fips-code  pic X(2).  

procedure division.

    init.
        
            set states-idx to 1
            move "AK" to state-code of states-rec(states-idx)
            move "Alaska" to state-name of states-rec(states-idx)
            move "02" to fips-code of states-rec(states-idx)
            set states-idx up by 1

            move "AL" to state-code of states-rec(states-idx)
            move "Alabama" to state-name  of states-rec(states-idx)
            move "01" to fips-code of states-rec(states-idx)
            set states-idx up by 1

            move "AR" to state-code of states-rec(states-idx)
            move "Arkansas" to state-name of states-rec(states-idx)
            move "05" to fips-code of states-rec(states-idx)
            set states-idx up by 1

            move "AZ" to state-code of states-rec(states-idx)
            move "Arizona" to state-name of states-rec(states-idx)
            move "04" to fips-code of states-rec(states-idx)
            set states-idx up by 1

            move "CA" to state-code of states-rec(states-idx)
            move "California" to state-name of states-rec(states-idx)
            move "06" to fips-code of states-rec(states-idx)
            set states-idx up by 1

            move "CO" to state-code of states-rec(states-idx)
            move "Colorado" to state-name of states-rec(states-idx)
            move "08" to fips-code of states-rec(states-idx)
            set states-idx up by 1

            move "CT" to state-code of states-rec(states-idx)
            move "Connecticut" to state-name of states-rec(states-idx)
            move "09" to fips-code of states-rec(states-idx)
            set states-idx up by 1

            move "DC" to state-code of states-rec(states-idx)
            move "District of Columbia" to state-name of states-rec(states-idx)
            move "11" to fips-code of states-rec(states-idx)
            set states-idx up by 1

            move "DE" to state-code of states-rec(states-idx)
            move "Delaware" to state-name of states-rec(states-idx)
            move "10" to fips-code of states-rec(states-idx)
            set states-idx up by 1

            move "FL" to state-code of states-rec(states-idx)
            move "Florida" to state-name of states-rec(states-idx)
            move "12" to fips-code of states-rec(states-idx)
            set states-idx up by 1

            move "GA" to state-code of states-rec(states-idx)
            move "Georgia" to state-name of states-rec(states-idx)
            move "13" to fips-code of states-rec(states-idx)
            set states-idx up by 1

            move "HI" to state-code of states-rec(states-idx)
            move "Hawaii" to state-name of states-rec(states-idx)
            move "15" to fips-code of states-rec(states-idx)
            set states-idx up by 1

            move "IA" to state-code of states-rec(states-idx) 
            move "Iowa" to state-name of states-rec(states-idx)
            move "19" to fips-code of states-rec(states-idx)
            set states-idx up by 1

            move "ID" to state-code of states-rec(states-idx)
            move "Idaho" to state-name of states-rec(states-idx)
            move "16" to fips-code of states-rec(states-idx)
            set states-idx up by 1

            move "IL" to state-code of states-rec(states-idx)
            move "Illinois" to state-name of states-rec(states-idx)
            move "17" to fips-code of states-rec(states-idx)
            set states-idx up by 1

            move "IN" to state-code of states-rec(states-idx)
            move "Indiana" to state-name of states-rec(states-idx)
            move "18" to fips-code of states-rec(states-idx)
            set states-idx up by 1

            move "KS" to state-code of states-rec(states-idx)
            move "Kansas" to state-name of states-rec(states-idx)
            move "20" to fips-code of states-rec(states-idx)
            set states-idx up by 1

            move "KY" to state-code of states-rec(states-idx)
            move "Kentucky" to state-name of states-rec(states-idx)
            move "21" to fips-code of states-rec(states-idx)
            set states-idx up by 1

            move "LA" to state-code of states-rec(states-idx)
            move "Louisiana" to state-name of states-rec(states-idx)
            move "22" to fips-code of states-rec(states-idx)
            set states-idx up by 1

            move "MA" to state-code of states-rec(states-idx)
            move "Massachusetts" to state-name of states-rec(states-idx)
            move "25" to fips-code of states-rec(states-idx)
            set states-idx up by 1

            move "MD" to state-code of states-rec(states-idx)
            move "Maryland" to state-name of states-rec(states-idx)
            move "24" to fips-code of states-rec(states-idx)
            set states-idx up by 1

            move "ME" to state-code of states-rec(states-idx)
            move "Maine" to state-name of states-rec(states-idx)
            move "23" to fips-code of states-rec(states-idx)
            set states-idx up by 1

            move "MI" to state-code of states-rec(states-idx)
            move "Michigan" to state-name of states-rec(states-idx)
            move "26" to fips-code of states-rec(states-idx)
            set states-idx up by 1

            move "MN" to state-code of states-rec(states-idx)
            move "Minnesota" to state-name of states-rec(states-idx)
            move "27" to fips-code of states-rec(states-idx)
            set states-idx up by 1

            move "MO" to state-code of states-rec(states-idx)
            move "Missouri" to state-name of states-rec(states-idx)
            move "29" to fips-code of states-rec(states-idx)
            set states-idx up by 1
            

            move "MS" to state-code of states-rec(states-idx)
            move "Mississippi" to state-name of states-rec(states-idx)
            move "28" to fips-code of states-rec(states-idx)
            set states-idx up by 1

            move "MT" to state-code of states-rec(states-idx)
            move "Montana" to state-name of states-rec(states-idx)
            move "30" to fips-code of states-rec(states-idx)
            set states-idx up by 1

            move "NC" to state-code of states-rec(states-idx)
            move "North Carolina" to state-name of states-rec(states-idx)
            move "37" to fips-code of states-rec(states-idx)
            set states-idx up by 1

            move "ND" to state-code of states-rec(states-idx)
            move "North Dakota" to state-name of states-rec(states-idx)
            move "38" to fips-code of states-rec(states-idx)
            set states-idx up by 1

            move "NE" to state-code of states-rec(states-idx)
            move "Nebraska" to state-name of states-rec(states-idx)
            move "31" to fips-code of states-rec(states-idx)
            set states-idx up by 1

            move "NH" to state-code of states-rec(states-idx)
            move "New Hampshire" to state-name of states-rec(states-idx)
            move "33" to fips-code of states-rec(states-idx)
            set states-idx up by 1

            move "NJ" to state-code of states-rec(states-idx)
            move "New Jersey" to state-name of states-rec(states-idx)
            move "34" to fips-code of states-rec(states-idx)
            set states-idx up by 1

            move "NM" to state-code of states-rec(states-idx)
            move "New Mexico" to state-name of states-rec(states-idx)
            move "35" to fips-code of states-rec(states-idx)
            set states-idx up by 1

            move "NV" to state-code of states-rec(states-idx)
            move "Nevada" to state-name of states-rec(states-idx)
            move "32" to fips-code of states-rec(states-idx)
            set states-idx up by 1

            move "NY" to state-code of states-rec(states-idx)
            move "New York" to state-name of states-rec(states-idx)
            move "36" to fips-code of states-rec(states-idx)
            set states-idx up by 1

            move "OH" to state-code of states-rec(states-idx)
            move "Ohio" to state-name of states-rec(states-idx)
            move "39" to fips-code of states-rec(states-idx)
            set states-idx up by 1

            move "OK" to state-code of states-rec(states-idx)
            move "Oklahoma" to state-name of states-rec(states-idx)
            move "40" to fips-code of states-rec(states-idx)
            set states-idx up by 1

            move "OR" to state-code of states-rec(states-idx)
            move "Oregon" to state-name of states-rec(states-idx)
            move "41" to fips-code of states-rec(states-idx)
            set states-idx up by 1

            move "PA" to state-code of states-rec(states-idx)
            move "Pennsylvania" to state-name of states-rec(states-idx)
            move "42" to fips-code of states-rec(states-idx)
            set states-idx up by 1

            move "RI" to state-code of states-rec(states-idx)
            move "Rhode Island" to state-name of states-rec(states-idx)
            move "44" to fips-code of states-rec(states-idx)
            set states-idx up by 1

            move "SC" to state-code of states-rec(states-idx)
            move "South Carolina" to state-name of states-rec(states-idx)
            move "45" to fips-code of states-rec(states-idx)
            set states-idx up by 1

            move "SD" to state-code of states-rec(states-idx)
            move "South Dakota" to state-name of states-rec(states-idx)
            move "46" to fips-code of states-rec(states-idx)
            set states-idx up by 1

            move "TN" to state-code of states-rec(states-idx)
            move "Tennessee" to state-name of states-rec(states-idx)
            move "47" to fips-code of states-rec(states-idx)
            set states-idx up by 1

            move "TX" to state-code of states-rec(states-idx)
            move "Texas" to state-name of states-rec(states-idx)
            move "48" to fips-code of states-rec(states-idx)
            set states-idx up by 1

            move "UT" to state-code of states-rec(states-idx)
            move "Utah" to state-name of states-rec(states-idx)
            move "49" to fips-code of states-rec(states-idx)
            set states-idx up by 1

            move "VA" to state-code of states-rec(states-idx)
            move "Virginia" to state-name of states-rec(states-idx)
            move "51" to fips-code of states-rec(states-idx)
            set states-idx up by 1

            move "VT" to state-code of states-rec(states-idx)
            move "Vermont" to state-name of states-rec(states-idx)
            move "50" to fips-code of states-rec(states-idx)
            set states-idx up by 1

            move "WA" to state-code of states-rec(states-idx)
            move "Washington" to state-name of states-rec(states-idx)
            move "53" to fips-code of states-rec(states-idx)
            set states-idx up by 1

            move "WI" to state-code of states-rec(states-idx)
            move "Wisconsin" to state-name of states-rec(states-idx)
            move "55" to fips-code of states-rec(states-idx)
            set states-idx up by 1

            move "WV" to state-code of states-rec(states-idx)
            move "West Virginia" to state-name of states-rec(states-idx)
            move "54" to fips-code of states-rec(states-idx)
            set states-idx up by 1

            move "WY" to state-code of states-rec(states-idx)
            move "Wyoming" to state-name of states-rec(states-idx)
            move "56" to fips-code of states-rec(states-idx)
            set states-idx up by 1

            display "States Table initialized"
            set states-idx to 1
            perform varying states-idx from 1 by 1 until states-idx is greater than 51
                display "State code:" space state-code of states-rec(states-idx) space 
                    "Fips code:" space fips-code of states-rec(states-idx) space
                    "State Name:" space state-name of states-rec(states-idx)
            end-perform
            open input states
            display "VSAM file open"
        goback
    .

    entry "release-module".
        close states
        display "VSAM file closed"
        goback
    .

    end program states-lookup-module.

    *>********************************************************************************************
    

    identification division.
    program-id. states-lookup.

    data division.

        working-storage section.

            01 states-table is external.
            05 states-rec occurs 51 times 
                ascending key is state-code
                indexed by states-idx.

                10 state-code pic X(2).
                10 state-name pic X(20).
                10 fips-code  pic X(2). 

        linkage section.
            
            01 state-code-param pic X(2). 
            01 return-value pic X(20).   
   
    procedure division  using state-code-param, return-value.

        move spaces to return-value
        set states-idx to 1

        search all states-rec
            at end 
                continue

            when state-code of states-rec(states-idx) equals state-code-param
                move state-name of states-rec(states-idx) to return-value 
        end-search
        goback
    .

    end program states-lookup.

*>********************************************************************************************

identification division.
    program-id. states-lookup-vsam.

    
environment division.
    input-output section.
         file-control.	
          
          *> file is on RamDisk
            select states 
            assign to '/mnt/ramdisk/states-lookup.db'
            organization is indexed
            access mode is dynamic
            record key is state-code.  

    data division.
        file section.
            fd states is external.
            01 vsam-states-rec.
                05 state-code pic X(2).
                05 state-name pic X(20). 
      
        linkage section.
            
            01 state-code-param pic X(2). 
            01 return-value pic X(20).   
   
    procedure division  using state-code-param, return-value.
   
        move state-code-param to state-code of vsam-states-rec
        
        read states
            invalid key
                move spaces to return-value
            not invalid key
                move state-name of vsam-states-rec to return-value
        end-read
      
        goback    
            
    .

    end program states-lookup-vsam.

