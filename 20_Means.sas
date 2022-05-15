footnote justify=left "20_means";

/*_______________________________  */

libname in "/home/u61070631/corsosas";

data statistiche;
	set in.italia_18;
run;

/*cosa c'è nella variabile AGEA?  */

proc print data=work.statistiche (obs=10) noobs;
	var agea;
run;

/*PRONC MEANS e STATISTICHE  */

title1 "Statistiche su una variabile";

proc means data = IN.ITALIA_18 maxdec=2; 
	var AGEA; 
run;

/* Se non specifico il tipo di statistica mi restituisce quelle di dafault  */
/* maxdec dice di farmi vedere solo due decimali  */

/*Solo minimo massimo e media  */

proc means data = IN.ITALIA_18 min max mean maxdec=2; 
	var AGEA; 
run;

/*Solo percentili  */

proc means data = IN.ITALIA_18 P1 P5 P10 maxdec=2; 
	var AGEA; 
run;

/* Solo media varianza e devianza  */

proc means data = IN.ITALIA_18 mean var std maxdec=2; 
	var AGEA; 
run;

title1;

/*________________________________________  */

/* STATISTICHE PER DUE VARIABILI INSIEME  */

title2 "Statistiche su due variabili";

proc means data = IN.ITALIA_18 mean min max var std maxdec=2; 
	var AGEA 
		HHMMB; 
run;

title2;

/*________________________________________  */

/* STATISTICHE PER CLASSIFICAZIONE  */

proc means data = IN.ITALIA_18 maxdec=2; 
	var AGEA; 
	class REGION; /*REGION è la variabile che usiamo per segmentare l'analisi*/ 
run;

/*________________________________________  */

/* STATISTICHE SORTATE COL BY*/

title3 "Statistiche effettuati col BY";

/*Prima si deve sortare il database  */

proc sort data = IN.ITALIA_18 out = ITALIA_18; 
	by gndr;
	run; 

options fmtsearch= (in); 
/* ho cambio luogo in cui sas cercherà i formati, mettendo libreria in  */

/* creo un formato da associare alla colonna gndr  */
proc format library=in;
	value $sesso
		2 = "femmina"
		1 = "maschio"
		;
run;

Proc print data= ITALIA_18 (obs= 10); 
	var gndr;
	format gndr sesso.;
run;

/*ha stampato la variabile gndr ma presentandola col formato sesso*/

/* Ora dopo aver sortato e associato il formato lancio la proc means col by  */

proc means data=ITALIA_18 maxdec=2;
	var AGEA;
	by GNDR;
	format gndr sesso.;
run;

/* controllo che il totale delle osservazioni divise per gruppi
sia uguale al totale delle osservazioni del dataset */

proc contents data = italia_18;
RUN;

title3;
/*________________________________________  */

/* UTILIZZO DEL WHERE  */

title4 "Statistiche con dati filtrati";

/*Non devo usare il valore formattato, ma il valore che assume la modalità del carattere.  */

proc freq data= IN.ITALIA_18;
	table region;
run;
/* la uso per vedere rapidamente le modalità del carattere  */

proc sort data = in.italia_18 out=italia_18bis;
	by REGION;
run;

proc means data = italia_18bis n mean maxdec=2;
	var AGEA;
	by REGION;
	WHERE region in("ITC", "ITF");
run;
/*devo sempre aver prima creato il dataset sortato  */

title4;

/*_____________________________________  */

/* CREARE DATASET DELLE STATISTICHE CALCOLATE  */

title5 "Statistiche inserite in tabella strutturata";

proc means data = in.italia_18 noprint;
	var AGEA;
		output out = STATISTICHE;
RUN;

proc print data = WORK.statistiche noobs;
run;

title5;

/*aggiungo la variabile di classificazione  */

title6 "Statistiche con variabili di classificazione";

proc means data = in.italia_18 noprint;
	var AGEA;
	class GNDR;
	format GNDR sesso.;
		output out = STATISTICHE_CLASSE;
RUN;

proc print data = WORK.statistiche_classe noobs;
run;


/* osserviamo solo la numerosità (n)  */

proc means data = in.italia_18 noprint;
	var AGEA;
	class GNDR;
	format GNDR sesso.;
		output out = STATISTICHE_CLASSE;
RUN;

proc print data = WORK.statistiche_classe noobs;
run;

/* output senza noprint  */

proc means data = in.italia_18;
	var AGEA;
	class GNDR;
	format GNDR sesso.;
		output out = STATISTICHE_CLASSE;
RUN;

title6;

/* DATASET CON CLASSIFICAZIONE E DUE VARIABILI  */

title7 "Statistiche con due variabili";

proc means data = in.italia_18 noprint;
	var AGEA;
	class GNDR REGION;
	format GNDR sesso.;
		output out = STATISTICHE_2CLASSE;
RUN;

proc print data = WORK.statistiche_2classe (obs=100) noobs;
run;

title7;

/* __________________________________  */

/* CAMBIO IL NOME DELLA STATISTICA  */

title8 "Cambio nome della statistica";

proc means data=in.italia_18 noprint;
	var AGEA;
	class gndr;
		output out = medie mean = eta_media n = numerosita;
run;

proc print data= work.medie noobs;
run;
