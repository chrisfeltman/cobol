       >>source format is free
identification division.
    program-id. sequenntial-to-index.

environment division.
    input-output section.
        file-control.	
          
            select states
            assign to './datafiles/states-lookup.db'
            organization is indexed
            access mode is sequential
            record key is state-code.

data division.
    file section.

	 
        fd states.
            01 states-rec.
                05 state-code pic X(2).
                05 state-name pic X(20).         

procedure division.

    main.
        open output states

            move "AK" to state-code
            move "Alaska" to state-name
            write states-rec

            move "AL" to state-code
            move "Alabama" to state-name
            write states-rec

            move "AR" to state-code
            move "Arkansas" to state-name
            write states-rec

            move "AZ" to state-code
            move "Arizona" to state-name
            write states-rec

            move "CA" to state-code
            move "California" to state-name
            write states-rec

            move "CO" to state-code
            move "Colorado" to state-name
            write states-rec

            move "CT" to state-code
            move "Connecticut" to state-name
            write states-rec

            move "DC" to state-code
            move "District of Columbia" to state-name
            write states-rec

            move "DE" to state-code
            move "Delaware" to state-name
            write states-rec

            move "FL" to state-code
            move "Florida" to state-name
            write states-rec

            move "GA" to state-code
            move "Georgia" to state-name
            write states-rec

            move "HI" to state-code
            move "Hawaii" to state-name
            write states-rec

            move "IA" to state-code 
            move "Iowa" to state-name
            write states-rec

            move "ID" to state-code
            move "Idaho" to state-name
            write states-rec

            move "IL" to state-code
            move "Illinois" to state-name
            write states-rec

            move "IN" to state-code
            move "Indiana" to state-name
            write states-rec

            move "KS" to state-code
            move "Kansas" to state-name
            write states-rec

            move "KY" to state-code
            move "Kentucky" to state-name
            write states-rec

            move "LA" to state-code
            move "Louisiana" to state-name
            write states-rec

            move "MA" to state-code
            move "Massachusetts" to state-name
            write states-rec

            move "MD" to state-code
            move "Maryland" to state-name
            write states-rec

            move "ME" to state-code
            move "Maine" to state-name
            write states-rec

            move "MI" to state-code
            move "Michigan" to state-name
            write states-rec

            move "MN" to state-code
            move "Minnesota" to state-name
            write states-rec

            move "MO" to state-code
            move "Missouri" to state-name
            write states-rec

            move "MS" to state-code
            move "Mississippi" to state-name
            write states-rec

            move "MT" to state-code
            move "Montana" to state-name
            write states-rec

            move "NC" to state-code
            move "North Carolina" to state-name
            write states-rec

            move "ND" to state-code
            move "North Dakota" to state-name
            write states-rec

            move "NE" to state-code
            move "Nebraska" to state-name
            write states-rec

            move "NH" to state-code
            move "New Hampshire" to state-name
            write states-rec

            move "NJ" to state-code
            move "New Jersey" to state-name
            write states-rec

            move "NM" to state-code
            move "New Mexico" to state-name
            write states-rec

            move "NV" to state-code
            move "Nevada" to state-name
            write states-rec

            move "NY" to state-code
            move "New York" to state-name
            write states-rec

            move "OH" to state-code
            move "Ohio" to state-name
            write states-rec

            move "OK" to state-code
            move "Oklahoma" to state-name
            write states-rec

            move "OR" to state-code
            move "Oregon" to state-name
            write states-rec

            move "PA" to state-code
            move "Pennsylvania" to state-name
            write states-rec

            move "RI" to state-code
            move "Rhode Island" to state-name
            write states-rec

            move "SC" to state-code
            move "South Carolina" to state-name
            write states-rec

            move "SD" to state-code
            move "South Dakota" to state-name
            write states-rec

            move "TN" to state-code
            move "Tennessee" to state-name
            write states-rec

            move "TX" to state-code
            move "Texas" to state-name
            write states-rec

            move "UT" to state-code
            move "Utah" to state-name
            write states-rec

            move "VA" to state-code
            move "Virginia" to state-name
            write states-rec

            move "VT" to state-code
            move "Vermont" to state-name
            write states-rec

            move "WA" to state-code
            move "Washington" to state-name
            write states-rec

            move "WI" to state-code
            move "Wisconsin" to state-name
            write states-rec

            move "WV" to state-code
            move "West Virginia" to state-name
            write states-rec

            move "WY" to state-code
            move "Wyoming" to state-name
            write states-rec


        close states
     
        goback
    .

