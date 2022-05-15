footnote justify=left "16_IF";

/* CREAZIONE TABELLA PER IF  */

DATA figli;
	INPUT madre $ figli;
	DATALINES;
	maria 1
	genoveffa 1
	anastasia 2
	troia 5
	biancaneve 2
	malefica 4
	pollon 3
	kendi 0
	sirenetta 1
	;
RUN;

/*ESEMPI DI IF  */

DATA bonus;
	SET figli;
	IF figli >=2 THEN bonus = "si";
		ELSE bonus = "no";
RUN;
/*creato la variabile bonus quando i figli sono maggiori a due  */
PROC PRINT DATA = bonus NOOBS;
title2 "bonus";
RUN;

/* -----------------------------------------------  */
DATA agevolazione;
	SET figli;
	IF (figli >2 AND figli <4) THEN agevolazione = 10;
		ELSE IF (figli >=4) THEN agevolazione = 20;
		ELSE agevolazione = 0;
RUN;

/* le parentesi sono facoltative  */

PROC PRINT DATA = agevolazione NOOBS;
title2;
title3 "agevolazioni";
RUN;
title3;

/* -------------------------------------------  */

LIBNAME mr "/home/u61070631/corsosas";

DATA italia_18;
	SET mr.italia_18;
	
	LENGTH monofamiglia 8 genere $ 7;
	
	conta_fam = 0;  /* creo variabile contatore*/
	
	ARRAY fam (I) yrbrn yrbrn2 yrbrn3 yrbrn4 yrbrn5 yrbrn6 yrbrn7 yrbrn8;
		DO OVER fam;
			IF fam >=1 THEN conta_fam +1;
		END;
		
	IF conta_fam = 0 THEN conta_fam =.;
		IF contafam = 1 THEN monofamiglia = 1;
						ELSE monofamiglia = 0;
	
	IF gndr = 1 THEN genere = "Maschio";
	IF gndr = 2 THEN genere = "Femmina";

RUN;

/* Leggo il dataset italia_18, ne creo una copia in work area, e creo due variabile; monofamiglia e genere. Uso il comando LENGHT per impostare la lunghezza della variabile. Dopodiché mi creo un array. Questa array in cui utilizzo delle variabili chiamate: yrbrn1 ecc. Dico a sas che se queste variabili della array hanno al loro interno un valore ≥ 0 di implementare un contatore. Il contatore in questione è il dato dalla variabile conta_fam = 0 (quindi il contatore è imposta ad un valore di partenza uguale a zero). Questo incremento del contattore funziona solo se c’è una variabile numerica, per questo conta_fam è uguale a zero, altrimenti se fosse stata mancante, sas lascerebbe la variabile mancante, senza incrementarla (mancante + numero = mancante). 
Nel secondo blocco dico a sas che se conta_fam vale zero di lasciare mancante (il valore nullo si mette col punto). Se invece il valore del conta fa risulta 1 allora il valore della monofamiglia dovrà essere impostato ad 1, altrimenti bisognerà attribuirgli zero. 
Significa che la variabile monofamiglia sarà uguale a zero per tutti i casi diversi da conta_fam = 1 . Questo vuol dire che anche quanto la variabile conta_fam avrà valore mancante conta_fam restituirà zero.
Abbiamo due diverse operazioni condizionate, con ELSE e senza ELSE.
Si ELSE: significa che il valore indicato sarà inserito a tutti i valori diversi dalla condizione vera, cioè quando la condizione è falsa inserire quel valore. Il test viene fatto solo sulla prima condizione, il secondo comando non viene processato. Quando si usa ELSE devo essere sicuro che nel falso ci deve davvero andare tutti quello che è presente e che non ho indicato in precedenza.
Solo IF:  il test viene eseguito solo per la condizione che ho imposto. Se la variabile gndr avesse altri valori non verranno presi in considerazione. I record saranno processati tutti e due.
  */

PROC PRINT DATA = italia_18 (OBS= 100);
VAR yrbrn yrbrn2 yrbrn3 yrbrn4 yrbrn5 yrbrn6 yrbrn7 yrbrn8;
RUN;

PROC PRINT DATA = italia_18 (OBS= 100);
VAR conta_fam monofamiglia gndr;
RUN;

/* Il metodo migliore per vedere se ha creato le variabili è usare una proc freq incrociata di tipo list  */

PROC FREQ DATA = italia_18;
	TABLES conta_fam * monofamiglia / LIST MISSING;
RUN;

/*In questo modo vedo i risultati relativi a tutti i record, e puntualmente vedo che
quandpo conta fam vale 1 allora anche monofamiglia vale 1, e in tutti gli altri casi vale zero.  */

PROC FREQ DATA = italia_18;
	TABLES conta_fam * monofamiglia / MISSING;
RUN;

/* senza mettere il list il controllo viene molto più scomodo  */

/* non funziona, restituisce dati diversi dalla prof  */

/* -------------------------------------------  */

/* PIU CONDIZIONI DI IF  */

data italia_18;
	SET mr.italia_18;
	
	LENGTH tipo 8;
	
	IF contafam = 1 THEN tipo = 1;
		ELSE IF conta_fam IN (2,3,4) THEN tipo = 2;
		ELSE IF conta_fam IN (5,6,7,8) THEN tipo = 4;
		ELSE tipo = 4;
RUN;

/* -------------------------------------------  */

/* ALTRI IF NIDIFICATI  */

DATA italia_18nidificatado;
	SET mr.italia_18;

LENGTH maschi femmine gndr 8 sex $ 1;
	maschi  = 0;
	femmine = 0;
IF gndr = 1		THEN DO;
					sex = "m";
					maschi = maschi +1;
				END;
					ELSE DO;
						sex = "f";
						femmine = femmine + 1;
					END;

RUN;

PROC PRINT DATA = italia_18nidificatado (OBS=10) NOOBS;
VAR maschi femmine gndr sex;
RUN;

PROC FREQ DATA= italia_18nidificatado;
TABLE maschi femmine gndr sex;
RUN;



