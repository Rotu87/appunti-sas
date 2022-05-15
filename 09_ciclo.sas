footnote justify=left "09_ciclo";

/* TABELLA DA USARE COME BASE PER AVVIARE UN CICLO DI DO  */

DATA stipendi;
	INPUT cognome $ stipendio;
	DATALINES;
	colangi 1700
	belloni 1500
	borti 1200
	iata 1600
	;
RUN;

PROC PRINT DATA = stipendi NOOBS;
title1 underlin=2 "stipendi";
RUN;

/* CREAIAMO UNA DATASET CON UNA VARIABILE IN PIU' RIPETUTA TRE VOLTE SU OGNI OSSERVAZIONE  */

DATA stipendi_anno;
	SET stipendi;
/*creiamo una nuova variabile che chiamiamo anno e la impostiamo
al valore 1, 2 e 3. Dopo prenderemo la variabile che abbiamo già dello stipendio,
e la moltiplichiamo per un numero. Così avremo anno 1 lo stipendio di tot. Poi facciamo
la stessa cosa con anno 2 e 3.  */
	ANNO = 1; 
		stipendio = stipendio * 1.05;
		OUTPUT;
		
		ANNO = 2;
		stipendio = stipendio * 1.05;
		OUTPUT;

		ANNO = 3;
		stipendio = stipendio * 1.05;
		OUTPUT;
/*Crea affianco a congnome la variabile anno 1 e nel contempo cambia la variabile stipendio moltiplicandola.
Dopo crea accanto a cognome la variabile anno 2 (per farlo crea una nuova copia di cognome) e prende lo stipendio di
cognome e lo moltiplica. In questo modo il nuovo dataset avrà righe aggiuntive copiate dal dataset di origine, più le
colonne aggiuntive che abbiamo deciso di aggiungere (di cui una, stipendio, rimane ma modificata). */
RUN;
		
PROC PRINT DATA = stipendi_anno NOOBS;
title1; title2 underlin=2 "stipendi annuali senza usare do";
RUN;


/*USIAMO IL CICLO DI DO PER OTTENERE LA STESSA TABELLA DI SOPRA  */

DATA stipendi_anno2;
	SET stipendi;
	
	DO anno= 1 to 3; /* creiamo la variabile anno, che riempiamo con valori: 1,2 e 3. Sarà aggiunta ad ogni osservazione
	presente nel dataset*/
		stipendio = stipendio * 1.05; /* lo stipendio sarà moltiplicato per 1,05 per ogni riga con anno uno.
		poi di nuovo con anno due e tre.*/
		OUTPUT;
	END;
RUN;

PROC PRINT DATA = stipendi_anno2 NOOBS;
title1;title2; title3 underlin=2 "stipendi annuali ottenuti col ciclo di do";
RUN;

/* CREIAMO IL CICLO DI DO DECENNIO  */

DATA stipendi_anno3;
	SET stipendi;
	DO decennio = 1 to 2;
		OUTPUT;
	END;
RUN;

PROC PRINT DATA = stipendi_anno3 NOOBS;
title1;title2;title3; title4 underlin=2 "stipendi e decennio usando il do";
RUN;
RUN;

/* CICLO DI DO NIDIFICATO  */

DATA stipendi_anno4;
	SET stipendi;
	DO decennio = 1 to 2;
		DO anno= 1 to 3;
			stipendio = stipendio * 1.05; 
			OUTPUT;
		END;
	END;
RUN;

/* Quando parte il DO, crea una variabile chiamata decennio, dove inserisce il valore 1 per ogni 
osservazione che c'è nel dataset. Poi parte il ciclo di DO della variabile anno, che per ogni osservazione 
inserisce l'anno 1 e moltiplica gli stipendi, poi l'anno due e tre. Terminato il ciclo di DO anno, 
riprende il ciclo di DO del decennio, che aggiungerà ad ogni osservazione il decennio n.2.  
Alla fine ogni record si raddoppia per il primo ciclo di DO e triplica per il secondo ciclo di DO. 
  */

PROC PRINT DATA = stipendi_anno4 NOOBS;
title1;title2; title3;
title4 underlin=2 "stipendi annuali e decennio ottenuti col ciclo di do";
RUN;

/* SENZA USARE IL CICLO DI DO NIDIFICATO  */

DATA stipendi_anno5;
	SET stipendi;
	
	decennio = 1;
		anno = 1; 
			stipendio = stipendio * 1.05;
			OUTPUT;
	decennio = 1;
		anno = 2;
			stipendio = stipendio * 1.05;
			OUTPUT;
			
	decennio = 1;
		anno = 3;
			stipendio = stipendio * 1.05;
			OUTPUT;
			
	decennio = 2;
		anno = 1; 
			stipendio = stipendio * 1.05;
			OUTPUT;
	decennio = 2;
		anno = 2;
			stipendio = stipendio * 1.05;
			OUTPUT;
			
	decennio = 2;
		anno = 3;
			stipendio = stipendio * 1.05;
			OUTPUT;			
RUN;

PROC PRINT DATA = stipendi_anno5 NOOBS;
title1;title2; title3;title4;
title5 underlin=2 "stipendi annuali e decennio senza usare il ciclo di do";
RUN;

/*il codice funziona anche senza riperete sempre la variabile decennio  */

DATA stipendi_anno6;
	SET stipendi;
	
	decennio = 1;
		anno = 1; 
			stipendio = stipendio * 1.05;
			OUTPUT;
		anno = 2;
			stipendio = stipendio * 1.05;
			OUTPUT;
		anno = 3;
			stipendio = stipendio * 1.05;
			OUTPUT;
			
	decennio = 2;
		anno = 1; 
			stipendio = stipendio * 1.05;
			OUTPUT;
		anno = 2;
			stipendio = stipendio * 1.05;
			OUTPUT;
		anno = 3;
			stipendio = stipendio * 1.05;
			OUTPUT;			
RUN;

PROC PRINT DATA = stipendi_anno6;
title1;title2; title3;title4; title5;
title6 underlin=2 "stipendi annuali e decennio senza usare il ciclo di do (alternativa)";
RUN;
