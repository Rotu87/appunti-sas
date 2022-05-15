footnote justify=left "06_Tabella per sorting";
/*CREAZIONE DATA SET  */

DATA agenti;
	LENGTH Agente $ 15 Cliente $ 15;
	INPUT Agente $ Cliente $ Importo;
		DATALINES;
			Goku Cesare 1500
			Loki Augusto 500
			Malefica Ramesse 2300
			Terence Bud 800
			Goku Cesare 500
			Loki Augusto 1500
			Malefica Ramesse 300
			Terence Bud 200
			Goku Antonio 100
			Loki Virgilio 1200
			Malefica Ultron 4300
			Goku Aurelio 100
			Loki Cicerone 1200
			Malefica Ironman 10300
			Goku Cesare 75
			Loki Augusto 80
			Malefica Ramesse 300
			;
RUN;

PROC PRINT DATA = agenti;
title1 color=red underlin=2 "VENDITE AGENTI";
RUN;

/*________________________________________________  */

/* ORDINO PER AGENTE E IMPORTO */

PROC SORT DATA = agenti OUT = vendite_agenti;
	BY agente DESCENDING importo;
RUN;

/*Inserendo out non modifico il data set originale, ma il sorting avviene su quello in output  */

PROC PRINT DATA = vendite_agenti NOOBS;
	VAR agente importo cliente;
title1;
title2 color=red underlin=2 "VENDITE AGENTI ORDINATA: agente importo cliente";
RUN;

/*________________________________________________  */
	
/* ORDINARE PER SOLI IMPORTI */

PROC SORT DATA = agenti OUT = vendite_agenti2;
	BY DESCENDING importo;
RUN;

PROC PRINT DATA = vendite_agenti2 NOOBS;
	VAR agente importo cliente;
title1; title2;
title3 color=red underlin=2 "VENDITE AGENTI ORDINATA: importo";
RUN;


/* ORDINO IN MANIERA CRESCENTE E SOMMO PER GRUPPO  */


PROC SORT DATA = agenti OUT = vendite_agenti4;
	BY agente importo;
RUN;

PROC PRINT DATA = vendite_agenti4 NOOBS;
	VAR agente importo cliente;
	BY agente;
	SUM importo;
title1; title2; title3;
title4 color=red underlin=2 "VENDITE AGENTI PER FATTURATO";
RUN;

/* Usando by per agente riesco a vedere il fatturato di ogni agente.
Sas riporta il totale nell'ultima riga  */