footnote justify=left "11_concatena";

DATA A; 
	INPUT num vara $; 
	DATALINES; 
	1 a1 
	2 a2 
	3 a3 
	; 
RUN; 


PROC PRINT DATA = A NOOBS;
RUN;



DATA B; 
	INPUT num varb $; 
	DATALINES; 
	3 b1 
	4 b2 
	5 b3 
	; 
RUN; 

PROC PRINT DATA = B NOOBS;
RUN;

/* Ordino sia la tabella A che B  */

PROC SORT DATA = a; 
	BY num;
RUN;

PROC SORT DATA = b; 
	BY num;
RUN;

PROC PRINT DATA = a NOOBS; RUN;
PROC PRINT DATA = b NOOBS; RUN;

/* COMBINO LE DUE TABELLE  */

DATA tab_a_b_combinata; 
	SET a b; 
		BY num; 
RUN; 

PROC PRINT DATA = tab_a_b_combinata NOOBS; RUN;

/* Per generare una combinazione dobbiamo inserire nel comando SET
le due tabelle che voglio combinare.  */

/*________________________________________________________  */

/* COMBINAZIONE CON LA VARIABILE IN BY NON è UNIVOCA  */

DATA c; 
	INPUT num stessa_variabile $; 
	DATALINES; 
	1 c1 
	2 c2 
	2 c3 
	3 c4 
	; 
RUN; 

PROC SORT DATA = c;
	BY num;
RUN;

PROC PRINT DATA = c NOOBS; RUN;


DATA d; 
	INPUT num stessa_variabile $; 
	DATALINES; 
	2 d1 
	3 d2 
	3 d3 
	; 
RUN;

PROC SORT DATA = d;
	BY num;
RUN;

PROC PRINT DATA = d NOOBS; RUN;


/*combiniamo le due tabelle  */
DATA combina_cd;  
	SET c d;  
		BY num;  
RUN;  
 
PROC PRINT DATA = combina_cd NOOBS; RUN; 


