footnote justify=left "17_Funzioni";

/* FUNZIONI  */

/* -------------------------------------  */

/* MASSIMO E MINIMO  */
DATA esercizio;
	SET mr.italia_18;

	Massimo = MAX (lrscale, stflife, stfgov, stfdem);
	Minimo = MIN (lrscale, stflife, stfgov, stfdem);
	
	FORMAT lrscale stflife stfgov stfdem 8.;

RUN;

PROC PRINT DATA = esercizio (OBS = 5) NOOBS;
	VAR lrscale stflife stfgov stfdem
		Massimo Minimo;
title1 "tabella massimo e minimo per le variabili indicate";
RUN;
title1;

/* -------------------------------------  */

/* ROUND e INT */

DATA arrotonda;
	INPUT cifra;
	CARDS;
	1234.56789
	;
RUN;

DATA arrotonda;
	SET arrotonda;
		D1 = ROUND (cifra, 100);
		D2 = ROUND (cifra, 10);
		D3 = ROUND (cifra, 1);
		D4 = ROUND (cifra, .1);
		D5 = ROUND (cifra, .01);
		D6 = ROUND (cifra, .001);
		int = INT(cifra);
RUN;

title2 "Tebella di arrotondamento";

PROC PRINT DATA = arrotonda NOOBS;
RUN;

PROC PRINT DATA = arrotonda NOOBS;
FORMAT cifra 10.8;
RUN;
title2;

/* il formato serve per leggere tutti i decimanli fino
all'ottavo numero dopo la virgola  */

/* -------------------------------------  */

/*VARIABILE ALFANUMERICA e FUNZIONE SUBSTR */

title3 "tabella funzione substr";

DATA esercizio_substr;
	INPUT testo $ 1-15;
	CARDS;
	Como, CO 27511
	;
RUN;
	

PROC PRINT DATA = esercizio_substr NOOBS;
RUN;

DATA esercizio_substr;
	SET esercizio_substr;
	SUBSTR(testo,8,2) = "TO";
RUN;

/*la funzione SUBSTR dice a sas di partire dal punto 0,
spostarsi a destra fino alla posizione n.8, e sotituire
due posizioni con la sigla "TO"  */

PROC PRINT DATA = esercizio_substr NOOBS; RUN;

title3;

/* -------------------------------------  */

/* FUNZIONE SCAN  */

title4 "Tebella funzione SCAN";

DATA esercizio_scan;
	INPUT testo $ 1-50;
	DATALINES;
	Che bella passeggeta al mare abbiamo fatto
	;
RUN;

DATA esercizio_scan;
	SET esercizio_scan;
	parola = SCAN(testo, 5, " ");
RUN;

/*la funzione scan va a prendere la 5° parola tenendo conto del
separatore vuoto/spazio/black/" "  */

PROC PRINT DATA = esercizio_scan NOOBS; RUN;

