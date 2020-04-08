10 REM ***************************
20 REM *        CHECK MATE       *
30 REM *                         *
40 REM * Originally published as *
50 REM *     "Chess Program"     *
60 REM *  by Dieter Steinwender  *
70 REM *  Ported to LM80C BASIC  *
80 REM *   by Leonardo Miliani   *
90 REM ***************************
100 CLS:GOSUB 30000:REM Show splash screen
110 DIM B(119),S(10,4),M(10),A$(10),U(10)
120 DIM R1(4),R2(4),R3(4),R4(4),R5(4),R6(4),R7(4),G1(10)
130 DIM W(10),P(10),O(15),OA(6),OE(6),L(6),Z(200,6)
140 DIM ZT(9,8),BV(8),BL(2,9),TL(2,9)
150 DIM T7(2),BA(2),KR(2),KL(2)
200 RESTORE 350
210 REM Initialisation
270 FOR I=0 TO 119
280 B(I)=100
290 NEXT I
300 FOR I=9 TO 2 STEP -1
310 FOR J=1 TO 8
320 READ B(I*10+J)
330 NEXT J
340 NEXT I
342 REM Initial displacement of pieces on board
343 REM 1=pawn/2=rook/3=bishop/4=knight/5=queen/6=king
344 REM Pos. numbers=whites / Neg. numbers=blacks
350 DATA -2,-4,-3,-5,-6,-3,-4,-2
360 DATA -1,-1,-1,-1,-1,-1,-1,-1
370 DATA 0,0,0,0,0,0,0,0
380 DATA 0,0,0,0,0,0,0,0
390 DATA 0,0,0,0,0,0,0,0
400 DATA 0,0,0,0,0,0,0,0
410 DATA 1,1,1,1,1,1,1,1
420 DATA 2,4,3,5,6,3,4,2
430 F=1
440 FOR I=1 TO 4
450 S(0,I)=1
460 NEXT I
470 S(0,0)=0
480 M(0)=0
510 FOR I=0 TO 6
520 READ A$(I),U(I),CH(I)
530 NEXT I
535 REM FIRST ONE IS 'NO PIECE'
540 DATA "_",0,228,"P",100,148,"R",500,128,"B",350,136
550 DATA "N",325,132,"Q",900,144,"K",20000,140
560 M0=48100
640 FOR I=0 TO 15
650 READ O(I)
660 NEXT I
670 DATA -9,-11,9,11,-1,10,1,-10,19,21,12,-8,-19,-21,-12,8
690 FOR I=1 TO 6
700 READ OA(I),OE(I),L(I)
710 NEXT I
720 DATA 0,3,0,4,7,1,0,3,1,8,15,0,0,7,1,0,7,0
750 FOR I=1 TO 4
760 READ R1(I),R2(I),R3(I),R4(I),R5(I),R6(I),R7(I)
770 NEXT I
780 DATA 96,97,95,97,95,97,98
790 DATA 92,94,93,95,95,93,91
800 DATA 26,27,25,27,25,27,28
810 DATA 22,24,23,25,25,23,21
840 FOR J=1 TO 8
850 FOR I=2 TO 9
860 ZT(I,J)=12-4*(ABS(5.5-I)+ABS(4.5-J))
870 NEXT I
880 READ BV(J)
890 NEXT J
900 DATA 0,0,4,6,7,2,0,0
930 MZ=0
940 G1(0)=1
1800 T=0:HN=0:MV=0
1810 CLS:GOSUB 31000:GOSUB 4000:REM First print on video
1820 IF TR=0 THEN 3500
2000 REM Player's move
2020 LOCATE0,22:PRINTSPC(31);:LOCATE0,22:PRINT "  Your move      ";:GOSUB 13000
2030 LOCATE 17,22:PRINT SPC(12);
2040 IF E$<>"" THEN 2050
2045 GOSUB 32000:GOTO 1810
2050 IF E$<>"R" THEN 2070
2060 GOTO 200:REM Restart
2070 IF E$<>"Q" THEN 2120
2080 GOTO 15000:REM Quit
2120 IF E$<>"C" THEN 2150
2130 GOSUB 5000:REM Set a specific configuration of pieces on board
2140 GOTO 2000
2150 IF E$<>"X" THEN 2170
2160 TR=TR XOR 1:GOSUB 31000:GOTO 3500:REM computer gets the current side
2170 IF E$<>"M" THEN 2210
2180 LOCATE 2,23:PRINT "Multiple move: ";
2190 IF MZ=0 THEN MZ=1:LOCATE 17,23:PRINT "Beginning";:GOTO 2000
2200 MZ=0:LOCATE 17,23:PRINT "End      ";:GOTO 2000
2210 IF E$<>"H" THEN 2260
2220 Z0=Z1:HN=1
2230 CLS:PRINT " Calculating moves...":PRINT:GOSUB 6500:REM Show legal moves
2240 Z1=Z0:HN=0
2250 GOSUB 13500:GOTO 1810
2260 IF E$<>"B" THEN 2330
2270 IF T=1 THEN 2300
2280 LOCATE 0,23:PRINT "  Sorry, not possible";
2290 GOTO 2000
2300 GOSUB 9600:REM Roll back move AND CHANGE SIDE
2310 LOCATE 0,23:PRINT "  OK";
2320 GOTO 2000
2330 IF E$<>"D" THEN 3000
2340 LOCATE 0,23:PRINT "  Analysing depth=";T0;
2350 INPUT T0
2360 T0=ABS(T0)
2365 LOCATE 0,23:PRINT SPC(31);
2370 GOTO 2000
3000 REM
3010 IF LEN(E$)<4 THEN 2000
3015 LOCATE 17,22:PRINT ": checking...";
3020 V1=ASC(E$)-64+10*(ASC(MID$(E$,2,1))-47)
3030 N1=ASC(MID$(E$,3,1))-64+10*(ASC(MID$(E$,4,1))-47)
3040 GOSUB 8800
3050 GOSUB 7000
3060 FOR Z1=1 TO G-1
3070 IF Z(Z1,1)<>V1 THEN 3090
3080 IF Z(Z1,2)=N1 THEN 3120
3090 NEXT Z1
3100 LOCATE 0,22:PRINT "          Illegal move          ";:PAUSE100
3110 GOTO 2000
3120 IF Z(Z1,4)=0 THEN 3170
3140 IF RIGHT$(E$,1)="N" THEN Z1=Z1+1
3150 IF RIGHT$(E$,1)="B" THEN Z1=Z1+2
3160 IF RIGHT$(E$,1)="R" THEN Z1=Z1+3
3170 LOCATE 0,22:PRINT "  Your move      =";
3180 GOSUB 6000:LOCATE 20,9+(5*TR):PRINT A$;
3185 MV=MV+1:LOCATE 25,3:PRINT MV
3190 GOSUB 9000
3200 GOSUB 7000
3210 IF MT=0 THEN 3300
3220 GOSUB 9600
3230 GOTO 3100
3300 IF MZ=1 THEN GOSUB 4000:GOTO 2000
3500 REM Computer's move
3510 GOSUB 4000
3515 LOCATE 0,22:PRINTSPC(31);:LOCATE 0,22:PRINT"  Evaluating     :";
3520 GOSUB 8800
3530 GOSUB 10000
3540 IF Z2=0 THEN 3650
3545 IF W=1 THEN 3660
3550 IF W=-32766 THEN 3630
3560 Z1=Z2
3570 LOCATE 0,22:PRINT "  My move        = ";
3580 GOSUB 6000:LOCATE 20,14-(5*TR):PRINT A$;
3585 MV=MV+1:LOCATE 25,3:PRINT MV
3590 GOSUB 9000
3595 IF W=-2 THEN 3660
3600 IF W<32765 THEN 3670
3610 LOCATE 0,22:PRINT "  CHECK MATE!";
3620 GOTO 3670
3630 LOCATE 0,22:PRINT "  Damn, you won!";
3640 GOTO 3670
3650 IF T0=0 THEN 3670
3660 LOCATE 0,22:PRINT "  Stalemate: draw!";
3670 LOCATE 0,23:PRINT SPC(31);
3672 LOCATE 0,23:PRINT "  Val=";W;"Pos. comp.=";C1;:PAUSE 200
3675 GOSUB 4000:LOCATE 0,23:PRINTSPC(31);
3680 GOTO 2000
4000 REM Displaying board and pieces
4010 X=2:Y=0
4020 FOR I=9 TO 2 STEP -1:CL=(I-1) AND 1
4030 FOR J=1 TO 8:A1=B(I*10+J):F1=SGN(A1)+1:A1=ABS(A1)
4040 CR=CH(A1):IF CR<>228 THEN 4080
4050 CR=CR+CL
4060 LOCATE X+(J-1)*2,Y:PRINT CHR$(CR);CHR$(CR);
4070 LOCATE X+(J-1)*2,Y+1:PRINT CHR$(CR);CHR$(CR);:GOTO 4100
4080 CR=CR+(F1*24)+(CL*24):LOCATE X+(J-1)*2,Y:PRINT CHR$(CR+2);CHR$(CR+3);
4090 LOCATE X+(J-1)*2,Y+1:PRINT CHR$(CR);CHR$(CR+1);
4100 CL=CL XOR 1:NEXT J
4110 Y=Y+2
4120 NEXT I
4170 REM Print Game statistics
4180 LOCATE 0,18
4190 PRINT "  Material value =";M(T)
4200 PRINT "  En passant sqr.= ";:GOSUB 6700
4210 PRINT "  Castle status  =";S(T,1);S(T,2);S(T,3);S(T,4)
4220 PRINT "  Now move       = ";
4230 IF F=1 THEN PRINT "White":GOTO 4250
4240 PRINT "Black"
4250 RETURN
5000 REM Input move
5020 T=0
5030 LOCATE 0,22:PRINT "Empty the board (Y/N)";
5040 GOSUB 13000
5050 IF E$="N" THEN 5130
5060 IF E$<>"Y" THEN 5030
5070 FOR I=2 TO 9
5080 FOR J=1 TO 8
5090 B(I*10+J)=0
5100 NEXT J
5110 NEXT I
5120 M(0)=0
5130 PRINT "White ";
5140 F=1
5150 GOSUB 5500
5160 PRINT "Black ";
5170 F=-1
5180 GOSUB 5500
5190 PRINT "Side to move (W/B) ";
5200 GOSUB 13000
5210 IF E$="B" THEN 5240
5220 IF E$<>"W" THEN 5190
5230 F=1
5240 PRINT "Change E.P./Castle sts. (Y/N)";
5250 GOSUB 13000
5260 IF E$="N" THEN 5320
5270 IF E$<>"Y" THEN 5240
5280 PRINT "E.P. square (0 to reset)";:GOSUB 13000
5285 IF E$="0" THEN S(0,0)=0:GOTO 5300
5290 S(0,0)=F*15+ASC(E$)-9
5300 PRINT "Castle status (N,N,N,N)";
5310 INPUT S(0,1),S(0,2),S(0,3),S(0,4)
5320 GOSUB 4000
5330 RETURN
5500 REM Setting up the pieces on one side
5505 REM Input is: Xxy - X is piece (R/N/B/Q/K/P), x is A/H, Y is 1/8
5510 REM to finish, enter "."
5520 GOSUB 13000
5530 IF E$="." THEN 5660
5540 IF LEN(E$)<>3 THEN 5590
5560 FOR I=0 TO 6
5570 IF LEFT$(E$,1)=A$(I) THEN A=I:GOTO 5600
5580 NEXT I
5590 PRINT "Wrong data":GOTO 5520
5600 REM
5610 N=ASC(MID$(E$,2,1))-64+10*(ASC(MID$(E$,3,1))-47)
5620 M(0)=M(0)-SGN(B(N))*U(ABS(B(N)))
5630 B(N)=F*A
5640 M(0)=M(0)+F*U(A)
5650 GOTO 5520
5660 RETURN
6000 REM Show move
6020 A$=A$(ABS(B(Z(Z1,1))))
6030 FOR J=1 TO 2
6040 RE=INT(Z(Z1,J) / 10)
6050 LI=Z(Z1,J)-10*RE
6060 A$=A$+CHR$(64+LI)+CHR$(47+RE)
6070 NEXT J
6080 IF Z(Z1,4)=0 THEN 6100
6090 A$=A$+"="+A$(Z(Z1,4))
6100 IF HN=0 THEN LOCATE 19,22:PRINT A$;SPC(7);:GOTO 6130
6110 PRINT " ";A$;:HN=HN+1
6120 IF HN>5 THEN HN=1:PRINT
6130 RETURN
6500 REM Show legal moves
6520 GOSUB 7000
6530 IF MT=0 THEN 6560
6540 PRINT "  King may be taken"
6550 RETURN
6560 PRINT G-G1(T);" Pseudo-legal moves":PRINT
6570 FOR Z1=G1(T) TO G-1
6580 GOSUB 6000
6590 NEXT Z1
6600 RETURN
6700 REM Show an e.p. square
6710 IF S(T,0)=0 THEN A$="0 ":GOTO 6750
6720 RE=INT(S(T,0) / 10)
6730 LI=S(T,0)-10*RE
6740 A$=CHR$(64+LI)+CHR$(47+RE)
6750 PRINT A$
6760 RETURN
7000 REM Move generation
7020 MT=0
7030 G=G1(T)
7040 FOR V=21 TO 98
7050 A=B(V)
7060 IF A=100 THEN 7490
7070 IF SGN(A)<>F THEN 7490
7080 A=ABS(A)
7110 IF A<>1 THEN 7360
7120 N=V+(F*10)
7130 IF B(N)<>0 THEN 7210
7140 GOSUB 7900
7150 IF (INT(V / 10)-5.5)*F<>-2.5 THEN 7210
7160 N=V+(F*20)
7170 IF B(N)<>0 THEN 7210
7180 GOSUB 8500
7190 Z(G-1,6)=(V+N)*.5
7210 REM
7220 FOR I=1 TO 2
7230 N=V+O(F+I)
7240 IF B(N)=100 THEN 7330
7250 IF N=S(T,0) THEN 7300
7260 IF SGN(B(N))<>-F THEN 7330
7270 IF B(N)=-F*6 THEN MT=1:GOTO 7810
7280 GOSUB 7900
7290 GOTO 7330
7300 GOSUB 8500
7310 Z(G-1,3)=1
7320 Z(G-1,6)=N-10*F
7330 NEXT I
7340 GOTO 7490
7360 REM
7370 FOR I=OA(A) TO OE(A)
7380 LA=L(A)
7390 N=V
7400 N=N+O(I)
7410 IF B(N)=100 THEN 7480
7420 IF SGN(B(N))=F THEN 7480
7430 IF B(N)=0 THEN 7460
7440 IF B(N)=-F*6 THEN MT=1:GOTO 7810
7450 LA=0
7460 GOSUB 8500
7470 IF LA=1 THEN 7400
7480 NEXT I
7490 NEXT V
7520 FOR I=F+2 TO F+3
7530 IF S(T,I)=0 THEN 7790
7540 FOR J=R1(I) TO R2(I)
7550 IF B(J)<>0 THEN 7790
7560 NEXT J
7580 FOR J=R3(I) TO R4(I)
7590 FOR K=0 TO 7
7600 N=J
7610 N=N+O(K)
7620 IF B(N)=100 THEN 7700
7630 IF SGN(B(N))=F THEN 7700
7640 IF B(N)=0 THEN 7610
7650 IF OA(ABS(B(N)))>K THEN 7700
7660 IF OA(ABS(B(N)))<K THEN 7700
7670 IF N=J+O(K) THEN 7790
7680 IF L(ABS(B(N)))<>1 THEN 7700
7690 GOTO 7790
7700 NEXT K
7710 FOR K=8 TO 15
7720 IF B(J+O(K))=-F*4 THEN 7790
7730 NEXT K
7740 NEXT J
7750 V=R5(I)
7760 N=R6(I)
7770 GOSUB 8500
7780 Z(G-1,5)=I
7790 NEXT I
7800 G1(T+1)=G
7810 RETURN
7900 REM Note the moves of pawn
7920 IF (INT(N / 10)-5.5)*F<>3.5 THEN GOSUB 8500:GOTO 7980
7940 FOR I2=5 TO 2 STEP -1
7950 GOSUB 8500
7960 Z(G-1,4)=I2
7970 NEXT I2
7980 RETURN
8500 REM Place the generated moves into the moves' stack
8520 Z(G,1)=V
8530 Z(G,2)=N
8540 Z(G,3)=ABS(B(N))
8550 FOR I1=4 TO 6
8560 Z(G,I1)=0
8570 NEXT I1
8580 IF G=200 THEN 8600
8590 G=G+1
8600 RETURN
8800 REM Tree moves initialisation
8820 IF T=0 THEN 8880
8830 FOR I=0 TO 4
8840 S(0,I)=S(1,I)
8850 NEXT I
8860 M(0)=M(1)
8870 T=0
8880 RETURN
9000 REM Make a move
9020 T=T+1
9030 S(T,0)=0
9040 FOR I=1 TO 4
9050 S(T,I)=S(T-1,I)
9060 NEXT I
9070 M(T)=M(T-1)
9080 V=Z(Z1,1)
9090 N=Z(Z1,2)
9100 IF Z(Z1,6)=0 THEN 9160
9110 IF Z(Z1,3)=0 THEN 9140
9120 B(Z(Z1,6))=0
9130 GOTO 9430
9140 S(T,0)=Z(Z1,6)
9150 GOTO 9430
9160 REM
9170 IF V<>R5(F+2) THEN 9210
9180 S(T,F+2)=0
9190 S(T,F+3)=0
9200 GOTO 9360
9210 IF V<>R7(F+2) THEN 9240
9220 S(T,F+2)=0
9230 GOTO 9260
9240 IF V<>R7(F+3) THEN 9260
9250 S(T,F+3)=0
9260 IF N<>R7(-F+2) THEN 9290
9270 S(T,-F+2)=0
9280 GOTO 9310
9290 IF N<>R7(-F+3) THEN 9310
9300 S(T,-F+3)=0
9310 REM
9320 IF Z(Z1,4)=0 THEN 9430
9330 B(V)=Z(Z1,4)*F
9340 M(T)=M(T)+F*(U(Z(Z1,4))-100)
9350 GOTO 9430
9360 REM
9370 RO=Z(Z1,5)
9380 IF RO=0 THEN 9430
9390 VO=R7(RO)
9400 B(VO)=0
9410 NA=(R5(RO)+R6(RO))*.5
9420 B(NA)=2*F
9430 REM
9440 B(N)=B(V)
9450 B(V)=0
9460 M(T)=M(T)+F*U(Z(Z1,3))
9470 F=-F
9480 RETURN
9600 REM Take back moves
9620 F=-F
9630 V=Z(Z1,1)
9640 N=Z(Z1,2)
9650 IF Z(Z1,6)=0 THEN 9710
9660 IF Z(Z1,3)=0 THEN 9820
9670 B(Z(Z1,6))=-F
9680 B(V)=F
9690 B(N)=0
9700 GOTO 9840
9710 REM
9720 RO=Z(Z1,5)
9730 IF RO=0 THEN 9790
9740 NA=(R5(RO)+R6(RO))*.5
9750 B(NA)=0
9760 VO=R7(RO)
9770 B(VO)=2*F
9780 GOTO 9820
9790 REM
9800 IF Z(Z1,4)=0 THEN 9820
9810 B(N)=F
9820 B(V)=B(N)
9830 B(N)=-F*Z(Z1,3)
9840 T=T-1
9850 RETURN
10000 REM Alpha-beta search
10020 Z2=0
10030 C1=0
10040 W(0)=-32767
10050 W(1)=-32767
10070 IF T<T0 THEN 10110
10080 GOSUB 12000
10090 W(T+2)=W*F
10100 GOTO 10380
10110 GOSUB 7000
10120 IF MT=0 THEN 10150
10130 W(T+2)=32767-T
10140 GOTO 10380
10150 IF G>G1(T) THEN 10190
10160 W(T+2)=0
10170 GOTO 10380
10180 REM
10190 P(T)=G1(T)
10200 W(T+2)=W(T)
10220 Z1=P(T)
10230 IF T<>0 THEN 10250
10240 GOSUB 6000
10250 GOSUB 9000
10260 C1=C1+1
10270 GOTO 10070
10290 IF -W(T+3)<=W(T+2) THEN 10350
10300 W(T+2)=-W(T+3)
10310 IF T>0 THEN 10340
10320 Z2=P(T)
10330 LOCATE 0,23:PRINT "  Best move ";A$;": Val=";W(2);
10340 IF W(T+2)>=-W(T+1) THEN 10380
10350 P(T)=P(T)+1
10360 IF P(T)<G1(T+1) THEN 10220
10370 IF W(T+2)<>-32766+T THEN 10380
10371 F=-F
10372 GOSUB 7000
10373 F=-F
10374 IF MT=1 THEN 10380
10375 W(T+2)=1+T
10380 IF T=0 THEN 10430
10390 Z1=P(T-1)
10400 GOSUB 9600
10410 GOTO 10290
10430 W=W(2)
10440 RETURN
12000 REM Eval function
12020 REM W=0:RETURN:REM:*** uncomment for zero eval function
12030 M=0
12040 W=0
12050 FOR I=0 TO 2
12060 T7(I)=0
12070 BA(I)=0
12080 FOR J=0 TO 9
12090 BL(I,J)=0
12100 TL(I,J)=0
12110 NEXT J
12120 NEXT I
12140 FOR I=2 TO 9
12150 FOR J=1 TO 8
12160 V=I*10+J
12170 A=ABS(B(V))
12180 IF A=0 THEN 12420
12190 FA=SGN(B(V))
12200 M=M+U(A)
12210 ON A GOTO 12220,12270,12320,12360,12420,12390
12220 REM
12230 BA(FA+1)=BA(FA+1)+1
12240 BL(FA+1,J)=BL(FA+1,J)+1
12250 W=W+FA*BV(J)*(3.5-FA*(5.5-I))
12260 GOTO 12420
12270 REM
12280 IF (I-5.5)*FA<>2.5 THEN 12300
12290 T7(FA+1)=T7(FA+1)+1
12300 TL(FA+1,J)=TL(FA+1,J)+1
12310 GOTO 12420
12320 REM
12330 IF (I-5.5)*FA<>-3.5 THEN 12420
12340 W=W-FA*10
12350 GOTO 12420
12360 REM
12370 W=W+FA*ZT(I,J)
12380 GOTO 12420
12390 REM
12400 KR(FA+1)=I
12410 KL(FA+1)=J
12420 NEXT J
12430 NEXT I
12440 REM
12460 FA=SGN(M(T))
12470 IF FA=0 THEN 12500
12480 W=W+M(T)+INT(M(T)*BA(FA+1) / (BA(FA+1)+1)*(M0-M)*.0001)
12500 REM
12510 W=W+INT(ZT(KR(2),KL(2))*(43000-M+M(T))*.001)
12520 W=W-INT(ZT(KR(0),KL(0))*(43000-M-M(T))*.001)
12550 W=W+T7(2)*T7(2)*12
12560 W=W-T7(0)*T7(0)*12
12590 FOR I=1 TO 8
12600 FOR J=0 TO 2
12610 FA=J-1
12620 IF FA=0 THEN 12880
12630 IF BL(J,I)=0 THEN 12830
12640 W=W-FA*(BL(J,I)-1)*8
12650 IIS=0
12660 IF BL(J,I-1)>0 THEN 12710
12670 IF BL(J,I+1)>0 THEN 12710
12690 W=W-FA*20
12700 IIS=1
12710 IF BL(2-J,I)>0 THEN 12880
12730 W=W-FA*TL(2-J,I)*TL(2-J,I)*3
12740 IF BL(2-J,I-1)>0 THEN 12790
12750 IF BL(2-J,I+1)>0 THEN 12790
12770 W=W+FA*18
12780 GOTO 12890
12790 REM
12800 IF IIS=0 THEN 12890
12810 W=W-FA*10
12820 GOTO 12890
12830 IF BL(2-J,I)>0 THEN 12880
12850 W=W+TL(2,I)*TL(2,I)*8
12860 W=W-TL(0,I)*TL(0,I)*8
12870 GOTO 12890
12880 NEXT J
12890 NEXT I
12900 RETURN
13000 REM Get an input and change it to upper cases only
13010 E$="":INPUT Z9$:IF Z9$="" THEN RETURN
13020 FOR I9=1 TO LEN(Z9$)
13030 A9=ASC(MID$(Z9$,I9,1))
13040 IF A9>=97 AND A9<=122 THEN A9=A9-32
13050 E$=E$+CHR$(A9)
13060 NEXT:RETURN
13490 REM Wait for a key to continue
13500 PRINT:PRINT " Press any key to continue":A=INKEY(10)
13510 A=INKEY(50):IF A=0 THEN 13510
13520 RETURN
30000 REM Display instructions and settings
30010 SCREEN 1:COLOR 15,2,12:RESTORE 40000:FORI=4 TO 6:LOCATE 4,I
30020 FOR J=1 TO 24:READ A:PRINT CHR$(A);:NEXT:NEXT
30030 LOCATE 6,8:PRINT "by  Leonardo Miliani"
30040 PRINT:PRINT " Enter a move using the format"
30050 PRINT " 'lnLN': 'ln' is the starting"
30060 PRINT " square and 'LN' is the target"
30070 PRINT " square. 'l/L' are letters (A-H)";
30070 PRINT " while 'n/N' are numbers (1-8)."
30080 PRINT " Example: C2C3 moves the piece"
30090 PRINT " in C2 to C3."
30100 PRINT:PRINT " Just press RETURN to get help"
30110 PRINT " during the game."
30120 GOSUB 13500
30130 CLS:LOCATE 0,2:D9=1:PRINT "Difficult (1-9, def.1)";
30140 INPUT D9$:IF VAL(D9$)>0 AND VAL(D9$)<10 THEN D9=VAL(D9$)
30150 T0=D9:PRINT "Difficult:";T0
30170 LOCATE 0,5:PRINT "Choose color to play with, white";
30180 PRINT "moves first (def.). (W/B)";
30190 GOSUB 13000:IF E$="" OR E$="W" THEN TR=1:GOTO 30220:REM Player chose white
30200 IF E$<>"B"THEN LOCATE 0,8:PRINT SPC(10);:GOTO 30170
30210 TR=0:REM Player chose black
30220 PRINT "You'll start with ";:IF TR=0 THEN PRINT "BLACK":GOTO 30270
30230 PRINT "WHITE"
30240 LOCATE 10,13:PRINT "Please  wait"
30250 LOCATE 6,15: PRINT "Initializing game...";
30260 REM Load graphic chars into VRAM
30270 RESTORE 40070
30280 FOR I=0TO191:READX:VPOKE1024+I,X:VPOKE1216+I,X
30290 VPOKE 1408+I,X:VPOKE1600+I,X:NEXT
30300 FORI=0TO15:READX:VPOKE1824+I,X:NEXT:REM EMPTY SQUARES
30310 FOR I=8208TO8210:VPOKEI,&H15:NEXT
30320 FOR I=8211TO8213:VPOKEI,&H14:NEXT
30330 FOR I=8214TO8216:VPOKEI,&HF5:NEXT
30340 FOR I=8217TO8219:VPOKEI,&HF4:NEXT
30350 VPOKE8220,&H45
30360 RETURN
30370 REM 128/151=WHITES ON LIGHT BLUE
30380 REM 152/175=WHITES ON DARK BLUE
30390 REM 128/152=ROOK-132/156=KNIGHT-136/162=BISHOP
30400 REM 140/166=QUEEN-144/170=KING-148/174=PAWN
30410 REM EACH PIECE IS 4 CHARS
30420 REM 176/199=BLACKS ON LIGHT BLUE
30430 REM 200/223=BLACKS ON DARK BLUE
30440 REM 176/200=ROOK-180/204=KNIGHT-184/208=BISHOP
30450 REM 188/216=QUEEN-192/220=KING-196/224=PAWN
30460 REM EACH PIECE IS 4 CHARS
30470 REM EMPTY SQUARE IS 228/229 FOR WHITE/BLACK
30990 REM Display GUI
31000 Y=0:FOR I=8 TO 1 STEP -1:LOCATE 0,Y:PRINT STR$(I);:Y=Y+2:NEXT
31010 LOCATE 2,Y:FOR I=1 TO 8:PRINT CHR$(64+I);" ";:NEXT
31020 LOCATE 20,1:PRINT "CHECK MATE";
31030 LOCATE 20,3:PRINT "Mv. :";MV;
31040 LOCATE 20,4:PRINT "Dft.:";T0;
31050 LOCATE 20,7:PRINT "BLACK: ";
31060 IF TR=0 THEN PRINT "You":GOTO 31080
31070 PRINT "CPU"
31080 LOCATE 20,8:PRINT "Last move";
31090 LOCATE 20,12:PRINT "WHITE: ";
31100 IF TR=1 THEN PRINT "You":GOTO 31120
31110 PRINT "CPU"
31120 LOCATE 20,13:PRINT "Last move";
31130 RETURN
32000 REM Show help
32010 CLS:PRINT "INSTRUCTIONS:"
32020 PRINT "To enter a move, just insert co-";
32030 PRINT "ordinates of start and end: C2C3";
32040 PRINT "moves a piece from C2 to C3."
32050 PRINT:PRINT "Q: quit the program"
32060 PRINT "R: restart the game"
32070 PRINT "C: let place pieces on board"
32080 PRINT "   to make a specific setup"
32090 PRINT "X: the player and CPU exchange"
32100 PRINT "   their sides, then CPU moves"
32110 PRINT "M: insert multiply moves, for"
32120 PRINT "   player & CPU, alternatively,"
32130 PRINT "   another 'M' before last move"
32140 PRINT "H: show hints (legal moves)"
32150 PRINT "B: roll back one move"
32160 PRINT "D: set difficult (def. 1)"
32170 GOSUB 13500
32180 RETURN
39990 REM FOR SPLASH SCREEN
40000 DATA 217,143,143,143,143,143,143,143,143,143,143,143
40010 DATA 143,143,143,143,143,143,143,143,143,143,143,218
40020 DATA 144,32,67,32,72,32,69,32,67,32,75,32,32,32,32
40030 DATA 77,32,65,32,84,32,69,32,144
40040 DATA 220,143,143,143,143,143,143,143,143,143,143,143
40050 DATA 143,143,143,143,143,143,143,143,143,143,143,219
40060 REM ROOK
40070 DATA 15,10,10,15,24,63,63,0
40080 DATA 240,16,16,240,24,252,252,0
40090 DATA 0,25,25,25,31,31,8,8
40100 DATA 0,152,152,152,248,248,80,80
40110 REM KNIGHT
40120 DATA 115,99,103,15,24,63,63,0
40130 DATA 176,176,176,240,24,252,252,0
40140 DATA 0,10,10,31,55,54,127,121
40150 DATA 0,0,0,128,192,224,112,176
40160 REM BISHOP
40170 DATA 30,14,15,7,4,31,60,0
40180 DATA 120,112,240,224,32,248,60,0
40190 DATA 0,1,3,7,14,28,28,30
40200 DATA 0,128,192,224,112,56,56,120
40210 REM KING
40220 DATA 49,63,31,8,15,8,15,0
40230 DATA 140,252,248,16,240,16,240,0
40240 DATA 0,1,3,3,1,13,31,49
40250 DATA 0,128,192,192,128,176,248,140
40260 REM QUEEN
40270 DATA 54,63,31,8,15,8,15,0
40280 DATA 108,248,240,16,240,16,240,0
40290 DATA 0,12,12,100,100,38,54,54
40300 DATA 0,48,48,38,38,100,108,108
40310 REM PAWN
40320 DATA 3,7,3,3,7,31,31,0
40330 DATA 192,224,192,192,224,248,248,0
40340 DATA 0,0,0,3,7,7,3,1
40350 DATA 0,0,0,192,224,224,192,128
40360 REM BLANK SQUARE
40370 DATA 0,0,0,0,0,0,0,0:REM LIGHT BLUE
40380 DATA 255,255,255,255,255,255,255,255:REM DARK BLUE
