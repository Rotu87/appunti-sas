footnote1 justify=left "01_primatabella";
*è il piè di pagina da riportare in stampa (giustificato a sinistra);

/*CREARE TABELLA E ORDINARLA IN MODO DECRESCENTE  */

data PrimaProva;
	input variabileA variabileB variabileC;
	datalines;
		10 10 10
		01 02 28
		25 01 06
		135 158 584
	;

/*Ordinare ogni attributo in maniera decrescente   */

proc sort data=PrimaProva;
 by descending variabileA variabileB variabileC;
 /* se non si mette desc. sas ordina in maniera crescente. Ordina
 per prima la 1° variabile (variabile A), poi la 2° e poi la 3° */ 
Run;


/* Stampo la tabella creata  */
proc print data = primaprova;
run;

/*E' stampata secondo l'ordine impartito dalla proc sort  */


 
