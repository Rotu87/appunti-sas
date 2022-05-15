footnote justify=left "10_Array";
/* CREARE TABELLA CON NUMERI PSEUDOCASUALI  */

DATA analisi;
	DO count = 1 TO 100;
			X = RANUNI (0);
			Y = RANUNI (1);
			Z = RANUNI (2);
		OUTPUT;
	END;
RUN;

PROC PRINT DATA = analisi NOOBS;
title1 "analisi";
RUN;
title1;


/* CREO LE MATRICI */

DATA analisi2;
	SET analisi;
/*devo creare una matrice che chiamo pratiche, contenente le
variabili X Y Z  */
	ARRAY pratiche (*) X Y Z;
/* creo un loop che si ripete tre volte indicizzato da 1 a 3 */
		DO L = 1 to 3;
/* prendendo dalla matrice pratiche la variabili n.L (da 1 a 3), una
alla volta, e moltiplico tutti i valori della variabile/colonna per 10,
e lo faccio per la matrice n.1, 2 e 3 (L)  */
		pratiche (L) = pratiche (L) * 10;
		END; /*chiudo il loop aperto con DO */
RUN;
title2 "matrice";
PROC PRINT NOOBS; RUN;
title2;

/* uso il DIM invece che elencare io il n. delle variabili,
le faccio contare a sas  */


DATA analisiDIM;
	SET analisi;
	ARRAY pratiche (*) X Y Z;
		DO L = 1 to DIM (pratiche);
		pratiche (L) = pratiche (L) * 10;
		END;
RUN;

title3 "matrice creata col dim";

PROC PRINT NOOBS; RUN;

/*col DIM ottengo lo stesso risultato, conta il numero delle colonne 
contenute nella Array invece che doverlo mettere io a mano  */

title3;

/* ---------------------------  */

/* doppia matrice con IF  */

DATA analisi3; 
	SET analisi; 
	 
	ARRAY pratiche (3) X Y Z; 
	ARRAY TIPO (3) $ 9 XX YY ZZ; 
		DO i = 1 TO 3; 
		pratiche (i) = pratiche (i) * 10; 
		IF pratiche (i) > 5 
			THEN TIPO (i) = "controllo"; 
			ELSE TIPO (i) = "apposto"; 
		END; 
RUN; 
 
PROC PRINT DATA = analisi3 NOOBS; 
title4 "Analisi3";
RUN;

/* uguale usando l'aterisco e il DIM */

DATA analisi4; 
	SET analisi; 
	 
	ARRAY pratiche (*) X Y Z; 
	ARRAY TIPO (*) $ 9 XX YY ZZ; 
		DO i = 1 TO DIM (pratiche); 
		pratiche (i) = pratiche (i) * 10; 
		IF pratiche (i) > 5 
			THEN TIPO (i) = "controllo"; 
			ELSE TIPO (i) = "apposto"; 
		END; 
RUN; 
 
PROC PRINT DATA = analisi4 NOOBS; 
title4;
title5 "Analisi3 col DIM";
RUN;

/* ------------------------------  */

DATA analisi3; 
	DO COUNT = 1 TO 100; 
		X = RANUNI (0); 
		Y = RANUNI (1); 
		Z = RANUNI (2); 
	OUTPUT; 
END; 
RUN; 
 
 
DATA analisi5; 
	set analisi; 
	 
	ARRAY pratiche (L) x y z; 
		DO OVER pratiche; 
			pratiche = pratiche * 100; 
	END; 
RUN; 

/*Il do over significa che sas utilizza tutte le variabile contenute
nella matrice, senza bisogno di specificare quante usarne.  */

PROC PRINT DATA = analisi5;  
title5;
title6 "Analisi5 col DO OVER";
RUN;



