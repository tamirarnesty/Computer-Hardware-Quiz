% Tamir Arnesty
% Ms. Krasteva
% December 18, 2014
% Culminating - Computer Hardware lesson and quiz
/*
 -------------------------------------------------------------------------------| 
    This program is an interactive lesson and quiz on computer hardware.        |
 The user can choose to learn the material provided, view the instructions, take|
  the quiz, or exit.                                                            |
 There are three main procedures in this program: mainMenu,                     |
  userInput, display. mainMenu is the main control for the program and the user |
  will eventually be brought back to it.                                        |
 Each procedure has it's own window in order to terminate ghost buttons and     |
  errors in display.                                                            |
 The userInput procedure is the quiz that the user can take after learning the  |
  material.                                                                     |
 The display procedure is the result window after the quiz, and it provides the |
  user with their score on the quiz.                                            |
 The window redirects back to mainMenu automatically after 10 seconds.          |
 Since the program is mainly controlled by GUI buttons, there is nowhere for    |
  error trapping.                                                               |    
 -------------------------------------------------------------------------------|
*/

%%-- Importing Graphic User Interface
import GUI

%%-- Forward Procedures
forward procedure animatedTitle
forward procedure clsLessTitle
forward procedure smallerTitle
forward procedure pauseProgram
forward procedure intro
forward procedure mainMenu
forward procedure learn
forward procedure instructions
forward procedure userInput
forward procedure display
forward procedure goodBye
%%-- End of Forward Procedures

%%-- Declaration Statements
%%- Windows
var mainWindow := Window.Open ("position:320;400,graphics:640;400")
var instructionsWindow := Window.Open ("position:320;400,graphics:400;200")
var learnWindow := Window.Open ("position:320;200,graphics:640;400")
var quizWindow := Window.Open ("position:280;400,graphics:720;400")
var mainMenuWindow, exitWindow : int
Window.Hide (instructionsWindow)
Window.Hide (learnWindow)
Window.Hide (quizWindow)
%%- Fonts
var titleFont, introFont, mainMenuFont, instructionsFont, quizFont, learnFont, smallerTitleFont, exitFont, displayFont : int

%%- Variables
var score : real
var correctAnswer : int := 0
var secondNum, firstNum : int
var sky := Pic.FileNew ("Sky.jpg")
var sky2 := Pic.FileNew ("Sky2.jpg")
var sky3 := Pic.FileNew ("Sky3.jpg")

%%-- End of Declaration Statements

%-------------------------------------------------------------------------------|
%%%--- First procedures
%%-- Backgrounds
%%- Main 640 x 400
procedure background
    Pic.Draw (sky, 0, 0, picMerge)
    clsLessTitle
end background

%%- Instructions 400 x 200
procedure background2
    Pic.Draw (sky2, 0, 0, picMerge)
    smallerTitle
end background2

%%- Quiz 720 x 400
procedure background3
    Pic.Draw (sky3, 0, 0, picMerge)
    clsLessTitle
end background3

%%-- Titles
%%- Animated Title
body procedure animatedTitle
    %%-- Font assignment
    titleFont := Font.New ("Magneto:30")
    %%-- Clear screen
    %cls
    %%-- Animation loop
    for i : 0 .. 100
	Font.Draw ("Computer Hardware", 106, 473 - i, titleFont, white)
	Font.Draw ("Computer Hardware", 106, 471 - i, titleFont, 77)
	delay (10)
    end for
end animatedTitle

%%- Main Static title
body procedure clsLessTitle
    %%-- Writing the main static title
    Font.Draw ("Computer Hardware", 106, 371, titleFont, 77)
end clsLessTitle

%%- Smaller static title, used in instructions procedure due to smaller window
body procedure smallerTitle
    %%-- Font assignment
    smallerTitleFont := Font.New ("Magneto:20")
    %%-- Writing the main static smaller title
    Font.Draw ("Computer Hardware", 55, 181, smallerTitleFont, 77)
end smallerTitle
%%%--- End of Title Procedures

%%-- Pause Program 
body procedure pauseProgram
    %%-- Font assignment
    learnFont := Font.New ("Copperplate Gothic Bold:10")
    var reply : string (1)
    %%-- Prompt text
    Font.Draw ("Press any key to continue...", 210, 20, learnFont, white)
    %%-- getting user input
    getch (reply)
end pauseProgram
%-------------------------------------------------------------------------------|

%%-- Introduction
body procedure intro
    %%-- Begin playing the music
    Music.PlayFileLoop ("A Sky Full of Stars (Instrumental).mp3")
    %%-- Setting the screen and window active
    setscreen ("offscreenonly")
    Window.SetActive (mainWindow)
    %%-- Font assignment
    introFont := Font.New ("Copperplate Gothic Bold:14")
    %%-- Calling animated title and background
    animatedTitle
    background
    locate (4, 1)
    %%-- Displaying the intro
    Font.Draw ("This program will teach you about computer hardware", 1, 300, introFont, 77)
    Font.Draw (" along with testing you on it.", 1, 280, introFont, 77)
    Font.Draw ("You will be given a final score after taking the quiz.", 1, 260, introFont, 77)
    Font.Draw ("Find out how well you know computer hardware!", 1, 240, introFont, 77)
    Font.Draw ("Click the button below or press enter to continue.", 1, 200, introFont, 77)
    %%-- Button declaration and assignment. The button is assigned a colour as well
    var mainMenuButton := GUI.CreateButton (280, 100, 0, "Continue ", mainMenu) % used in intro
    GUI.SetColour (mainMenuButton, 77)
    GUI.SetDefault (mainMenuButton, true)
    %%-- The button proceeds to mainMenu once clicked upon
    View.Update
end intro

%%-- Main Menu
body procedure mainMenu
    %%-- Hiding open windows
    Window.Hide (quizWindow)
    Window.Hide (learnWindow)
    Window.Hide (instructionsWindow)
    Window.Hide (mainWindow)
    %%-- Font assignment
    mainMenuFont := Font.New ("Copperplate Gothic Bold:20")
    %%-- Declaring, creating and opening the mainMenu window
    mainMenuWindow := Window.Open ("position:640;400,graphics:640;400")
    Window.SetActive (mainMenuWindow)
    Window.Show (mainMenuWindow)
    %%-- Calling the background
    background
    Font.Draw ("Choose one of the following:", 1, 300, mainMenuFont, 77)
    %%-- Button declaration and assignment. Bottons are assigned colours as well
    var learnButton := GUI.CreateButton (130, 120, 0, "Learn The Material", learn)
    GUI.SetColor (learnButton, 77)
    var instructionsButton := GUI.CreateButton (275, 120, 0, "Instructions", instructions) 
    GUI.SetColour (instructionsButton, 77)
    var quizButton := GUI.CreateButton (380, 120, 0, "Take The Quiz", userInput) 
    GUI.SetColour (quizButton, 77)
    var exitButton := GUI.CreateButtonFull (295, 50, 0, "Exit", GUI.Quit, 0, KEY_ESC, false)
    GUI.SetColour (exitButton, 77)
    View.Update
end mainMenu

%%-- Information on Computer Hardware
body procedure learn
    %%-- Hiding mainMenu window
    Window.Hide (mainMenuWindow)
    %%-- Creating and showing learn window
    Window.SetActive (learnWindow)
    Window.Show (learnWindow)
    %%-- Calling background
    background
    
    %%-- Array declarations
    %%- The array used to determine when not to repeat the hardware
    var finished : array 1 .. 15 of int

    %%- Name of the hardware component
    var hardwareName : array 1 .. 15 of string
    hardwareName (1) := "Central Processing Unit (CPU)"
    hardwareName (2) := "Hard Disk Drive (HDD)"
    hardwareName (3) := "Graphics Card"
    hardwareName (4) := "Random Access Memory (RAM)"
    hardwareName (5) := "Read Only Memory (ROM)"
    hardwareName (6) := "Monitor"
    hardwareName (7) := "Keyboard"
    hardwareName (8) := "Mouse"
    hardwareName (9) := "Floppy Disk"
    hardwareName (10) := "Universal Serial Bus (USB)"
    hardwareName (11) := "Motherboard"
    hardwareName (12) := "ReWritable Disk"
    hardwareName (13) := "Digital Versatile Disk (DVD)"
    hardwareName (14) := "Sound"
    hardwareName (15) := "Solid State Drive (SSD)"

    %%- Type of component of the hardware
    var hardwareType : array 1 .. 15 of string
    hardwareType (1) := "Processor"
    hardwareType (2) := "Storage"
    hardwareType (3) := "Processor"
    hardwareType (4) := "Storage"
    hardwareType (5) := "Storage"
    hardwareType (6) := "Output"
    hardwareType (7) := "Input"
    hardwareType (8) := "Input"
    hardwareType (9) := "Storage"
    hardwareType (10) := "Storage"
    hardwareType (11) := "Main Processor"
    hardwareType (12) := "Storage"
    hardwareType (13) := "Storage"
    hardwareType (14) := "Output"
    hardwareType (15) := "Diskless storage"

    %%- Description of the hardware component
    var description : array 1 .. 15 of string
    description (1) := "The Central Processing Unit is the brain of the computer. It is where the       computer processes commans and information."
    description (2) := "Data is read in a random-access manner, meaning individual blocks of data can bestored or retrieved in any order rather than sequentially."
    description (3) := "A graphics card is an expansion card which generates a feed of output images to a display."
    description (4) := "Random Access Memory allows the CPU to read information from it and write       information onto it. RAM capacity varies and can be changed."
    description (5) := "Read Only Memory contains all the instructions for a computer to perfom simple  tasks. ROM cannot be removed and capacity cannot be changed."
    description (6) := "A monitor is an output which comprises the display device, circuitry and an     enclosure. A monitor or a display is an electronic visual display for computers."
    description (7) := "A keyboard is an input device used to enter characters into the computer, which then processes the keys entered to determine the output to be displayed."
    description (8) := "A mouse is a pointing device that detects two-dimensional motion relative to a  surface. The motion is translated onto the monitor (or display) as a cursor,    which moves across the screen in relativity to the mouse."
    description (9) := "Floppy Disks are one of the older methods of backing up memory. They store data on spinning concentric cirles called tracks. Floppy Disk storage can be up to   1.4 megabytes."
    description (10) := "A USB is a newer more advanced form of storage. It is a standardized technology for attaching peripheral devices to a computer."
    description (11) := "The motherboard is the main printed circuit board (PCB) found in computers and  other expandable systems. It holds many of the crucial electronic components of the system, such as the central processing unit (CPU) and memory."
    description (12) := "A ReWritable disk is a compact disc that can be written, read arbitrarily many  times, erased and written again. Compact Disks have storage between 4.7 and 17  Gigabytes."
    description (13) := "A Digital Versatile Disk is similar to a compact disk and it is able to store   large amounts of data, especially high-resolution audiovisual material. DVDs    have storage of 25 and 50 Gigabytes."
    description (14) := "Sound is an output, usually in the form of headphones or speakers."
    description (15) := "Solid State Drives are data storage devices using integrated circuit assemblies as memory to store data persistently."

    %%-- Picture corresponding to the hardware name, type, and descripion
    var cpu : int := Pic.FileNew ("cpu.jpg")
    var ssd : int := Pic.FileNew ("solidStateDrive.jpg")
    var ram : int := Pic.FileNew ("randomAccessMemory.jpg")
    var rom : int := Pic.FileNew ("readOnlyMemory.jpg")
    var usb : int := Pic.FileNew ("universalSerialBus.jpg")
    var dvd : int := Pic.FileNew ("digitalVersatileDisc.jpg")
    var mouse : int := Pic.FileNew ("mouse.jpg")
    var rwDisk : int := Pic.FileNew ("reWritableDisc.jpg")
    var speaker : int := Pic.FileNew ("sound.jpg")
    var keyboard : int := Pic.FileNew ("keyboard.jpg")
    var hardDrive : int := Pic.FileNew ("hardDrive.jpg")
    var floppyDisk : int := Pic.FileNew ("floppyDisk.jpg")
    var motherboard : int := Pic.FileNew ("motherboard.jpg")
    var graphicsCard : int := Pic.FileNew ("graphicsCard.gif")
    var computerMonitor : int := Pic.FileNew ("monitor.jpg")
    
    %%-- Font assignment
    learnFont := Font.New ("Copperplate Gothic Bold:10")
    %%-- Variable declaration
    var informationCounter : int := 0
    var pictureName : string := ""
    var information : int
    var name, Type, info : string := ""
    
    %%-- Finished loop
    for i:1..15
	finished(i):=0
    end for
    
    %%-- Beginning of loop
    loop
	background
	%%-- Loop to determine the information to be displayed
	loop
	    %%-- Randint to choose a number from 1 to 15
	    randint (information, 1, 15)
	    %%-- If the value of finished of the specific information (chosen by randint) is 0 
	    %%- Then display the information
	    if finished (information) = 0 then
		%%-- If the value is 1 (assigned at the end of the loop) then choose another number
	       exit
	    end if
	end loop
	
	%%-- Displaying hardware name, type, and description
	Font.Draw (hardwareName (information), 1, 250, learnFont, 77)
	Font.Draw (hardwareType (information), 1, 230, learnFont, 77)
	locate (14, 1)
	put description (information) 
	%%-- If structure to determine which picture to display
	if information = 1 then
	    Pic.Draw (cpu, 480, 220, picMerge)
	elsif information = 2 then
	    Pic.Draw (hardDrive, 480, 220, picMerge)
	elsif information = 3 then
	    Pic.Draw (graphicsCard, 480, 220, picMerge)
	elsif information = 4 then
	    Pic.Draw (ram, 480, 220, picMerge)
	elsif information = 5 then
	    Pic.Draw (rom, 480, 220, picMerge)
	elsif information = 6 then
	    Pic.Draw (computerMonitor, 480, 220, picMerge)
	elsif information = 7 then
	    Pic.Draw (keyboard, 480, 220, picMerge)
	elsif information = 8 then
	    Pic.Draw (mouse, 480, 220, picMerge)
	elsif information = 9 then
	    Pic.Draw (floppyDisk, 480, 220, picMerge)
	elsif information = 10 then
	    Pic.Draw (usb, 480, 220, picMerge) 
	elsif information = 11 then
	    Pic.Draw (motherboard, 480, 220, picMerge)
	elsif information = 12 then
	    Pic.Draw (rwDisk, 480, 220, picMerge)
	elsif information = 13 then
	    Pic.Draw (dvd, 480, 220, picMerge)
	elsif information = 14 then
	    Pic.Draw (speaker, 480, 220, picMerge)
	elsif information = 15 then
	    Pic.Draw (ssd, 480, 220, picMerge)
	end if
       
	%%-- Pause program so the user can read the information. Once the user presses a key, the next hardware appears
	pauseProgram
	%%-- The informationCounter counts how many hardware components have been displayed
	informationCounter += 1
	%%-- Reassigning the finsihed variable to 1 (of the current question)
	%%- In order for it to not be chosen, so it cannot be repeated
	finished (information) := 1
	%%-- Once the counter reaches 15, the loop exits
	exit when informationCounter = 15
    end loop
    background
    %%-- End of loop
    %%- Resetting the counter to 0
    informationCounter := 0
    %%- Button declaration and assignment. The button returns the user to mainMenu. The button is assigned a colour as well
    var returnButton := GUI.CreateButton (260, 100, 0, "Return to Main Menu", mainMenu) % used in instructions and learn
    GUI.SetColour (returnButton, 77)
    %%-- Updating the screen in order to improve animation (the coloured text)
    View.Update
end learn

%%-- Instructions on what to do in the program
body procedure instructions
    %%-- Hide mainMenu window
    Window.Hide (mainMenuWindow)
    %%-- Show instructions window
    Window.SetActive (instructionsWindow)
    Window.Show (instructionsWindow)
    %%-- Font assignment
    instructionsFont := Font.New ("Copperplate Gothic Bold:10")
    %%-- Calling smaller background with smaller title
    background2
    %%-- Displaying instructions
    Font.Draw ("1. Learn about computer hardware", 1, 130, instructionsFont, 77)
    Font.Draw ("2. Take the quiz", 1, 115, instructionsFont, 77)
    Font.Draw ("3. After taking the quiz, ", 1, 100, instructionsFont, 77)
    Font.Draw ("  Determine how well you know computer hardware", 1, 85, instructionsFont, 77)
    %%-- Button declaration and assignment. The button returns the user to mainMenu. The button is assigned a colour as well
    var returnButton := GUI.CreateButton (120, 30, 0, "Return to Main Menu", mainMenu)
    GUI.SetColour (returnButton, 77)
    View.Update
end instructions

%%-- User Quiz
body procedure userInput
    %%-- Hide mainMenu window
    Window.Hide (mainMenuWindow)
    %%-- Creating and showing quiz window
    Window.SetActive (quizWindow)
    Window.Show (quizWindow)
    %%-- Calling stretched background
    background3
    
    %%-- Question declaration and assignment
    %%- The array used to determine when not to repeat the question
    var finished : array 1 .. 15 of int
    %%- Questions array for the quiz 
    var questions : array 1 .. 15 of string
    questions (1) := "What does CPU stand for?"
    questions (2) := "In a hard drive, what type of manner is data accessed by?"
    questions (3) := "What expansion card generates a feed of output images to a display?"
    questions (4) := "Random Access Memory allows the ____ to read information from it and write information onto it?"
    questions (5) := "Can ROM be removed and have it's capacity changed?"
    questions (6) := "What is an electronic visual display for computers?"
    questions (7) := "What input device allows you to enter characters or phrases into the computer?"
    questions (8) := "What input device detects two-dimensional motion relative to a surface?"
    questions (9) := "What is one of the oldest methods of backing up data?"
    questions (10) := "What is the newer method of backing up data?"
    questions (11) := "What is the main circuit board of a microcomputer?"
    questions (12) := "What minimum capacity does a ReWritable Disk have?"
    questions (13) := "What other type of disc is a DVD similar to?"
    questions (14) := "What type of output do speakers produce?"
    questions (15) := "What kind of circuit assemblies do Solid State Drives use to store data?"
    
    %%-- Finished loop
    for i:1..15
	finished(i):=0
    end for
    
    %%-- Font assignment
    quizFont := Font.New ("Copperplate Gothic Bold:10")
    %%-- Variable declaration and assignment
    var answer : string
    var questionCounter : int := 0
    var question : int
    var key : string (1)
    
    %%-- Brief instruction note for the user
    Font.Draw ("Note: The following questions are expected abbreviations, and few words answers.", 1, 300, quizFont, 77)
    Font.Draw ("No long answers please, or your answer will be marked incorrect.", 42, 280, quizFont, 77)
    Font.Draw ("Press any key to continue...", 280, 20, quizFont, white)
    getch (key)
    
    %%-- Beginning of loop
    loop
    %   %-- Calling the stretched background again to clear the previous text 
	background3
	%%-- Screen correction and setting
	View.Set ("nooffscreenonly")
	Window.Update (quizWindow)
	%%-- Loop to determine the question to be asked
	loop
	    %%-- Randint to choose a number from 1 to 15
	    randint (question, 1, 15)
	    %%-- If the value of finished of the specific question (chosen by randint) is 0 
	    %%- Then ask the question
	    if finished (question) = 0 then
		%%-- If the value is 1 (assigned at the end of the loop) then choose another number
		exit
	    end if
	end loop

	%%-- Displaying the questions
	Font.Draw ("Remember, these aren't long answer questions. Keep it simple!", 1, 300, quizFont, 77)
	Font.Draw (questions (question), 1, 250, quizFont, 77)
	locate (11, 1)
	%%-- Getting the user's answer
	get answer : *
	%%-- Converting the user's answer into all lower case characters
	answer := Str.Lower (answer)

	%%-- Answer processing to determine whether the answer is correct or incorrect
	if question = 1 and answer = "central processing unit" then
	    correctAnswer := correctAnswer + 1
	elsif question = 2 and (answer = "random access manner" or answer = "random-access manner")then
	    correctAnswer := correctAnswer + 1
	 elsif question = 3 and (answer = "a graphics card" or answer = "graphics card")then
	    correctAnswer := correctAnswer + 1
	elsif question = 4 and (answer = "cpu" or answer = "central processing unit") then
	    Font.Draw ("Fill in the blank!", 1, 270, quizFont, purple)
	    correctAnswer := correctAnswer + 1
	elsif question = 5 and answer = "no" then
	    correctAnswer := correctAnswer + 1
	elsif question = 6 and (answer = "a monitor" or answer = "monitor") then
	    correctAnswer := correctAnswer + 1
	elsif question = 7 and (answer = "a keyboard" or answer = "keyboard" or answer = "the keyboard") then
	    correctAnswer := correctAnswer + 1
	elsif question = 8 and (answer = "a mouse" or answer = "mouse") then
	    correctAnswer := correctAnswer + 1
	elsif question = 9 and (answer = "a floppy disk" or answer = "floppy disk") then
	    correctAnswer := correctAnswer + 1
	elsif question = 10 and (answer = "a usb" or answer = "a universal serial bus" or answer = "usb" or answer = "universal serial bus") then
	    correctAnswer := correctAnswer + 1
	elsif question = 11 and (answer = "the motherboard" or answer = "motherboard" or answer = "a motherboard") then
	    correctAnswer := correctAnswer + 1
	elsif question = 12 and (answer = "4.7 gb" or answer = "4.7 gigabytes") then
	    correctAnswer := correctAnswer + 1
	 elsif question = 13 and (answer = "a cd" or answer = "a compact disc" or answer = "cd" or answer = "compact disc") then
	    correctAnswer := correctAnswer + 1
	elsif question = 14 and answer = "sound" then
	    correctAnswer := correctAnswer + 1
	elsif question = 15 and (answer = "integrated circuit" or answer = "an integrated circuit" or answer = "integrated circuit assemblies" or answer = "integrated circuit assembly" or answer = "an integrated circuit assembly") then
	    correctAnswer := correctAnswer + 1
	end if
	%%-- Questions asked counter to determine when to stop asking the questions
	questionCounter += 1
	%%-- Reassigning the finsihed variable to 1 (of the current question)
	%%- In order for it to not be chosen, so it cannot be repeated
	finished (question) := 1
	%%-- Exit when 15 questions have been asked
	exit when questionCounter = 15
    end loop
    display
end userInput

%%-- Quiz result screen
body procedure display
    %%-- Font assignment
    displayFont := Font.New ("Copperplate Gothic Bold:15")
    %%-- Final score processing
    score := (correctAnswer/15.0)*100.0
    %%-- Assigning the value of 1 to both variables
    secondNum := 49
    firstNum := 49
   
    %%-- Beginning of loop
    loop 
	%%-- Calling stretched background
	background3
	%%-- Declaring that the second number decreases by 1 each time the program loops
	secondNum -= 1
	%%-- If the second number is less than zero, then
	if secondNum = 47 then
	    %%-- Assign the two numbers the:
	    secondNum := 57 % ASCII value of 9
	    firstNum := 32 % ASCII value of 0
	end if
	%%-- Message declaration and assignment 
	var message : array 1 ..6 of string
	message (1) := "Welcome. Congratulations on making it this far."
	message (2) := "You have been taught about computer hardware."
	message (3) := "You have also been tested on your knowledge."
	message (4) := "Let's see your result."
	message (5) := "Your score is "+ realstr(score,2) + "%"
	message (6) := "(This window will return to Main Menu in " + chr (firstNum) + chr (secondNum) + " seconds)"
	%%-- Displaying the messages
	Font.Draw (message (1), 1, 250, displayFont, 77)
	Font.Draw (message (2), 2, 230, displayFont, 77)  
	Font.Draw (message (3), 2, 210, displayFont, 77)
	Font.Draw (message (4), 3, 190, displayFont, 77)
	Font.Draw (message (5), 1, 160, displayFont, 77)
	Font.Draw (message (6), 1, 100, displayFont, 77)
  
	if score <= 49 then
	    Font.Draw ("Try harder next time. Nobody fails my quiz!", 1, 120, quizFont, red)
	elsif score > 50 and score <= 99 then
	    Font.Draw ("You passed.. But you can do better.", 1, 120, quizFont, 77)
	elsif score = 100 then
	    Font.Draw ("Congratulations. The student has become the master.", 1, 120, quizFont, purple)
	end if
	View.Update
	%%-- Delay of one second so the countdown is realistic
	delay (1000)
	%%-- exit when the first number is a space and the second number is 0
	exit when firstNum = 32 and secondNum = 48
    end loop
    %%-- Clearing the correctAnswer variable so if the user decides to try agaib they start from the beginning
    correctAnswer := 0
    %%-- Calling mainMenu
    mainMenu
end display

%%-- Ending message and end of program
body procedure goodBye
    %%-- Stopping the music that begins in intro
    Music.PlayFileStop
    %%-- Begin playing outro music
    Music.PlayFileLoop ("Thats all folks!.wav")
    %%-- Closing open windows
    Window.Close (mainMenuWindow)
    %%-- Declaring, creating, and opening the goodbye window
    var exitWindow := Window.Open ("position:320;400,graphics:640;400")
    Window.SetActive (exitWindow)
    %%-- Setting the screen
    setscreen ("offscreenonly")
    %%-- Font assignment
    exitFont := Font.New ("Copperplate Gothic Bold:14")
    %%-- Assigning the value of 1 to both variables
    secondNum := 49
    firstNum := 49
    %%-- Font assignment
    introFont := Font.New ("Comic Sans:20")
    %%-- Beginning of loop
    loop
	%%-- Calling background
	background 
	%%-- Declaring that the second number decreases by 1 each time the program loops
	secondNum -= 1
	%%-- If the second number is less than zero, then
	if secondNum = 47 then
	    %%-- Assign the two numbers the:
	    secondNum := 57 % ASCII value of 9
	    firstNum := 32 % ASCII value of 0
	end if
	%%-- Declaration and assignment of array ending
	var ending : array 1 .. 4 of string
	ending (1) := "This program was designed and created by Tamir Arnesty"
	ending (2) := "Thank you for using my program."
	ending (3) := "I hope you learned a lot about computer hardware!"
	ending (4) := "(This window will close in " + chr (firstNum) + chr (secondNum) + " seconds)"
	%%-- Displaying the texts
	Font.Draw (ending (1), 1, 300, exitFont, 77)
	Font.Draw (ending (2), 1, 275, exitFont, 77)
	Font.Draw (ending (3), 1, 250, exitFont, 77)
	Font.Draw (ending (4), 1, 225, exitFont, 77)
	View.Update
	%%-- Delay of one second so the countdown is realistic
	delay (1000)
	%%-- exit when the first number is a space and the second number is 0
	exit when firstNum = 32 and secondNum = 48
    end loop
    %%-- End of loop
    %%-- Stop the music
    Music.PlayFileStop
    %%-- Close the window
    Window.Close (exitWindow)
    %%-- Quit the program
    GUI.Quit
    View.Update
end goodBye


%%%--- Main Program
intro
loop
    exit when GUI.ProcessEvent
end loop
goodBye
%%%--- End of Program




