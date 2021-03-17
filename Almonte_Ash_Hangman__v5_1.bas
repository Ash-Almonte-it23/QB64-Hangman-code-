_TITLE "Count characters " 'puts tittle on tab
SCREEN _NEWIMAGE(800, 600, 32) 'Put into Graphics Mode
_SCREENMOVE _MIDDLE 'Put Screen in Middle
CALL MAIN ' Calls the Main program to be run.
SUB MAIN 'BEGIN: PROCEDURE MAIN
    'Begin: Main Program
    dd_total$ = "" 'Contains the Displayed letters that user added in
    DO
        CLS 'Clears the screen
        _PRINTSTRING (10, 10), "THIS GAME COUNTS THE CHARACTERS YOU TYPE IN"
        _PRINTSTRING (10, 30), "Keep selecting a lower case letter until you want to stop playing the game."
        _PRINTSTRING (10, 50), "Hit the escape key to end the game."
        dd_key$ = INKEY$ 'Collects the players entry from the keyboard
        IF dd_key$ <> "" THEN 'BEGIN: ONLY RUN if letter was picked
            dd_total$ = dd_total$ + dd_key$ 'add your new letter into the dd_total$ variable
        END IF 'END: ONLY RUN if letter was picked
        _PRINTSTRING (10, 70), "Display of Original dd_total$ variable:  " + dd_total$
        _PRINTSTRING (10, 90), "Now lets count all the letters contained in dd_total$ shown on next line"
        _PRINTSTRING (10, 110), MAIN.DISPLAYLETTERS$(dd_total$)
        _PRINTSTRING (10, 140), STR$(LEN(dd_total$)) + " total characters typed in "
        _DISPLAY 'Displays graphic
    LOOP UNTIL dd_key$ = CHR$(27) 'Ends the game immediatly with the ESC Key
    SYSTEM
END SUB 'END: PROCEDURE MAIN
'
FUNCTION MAIN.DISPLAYLETTERS$ (dd_temp$)
    dd_temphold$ = "" 'temporary holding variable for simulated counting text
    IF LEN(dd_temp$) = 0 THEN 'BEGIN: Check if variable is empty
        dd_temphold$ = "dd_total$ is empty" 'variable is empty
    ELSE 'variable is not empty
        FOR n = 1 TO LEN(dd_temp$) 'BEGIN: Loop to check every letter in variable
            dd_current_letter_examined$ = MID$(dd_temp$, n, 1) 'Gets a letter to examine
            dd_temphold$ = dd_temphold$ + dd_current_letter_examined$ + " is" + STR$(n) + ", " 'creates the simulating counting
        NEXT n 'END; Loop to check every letter in variable
    END IF 'END: Check if variable is empty
    MAIN.DISPLAYLETTERS$ = dd_temphold$ 'always last line in function

END FUNCTION 'END: FUNCTION MAIN.DISPLAYLETTERS$


_TITLE "Hangman" 'puts tittle on tab
SCREEN _NEWIMAGE(800, 600, 32) 'Put into Graphics Mode
_SCREENMOVE _MIDDLE 'Put Screen in Middle

RANDOMIZE TIMER 'Needed for Random word generation

'Begin: Define Global Variables
DIM SHARED dd_White&, dd_Green&, dd_Yellow&, dd_Blue&, dd_Body&, dd_Wood&
DIM SHARED dd_key$, dd_letters$, dd_word$, dd_correct$, dd_wrong, dd_game_status, dd_found_error
DIM SHARED dd_error_message$, dd_dictionary$, dd_max_numb_of_body_parts, AA_counter
'End: Define Global Variables

CALL MAIN ' Calls the Main program to be run.
SUB MAIN
    'Begin: Main Program
    CALL MAIN.INIT_VARIABLES
    dd_word$ = MAIN.GET_WORD$(dd_dictionary$, MAIN.FILE_LENGTH(dd_dictionary$)) 'Gets a Random Word
    dd_correct$ = STRING$(LEN(dd_word$), "_") 'Contains the Displayed word that user is trying to solve
    DO

        CALL MAIN.DISPLAY 'PROCEDURE to Display the Screen
        CALL MAIN.DATA_PROCESS 'PROCEDURE to Process Data

    LOOP UNTIL dd_key$ = CHR$(27) 'Ends the game immediatly with the ESC Key

    SYSTEM
END SUB 'PROCEDURE MAIN
'END: MAIN Program
'
SUB MAIN.INIT_VARIABLES ()
    'Begin: Variables that never change
    'Begin: Variables define color
    dd_White& = _RGB(255, 255, 255)
    dd_Green& = _RGB(0, 153, 0)
    dd_Yellow& = _RGB(255, 255, 0)
    dd_Blue& = _RGB(0, 255, 255)
    dd_Body& = _RGB(255, 178, 102)
    dd_Wood& = _RGB(102, 0, 0)
    'END: Variables define color
    dd_max_numb_of_body_parts = 6 'The number of body parts in the entire hangman
    'END: Variables that never change

    'BEGIN :Variables that change
    dd_letters$ = "" 'Contains all the letters you picked
    dd_wrong = 0 'number of wrong letters picked
    dd_game_status = 0 'if equal to  0 means game in play, if equal to 1 means game was lost
    'if equal to 2 means game was won
    dd_found_error = 0 'if equal to  0 means no error, if equal to 1 means error
    dd_error_message$ = "" ' displays error message for the user
    dd_dictionary$ = "words.txt" 'File name that contains words
    AA_counter = 1 ' Initially Sets the counter that runs the animation to one
    'END :Variables that change
END SUB 'PROCEDURE MAIN.INIT_VARIABLES

FUNCTION MAIN.FILE_LENGTH (dd_file$)
    'BEGIN: get the file length'
    'ADD CODE::
    MAIN.FILE_LENGTH = 0
    'END: get the file length'

END FUNCTION ' FUNCTION MAIN.FILE_LENGTH
'
FUNCTION MAIN.GET_WORD$ (dd_file$, dd_filelength)
    'BEGIN Get Random Nunber
    'ADD CODE::
    'END: Get Random Nunber
    'BEGIN: Get the Word'
    'ADD CODE::
    MAIN.GET_WORD$ = "boces"
    'END: Get the Word'
END FUNCTION 'FUNCTION MAIN.GET_WORD$
'
SUB MAIN.DISPLAY 'PROCEDURE to Display the Screen
    CLS
    CALL MAIN.DISPLAY.DRAW_PLATFORM 'PROCEDURE to draw the Background and PLATFORM
    CALL MAIN.DISPLAY.DRAW_HANGMAN 'PROCEDURE to draw the HANGMAN
    CALL MAIN.DISPLAY.DRAW_TEXT 'PROCEDURE to draw all TEXT IN GAME
    _DISPLAY
END SUB 'PROCEDURE MAIN.DISPLAY
'
SUB MAIN.DATA_PROCESS 'PROCEDURE to data Process the GAME
    CALL MAIN.DATA_PROCESS.GET_GOOD_KEY 'PROCEDURE TO GET GOOD INPUT
    CALL MAIN.DATA_PROCESS.PARSE_DATA 'PROCEDURE TO ANALYSE KEY
END SUB 'PROCEDURE MAIN.DATA_PROCESS
'
SUB MAIN.DISPLAY.DRAW_PLATFORM 'PROCEDURE to draw the the Background and PLATFORM
    'BEGIN:draw the background
    LINE (0, 589)-(799, 0), _RGB(137, 0, 0), BF 'DarkRed the top
    LINE (0, 589)-(799, 489), _RGB(205, 92, 92), BF 'indianread Box from all the way to the bottom
    LINE (0, 287)-(799, 489), _RGB(178, 34, 34), BF 'firebrick  box second bottom
    LINE (40, 380)-(0, 380), _RGB(128, 0, 0) 'red line that show  movement to the red water
    LINE (40, 330)-(200, 330), _RGB(128, 0, 0) 'red line that show  movement to the red water
    LINE (40, 430)-(200, 430), _RGB(128, 0, 0) 'red line that show  movement to the red water
    LINE (200, 380)-(360, 380), _RGB(128, 0, 0) 'red line that show  movement to the red water
    LINE (360, 330)-(520, 330), _RGB(128, 0, 0) 'red line that show  movement to the red water
    LINE (360, 430)-(520, 430), _RGB(128, 0, 0) 'red line that show  movement to the red water
    LINE (520, 380)-(690, 380), _RGB(128, 0, 0) 'red line that show  movement to the red water
    LINE (690, 330)-(799, 330), _RGB(128, 0, 0) 'red line that show  movement to the red water
    LINE (690, 430)-(799, 430), _RGB(128, 0, 0) 'red line that show  movement to the red water
    CIRCLE (599, 100), 75, _RGB(205, 92, 92) 'Red circle
    PAINT (599, 100), _RGB(205, 92, 92), _RGB(205, 92, 92) 'Fills red circle
    CIRCLE (599, 100), 50, _RGB(193, 55, 55) 'dark Red circle
    PAINT (599, 100), _RGB(193, 55, 55), _RGB(193, 55, 55) 'Fills dark red circle
    LINE (690, 287)-(780, 200), _RGB(0, 0, 0), BF 'black building
    LINE (699, 220)-(710, 210), _RGB(255, 255, 255), BF 'white window
    LINE (740, 220)-(750, 210), _RGB(255, 255, 255), BF 'white window
    LINE (740, 287)-(750, 250), _RGB(255, 255, 255), BF 'white window


    IF AA_counter = 1 THEN 'BEGIN: IF COMMAND #1

        CIRCLE (130, 50), 2, _RGB(255, 255, 224) 'light yellow star circle
        PAINT (130, 50), _RGB(255, 255, 224), _RGB(255, 255, 224) 'Fills light yellow star circle


        CIRCLE (220, 70), 2, _RGB(255, 255, 224) 'light yellow star circle
        PAINT (220, 70), _RGB(255, 255, 224), _RGB(255, 255, 224) 'Fills light yellow star circle


        CIRCLE (320, 50), 2, _RGB(255, 255, 224) 'light yellow star circle
        PAINT (320, 50), _RGB(255, 255, 224), _RGB(255, 255, 224) 'Fills light yellow star circle


        CIRCLE (420, 145), 2, _RGB(255, 255, 224) 'light yellow star circle
        PAINT (420, 145), _RGB(255, 255, 224), _RGB(255, 255, 224) 'Fills light yellow star circle


        CIRCLE (100, 190), 2, _RGB(255, 255, 224) 'light yellow star circle
        PAINT (100, 190), _RGB(255, 255, 224), _RGB(255, 255, 224) 'Fills light yellow star circle

    END IF 'END: IF COMMAND #1

    IF AA_counter = 2 THEN 'BEGIN: IF COMMAND #2

        CIRCLE (316, 190), 2, _RGB(255, 255, 224) 'light yellow star circle
        PAINT (316, 190), _RGB(255, 255, 224), _RGB(255, 255, 224) 'Fills light yellow star circle


        CIRCLE (516, 190), 2, _RGB(255, 255, 224) 'light yellow star circle
        PAINT (516, 190), _RGB(255, 255, 224), _RGB(255, 255, 224) 'Fills light yellow star circle


        CIRCLE (686, 230), 2, _RGB(255, 255, 224) 'light yellow star circle
        PAINT (686, 230), _RGB(255, 255, 224), _RGB(255, 255, 224) 'Fills light yellow star circle


        CIRCLE (699, 50), 2, _RGB(255, 255, 224) 'light yellow star circle
        PAINT (699, 50), _RGB(255, 255, 224), _RGB(255, 255, 224) 'Fills light yellow star circle


        CIRCLE (420, 20), 2, _RGB(255, 255, 224) 'light yellow star circle
        PAINT (420, 20), _RGB(255, 255, 224), _RGB(255, 255, 224) 'Fills light yellow star circle

    END IF 'END: IF COMMAND #2

    IF AA_counter = 3 THEN 'BEGIN: IF COMMAND #3

        CIRCLE (130, 50), 2, _RGB(255, 255, 224) 'light yellow star circle
        PAINT (130, 50), _RGB(255, 255, 224), _RGB(255, 255, 224) 'Fills light yellow star circle


        CIRCLE (220, 70), 2, _RGB(255, 255, 224) 'light yellow star circle
        PAINT (220, 70), _RGB(255, 255, 224), _RGB(255, 255, 224) 'Fills light yellow star circle


        CIRCLE (320, 50), 2, _RGB(255, 255, 224) 'light yellow star circle
        PAINT (320, 50), _RGB(255, 255, 224), _RGB(255, 255, 224) 'Fills light yellow star circle


        CIRCLE (420, 145), 2, _RGB(255, 255, 224) 'light yellow star circle
        PAINT (420, 145), _RGB(255, 255, 224), _RGB(255, 255, 224) 'Fills light yellow star circle


        CIRCLE (100, 190), 2, _RGB(255, 255, 224) 'light yellow star circle
        PAINT (100, 190), _RGB(255, 255, 224), _RGB(255, 255, 224) 'Fills light yellow star circle

    END IF 'END: IF COMMAND #3

    IF AA_counter = 4 THEN 'BEGIN: IF COMMAND #4

        CIRCLE (316, 190), 2, _RGB(255, 255, 224) 'light yellow star circle
        PAINT (316, 190), _RGB(255, 255, 224), _RGB(255, 255, 224) 'Fills light yellow star circle


        CIRCLE (516, 190), 2, _RGB(255, 255, 224) 'light yellow star circle
        PAINT (516, 190), _RGB(255, 255, 224), _RGB(255, 255, 224) 'Fills light yellow star circle


        CIRCLE (686, 230), 2, _RGB(255, 255, 224) 'light yellow star circle
        PAINT (686, 230), _RGB(255, 255, 224), _RGB(255, 255, 224) 'Fills light yellow star circle


        CIRCLE (699, 50), 2, _RGB(255, 255, 224) 'light yellow star circle
        PAINT (699, 50), _RGB(255, 255, 224), _RGB(255, 255, 224) 'Fills light yellow star circle


        CIRCLE (420, 20), 2, _RGB(255, 255, 224) 'light yellow star circle
        PAINT (420, 20), _RGB(255, 255, 224), _RGB(255, 255, 224) 'Fills light yellow star circle

        AA_counter = 0 'Resets the counter to one

    END IF 'END: IF COMMAND #4

    _DELAY 0.3 '  PAUSE FOR 0.1 SEC

    AA_counter = AA_counter + 1 'Increments the counter by 1
    'END : draw the background
    'BEGIN:draw the platform
    LINE (20, 480)-(30, 90), _RGB(139, 69, 19), BF 'Brown box middle
    LINE (20, 100)-(300, 90), _RGB(139, 69, 19), BF 'Brown box top
    LINE (20, 480)-(399, 489), _RGB(139, 69, 19), BF 'Brown box bottom
    LINE (139, 99)-(156, 112), _RGB(160, 82, 45), BF 'rope
    'END : draw the platform

END SUB 'PROCEDURE MAIN.DISPLAY.DRAW_PLATFORM
'
SUB MAIN.DISPLAY.DRAW_HANGMAN 'PROCEDURE to draw the HANGMAN
    AA_counter2 = dd_wrong 'syncs my counter with Dr.D's counter for adding body parts.
    'ADD CODE:: HEAD
    IF AA_counter2 >= 1 THEN
        CIRCLE (150, 149), 37, _RGB(105, 105, 105) 'gray head
        PAINT (150, 149), _RGB(105, 105, 105), _RGB(105, 105, 105) 'Fills gray circle
    END IF

    IF AA_counter2 >= 2 THEN
        LINE (150, 129)-(150, 300), _RGB(105, 105, 105) 'gray body
    END IF

    IF AA_counter2 >= 3 THEN
        LINE (100, 294)-(150, 210), _RGB(105, 105, 105) 'Left gray arm
    END IF

    IF AA_counter2 >= 4 THEN
        LINE (200, 294)-(150, 210), _RGB(105, 105, 105) 'right gray arm
    END IF

    IF AA_counter2 >= 5 THEN
        LINE (150, 294)-(190, 400), _RGB(105, 105, 105) 'right gray leg
    END IF

    IF AA_counter2 >= 6 THEN
        LINE (150, 294)-(100, 400), _RGB(105, 105, 105) 'left gray leg
    END IF

    'ADD CODE:: IF THEN ELSE for all Body Parts
END SUB 'PROCEDURE MAIN.DISPLAY.DRAW_HANGMAN
'
SUB MAIN.DISPLAY.DRAW_TEXT 'PROCEDURE to draw all TEXT IN GAME
    '_PRINTSTRING (600, 0), "SAVE THE HANGMAN!" 'Dr. D's old name not used
    word$ = "SAVE THE HANGMAN PLZ!!"
    _PRINTSTRING (610, 70), word$
    word$ = "By: Ash Almonte"
    _PRINTSTRING (610, 90), word$


    _PRINTSTRING (100, 480), MAIN.DISPLAY.DRAW_TEXT.DISPLAYWORD$(dd_correct$)
    _PRINTSTRING (400, 480), "It is a " + STR$(LEN(dd_word$)) + " letter word."
    _PRINTSTRING (0, 510), "Keep selecting a lower case letter until the game ends then hit the escape key."
    _PRINTSTRING (0, 530), "To exit before the game ends select the Escape key."
    _PRINTSTRING (0, 550), "NUMBER OF LETTERS SELECTED: " + STR$(LEN(dd_letters$))
    _PRINTSTRING (300, 550), "INCORRECTLY: " + STR$(dd_wrong)
    _PRINTSTRING (500, 550), "CORRECTLY: " + STR$(LEN(dd_letters$) - dd_wrong)
    _PRINTSTRING (0, 570), "SELECTED LETTERS: " + UCASE$(dd_letters$)


    IF dd_game_status = 2 THEN 'this means you won the game
        _PRINTSTRING (500, 240), "YAY! YOU WIN!!!"
        _PRINTSTRING (500, 260), "Please hit the escape key!!"
    END IF
    IF dd_game_status = 1 THEN 'this means you lost the game
        _PRINTSTRING (500, 240), "OH NO, HANGMAN! YOU LOSE!!"
        _PRINTSTRING (500, 260), "The word was " + dd_word$
        _PRINTSTRING (500, 280), "Please hit the escape key!!"
    END IF

    IF dd_found_error = 1 THEN 'used to display an error
        _PRINTSTRING (500, 240), dd_error_message$ 'variable contains the error message
        _PRINTSTRING (500, 260), "PICK ANOTHER LETTER" 'tells the user to continue
    END IF

END SUB 'PROCEDURE MAIN.DISPLAY.DRAW_TEXT
'
FUNCTION MAIN.DISPLAY.DRAW_TEXT.DISPLAYWORD$ (dd_displaycorrect$) 'Puts a space between characters of the word
    'Add 6 lines of code
    MAIN.DISPLAY.DRAW_TEXT.DISPLAYWORD = dd_displaycorrect$
END FUNCTION 'MAIN.DISPLAY.DRAW_TEXT.DISPLAYWORD
'
SUB MAIN.DATA_PROCESS.GET_GOOD_KEY 'PROCEDURE TO GET GOOD INPUT
    dd_key$ = INKEY$ 'Collects the players entry from the keyboard
    IF dd_game_status = 0 THEN 'BEGIN: ONLY RUN if Game is still running

        IF dd_key$ <> "" THEN 'BEGIN: ONLY RUN if letter was picked
            dd_found_error = 0 'No errors found
            IF dd_key$ >= "a" AND dd_key$ <= "z" THEN 'BEGIN:check if key is small letter

                'BEGIN: look for a duplicate
                'ADD CODE:: TO CHECK For Duplicates' 10 Lines of Code
                '
                'END: look for a duplicate
            ELSE 'ELSE for:check if key is small letter
                dd_found_error = 1 'Error found because not lower case letter
                dd_error_message$ = "Please only pick a lower case letter "

            END IF 'END :check if key is small letter
            '
        END IF 'END: ONLY RUN if letter was picked
        '
    END IF 'ONLY RUN if Game is still running

END SUB 'PROCEDURE MAIN.DATA_PROCESS.GET_GOOD_KEY
SUB MAIN.DATA_PROCESS.PARSE_DATA 'ANALYSE KEY
    IF dd_found_error = 0 THEN 'Begin :only run rest of code if no error
        IF dd_key$ <> "" THEN 'BEGIN: ONLY RUN if letter was picked
            dd_letters$ = dd_letters$ + dd_key$ 'add you letter to the picked letters
            'BEGIN: look for a match
            dd_found = 0 ' if dd_found= 0 it means chosen letter is not in word
            FOR n = 1 TO LEN(dd_word$) 'checks beginning from first letter to last letter of word
                dd_current_letter_examined$ = MID$(dd_word$, n, 1) 'Gets a letter to examine
                IF dd_key$ = dd_current_letter_examined$ THEN 'BEGIN: Check if letter examined is in word
                    MID$(dd_correct$, n, 1) = UCASE$(dd_key$) 'ADDS letter to Correct Word
                    dd_found = 1 'if dd_found= 1 it means chosen letter is found in word
                END IF 'END: Check if letter examined is in word
            NEXT n
            IF dd_found = 0 THEN 'BEGIN: CHECK if chosen letter was not found in word
                dd_wrong = dd_wrong + 1 ' no letter found so increment dd_wrong counter
            END IF 'END: CHECK if chosen letter was not found in word
            'END: look for a match
            'BEGIN: check if Game is won
            IF UCASE$(dd_word$) = dd_correct$ THEN 'BEGIN: checks if your correct word is exactly equal to the word
                dd_game_status = 2 'Means game won
            END IF 'END: checks if your correct word is exactly equal to the word
            'END: check if Game is won
            'BEGIN: check if Game is lost
            IF dd_wrong >= dd_max_numb_of_body_parts THEN 'BEGIN: checks if wrong counter equals the number of body parts
                dd_game_status = 1 'Means game lost
            END IF 'END: checks if wrong counter equals the number of body parts
            'END: check if Game is lost
        END IF 'END: ONLY RUN if letter was picked
    END IF 'END :only run rest of code if no error

END SUB 'PROCEDURE MAIN.DATA_PROCESS.PARSE_DATA
