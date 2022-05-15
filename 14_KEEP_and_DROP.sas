footnote1 justify=left "14_keep_and_drop";
/*_________________________________  */

DATA punteggi; 
	INPUT nome $ cognome $ test1 test2; 
		DATALINES; 
			mario rossi 73 70 
			marco moltemi 89 90 
			luca lisi 75 99 
			paolo borri 85 64 
			; 
PROC PRINT DATA = punteggi; 
RUN;

/* _____________________________________ */

/*CREARE TABELLA CON KEEP IN STATEMENT  */
DATA Test1_keep;
	SET punteggi;
	KEEP nome cognome test1;
RUN;

TITLE1 "KEEP in Statement";
PROC PRINT DATA = Test1_keep NOOBS;
RUN;
/* mantiene solo i campi dichiarati  */
TITLE1;


/* _____________________________________ */

/*CREARE TABELLA CON DROP IN STATEMENT  */
DATA Test1_drop;
	SET punteggi;
	DROP test2;
RUN;
/* elimina il campo indicato  */
TITLE2 "DROP in Statement";
PROC PRINT DATA = Test1_drop NOOBS;
RUN;
title2;
/* _____________________________________ */

/*CREARE TABELLA CON KEEP IN OPZIONE  */
DATA Test1_keep2 (KEEP = nome cognome test1);
	SET punteggi;
RUN;
TITLE3 "KEEP in OPTION";
PROC PRINT DATA = Test1_keep2 NOOBS;
RUN;
TITLE3;
/* _____________________________________ */

/*CREARE TABELLA CON DROP IN OPZIONE  */
DATA Test1_drop2 (DROP = test2);
	SET punteggi;
RUN;
TITLE4 "DROP in OPTION";
PROC PRINT DATA = Test1_drop2 NOOBS;
RUN;




