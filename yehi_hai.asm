.MODEL SMALL
.STACK 100H
.DATA

; ===================== CUBE VARIABLES =====================
XCUBE  DW 184      ; X-coordinate of the cube (player)
X1CUBE DW ?        ; Temporary  variable for cube (e.g., left edge)
X2CUBE DW ?        ; Temporaryvariable for cube (e.g., right edge)

YCUBE  DW 50       ; Y-coordinate of the cube (player)
Y1CUBE DW ?        ; Temporary  variable for cube (e.g., top edge)
Y2CUBE DW ?        ; Temporary variable for cube (e.g., bottom edge)

; ===================== FIRST LINE VARIABLES =====================
XLINE  DW 100      ; X-coordinate of the first falling line
X1LINE DW ?        ; Temporary  variable for line (e.g., left edge)
X2LINE DW ?        ; Temporary variable for line (e.g., right edge)

YLINE  DW 190      ; Y-coordinate of the first falling line
YLINE DW ?        ; Temporary / boundary variable for line (e.g., top edge)
Y2LINE DW ?        ; Temporary / boundary variable for line (e.g., bottom edge)

; ===================== SECOND LINE VARIABLES =====================
NXLINE  DW 160     ; X-coordinate of the second falling line
NX1LINE DW ?       ; Temporary / boundary variable for line
NX2LINE DW ?       ; Temporary / boundary variable for line

NYLINE  DW 70      ; Y-coordinate of the second falling line
NY1LINE DW ?       ; Temporary  variable for line
NY2LINE DW ?       ; Temporary variable for line

; ===================== THIRD LINE VARIABLES =====================
NNXLINE  DW 30     ; X-coordinate of the third falling line
NNX1LINE DW ?      ; Temporary  variable for line
NNX2LINE DW ?      ; Temporary  variable for line

NNYLINE  DW 140    ; Y-coordinate of the third falling line
NNY1LINE DW ?      ; Temporary variable for line
NNY2LINE DW ?      ; Temporary variable for line

; ===================== FOURTH LINE VARIABLES =====================
NNNXLINE  DW 230   ; X-coordinate of the fourth falling line
NNNX1LINE DW ?     ; Temporary variable for line
NNNX2LINE DW ?     ; Temporary variable for line

NNNYLINE  DW 100   ; Y-coordinate of the fourth falling line
NNNY1LINE DW ?     ; Temporary variable for line
NNNY2LINE DW ?     ; Temporary variable for line

             
 CHECK DW 1          ; Used as a flag for input handling in DELAY routines (checks if key press should be considered)

RANDNUMBER DW 0     ; Stores a randomly generated number for positioning the falling lines

TIK DW ?            ; Temporary variable to store system clock ticks for implementing delays

CHECK_UND DW 0      ; Flag to check collision of cube with first falling line (XLINE/YLINE)
NCHECK_UND DW 0     ; Flag to check collision of cube with second falling line (NXLINE/NYLINE)
NNCHECK_UND DW 0    ; Flag to check collision of cube with third falling line (NNXLINE/NNYLINE)
NNNCHECK_UND DW 0   ; Flag to check collision of cube with fourth falling line (NNNXLINE/NNNYLINE)

RATE DW 1           ; controls score increment rate or game speed factor

SCOREMSG DB 'Score: $' ; Message template for displaying the score on screen
SCORE DW 0          ; Stores current score of the player
SCORE1 DW 0         ; Backup of score (maybe used when restarting or after game over)
HIGHSCORE DW 0      ; Stores highest score achieved in the current session

COUNT DW 3          ; Player's remaining lives (current)
COUNT1 DW 3         ; Backup of remaining lives (for restarting the game)

X DW 1              ; Auxiliary variable used in life increment/decrement logic
Y DW 1              ; Auxiliary variable used in life increment/decrement logic

BORDERX DW 1        ; X-coordinate for drawing the border
BORDERY DW 16       ; Y-coordinate for drawing the border
 
                
  MSG DB 0AH,0DH,0AH,0DH,0AH,0DH,0AH,0DH,'             RAPID ROLL$'  
 MSG1 DB 0AH,0DH,0AH,0DH,0AH,0DH,0AH,0DH,0AH,0DH,'       PRESS 1 TO START THE GAME$'
 MSG2 DB 0AH,0DH,0AH,0DH,'       PRESS 2 FOR HELP$'
 MSG3 DB 0AH,0DH,0AH,0DH,'       PRESS 3 TO EXIT THE GAME$'
 MSG4 DB 0AH,0DH,0AH,0DH,0AH,0DH,0AH,0DH,0AH,0DH,'           COAL  PROJECT$'   
 MSG5 DB 0AH,0DH,0AH,0DH,'   PREPARED BY Noor Fatima,Laiba Amir$' 
 MSG6 DB 0AH,0DH,' LIFE REMAINING: 3$'
 MSG7 DB 0AH,0DH,' LIFE REMAINING: 2$'
 MSG8 DB 0AH,0DH,' LIFE REMAINING: 1$'  
 MSG9 DB '                SCORE: $'   
 MSG10 DB 0AH,0DH,'LIFE REMAINING:$'
 
 
 IMSG1 DB 0AH,0DH,' YOU HAVE A SMALL CUBE THAT FALLS ALONG'
      db 0AH,0DH,0AH,0DH,' THROUGH THE SCREEN. BY CONTINUING IN'
      db 0AH,0DH,0AH,0DH,' YOUR DESCEND THROUGH LEVELS OF THE '
      db 0AH,0DH,0AH,0DH,' GAME,YOU GAIN POINTS'
      db 0AH,0DH,0AH,0DH,0AH,0DH,' CONTROLS:'
      db 0AH,0DH,0AH,0DH,' PRESS A TO MOVE LEFT'
      db 0AH,0DH,0AH,0DH,' PRESS D TO MOVE RIGHT'
      db 0AH,0DH,0AH,0DH,0AH,0DH,0AH,0DH,0AH,0DH,0AH,0DH,0AH,0DH,0AH,0DH,' PRESS ANY KEY TO GET BACK$'      

  GAMEOVERMSG DB 0AH,0DH,0AH,0DH,0AH,0DH,0AH,0DH,0AH,0DH,0AH,0DH,'              GAME OVER'
              DB 0AH,0DH,0AH,0DH,0AH,0DH,'            YOUR SCORE: $'
        
  GAMEOVERMSG1 DB 0AH,0DH,0AH,0DH,0AH,0DH,'         PRESS P TO PLAY AGAIN$'  
  
  GAMEOVERMSG2 DB 0AH,0DH,0AH,0DH,0AH,0DH,0AH,0DH,0AH,0DH,0AH,0DH,0AH,0DH,'        YOU FORFEITED THE GAME$' 
  
  GAMEOVERMSG3 DB 0AH,0DH,0AH,0DH,0AH,0DH,'           PRESS X TO EXIT$'  
  
  
  HIGHESTMSG  DB  0AH,0DH,0AH,0DH,'           HIGHEST SCORE: 100$'   
  HIGHESTMSG2 DB  0AH,0DH,0AH,0DH,0AH,0DH,'           HIGHEST SCORE: $' 
  
  SCORE_ARRAY DB ? ;2,2,3,0,0
  
.CODE 


; ----------------------------
; Initialize positions of cube and lines for "Play Again" screen
; ----------------------------
PLAY_AGAIN PROC   
    MOV XCUBE , 184       ; Set initial X coordinate of cube
    MOV YCUBE , 50        ; Set initial Y coordinate of cube

    MOV XLINE , 100       ; Set X coordinate for line (first option)
    MOV YLINE , 190       ; Set Y coordinate for line (first option)

    MOV NXLINE , 160      ; Set X coordinate for line (second option)
    MOV NYLINE , 70       ; Set Y coordinate for line (second option)
             
    MOV NNXLINE , 30      ; Set X coordinate for line (third option)
    MOV NNYLINE , 140     ; Set Y coordinate for line (third option)

    MOV NNNXLINE , 230    ; Set X coordinate for line (fourth option)
    MOV NNNYLINE , 100    ; Set Y coordinate for line (fourth option)

    RET
PLAY_AGAIN ENDP 

; ----------------------------
; Initialize cube position for alternative "Play Again" screen
; ----------------------------
PLAY_AGAIN_2 PROC
    MOV XCUBE , 36        ; Cube X position
    MOV YCUBE , 56        ; Cube Y position
    RET
PLAY_AGAIN_2 ENDP

; ----------------------------
; Draw cube moving UP
; ----------------------------
UPDRAWCUBE PROC 
    MOV BX,XCUBE
    MOV X1CUBE,BX
    MOV X2CUBE,BX
    ADD X1CUBE,7          ; X1CUBE = end X position of cube for horizontal line
    
    MOV BX,YCUBE
    MOV Y1CUBE,BX
    MOV Y2CUBE,BX
    SUB Y1CUBE,7          ; Y1CUBE = end Y position after moving up

LUP:
    MOV AH,0CH            ; BIOS: plot pixel function
    MOV AL,12             ; Color: RED
    MOV CX,XCUBE
    MOV DX,YCUBE
    INT 10H               ; Draw pixel
    INC XCUBE             ; Move cube pixel by pixel horizontally
    MOV BX,X1CUBE
    CMP XCUBE,BX
    JLE LUP               ; Repeat until X1CUBE reached
    MOV BX,X2CUBE
    MOV XCUBE,BX
    DEC YCUBE             ; Move cube vertically up
    MOV BX,Y1CUBE
    CMP YCUBE,BX
    JNE LUP               ; Repeat until Y1CUBE reached

    RET
ENDP UPDRAWCUBE

; ----------------------------
; Draw cube moving DOWN
; ----------------------------
DOWNDRAWCUBE PROC 
    MOV BX,XCUBE
    MOV X1CUBE,BX
    MOV X2CUBE,BX
    ADD X1CUBE,7

    MOV BX,YCUBE
    MOV Y1CUBE,BX
    MOV Y2CUBE,BX
    ADD Y1CUBE,7           ; Move down by 7 pixels

LDOWN:
    MOV AH,0CH
    MOV AL,12              ; RED color
    MOV CX,XCUBE
    MOV DX,YCUBE
    INT 10H
    INC XCUBE
    MOV BX,X1CUBE
    CMP XCUBE,BX
    JLE LDOWN
    MOV BX,X2CUBE
    MOV XCUBE,BX
    INC YCUBE              ; Move cube vertically down
    MOV BX,Y1CUBE
    CMP YCUBE,BX
    JNE LDOWN

    RET
ENDP DOWNDRAWCUBE

; ----------------------------
; Remove cube moving UP
; ----------------------------
UPRMVCUBE PROC  
    MOV BX,X2CUBE          
    MOV XCUBE,BX
    MOV BX,XCUBE
    MOV X1CUBE,BX
    MOV X2CUBE,BX
    ADD X1CUBE,7
    MOV BX,Y2CUBE
    MOV YCUBE,BX

L1:
    MOV AH,0CH
    MOV AL,0               ; Black color = erase pixel
    MOV CX,XCUBE
    MOV DX,YCUBE
    INT 10H
    INC XCUBE
    MOV BX,X1CUBE
    CMP XCUBE,BX
    JLE L1
    MOV BX,X2CUBE
    MOV XCUBE,BX
    DEC YCUBE
    MOV BX,Y1CUBE
    CMP YCUBE,BX
    JNE L1
    MOV BX,X2CUBE
    MOV XCUBE,BX
    MOV BX,Y2CUBE
    MOV YCUBE,BX 
    RET
ENDP UPRMVCUBE

; ----------------------------
; Remove cube moving DOWN
; ----------------------------
DOWNRMVCUBE PROC 
    MOV BX,X2CUBE           
    MOV XCUBE,BX
    MOV BX,XCUBE
    MOV X1CUBE,BX
    MOV X2CUBE,BX
    ADD X1CUBE,7 
    MOV BX,Y2CUBE
    MOV YCUBE,BX

L1DOWN:
    MOV AH,0CH
    MOV AL,0               ; Black = erase
    MOV CX,XCUBE
    MOV DX,YCUBE
    INT 10H
    INC XCUBE
    MOV BX,X1CUBE
    CMP XCUBE,BX
    JLE L1DOWN
    MOV BX,X2CUBE
    MOV XCUBE,BX
    INC YCUBE
    MOV BX,Y1CUBE
    CMP YCUBE,BX
    JNE L1DOWN
    MOV BX,X2CUBE
    MOV XCUBE,BX
    MOV BX,Y2CUBE
    MOV YCUBE,BX
    RET
ENDP DOWNRMVCUBE  

; ----------------------------
; Check if cube is aligned with line (up or down)
; ----------------------------
CHECK_UP_OR_DOWN PROC  
    MOV BX,YLINE
    SUB BX,3
    CMP YCUBE,BX
    JE NEXTPHASE
    DEC BX     
    CMP YCUBE,BX
    JE  NEXTPHASE  
    MOV CHECK_UND,0
    JMP DID
    
NEXTPHASE:
    MOV BX,XLINE
    ADD BX,57
    CMP XCUBE,BX
    JL NEXTPHASE1
    MOV CHECK_UND,0
    JMP DID
    
NEXTPHASE1:
    MOV BX,XLINE
    SUB BX,9
    CMP BX,XCUBE
    JL LASTPHASE
    MOV CHECK_UND,0
    JMP DID
    
LASTPHASE:
    MOV CHECK_UND,1       ; Cube is correctly aligned
DID:
    RET
ENDP CHECK_UP_OR_DOWN

; ----------------------------
; Check alignment for alternative line positions
; ----------------------------
; ==================================================================================
; NCHECK_UP_OR_DOWN PROCEDURE
; Purpose: Checks if the cube is properly aligned with a second line option.
; This is used to determine if the cube has reached a selectable position on the screen.
; Input: XCUBE, YCUBE - current cube coordinates
; Output: NCHECK_UND - flag indicating whether the cube is aligned (1 = aligned, 0 = not aligned)
; ==================================================================================
NCHECK_UP_OR_DOWN PROC
    MOV BX,NYLINE           ; Load the Y coordinate of the line into BX
    SUB BX,3                ; Allow a tolerance of 3 pixels for vertical alignment
    CMP YCUBE,BX            ; Compare cube Y with the top tolerance
    JE  NNEXTPHASE          ; If equal, jump to X-axis check
    DEC BX                  ; Check one pixel lower for small margin
    CMP YCUBE,BX
    JE  NNEXTPHASE
    MOV NCHECK_UND,0        ; Cube is not vertically aligned
    JMP NDID                ; Skip the rest of checks

NNEXTPHASE:
    MOV BX,NXLINE           ; Load X coordinate of line
    ADD BX,57               ; Right boundary of the selectable area
    CMP XCUBE,BX
    JL NNEXTPHASE1          ; If cube is left of boundary, continue to next phase
    MOV NCHECK_UND,0        ; Otherwise, cube is out of horizontal alignment
    JMP NDID

NNEXTPHASE1:
    MOV BX,NXLINE
    SUB BX,9                ; Left boundary of the selectable area
    CMP BX,XCUBE
    JL NLASTPHASE           ; If cube is beyond left boundary, go to final phase
    MOV NCHECK_UND,0        ; Not horizontally aligned
    JMP NDID

NLASTPHASE:
    MOV NCHECK_UND,1        ; Cube is correctly aligned with both X and Y boundaries

NDID:
    RET                     ; Return to calling procedure
ENDP NCHECK_UP_OR_DOWN

; ==================================================================================
; NNCHECK_UP_OR_DOWN PROCEDURE
; Purpose: Checks if the cube is aligned with the third selectable line option.
; This uses the coordinates NNXLINE and NNYLINE for horizontal and vertical checks.
; Same logic as NCHECK_UP_OR_DOWN but for a different position on the screen.
; ==================================================================================
NNCHECK_UP_OR_DOWN PROC
    MOV BX,NNYLINE
    SUB BX,3
    CMP YCUBE,BX
    JE NNNEXTPHASE
    DEC BX
    CMP YCUBE,BX
    JE  NNNEXTPHASE
    MOV NNCHECK_UND,0       ; Cube not aligned vertically
    JMP NNDID

NNNEXTPHASE:
    MOV BX,NNXLINE
    ADD BX,57
    CMP XCUBE,BX
    JL NNNEXTPHASE1
    MOV NNCHECK_UND,0       ; Cube not aligned horizontally
    JMP NNDID

NNNEXTPHASE1:
    MOV BX,NNXLINE
    SUB BX,9
    CMP BX,XCUBE
    JL NNLASTPHASE
    MOV NNCHECK_UND,0
    JMP NNDID

NNLASTPHASE:
    MOV NNCHECK_UND,1        ; Cube is aligned with 3rd option

NNDID:
    RET
ENDP NNCHECK_UP_OR_DOWN

; ==================================================================================
; NNNCHECK_UP_OR_DOWN PROCEDURE
; Purpose: Checks if the cube is aligned with the fourth selectable line option.
; Uses NNNXLINE and NNYYLINE for horizontal and vertical boundaries.
; Output flag: NNNCHECK_UND = 1 if cube is aligned, 0 otherwise.
; This ensures that cube movement and selection is limited to valid areas.
; ==================================================================================
NNNCHECK_UP_OR_DOWN PROC
    MOV BX,NNNYLINE
    SUB BX,3
    CMP YCUBE,BX
    JE  NNNNEXTPHASE
    DEC BX
    CMP YCUBE,BX
    JE  NNNNEXTPHASE
    MOV NNNCHECK_UND,0       ; Cube not aligned vertically
    JMP NNNDID

NNNNEXTPHASE:
    MOV BX,NNNXLINE
    ADD BX,57
    CMP XCUBE,BX
    JL NNNNEXTPHASE1
    MOV NNNCHECK_UND,0       ; Cube not aligned horizontally
    JMP NNNDID

NNNNEXTPHASE1:
    MOV BX,NNNXLINE
    SUB BX,9
    CMP BX,XCUBE
    JL NNNLASTPHASE
    MOV NNNCHECK_UND,0       ; Cube out of left boundary
    JMP NNNDID

NNNLASTPHASE:
    MOV NNNCHECK_UND,1       ; Cube fully aligned with 4th option

NNNDID:
    RET
ENDP NNNCHECK_UP_OR_DOWN

; ==================================================================================
; DELAY PROCEDURE
; Purpose: Introduces a controlled time delay in the program.
; This procedure also optionally handles direct keyboard input if CHECK > 0.
; ==================================================================================
DELAY PROC
    ; -------------------------
    ; Get current system time
    ; -------------------------
    MOV AX,00H
    INT 1AH                   ; BIOS call: Read system clock
    MOV TIK,DX                ; Store low-order part of timer
    ADD TIK,3H                ; Add small offset to define delay duration

DELAYL:
    MOV AX,00H
    INT 1AH                   ; Read current time again
    CMP TIK,DX                ; Compare with target time
    JGE DELAYL                ; Loop until delay has passed

    ; -------------------------
    ; Optional keyboard input
    ; -------------------------
    CMP CHECK,0               ; Check if we need to handle key input
    JE DDD                    ; If CHECK=0, skip input

    MOV AH,7                  ; DOS function: direct keyboard input without echo
    INT 21H                   ; Read character from keyboard
    DEC CHECK                 ; Reduce CHECK to track number of inputs

; ==================================================================================
; DELAY PROCEDURES (DELAY, DELAY2, DELAY3, DELAY4, DELAY5)
; Purpose: Introduce timed pauses in the program for controlling speed of movements
;          or animations. Each delay has a slightly different duration.
; Input: CHECK - if > 0, allows keyboard input during delay
; Output: None (but CHECK is decremented if a key is read)
; ==================================================================================

; -------------------------
; DELAY - default delay (~3 ticks)
; -------------------------
DELAY PROC
    MOV AX,00H               ; BIOS call function 00H - read system clock
    INT 1AH                  ; Read current time into DX:AX
    MOV TIK,DX               ; Store low-order part of timer in TIK
    ADD TIK,3H               ; Set target time after 3 clock ticks

DELAYL:
    MOV AX,00H
    INT 1AH                  ; Read current time
    CMP TIK,DX               ; Compare current time with target
    JGE DELAYL               ; Loop until target time is reached

    CMP CHECK,0              ; Check if keyboard input should be handled
    JE DDD                   ; Skip if CHECK = 0

    MOV AH,7                 ; DOS function: direct input, no echo
    INT 21H                  ; Read key from keyboard
    DEC CHECK                ; Decrement CHECK to track input availability

DDD:
    RET
ENDP DELAY

; -------------------------
; DELAY2 - shorter delay (~2 ticks)
; Same logic as DELAY but slightly faster
; -------------------------
DELAY2 PROC
    MOV AX,00H
    INT 1AH
    MOV TIK,DX
    ADD TIK,2H               ; Shorter duration than DELAY

DELAYL2:
    MOV AX,00H
    INT 1AH
    CMP TIK,DX
    JGE DELAYL2

    CMP CHECK,0
    JE DDD2

    MOV AH,7
    INT 21H
    DEC CHECK

DDD2:
    RET
ENDP DELAY2

; -------------------------
; DELAY3 - even shorter delay (~1 tick)
; -------------------------
DELAY3 PROC
    MOV AX,00H
    INT 1AH
    MOV TIK,DX
    ADD TIK,1H               ; Shortest delay

DELAYL3:
    MOV AX,00H
    INT 1AH
    CMP TIK,DX
    JGE DELAYL3

    CMP CHECK,0
    JE DDD3

    MOV AH,7
    INT 21H
    DEC CHECK

DDD3:
    RET
ENDP DELAY3

; -------------------------
; DELAY4 - delay with 0 tick increment (essentially reads current time once)
; Useful for instantaneous or minimal delay operations
; -------------------------
DELAY4 PROC
    MOV AX,00H
    INT 1AH
    MOV TIK,DX               ; Capture current time

DELAYL4:
    MOV AX,00H
    INT 1AH
    CMP TIK,DX
    JGE DELAYL4

    CMP CHECK,0
    JE DDD4

    MOV AH,7
    INT 21H
    DEC CHECK

DDD4:
    RET
ENDP DELAY4

; -------------------------
; DELAY5 - negative delay offset (SUB TIK,1H)
; Used for specific timing adjustments, perhaps to create small reverse delay
; -------------------------
DELAY5 PROC
    MOV AX,00H
    INT 1AH
    MOV TIK,DX
    SUB TIK,1H               ; Adjust timer for negative offset

DELAYL5:
    MOV AX,00H
    INT 1AH
    CMP TIK,DX
    JGE DELAYL5

    CMP CHECK,0
    JE DDD5

    MOV AH,7
    INT 21H
    DEC CHECK

DDD5:
    RET
ENDP DELAY5

; ==================================================================================
; DRAWLINE PROCEDURE
; Purpose: Draws a diagonal/red line on the screen from a starting X,Y coordinate.
; Input: XLINE, YLINE - starting position of the line
; Output: X1LINE, X2LINE, Y1LINE, Y2LINE - temporary variables used for drawing
; Notes:
;   - Uses INT 10H BIOS call 0Ch to plot pixels
;   - Draws line from bottom-left to top-right by incrementing X and decrementing Y
; ==================================================================================
DRAWLINE PROC
    MOV BX,XLINE
    MOV X1LINE,BX
    MOV X2LINE,BX
    ADD X1LINE,55            ; Define end X coordinate of line (length = 55 pixels)

    MOV BX,YLINE
    MOV Y1LINE,BX
    MOV Y2LINE,BX
    SUB Y1LINE,3             ; Small adjustment for vertical tolerance

LINE:
    MOV AH,0CH                ; BIOS function to plot pixel
    MOV AL,4                  ; Set color RED
    MOV CX,XLINE
    MOV DX,YLINE
    INT 10H                   ; Draw pixel at (CX,DX)
    INC XLINE                 ; Move pixel horizontally
    MOV BX,X1LINE
    CMP XLINE,BX
    JLE LINE                  ; Continue until end X coordinate

    MOV BX,X2LINE
    MOV XLINE,BX
    DEC YLINE                 ; Move pixel vertically up
    MOV BX,Y1LINE
    CMP YLINE,BX
    JNE LINE                  ; Continue vertical line drawing

    RET
ENDP DRAWLINE
 
 
; ==================================================================================
; RMVLINE PROCEDURE
; Purpose: Removes a previously drawn diagonal RED line by overwriting it with
;          background color (BLACK) pixels.
; Input: XLINE, YLINE - current starting coordinates of the line
;        X1LINE, X2LINE, Y1LINE, Y2LINE - temporary variables for drawing boundaries
; Output: The RED line is erased from the screen
; ==================================================================================
RMVLINE PROC 
    MOV BX,XLINE
    MOV X1LINE,BX
    MOV X2LINE,BX
    ADD X1LINE,55            ; Define end X coordinate (line length)

    MOV XLINE,BX
    MOV BX,Y2LINE
    MOV YLINE,BX             ; Reset starting Y position

LINE1: 
    MOV AH,0CH               ; BIOS function: plot pixel
    MOV AL,0                 ; Set pixel color to BLACK (background)
    MOV CX,XLINE
    MOV DX,YLINE
    INT 10H                  ; Draw pixel
    INC XLINE                ; Move pixel horizontally
    MOV BX,X1LINE
    CMP XLINE,BX
    JLE LINE1                ; Repeat until end of line horizontally

    MOV BX,X2LINE
    MOV XLINE,BX
    DEC YLINE                ; Move pixel vertically
    MOV BX,Y1LINE
    CMP YLINE,BX
    JNE LINE1                ; Repeat until vertical component complete

    MOV BX,X2LINE
    MOV XLINE,BX
    MOV BX,Y2LINE
    MOV YLINE,BX             ; Reset coordinates
    RET
RMVLINE ENDP  

; ==================================================================================
; DRAWNLINE PROCEDURE
; Purpose: Draws a diagonal CYAN line on the screen at coordinates NXLINE, NYLINE
; Input: NXLINE, NYLINE - starting position
; Output: The line is drawn pixel by pixel
; Notes: Color = 3 (CYAN), line length = 55 pixels, diagonal drawn top-right
; ==================================================================================
DRAWNLINE PROC
    MOV BX,NXLINE
    MOV NX1LINE,BX
    MOV NX2LINE,BX
    ADD NX1LINE,55           ; Set end X coordinate

    MOV BX,NYLINE
    MOV NY1LINE,BX
    MOV NY2LINE,BX
    SUB NY1LINE,3            ; Small vertical adjustment for top edge

NLINE:
    MOV AH,0CH               ; BIOS function: plot pixel
    MOV AL,3                 ; CYAN color
    MOV CX,NXLINE
    MOV DX,NYLINE
    INT 10H                  ; Draw pixel
    INC NXLINE
    MOV BX,NX1LINE
    CMP NXLINE,BX
    JLE NLINE                ; Repeat horizontal component

    MOV BX,NX2LINE
    MOV NXLINE,BX
    DEC NYLINE               ; Move vertically
    MOV BX,NY1LINE
    CMP NYLINE,BX
    JNE NLINE                ; Repeat vertical component

    RET
DRAWNLINE ENDP

; ==================================================================================
; RMVNLINE PROCEDURE
; Purpose: Removes previously drawn CYAN line
; Input: NXLINE, NYLINE - starting coordinates
; Output: Line erased using BLACK color
; ==================================================================================
RMVNLINE PROC 
    MOV BX,NXLINE
    MOV NX1LINE,BX
    MOV NX2LINE,BX
    ADD NX1LINE,55           ; End X coordinate

    MOV NXLINE,BX
    MOV BX,NY2LINE
    MOV NYLINE,BX            ; Reset Y coordinate

NLINE1:  
    MOV AH,0CH
    MOV AL,0                 ; BLACK color
    MOV CX,NXLINE
    MOV DX,NYLINE
    INT 10H
    INC NXLINE
    MOV BX,NX1LINE
    CMP NXLINE,BX
    JLE NLINE1

    MOV BX,NX2LINE
    MOV NXLINE,BX
    DEC NYLINE
    MOV BX,NY1LINE
    CMP NYLINE,BX
    JNE NLINE1

    MOV BX,NX2LINE
    MOV NXLINE,BX
    MOV BX,NY2LINE
    MOV NYLINE,BX
    RET
RMVNLINE ENDP

; ==================================================================================
; DRAWNNLINE PROCEDURE
; Purpose: Draws a diagonal MAGENTA line using NNXLINE, NNYLINE as starting points
; Input: NNXLINE, NNYLINE
; Output: Line drawn pixel by pixel, color = MAGENTA (13)
; Notes: Diagonal from bottom-left to top-right
; ==================================================================================
DRAWNNLINE PROC
    MOV BX,NNXLINE
    MOV NNX1LINE,BX
    MOV NNX2LINE,BX
    ADD NNX1LINE,55          ; End X coordinate

    MOV BX,NNYLINE
    MOV NNY1LINE,BX
    MOV NNY2LINE,BX
    SUB NNY1LINE,3           ; Top vertical adjustment

NNLINE:
    MOV AH,0CH
    MOV AL,13                ; MAGENTA color
    MOV CX,NNXLINE
    MOV DX,NNYLINE
    INT 10H
    INC NNXLINE
    MOV BX,NNX1LINE
    CMP NNXLINE,BX
    JLE NNLINE

    MOV BX,NNX2LINE
    MOV NNXLINE,BX
    DEC NNYLINE
    MOV BX,NNY1LINE
    CMP NNYLINE,BX
    JNE NNLINE

NNDIDI:
    RET
DRAWNNLINE ENDP

; ==================================================================================
; RMVNNLINE PROCEDURE
; Purpose: Removes previously drawn MAGENTA line
; Input: NNXLINE, NNYLINE
; Output: Line erased using BLACK color
; ==================================================================================
RMVNNLINE PROC
    MOV BX,NNXLINE
    MOV NNX1LINE,BX
    MOV NNX2LINE,BX
    ADD NNX1LINE,55

    MOV NNXLINE,BX
    MOV BX,NNY2LINE
    MOV NNYLINE,BX

NNLINE1:
    MOV AH,0CH
    MOV AL,0                 ; BLACK color to erase
    MOV CX,NNXLINE
    MOV DX,NNYLINE
    INT 10H
    INC NNXLINE
    MOV BX,NNX1LINE
    CMP NNXLINE,BX
    JLE NNLINE1

    MOV BX,NNX2LINE
    MOV NNXLINE,BX
    DEC NNYLINE
    MOV BX,NNY1LINE
    CMP NNYLINE,BX
    JNE NNLINE1

    MOV BX,NNX2LINE
    MOV NNXLINE,BX
    MOV BX,NNY2LINE
    MOV NNYLINE,BX
    RET
RMVNNLINE ENDP

; ==================================================================================
; DRAWNNNLINE PROCEDURE
; Purpose: Draws a diagonal GREEN line using NNNXLINE, NNNYLINE as starting points
; Input: NNNXLINE, NNNYLINE
; Output: Line drawn pixel by pixel, color = GREEN (2)
; Notes: Similar logic to previous DRAW lines, uses INT 10H BIOS pixel plotting
; ==================================================================================
DRAWNNNLINE PROC
    MOV BX,NNNXLINE
    MOV NNNX1LINE,BX
    MOV NNNX2LINE,BX
    ADD NNNX1LINE,55

    MOV BX,NNNYLINE
    MOV NNNY1LINE,BX
    MOV NNNY2LINE,BX
    SUB NNNY1LINE,3           ; Small vertical adjustment

NNNLINE:
    MOV AH,0CH
    MOV AL,2                  ; GREEN color
    MOV CX,NNNXLINE
    MOV DX,NNNYLINE
    INT 10H
    INC NNNXLINE
    MOV BX,NNNX1LINE
    CMP NNNXLINE,BX
    JLE NNNLINE

    MOV BX,NNNX2LINE
    MOV NNNXLINE,BX
    DEC NNNYLINE
    MOV BX,NNNY1LINE
    CMP NNNYLINE,BX
    JNE NNNLINE
    RET

    
    
     
    NNNDIDI:
    
    RET
; ==================================================================================
; RMVNNNLINE PROCEDURE
; Purpose: Removes a previously drawn GREEN line on the screen
; Input: NNNXLINE, NNNYLINE - starting coordinates
; Output: The green line is erased by drawing black pixels over it
; ==================================================================================
RMVNNNLINE PROC 
    MOV BX,NNNXLINE
    MOV NNNX1LINE,BX
    MOV NNNX2LINE,BX
    ADD NNNX1LINE,55           ; Define end X coordinate (line length)
               
    MOV NNNXLINE,BX
    MOV BX,NNNY2LINE
    MOV NNNYLINE,BX            ; Reset Y coordinate

NNNLINE1:
    MOV AH,0CH                 ; BIOS function: plot pixel
    MOV AL,0                   ; BLACK color to erase line
    MOV CX,NNNXLINE
    MOV DX,NNNYLINE
    INT 10H
    INC NNNXLINE               ; Move horizontally
    MOV BX,NNNX1LINE
    CMP NNNXLINE,BX
    JLE NNNLINE1               ; Repeat until end X coordinate

    MOV BX,NNNX2LINE
    MOV NNNXLINE,BX
    DEC NNNYLINE               ; Move vertically
    MOV BX,NNNY1LINE
    CMP NNNYLINE,BX
    JNE NNNLINE1               ; Repeat vertical movement

    MOV BX,NNNX2LINE
    MOV NNNXLINE,BX
    MOV BX,NNNY2LINE
    MOV NNNYLINE,BX            ; Reset coordinates after erase
    RET
RMVNNNLINE ENDP

; ==================================================================================
; GENERATE_RANDOM_NUMBER PROCEDURE
; Purpose: Generates a pseudo-random number using system clock
; Registers used: AX, BX, CX, DX
; Macros: PUSHALL, POPALL to preserve registers
; Notes: The generated number is stored in variable RANDNUMBER
; ==================================================================================
GENERATE_RANDOM_NUMBER PROC

    PUSHALL MACRO
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
    ENDM

    POPALL MACRO
        POP DX
        POP CX
        POP BX
        POP AX
    ENDM

    GETRAND MACRO CUR
        PUSHALL
        MOV AH,0
        INT 1AH                  ; Read system clock
        MOV AX,DX                ; Move low-order part of clock to AX
        MOV DX,CX                ; Move high-order part to DX
        MOV BX,7261
        MUL AX                    ; Multiply AX with 7261
        ADD AX,1
        MOV DX,0
        MOV BX,200
        DIV BX                     ; Divide to constrain range
        MOV CUR,DX                ; Store remainder as random number
        POPALL
    ENDM

    MOV CX,0
    GETRAND RANDNUMBER           ; Generate random number
    RET
GENERATE_RANDOM_NUMBER ENDP

; ==================================================================================
; NEXT_XLINE PROCEDURE
; Purpose: Updates XLINE and YLINE when cube reaches top of screen (Y < 18)
;          Resets YLINE and sets XLINE to a new random X position
; ==================================================================================
NEXT_XLINE PROC
    CMP YLINE,18
    JGE NOCHANGE
    MOV YLINE,196
    MOV Y2LINE,196             ; Reset vertical position
    MOV BX,RANDNUMBER
    MOV XLINE,BX
    MOV X1LINE,BX              ; Update horizontal position

NOCHANGE:
    RET
NEXT_XLINE ENDP

; ==================================================================================
; NEXT_NXLINE, NEXT_NNXLINE, NEXT_NNNXLINE PROCEDURES
; Purpose: Same as NEXT_XLINE but for NXLINE, NNXLINE, NNNXLINE
; Notes: Resets position if vertical coordinate < 18, assigns new random X
; ==================================================================================
NEXT_NXLINE PROC
    CMP NYLINE,18
    JGE NNOCHANGE
    MOV NYLINE,196
    MOV NY2LINE,196
    MOV BX,RANDNUMBER
    MOV NXLINE,BX
    MOV NX1LINE,BX
NNOCHANGE:
    RET
NEXT_NXLINE ENDP

NEXT_NNXLINE PROC
    CMP NNYLINE,18
    JGE NNNOCHANGE
    MOV NNYLINE,196
    MOV NNY2LINE,196
    MOV BX,RANDNUMBER
    MOV NNXLINE,BX
    MOV NNX1LINE,BX
NNNOCHANGE:
    RET
NEXT_NNXLINE ENDP

NEXT_NNNXLINE PROC
    CMP NNNYLINE,18
    JGE NNNNOCHANGE
    MOV NNNYLINE,196
    MOV NNNY2LINE,196
    MOV BX,RANDNUMBER
    MOV NNNXLINE,BX
    MOV NNNX1LINE,BX
NNNNOCHANGE:
    RET
NEXT_NNNXLINE ENDP

; ==================================================================================
; BORDER PROCEDURE
; Purpose: Draws rectangular border around the play area
; Uses INT 10H to plot pixels (AL=6, YELLOW)
; Draws top, bottom, left, right borders
; ==================================================================================
BORDER PROC
BOR:                                                  
    MOV AH,0CH
    MOV AL,6
    MOV CX,BORDERX
    MOV DX,BORDERY
    INT 10H
    INC BORDERX
    CMP BORDERX,318
    JE NNP
    JMP BOR

NNP:
    MOV BORDERX,1
    MOV BORDERY,198
BOR1:
    MOV AH,0CH
    MOV AL,6
    MOV CX,BORDERX
    MOV DX,BORDERY
    INT 10H
    INC BORDERX
    CMP BORDERX,318
    JE NNP1
    JMP BOR1

NNP1:
    MOV BORDERX,1
    MOV BORDERY,16
BOR2:
    MOV AH,0CH
    MOV AL,6
    MOV CX,BORDERX
    MOV DX,BORDERY
    INT 10H
    INC BORDERY
    CMP BORDERY,198
    JE NNP2
    JMP BOR2

NNP2:
    MOV BORDERX,318
    MOV BORDERY,16
BOR3:
    MOV AH,0CH
    MOV AL,6
    MOV CX,BORDERX
    MOV DX,BORDERY
    INT 10H
    INC BORDERY
    CMP BORDERY,198
    JG DADA
    JMP BOR3

DADA:
    MOV BORDERX,1
    MOV BORDERY,16
    RET
BORDER ENDP

; ==================================================================================
; MAIN_MENU PROCEDURE
; Purpose: Display main menu with options and handle user input
; Options: 1 - Start Game, 2 - Instructions, 3 - Exit
; Input: Keyboard character (AL)
; Output: Jumps to appropriate routines
; ==================================================================================
MAIN_MENU PROC
MPR:
    MOV AH,9
    LEA DX,MSG
    INT 21H
    LEA DX,MSG1
    INT 21H
    LEA DX,MSG2
    INT 21H
    LEA DX,MSG3
    INT 21H
    LEA DX,MSG4
    INT 21H
    LEA DX,MSG5
    INT 21H

LL1:
    MOV AH,7                   ; Direct keyboard input
    INT 21H
    CMP AL,'1'
    JE STG
    CMP AL,'2'
    JE INSTRUC
    CMP AL,'3'
    JE EXIT1
    JMP LL1

INSTRUC:
    CALL RESET_THE_SCREEN
    MOV AH,9
    LEA DX,IMSG1
    INT 21H
    MOV AH,1
    INT 21H                    ; Wait for any key
    CALL RESET_THE_SCREEN
    JMP MPR

STG:
    CALL RESET_THE_SCREEN
    MOV AH,9
    LEA DX,MSG10
    INT 21H
    MOV AH,9
    LEA DX,MSG9
    INT 21H
    JMP GAME

EXIT1:
    MOV AH,0
    MOV AL,2                   ; Reset text mode
    INT 10H
    MOV AH,4CH
    INT 21H                    ; Terminate program
    RET
MAIN_MENU ENDP

; ==================================================================================
; RESET_THE_SCREEN PROCEDURE
; Purpose: Clears the screen and sets graphics/text mode
; Uses BIOS interrupts:
;   INT 10H, AH=0, AL=2 -> Set text mode
;   INT 10H, AX=13H -> Set 320x200 graphics mode
; ==================================================================================
RESET_THE_SCREEN PROC
    MOV AH,0
    MOV AL,2
    INT 10H                     ; Text mode 80x25
    MOV AX,13H
    INT 10H                     ; Graphics mode 320x200
    RET
RESET_THE_SCREEN ENDP

   

OUTDEC PROC   
  
   PUSH BX                        ; push BX onto the STACK
   PUSH CX                       
   PUSH DX                        

   XOR CX, CX                     ; clear CX
   MOV BX, 10                     

 OUTPUT:                       
    
     XOR DX, DX                   ; clear DX
     DIV BX                       ; divide AX by BX
     PUSH DX                     
     INC CX                       
     OR AX, AX                    
    
   JNE OUTPUT                     ; jump to label OUTPUT if ZF=0

     MOV AH, 2                     

 DISP:                      
    
     POP DX                       ; pop a value from STACK to DX
     OR DL, 30H                   ; convert decimal to ascii code
     INT 21H                     
  
   LOOP DISP                   ; jump to label DISPLAY if CX!=0

    POP DX                        ; pop a value from STACK into DX
    POP CX                         
    POP BX 
                          
    RET                            
 
OUTDEC ENDP      

OUTDECGPS PROC   
  
   PUSH BX                        ; push BX onto the STACK
   PUSH CX                       
   PUSH DX                        

   XOR CX, CX                     ; clear CX
   MOV BX, 10                     

 OUTPUTGP:                       
    
     XOR DX, DX                   ; clear DX
     DIV BX                       ; divide AX by BX
     PUSH DX                     
     INC CX                       
     OR AX, AX                    
    
   JNE OUTPUTGP                     ; jump to label OUTPUT if ZF=0

     MOV AH, 0BH
     INT 10H
     MOV AH,02
     MOV BH,0
     MOV DH,1
     MOV DL,39
     INT 10H
     MOV AH,9                     

 DISPGP:                      
    
     POP DX                       ; pop a value from STACK to DX
     OR DL, 30H                   ; convert decimal to ascii code 
     MOV AL,DL
     MOV BL,2
     MOV CX,1
     INT 10H                     
  
   LOOP DISPGP                   ; jump to label DISPLAY if CX!=0

    POP DX                        ; pop a value from STACK into DX
    POP CX                         
    POP BX 
                          
    RET                            
 
OUTDECGPS ENDP           

OUTDECGPS1 PROC   
  
     MOV AH, 0BH
     INT 10H
     MOV AH,02
     MOV BH,0
     MOV DH,1
     MOV DL,38
     INT 10H
     MOV AH,9                     

     MOV AL,'1'
     MOV BL,2
     MOV CX,1
     INT 10H                     
                     
    RET                            
 
OUTDECGPS1 ENDP    

OUTDECGPS2 PROC   
  
     MOV AH, 0BH
     INT 10H
     MOV AH,02
     MOV BH,0
     MOV DH,1
     MOV DL,38
     INT 10H
     MOV AH,9                     

     MOV AL,'2'
     MOV BL,2
     MOV CX,1
     INT 10H                     
                     
    RET                            
 
OUTDECGPS2 ENDP  

OUTDECGPS3 PROC   
  
     MOV AH, 0BH
     INT 10H
     MOV AH,02
     MOV BH,0
     MOV DH,1
     MOV DL,38
     INT 10H
     MOV AH,9                     

     MOV AL,'3'
     MOV BL,2
     MOV CX,1
     INT 10H                     
                     
    RET                            
 
OUTDECGPS3 ENDP  

OUTDECGPS4 PROC   
  
     MOV AH, 0BH
     INT 10H
     MOV AH,02
     MOV BH,0
     MOV DH,1
     MOV DL,38
     INT 10H
     MOV AH,9                     

     MOV AL,'4'
     MOV BL,2
     MOV CX,1
     INT 10H                     
                     
    RET                            
 
OUTDECGPS4 ENDP   

OUTDECGPS5 PROC   
  
     MOV AH, 0BH
     INT 10H
     MOV AH,02
     MOV BH,0
     MOV DH,1
     MOV DL,38
     INT 10H
     MOV AH,9                     

     MOV AL,'5'
     MOV BL,2
     MOV CX,1
     INT 10H                     
                     
    RET                            
 
OUTDECGPS5 ENDP 

OUTDECGPS6 PROC   
  
     MOV AH, 0BH
     INT 10H
     MOV AH,02
     MOV BH,0
     MOV DH,1
     MOV DL,38
     INT 10H
     MOV AH,9                     

     MOV AL,'6'
     MOV BL,2
     MOV CX,1
     INT 10H                     
                     
    RET                            
 
OUTDECGPS6 ENDP 

OUTDECGPS7 PROC   
  
     MOV AH, 0BH
     INT 10H
     MOV AH,02
     MOV BH,0
     MOV DH,1
     MOV DL,38
     INT 10H
     MOV AH,9                     

     MOV AL,'7'
     MOV BL,2
     MOV CX,1
     INT 10H                     
                     
    RET                            
 
OUTDECGPS7 ENDP 

OUTDECGPS8 PROC   
  
     MOV AH, 0BH
     INT 10H
     MOV AH,02
     MOV BH,0
     MOV DH,1
     MOV DL,38
     INT 10H
     MOV AH,9                     

     MOV AL,'8'
     MOV BL,2
     MOV CX,1
     INT 10H                     
                     
    RET                            
 
OUTDECGPS8 ENDP 

OUTDECGPS9 PROC   
  
     MOV AH, 0BH
     INT 10H
     MOV AH,02
     MOV BH,0
     MOV DH,1
     MOV DL,38
     INT 10H
     MOV AH,9                     

     MOV AL,'9'
     MOV BL,2
     MOV CX,1
     INT 10H                     
                     
    RET                            
 
OUTDECGPS9 ENDP 

OUTDECGPC PROC   
                
   
   PUSH BX                        ; push BX onto the STACK
   PUSH CX                       
   PUSH DX                        

   XOR CX, CX                     ; clear CX
   MOV BX, 10                     

 OUTPUTGP1:                       
    
     XOR DX, DX                   ; clear DX
     DIV BX                       ; divide AX by BX
     PUSH DX                     
     INC CX                       
     OR AX, AX                    
    
   JNE OUTPUTGP1                     ; jump to label OUTPUT if ZF=0

     MOV AH, 0BH
     INT 10H
     MOV AH,02
     MOV BH,0
     MOV DH,1
     MOV DL,16
     INT 10H
     MOV AH,9                     

 DISPGP1:                      
    
     POP DX                       ; pop a value from STACK to DX
     OR DL, 30H                   ; convert decimal to ascii code 
     MOV AL,DL
     MOV BL,14
     MOV CX,1
     INT 10H                     
  
   LOOP DISPGP1                   ; jump to label DISPLAY if CX!=0

    POP DX                        ; pop a value from STACK into DX
    POP CX                         
    POP BX 
                          
    RET                                                
 
OUTDECGPC ENDP

GAME_OVER PROC
    
    
   
    MOV DI,0
    ;MOV BX,COUNT1
    ;MOV COUNT,BX
    GLO:
    
    DEC COUNT
    CMP COUNT,0
    JE  GLO1
     
   ; CALL RESET_THE_SCREEN 
   ; CALL PLAY_AGAIN_2
    
   ; MOV AH,9
   ; LEA DX,MSG10
   ; INT 21H 
    CALL RESET_THE_SCREEN
    MOV AH,9
    LEA DX,MSG10
    INT 21H  
    MOV AH,9 
    LEA DX,MSG9
    INT 21H 
    
    MOV AX,COUNT
    CALL OUTDECGPC 
    
    XOR AX,AX
    XOR BX,BX
    XOR CX,CX
    XOR DX,DX
    
    MOV AX,SCORE
    CALL OUTDECGPS 
    CALL PLAY_AGAIN_2
    JMP GAME
    
   GLO1:
    CALL RESET_THE_SCREEN 
    
    MOV AH,9
    LEA DX,GAMEOVERMSG
    INT 21H    
    
    MOV AX,SCORE
    CALL OUTDEC  
    
    MOV AH,9  
    LEA DX,HIGHESTMSG2
    INT 21H  
    
    MOV AX,SCORE
    CMP AX,HIGHSCORE
    JG  HSCORE  
    JMP NHSCORE
    
 HSCORE: 
    
    MOV AX,SCORE
    MOV HIGHSCORE,AX
    CALL OUTDEC 
    JMP FNSH 
    
 NHSCORE:
    
    MOV AX,HIGHSCORE
    CALL OUTDEC
    JMP FNSH 
    
 FNSH:
    MOV AH,9
    LEA DX,GAMEOVERMSG1
    INT 21H   
    
    LEA DX,GAMEOVERMSG3
    INT 21H 
    
    MOV BX,SCORE1
    MOV SCORE,BX
    
    AGA:
    ;DIRECT CHARACTER INPUT WITHOUT ECHO
    MOV AH,7
    INT 21H
    CMP AL,'X'
    JE GGG
    CMP AL,'x'
    JE GGG
    CMP AL,'P'
    JE DIDA 
    CMP AL,'p'
    JE DIDA
    JMP AGA
    
    DIDA:
    MOV BX,COUNT1
    MOV COUNT,BX 
    
    CALL RESET_THE_SCREEN   
    MOV AH,9
    LEA DX,MSG10
    INT 21H  
    MOV AH,9 
    LEA DX,MSG9
    INT 21H  
    CALL PLAY_AGAIN
    JMP GAME
    
    GGG:
     RET  
     
GAME_OVER ENDP   

HIGHEST PROC
    
    CALL RESET_THE_SCREEN 
    
    MOV AH,9
    LEA DX,GAMEOVERMSG
    INT 21H    
    
    MOV AX,SCORE
    CALL OUTDEC 
    
    MOV AH,9
    LEA DX,GAMEOVERMSG1
    INT 21H 
    
    MOV BX,SCORE1
    MOV SCORE,BX  
    
    MOV AH,9
    LEA DX,HIGHESTMSG
    INT 21H    
    
    LEA DX,GAMEOVERMSG3
    INT 21H 
    
    AGAH:
    ;DIRECT CHARACTER INPUT WITHOUT ECHO
    MOV AH,7
    INT 21H
    CMP AL,'X'
    JE GGGH
    CMP AL,'x'
    JE GGGH
    CMP AL,'P'
    JE DIDAH 
    CMP AL,'p'
    JE DIDAH
    JMP AGAH
    
    DIDAH:
    MOV BX,COUNT1
    MOV COUNT,BX 
    
    CALL RESET_THE_SCREEN   
    MOV AH,9
    LEA DX,MSG10
    INT 21H  
    MOV AH,9 
    LEA DX,MSG9
    INT 21H  
    CALL PLAY_AGAIN
    JMP GAME
    
    GGGH:
     RET  
     
HIGHEST ENDP  

FINAL_EX PROC
    MOV AH,0
    MOV AL,2
    INT 10H
       
    MOV AH,4CH
    INT 21H
FINAL_EX ENDP

 MAIN PROC
   
    MOV AX,@DATA
    MOV DS,AX 
    
    ;SET GRAPHICS MODE 320 X 200 256 COLOR
    MOV AX,13H
    INT 10H
    CALL MAIN_MENU   
    
    MOV BX,COUNT1
    MOV COUNT,BX   
    
  GAME:
    
    ;Checks to see if a character is available in the buffer
    MOV AH,1
    INT 16H
    
     JZ NOKEYPRESS  ;JUMP IF FLAG IS ZERO
    JNZ KEYPRESS
NOKEYPRESS:

    ;-----------------------------
    ; Move all the lines automatically
    ;-----------------------------
    CALL NEXT_XLINE       ; Update the main red line's position
    CALL NEXT_NXLINE      ; Update cyan line's position
    CALL NEXT_NNXLINE     ; Update magenta line's position
    CALL NEXT_NNNXLINE    ; Update green line's position

    ;-----------------------------
    ; Generate a random X position for new lines if needed
    ;-----------------------------
    CALL GENERATE_RANDOM_NUMBER

    ;-----------------------------
    ; Draw the game borders to keep everything in screen
    ;-----------------------------
    CALL BORDER 

    ;-----------------------------
    ; Draw the player cube at its current position
    ;-----------------------------
    CALL UPDRAWCUBE

    ;-----------------------------
    ; Draw all the lines at their new positions
    ;-----------------------------
    CALL DRAWLINE        ; Draw main red line
    CALL DRAWNLINE       ; Draw cyan line
    CALL DRAWNNLINE      ; Draw magenta line
    CALL DRAWNNNLINE     ; Draw green line

    ;-----------------------------
    ; Control the game speed based on the current score
    ; Higher score ? faster game
    ;-----------------------------
    MOV  BX,SCORE
    CMP  BX,80 
    JG   DLA5            ; Score > 80 ? shortest delay
    CMP  BX,60
    JG   DLA4            ; Score > 60 ? faster delay
    CMP  BX,40
    JG   DLA3            ; Score > 40 ? medium-fast delay
    CMP  BX,20
    JG   DLA2            ; Score > 20 ? medium delay
    CMP  BX,0
    JGE  DLA             ; Score >=0 ? slowest delay

;-----------------------------
; Delay routines control game speed
;-----------------------------
DLA5: 
    CALL DELAY5
    JMP  NXT  
    
DLA4: 
    CALL DELAY4
    JMP  NXT 
    
DLA3: 
    CALL DELAY3
    JMP  NXT  
    
DLA2: 
    CALL DELAY2
    JMP  NXT

DLA: 
    CALL DELAY
    JMP  NXT  

;-----------------------------
; NXT: Erase previous positions to prepare next frame
;-----------------------------
NXT:
    CALL UPRMVCUBE       ; Remove cube from old position
    CALL RMVLINE         ; Remove main red line from old position
    CALL RMVNLINE        ; Remove cyan line from old position
    CALL RMVNNLINE       ; Remove magenta line from old position
    CALL RMVNNNLINE      ; Remove green line from old position

    ;-----------------------------
    ; Loop back to main game logic (collision checks, scoring, etc.)
    ;-----------------------------
    JMP AGAIN

   
  KEYPRESS:  
   
    MOV AH,0
    INT 16H 
    CMP AL,'E'
    JE  EXIT2
    CMP AL,'e'
    JE  EXIT2
    CMP AL,'A'
    JE MOVELEFT
    CMP AL,'a'
    JE MOVELEFT
    CMP AL,'D'
    JE MOVERIGHT
    CMP AL,'d'
    JE MOVERIGHT
    JMP AGAIN  
       
  MOVELEFT: 
    ;-----------------------------
    ; Move the cube to the left
    ;-----------------------------
    MOV BX,XCUBE          ; Copy current X position of cube to BX
    CMP BX,4              ; Check if cube is near left screen boundary
    JL  AGAIN             ; If it is, don’t move, jump back to game loop
    SUB XCUBE,2           ; Move cube left by 2 pixels
    SUB X2CUBE,2          ; Adjust second cube X-coordinate accordingly
    JMP AGAIN             ; Jump back to main game loop

MOVERIGHT:  
    ;-----------------------------
    ; Move the cube to the right
    ;-----------------------------
    MOV BX,XCUBE 
    ADD BX,7              ; Check future right edge of cube
    CMP BX,315            ; Ensure cube does not go past right screen boundary
    JG  AGAIN             ; If it does, skip movement
    ADD XCUBE,2           ; Move cube right by 2 pixels
    ADD X2CUBE,2          ; Adjust second cube X-coordinate accordingly
    JMP AGAIN             ; Jump back to main game loop

EXIT2: 
    ;-----------------------------
    ; Exit game triggered by user
    ;-----------------------------
    CALL RESET_THE_SCREEN ; Clear the screen
    MOV AH,9
    LEA DX,GAMEOVERMSG2  ; Display GAME OVER message part 2
    INT 21H       
    LEA DX,GAMEOVERMSG1  ; Display GAME OVER message part 1
    INT 21H    
    LEA DX,GAMEOVERMSG3  ; Display GAME OVER message part 3
    INT 21H 
    JMP AGA2             ; Jump to handle exit input

AGAIN:  
    ;-----------------------------
    ; Check cube collision with lines
    ;-----------------------------
    CALL CHECK_UP_OR_DOWN       ; Check main line collision
    CALL NCHECK_UP_OR_DOWN      ; Check cyan line collision
    CALL NNCHECK_UP_OR_DOWN     ; Check magenta line collision
    CALL NNNCHECK_UP_OR_DOWN    ; Check green line collision

    ;-----------------------------
    ; If any collision detected, proceed to life handling
    ;-----------------------------
    CMP CHECK_UND,1
    JE AGAIN1
    CMP NCHECK_UND,1
    JE AGAIN1
    CMP NNCHECK_UND,1
    JE AGAIN1
    CMP NNNCHECK_UND,1
    JE AGAIN1  
    JMP AGAIN3                 ; No collision, jump to continue game

AGAIN1: 
    ;-----------------------------
    ; Determine if collision costs life or increases score/lives
    ;-----------------------------
    CMP CHECK_UND,1
    JE  LIFEDEC               ; Main line collision ? decrease life
    
    CMP NNNCHECK_UND,1
    JE  LIFEINC               ; Green line collision ? increase life
    JMP LIFEADJ               ; Go to life adjustment logic

LIFEINC: 
    ;-----------------------------
    ; Increase life if green line hit
    ;-----------------------------
    MOV BX,Y  
    CMP BX,1                  ; Check some life-related flag
    JE  YES2
    JMP LIFEADJ

YES2:
    MOV BX,0
    MOV Y,BX                  ; Reset life flag
    INC COUNT                 ; Increase player's life count
    
    CMP COUNT,9               ; Maximum lives = 9
    JG  CNTG
    JMP CNTL

CNTG:
    MOV COUNT,9               ; Cap lives at 9
    CNTL:
    ;-----------------------------
    ; Display current life count
    ;-----------------------------
    MOV AX,COUNT         ; Load current life count into AX
    CALL OUTDECGPC       ; Call procedure to display count on screen
    JMP LIFEADJ          ; Jump to life adjustment section

LIFEDEC:
    ;-----------------------------
    ; Decrease life when main line collision occurs
    ;-----------------------------
    MOV BX,X             ; Load flag X (life-related flag)
    CMP BX,1             ; Check if life is active
    JE  YES              ; If yes, proceed to decrement life
    JMP LIFEADJ          ; If not, jump to life adjustment

YES:
    ;-----------------------------
    ; Decrement life count
    ;-----------------------------
    MOV BX,0
    MOV X,BX             ; Reset life flag X
    DEC COUNT            ; Decrease life by 1

    MOV AX,COUNT
    CALL OUTDECGPC       ; Display updated life count

    CMP COUNT,0          ; Check if lives reached zero
    JE  DEAD             ; If yes, trigger game over
    JMP ALIVE            ; If not, continue game

DEAD:
    ;-----------------------------
    ; Handle game over
    ;-----------------------------
    CALL RESET_THE_SCREEN ; Clear screen

    MOV AH,9
    LEA DX,GAMEOVERMSG    ; Display "GAME OVER" message
    INT 21H    

    MOV AX,SCORE
    CALL OUTDEC           ; Display final score

    MOV AH,9
    LEA DX,HIGHESTMSG2    ; Display "Highest Score" message
    INT 21H  

    ;-----------------------------
    ; Check and update high score
    ;-----------------------------
    MOV AX,SCORE
    CMP AX,HIGHSCORE      ; Compare current score with highest score
    JG  HSCORE1           ; If current score > high score, update
    JMP NHSCORE1          ; Otherwise, keep existing high score

HSCORE1:
    MOV AX,SCORE
    MOV HIGHSCORE,AX      ; Update high score
    CALL OUTDEC           ; Display updated high score
    JMP FNSH1

NHSCORE1:
    MOV AX,HIGHSCORE
    CALL OUTDEC           ; Display current high score
    JMP FNSH1

FNSH1:
    ;-----------------------------
    ; Display additional GAME OVER messages
    ;-----------------------------
    MOV AH,9
    LEA DX,GAMEOVERMSG1
    INT 21H   

    LEA DX,GAMEOVERMSG3
    INT 21H 

    MOV BX,SCORE1
    MOV SCORE,BX          ; Reset score for next game

AGAD:
    ;-----------------------------
    ; Wait for user input to exit or play again
    ; Direct character input without echo
    ;-----------------------------
    MOV AH,7
    INT 21H
    CMP AL,'P'            ; If user presses 'P' or 'p', play again
    JE DIDAD 
    CMP AL,'p'
    JE DIDAD 
    CMP AL,'X'            ; If user presses 'X' or 'x', exit game
    JE  FEX
    CMP AL,'x'
    JE  FEX
    JMP AGAD              ; Otherwise, wait for valid input

FEX:
    CALL FINAL_EX          ; Exit the game completely

    DIDAD:
    ;---------------------------------------
    ; Reset life and score after player chooses to play again
    ;---------------------------------------
    MOV BX,COUNT1         ; Load initial life count
    MOV COUNT,BX          ; Set current life count

    CALL RESET_THE_SCREEN ; Clear the screen

    ; Display game messages
    MOV AH,9
    LEA DX,MSG10          ; Message: Score/Life info or instructions
    INT 21H  
    MOV AH,9 
    LEA DX,MSG9
    INT 21H  

    CALL PLAY_AGAIN       ; Call procedure to set up game restart
    JMP GAME              ; Jump back to main game loop

ALIVE: 
    ;---------------------------------------
    ; Player is still alive, continue life adjustment
    ;---------------------------------------
    JMP LIFEADJ  

LIFEADJ:
    ;---------------------------------------
    ; Adjust cube Y position each cycle
    ;---------------------------------------
    DEC YCUBE
    JMP AGAIN2

AGAIN3:
LIFEADJX:
    ;---------------------------------------
    ; Check if cube is at the first line for X position adjustment
    ;---------------------------------------
    MOV BX,YLINE
    CMP YCUBE,BX
    JE XNEW 
    DEC BX     
    CMP YCUBE,BX
    JE XNEW 
    JMP LIFEADJY

XNEW:
    MOV BX,1
    MOV X,BX             ; Reset X flag

LIFEADJY:
    ;---------------------------------------
    ; Check cube against third line (NNNYLINE) for Y adjustment
    ;---------------------------------------
    MOV BX,NNNYLINE
    CMP YCUBE,BX
    JE YNEW 
    DEC BX     
    CMP YCUBE,BX
    JE YNEW 
    JMP FINAL

YNEW:
    MOV BX,1
    MOV Y,BX             ; Reset Y flag

FINAL:
    ;---------------------------------------
    ; Check if cube hits any lines to increment score
    ;---------------------------------------
    MOV BX,YLINE
    CMP YCUBE,BX
    JE SCOREL 
    DEC BX     
    CMP YCUBE,BX
    JE SCOREL 
    MOV BX,NYLINE
    CMP YCUBE,BX
    JE SCOREL 
    DEC BX     
    CMP YCUBE,BX
    JE SCOREL 
    MOV BX,NNYLINE
    CMP YCUBE,BX
    JE SCOREL 
    DEC BX     
    CMP YCUBE,BX
    JE SCOREL 
    MOV BX,NNNYLINE
    CMP YCUBE,BX
    JE SCOREL 
    DEC BX     
    CMP YCUBE,BX
    JE SCOREL 

    INC YCUBE            ; If no hit, just move cube down
    JMP AGAIN2

SCOREL:
    ;---------------------------------------
    ; Cube hit a line, increment Y and Score
    ;---------------------------------------
    INC YCUBE
    INC SCORE

    MOV AX,COUNT
    CALL OUTDECGPC       ; Display life count

    ;---------------------------------------
    ; Display different graphics or effects based on score ranges
    ;---------------------------------------
    CMP SCORE,10
    JL SC1 
    CMP SCORE,20
    JL SC2  
    CMP SCORE,30
    JL SC3 
    CMP SCORE,40
    JL SC4
    CMP SCORE,50
    JL SC5  
    CMP SCORE,60
    JL SC6    
    CMP SCORE,70
    JL SC7  
    CMP SCORE,80
    JL SC8
    CMP SCORE,90
    JL SC9   
    CMP SCORE,100
    JL SC10
    CMP SCORE,100
    JGE EXITH  

EXITH:
    CALL HIGHEST         ; Display/update high score if needed

SC1: 
    MOV AX,SCORE
    JMP FJUMP
SC2:   
    CALL OUTDECGPS1      ; Display score effect for 10-19
    MOV AX,SCORE
    SUB AX,10    
    JMP FJUMP 
SC3:
    CALL OUTDECGPS2
    MOV AX,SCORE
    SUB AX,20    
    JMP FJUMP
SC4:   
    CALL OUTDECGPS3
    MOV AX,SCORE
    SUB AX,30    
    JMP FJUMP
SC5:
    CALL OUTDECGPS4
    MOV AX,SCORE
    SUB AX,40  
    JMP FJUMP
SC6:
    CALL OUTDECGPS5
    MOV AX,SCORE
    SUB AX,50    
    JMP FJUMP
SC7:
    CALL OUTDECGPS6
    MOV AX,SCORE
    SUB AX,60    
    JMP FJUMP  
SC8:
    CALL OUTDECGPS7
    MOV AX,SCORE
    SUB AX,70    
    JMP FJUMP
SC9:
    CALL OUTDECGPS8
    MOV AX,SCORE
    SUB AX,80    
    JMP FJUMP  
SC10:
    CALL OUTDECGPS9
    MOV AX,SCORE
    SUB AX,90    
    JMP FJUMP 

FJUMP:  
    CALL OUTDECGPS       ; Finalize score graphics
    JMP AGAIN2

AGAIN2:
    ;---------------------------------------
    ; Move all lines down to simulate cube motion
    ;---------------------------------------
    DEC YLINE
    DEC NYLINE
    DEC NNYLINE 
    DEC NNNYLINE  

    ; Check if cube reached boundaries to end game
    CMP YCUBE,198
    JE EXIT
    CMP YCUBE,25
    JE EXIT
    CMP YCUBE,26
    JE EXIT
    JMP GAME

AGA2:
    ;---------------------------------------
    ; Wait for user input after game over
    ;---------------------------------------
    MOV AH,7
    INT 21H
    CMP AL,'X'
    JE FINAL_EXIT
    CMP AL,'x'
    JE FINAL_EXIT
    CMP AL,'P'
    JE DIDA2 
    CMP AL,'p'
    JE DIDA2
    JMP AGA2

DIDA2:
    ;---------------------------------------
    ; Reset life and score to restart game
    ;---------------------------------------
    MOV BX,COUNT1
    MOV COUNT,BX   
    MOV BX,SCORE1
    MOV SCORE,BX
    CALL RESET_THE_SCREEN 
    MOV AH,9
    LEA DX,MSG10
    INT 21H  
    MOV AH,9 
    LEA DX,MSG9
    INT 21H  
    CALL PLAY_AGAIN
    JMP GAME

EXIT:
    CALL GAME_OVER        ; Game over routine
    JMP FINAL_EXIT

FINAL_EXIT:
    ;---------------------------------------
    ; Exit program safely
    ;---------------------------------------
    MOV AH,0
    MOV AL,2
    INT 10H               ; Set text mode
    MOV AH,4CH
    INT 21H               ; Terminate program

MAIN ENDP
END MAIN
