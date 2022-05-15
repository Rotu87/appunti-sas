footnote justify=left "04_copia_tabella_e_agg_colonne";

/*1) Creo tabella e la stampo  */

DATA punteggi;
	INPUT nome $ cognome $ test1 test2;
		DATALINES;
			mario rossi 73 70
			marco moltemi 89 90
			luca lisi 75 99
			paolo borri 85 64
			;
PROC PRINT DATA = punteggi;
title1 "punteggi";
RUN;

/*2) Creo seconda tabella partendo dalla tabella punteggi e aggiungo due variabili che contenga
sia il valore di test1 e test2 (senza che i valori siano uniti, ma che ci sia un record per
ogni valore di test1 e test2, in pratica sono da impilare uno sotto l'altro).
Inoltre lasciare in stampa solo la colonna nuova del test*/

DATA punteggi2;
	SET punteggi;
		test = test1;
		OUTPUT;
		test = test2;
		OUTPUT;
	DROP test1 test2;
RUN;

/*3) Stampo senza la colonna delle osservazioni  */
PROC PRINT DATA = punteggi2 NOOBS;
title1; *Serve per eliminare da questa procedura la stampa del titolo 1;
title2 color=red "punteggi2"; 		
RUN;

/*Dico a sas di creare una nuova colonna chiamata TEST,
 copiandola sia da test 1 che da test2, quindi da due colonne.
 Per fare ciò sas copierà una riga riportando il valore della 
 colonna test1 nella colonna test (quindi si perde il valore
 test2), e poi ricopierà la stessa riga riportando 
 nella colonna TEST il valore presente nella colonna 
 test2 (si perde il valore di test1). 
 In questo modo duplico ogni riga la cui colonna differisce 
 solo per la colonna test. Questo serve per avere un andamento 
 progressivo del punteggio per riga, e non per colonna. Test è una 
 variabili formata dai valori di test2 e test1.*/

/* 4) Che cosa sarebbe successo se non avessi messo output?  */
DATA punteggi2_nooutput;
	SET punteggi;
		test = test1;
		test = test2;
	DROP test1 test2;
RUN;

PROC PRINT DATA = punteggi2_nooutput NOOBS;
title1; title2;
title3 color=black bold "TABELLA SENZA INSERIMENTO DEL COMANDO OUTPUT";		
RUN;
/* Il comando riferito alla creazione della seconda variabile: test = test2 va a 
sovrascrivere i valori della prima nuova variabile: test = test1. 
Quindi troviano una tabella con solo i valori della seconda variabile creata, cioè:
test = test2 */

/*________________________________________________  */

/* CREARE DUE TABELLE AVENDO COME ORIGINE UNA TABELLA SOLA  */

/* Posso creare due tabelle invece di una, e dire a sas 
in quale tabella mettere la nuova variabile. Per farlo si devono
creare due tabelle, per ogni nuova variabile creata si deve aggiungere
dopo output il nome della tabella in cui dovrà infilarsi la nuova variabile */

DATA punteggi_test1 punteggi_test2;
/* per creare due tabelle basta che le scrivo una dopo l'altra*/
	SET punteggi;
		test = test1;
		OUTPUT punteggi_test1;
		test = test2;
		OUTPUT punteggi_test2;
/*se dopo il comando OUTPUT inserirsco il nome della tabella
che ho creato nel passo di data, sas aggiungerà quella variabile
solo alla tabella indicata, e non a tutti e due. */
	DROP test1 test2;
RUN;

PROC PRINT DATA = punteggi_test1 NOOBS ;
title1; title2;title3;
title4 font="Arial" color=black underlin=2  "punteggi_test1 ";
RUN;

PROC PRINT DATA = punteggi_test2 NOOBS;
title1;title2;title3;title4;
title5 font="Times New Roman" bold italic "punteggi_test2 ";	
RUN;
