/*OPZIONI DI GLOBAL STATEMENT PRELIMINARI  */

DM "LOG;CLEAR;OUTPUT;CLEAR";
OPTIONS NODATE NOCENTER LS = 78 PS = 55;

/*Sono comandi per la formattazione della pagina, sono tutti opzionali  */

OPTIONS FORMCHAR = "|----|+|---+=|-/\<>*";
ODS listing; ODS GRAPHICS OFF;

/* Queste due opzioni le tengo se non voglio i grafici di sas, ma li lascio creare
con il trattino (-) e il più (+). Ma meglio eliminarle o non lanciarle in stampa.  */

/*________________________________________*/

FOOTNOTE JUSTIFY=left "02_analisi people";

TITLE1 "ESERCIZIO DA INTERNET";

DATA people;
	INPUT gender $ height weight;
	DATALINES; *Potevo usara cards al posto di datalines;
	m 63 125
	m 76 195
	f 62 109
	m 75 186
	f 67 115
	f 60 120
	m 75 205
	m 71 185
	m 63 140
	f 59 135
	f 65 125
	m 68 167
	m 72 220
	f 66 155
;
			
PROC SORT DATA = people;
	BY gender;
RUN;

PROC PRINT DATA=people;
	TITLE2 "Dati grezzi ordinati solo per genere";
RUN;

/*______________________________________________________  */

/* Ordino per tutte e tre le variabili in modo crescente  */

PROC SORT DATA = people out=people_II_ordinamento;
	BY gender height weight;
RUN;

/*Ho aggiunto out per non sovrascrivere la tabella people ordianta solo per genere.
Il comando out mi permette di generare una nuova tabella da usare al posto di quella originale  */

TITLE2; /*si inserisce per disattivare la stampa del titolo2*/

PROC PRINT DATA = people_II_ordinamento;
	TITLE3 "Dati grezzi ordinati per genere, altezza e peso";
RUN;

/*______________________________________________________  */

/*PREDISPORRE L'ANALISI STATITSTICA UNIVARIATA SULLA VARIABILE GENERE  */

TITLE2; TITLE3;

PROC UNIVARIATE PLOT DATA = people_II_ordinamento; 
	by gender;
	TITLE4 "Univariate procedure output done separately by gender";
	TITLE5 "The analysis was done for two quantitative variables";
	FOOTNOTE2 "Univariate analysis"; /*è il pié di pagina*/
	VAR height weight;
	
RUN;

/*Sto dicendo a sas condurre un'analisi statistica univariata sulle variabili height e weight,
separata per genere. La pocedurà fornirà quattro analisi, comprensiva di grafico, per:
- altezza dei maschi
- altezza delle femmine
- peso dei maschi
- peso delle femmine  */

