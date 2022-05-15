OPTION DATE;  
ODS RTF FILE = "/home/u61070631/prova1.doc" STYLE = journal;  
/* ods è il comando di esportazione, poi devo scegliere il formato 
sas ne propone tantissimi, per aprire in word è RTF, segue FILE 
e poi seleziono ilpercorso di destinazione  
STYLE è la formattazione che creerà in word*/ 
 
	TITLE1 "Titolo del Progetto";  
	/* è la opzione titolo se vogli inserire un titolo*/ 
 
	PROC PRINTI DATA = mr.italia_18 (OBS = 5) LABEL SPLIT = "@";  
	/* label è la descrizione delle tabelle, e SPLIT il separatore per 
	andare a capo */ 
		VAR REGION NETUSTM PPLTRST;  
	/*VAR sono le variabili da esportare*/ 
	  
		LABEL /*sono le etichette da attribuire alle colonne*/ 
			REGION = "prova @ prova"  
			NETUSTM = "prova @ prova"  
			PPLTRST = "prova @ prova"  
			;  
	RUN;  
  
ODS RTF CLOSE;
/* termine della procedura di esportazione*/ 
