footnote justify=left "07_doppioni";

LIBNAME mr "/home/u61070631/corsosas";

/* TOGLIERE I VALORI DOPPI DA UN DATASET  */

/*ORDINO PER VISUALIZZARE SE CI SONO DOPPIONI  */

proc contents data = mr.campione_asili;
run;
/* La uso per vedere i metadati */

PROC SORT DATA = mr.campione_asili OUT = esercizio;
	BY  DESCENDING id_famiglia;
RUN;

PROC PRINT DATA = mr.campione_asili (obs=10) ; RUN;


PROC SORT DATA = MR.campione_asili OUT = esercizio2; 
	BY id_famiglia; 
RUN; 
 
PROC PRINT DATA = esercizio2 (OBS = 10); 
RUN;


proc contents data = mr.campione_asili;
run;
/* controllo la tabella per vedere il numero dei record totale  */

/* USO IL COMANDO DI OPZIONE NODUPKEY PER TOGLEIRE DALLA
TABELLA I DOPPIONI, IL COMANDO OUT PER CREARE UNA NUOVA
TABELLA SENZA DOPPIONI, IL COMANDO DUPOUT PER CREARE UNA SECONDA
TABELLA DI SOLO DOPPIONI   */
PROC SORT DATA = mr.campione_asili NODUPKEY OUT = esercizio_distinta 
									DUPOUT = doppi; 
	BY DESCENDING id_famiglia; 
RUN; 

/* CONTROLLO I RISULTATI DELLE DUE TABELLE: QUELLA SENZA DOPPIONI
E QUELLA CON DOPPIONI   */
 
PROC PRINT DATA = esercizio_distinta (OBS = 20); 
RUN; 


PROC CONTENTS DATA = esercizio_distinta; 
RUN; 


PROC PRINT DATA = doppi (OBS=10);
RUN;

PROC CONTENTS DATA = doppi; 
RUN;

/* VEDERE LE VARIABILI DI SISTEMA CHE USA SAS PER 
VISUALIZZARE I DOPPIONI  */

PROC SORT DATA = mr.campione_asili OUT = prova; 
	BY id_famiglia; 
	RUN; 
/* ho ordinato il dataset per id famiglia  */

data varaibili_di_sistema (KEEP = id_soggetto PRIMA_OSS ULTIMA_OSS); 
	SET prova; 
		BY id_famiglia; 
		 
		PRIMA_OSS = first.id_famiglia; 
		ULTIMA_OSS = last.id_famiglia; 
RUN; 

/* aggiungo al nuovo dataset le varaibili di sistema, che sono chiamate
da sas FIST.campo_che_ordino e LAST.id_famiglia, che ho rinominato come
PRIMA_OSS e ULTIMA_OSS  */

PROC PRINT DATA = varaibili_di_sistema (OBS = 30) NOOBS;
TITLE1 bold color=black "Tabella con variabili di sistema per vedere i doppioni" ;
run;

/* La variabile prima_oss vale una per il primo record, mentre zero per tutti i 
record succevi uguali al primo record (cioè i doppi). La variabile
ultima_oss fa l'opposto.  */



