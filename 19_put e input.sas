footnote justify=left "19_put e input";

/* FUNZIONI PUT E INPUT   */

/*put = trasforma da numerica ad alfanumerica  */
/* input = trasforma da alfanumerica a numerica  */

/*1) CREO IL DATASET  */

data PUTINPUT;
	input
	NUMERO CARATTERE $;
	datalines;
	303 topo
	32000 gatto
	366 pesce
	;
proc print data=PUTINPUT noobs;
title1 "Tabella dati per put e input";
run;
title1;

/* 2) APPLICO IL COMANDO PUT  */

data PUTINPUT2;
	set PUTINPUT;
	_PUT_ = put (NUMERO,3.);
	_INPUT_ = input(CARATTERE, $6.);
	_DATA_ = put (NUMERO, date9.);
	_PUT2_ = put(CARATTERE, $6.);
run;

proc print data = PUTINPUT2 noobs;
title2 "Tabella applicazione funzioni put e input";
run;
title2;

/*3) CONTROLLO TIPO E NUOVE LUGHEZZE VARIABILI  */

title3 "CONTROLLO LENGHT";

proc contents data= PUTINPUT;
run;


proc contents data= PUTINPUT2;
run;

title3;

/*Se trasformo un carattere in numero, resta un carattere.  */

/* ___________________________________________________  */

/* TRASFORMO NUMERI ALFANUMERICI IN NUMERI  */

title4 "Tabelle applicazione funzione input";

data INPUT;
	input NUMERO $;
	datalines;
	303
	32,000
	01JAN1961
	;
proc print data=INPUT noobs;
run;

data INPUT2;
	set INPUT;
	_INPUT_ = input (NUMERO,5.);
	_INPUT2_ = input(NUMERO, comma7.);
	_INPUTdata_ = input (NUMERO, date9.);
run;

proc print data = INPUT2 noobs;
run;

title4;
title5 "CONTROLLO LUNGHEZZE";

proc contents data = input; run;

proc contents data=input2; run;
