10 REM OPERATORE LOGICO
11 :
12 REM ESEMPIO DI INTELLIGENZA ARTIFICIALE BY SANDRO CERTI & FRANCO TOLDI
13 :
14 REM PER QUALSIASI COMMODORE
15 :
20 REM ROUTINE SUPERVISORE
30 CLEAR 200:GOSUB 100:REM INIZIALIZZAZIONE
40 WW=0:GOSUB 220:IF WW THEN 40:REM RICEVE INPUT
50 GOSUB 280:REM SMISTA E ELABORA INPUT
60 IF P=1 THEN GOSUB 500:GOTO40: REM DICHIARATIUE
70 IF P=2 THEN GOSUB 610:GOTO40: REM INTERROGATIVE
80 IF P=3 THEN GOSUB 840:REM VISUALIZZA LISTE
90 GOTO 40
100 REM INIZIALIZZAZIONE
110 DIM A$(19,19)
120 FOR Y=0 TO 19
130 FOR X=0 TO 19
140 A$(Y,X)="*":REM CARATTERE "SPIA"
150 NEXTX:NEXTY:CLS:GOSUB 1000:RETURN
220 REM RICEVE INPUT
230 P=0
250 INPUT"(HELP D- I- V-)";I$:IF I$="HELP" THEN GOSUB 1000:RETURN
260 IF I$="FINE" THEN END
270 RETURN
280 REM SMISTA
290 B$=LEFT$(I$,2)
300 I$=MID$(I$,3)
310 IF B$="D-" THEN P=1:GOTO 350
320 IF B$="I-" THEN P=2:GOTO 350
330 IF B$="V-" THEN P=3:GOTO 350
340 PRINT"INPUT NON CONFORME ALLE REGOLE":GOTO 490
350 REM DIUIDE INPUT
360 IF P=3 THEN NO$=I$:GOTO 410
370 FOR K=1 TO LEN(I$)
380 IFMID$(I$,K,4)=" E' "THENNO$=LEFT$(I$,K-1):AT$=MID$(I$,K+4):GOTO410
390 NEXT
400 PRINT"INPUT NON CONFORME ALLE REGOLE":GOTO 490
410 REM TOGLIE ARTICOLI
420 RESTORE
430 FOR XX=1 TO 8
440 READ AR$
450 IF MID$(NO$,1,LEN(AR$))=AR$ THEN NO$=MID$(NO$,LEN(AR$)+1)
460 IF MID$(AT$,1,LEN(AR$))=AR$ THEN AT$=MID$(AT$,LEN(AR$)+1)
470 NEXT
480 DATA "IL ","LO ","LA ","L'","UN ","UNA ","UN'","UNO "
490 RETURN
500 REM STORAGE FRASI DICHIARATIUE
510 FOR X=0 TO 19
520 IF A$(0,X)=NO$ THEN 550
530 IF A$(0,X)="*" THEN A$(O,X)=NO$:GOTO 550
540 NEXT
550 FOR Y=1 TO 19
560 IF A$(Y,X)=AT$ THEN 590
570 IF A$(Y,X)="*" THEN A$(Y,X)=AT$:GOTO 590
580 NEXT
590 PRINT"OK"
600 RETURN
610 REM INTERROGATIUE
620 FOR X=0 TO 19
630 IF A$(O,X)=NO$ THEN 660
640 NEXT
650 PRINT "NESSUN DATO PER CONFERMARE":GOTO 830
660 FOR Y=1 TO 19
670 IF A$(Y,X)=AT$ THEN 820
680 NEXT
690 FOR N=1 TO 19
700 FOR M=0 TO 19
710 IF A$(N, M)=AT$ THEN 740
720 NEXT:NEXT
730 GOTO 770
740 FOR Y=1 TO 19
750 IF A$(Y,X)=A$(0,M) THEN 780
760 NEXT
770 PRINT"NESSUN DATO PER CONFERMARE":GOTO 830
780 FOR S=Y+1 TO 19
790 IF A$(S,X)="*" THEN A$(S,X)=AT$:GOTO 820
800 NEXT
810 PRINT"NON HO PIU' SPAZIO":GOTO 830
820 PRINT"POSSO CONFERMARE "
830 RETURN
840 REM VISUALIZZAZIONI
850 FOR K=0 TO 19
860 IF A$(0,K)=NO$ THEN 900
870 NEXT
880 PRINT"NESSUN DATO DISPONIBILE"
890 GOTO 940
900 PRINT NO$+" E': "
910 FOR J=1 TO 19
920 IF A$(J,K)<>"*" THEN PRINT A$(J,K)
930 NEXT
940 RETURN
999 REM MESSAGGIO DI HELP
1000 PRINT:PRINT
1010 PRINT"PER LE DICHIARAIIVE FAR PRECEDERE D-"
1020 PRINT"PER LE INTERROGAIIVE FAR PRECEDERE I-"
1030 PRINT"PER LE VISUALIZZAZ1ONI FAR PRECEDERE V-":PRINT
1035 PRINT"HELP PER RICHIAMARE REGOLE":PRINT
1040 PRINT"FINE PER FINIRE"
1050 PRINT:INPUT"PREMI INVIO";ZZ$
1060 WW=1:RETURN
