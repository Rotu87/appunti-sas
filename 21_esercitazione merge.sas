footnote justify=left "21_esercitazione merge";

/*ESERCITAZIONE BALDISSERI  */

/* Si considerino i seguenti data set ELEZIONE e CANDIDAT. Il primo data set contiene il nome del
vincitore e del perdente per ogni elezione presidenziale negli USA dal 1960 al 1984, mentre il
secondo contiene i nomi dei candidati dei maggiori partiti, il loro partito politico e lo Stato d i
origine di ciascuno. Rispondete alle seguenti domande utilizzando i due data set:
1. per ogni anno di elezione, trovare il partito e lo Stato di appartenenza del candidato
perdente;
2. per ogni candidato, trovare l’ultima elezione cui ha partecipato e indicare se ha vinto o
perso;
3. per ogni candidato, contare il numero di volte in cui ha vinto una elezione;
4. trovare i candidati che sono stati sia perdenti che vincenti.  */

/*
DATA SET ELEZIONE
OBS ANNO VINTO PERSO
1 1960 KENNEDY NIXON
2 1964 JOHNSON GOLDWATE
3 1968 NIXON HUMPHREY
4 1972 NIXON MCGOVERN
5 1976 CARTER FORD
6 1980 REAGAN CARTER
7 1984 REAGAN MONDALE

DATA SET CANDIDAT
OBS NOME PARTITO STATO
1 NIXON R CALIF
2 GOLDWATE R ARIZ
3 KENNEDY D MASS
4 JOHNSON D TEXAS
5 HUMPHREY D MINN
6 MCGOVERN D S_DAK
7 FORD R MICH
8 CARTER D GA
9 MONDALE D MINN
10 REAGAN R CALIF
  */


/* Creo la variabile numerica COD per fare il merge. */

data ELEZIONE2;
	input 
	ANNO
	VINTO $ 
	PERSO $
	COD
	;
	datalines;
	1960 KENNEDY NIXON 1
	1964 JOHNSON GOLDWATE 2
	1968 NIXON HUMPHREY 5
	1972 NIXON MCGOVERN 6
	1976 CARTER FORD 7
	1980 REAGAN CARTER 8
	1984 REAGAN MONDALE 9
	;
run;

data CANDIDAT2;
	input 
	NOME $
	PARTITO $ 
	STATO $
	COD
	;
	datalines;
	NIXON R CALIF 1
	GOLDWATE R ARIZ 2
	KENNEDY D MASS 3
	JOHNSON D TEXAS 4
	HUMPHREY D MINN 5
	MCGOVERN D S_DAK 6
	FORD R MICH 7
	CARTER D GA 8
	MONDALE D MINN 9
	REAGAN R CALIF 10
	;
run;

/* I nomi con cui fare il merge non sono uguali a livello esadecimale.
	Non posso usarli per fare il merge. */
data ELEZIONE2HEX;
	set ELEZIONE2;
	format PERSO $HEX8.;
run;

data CANDIDAT2HEX;
	set CANDIDAT2;
	format NOME $HEX8.;
run;

proc print data = ELEZIONE2HEX;
title1 "elezione2";
run; title1;

proc print data = CANDIDAT2HEX;
title2 "Candidat2";
run; title2;
/* Fine prova. */

proc sort data = ELEZIONE2;
by COD;
run;

proc sort data = CANDIDAT2;
by COD;
run;

data PARTITI;
	merge ELEZIONE2 (IN = A) CANDIDAT2 (IN = B);
	by COD;
	if A;
	drop COD;
run;

proc print data = partiti noobs;
title3 bold color=red "Partiti";
run;

