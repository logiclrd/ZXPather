0 REM INITIALISE POSITION
1 LET x=128:LET y=88
2 LET b$=""
3 BORDER 4:PAPER 0:CLS:INK 5:PLOT x,y
9 REM KEYBOARD LOOP
10 LET k$=INKEY$
11 IF k$="" THEN GO TO 10
12 REM undraw old point
13 INK 1:PLOT OVER 1; x,y
15 REM process key
16 LET l=CODE k$
17 IF l=8 AND x>0 THEN LET x=x-1
18 IF l=9 AND x<255 THEN LET x=x+1
19 IF l=10 AND y<175 THEN LET y=y-1
20 IF l=11 AND y>0 THEN LET y=y+1
21 IF l=32 THEN GO SUB 60
22 IF l=13 THEN GO TO 30
23 REM draw new point
24 INK 5:PLOT OVER 1; x,y
25 GO TO 10
29 REM tail, dump output and stop
30 CLS:INK 7
31 PRINT "Here's your hex:"
32 PRINT
33 INK 6
34 PRINT b$
35 STOP
39 REM GO SUB 40 - output a hex byte in n to b$, clobbers m
40 LET m=INT(n/16):GO SUB 50
41 LET m=n-16*m:GO SUB 50
42 RETURN
49 REM GO SUB 50 - output a hex digit in m to b$, does nothing if m is not 0..15
50 IF m>=0 AND m<=9 THEN LET b$=b$+CHR$ (m+48)
51 IF m>=10 AND m<=15 THEN LET b$=b$+CHR$ (m+55)
52 RETURN
59 REM GO SUB 60 - append the current x,y point to b$ in hex, draw the new segment
60 LET n=x:GO SUB 40
61 LET n=175-y:GO SUB 40
62 IF LEN(b$)<=4 THEN LET a$=b$
63 IF LEN(b$)>4 THEN LET a$=b$(LEN b$-7 TO)
64 INK 1:GO SUB 70
65 RETURN
69 REM GO SUB 70 - draw connected lines described by a$, clobbers h$, l$, m, n and v
70 LET h$=a$(1):LET l$=a$(2):GO SUB 80:LET m=v
71 LET h$=a$(3):LET l$=a$(4):GO SUB 80:LET n=v
72 PLOT m,175-n
73 FOR i=5 TO LEN a$ STEP 4
74 LET h$=a$(i+0):LET l$=a$(i+1):GO SUB 80:LET q=v
75 LET h$=a$(i+2):LET l$=a$(i+3):GO SUB 80:LET w=v
76 DRAW q-m,n-w:LET m=q:LET n=w
77 NEXT i:RETURN
79 REM GO SUB 80: parse hex byte in h$ and l$ into v (clobbers u)
80 GO SUB 90:LET u=16*v:LET h$=l$:GO SUB 90:LET v=u+v:RETURN
89 REM GO SUB 90: parse hex digit in h$ into v
90 LET v=CODE h$-CODE "0"-(7 AND h$>"9"):RETURN
