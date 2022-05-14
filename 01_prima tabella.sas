/*CREARE TABELLA E ORDINARLA IN MODO DECRESCENTE  */

data PrimaProva;
	input variabilea variabileb variabilec;
	datalines;
		10 10 10
		01 02 28
		25 01 06
		135 158 584
	;

proc sort data=PrimaProva;
 by descending variabilea variabileb variabilec;
 /* se non si mette desc. sas ordina in maniera crescente. Ordina
 per prima la 1° variabile (variabile a), poi la 2° e poi la 3° */
 
Run;

proc print data = primaprova;
run;



 
