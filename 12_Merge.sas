footnote justify=left "12_merge";
DATA A; 
	INPUT num vara $; 
	DATALINES; 
	1 a1 
	2 a2 
	3 a3 
	; 
RUN; 

title1 underlin=2 color=red "tabella A";

PROC PRINT DATA = A NOOBS;
RUN;

title1;



DATA B; 
	INPUT num varb $; 
	DATALINES; 
	3 b1 
	4 b2 
	5 b3 
	; 
RUN; 

title2 underlin=2 color=red "tabella B";

PROC PRINT DATA = B NOOBS;
RUN;

title2;

/* Ordino sia la tabella A che B  */

PROC SORT DATA = a; 
	BY num;
RUN;

PROC SORT DATA = b; 
	BY num;
RUN;

title3 underlin=2 color=red "tabella A e B ORDINATE";

PROC PRINT DATA = a NOOBS; RUN;
PROC PRINT DATA = b NOOBS; RUN;

title3;


/* UNISCO LE DUE TABELLE  */

DATA merge_ab; 
	MERGE a b; 
		BY num; 
RUN; 

PROC PRINT DATA = merge_ab NOOBS; 
title4 underlin=2 color=red "MERGE FULL A e B";
RUN;

title4;

/* Per generare un merge dobbiamo inserire il comando MERGE al posto del SET più
le due tabelle che voglio unire.  */

/*________________________________________________________  */

/* aggiungere le variabili di sistema  */

DATA merge_ab_sistema; 
	MERGE a (IN = a) b (IN = b); 
		BY num; 
	
	AA = a;
	BB = b;
RUN; 

PROC PRINT DATA = merge_ab_sistema NOOBS; 
title5 underlin=2 color=red "MERGE con variabile di sistema";
RUN; 
title5;

/* è un trucco per vedere cosa fa sas. Se la tabella creata da
sas nel pdv contiene il valore a allora la colonna AA riporterà 1 (VERO), 
altrimenti riporterà 0 (FALSO), stessa cosa per la tabella b.
Al num = 3 sono vere sia AA e BB, perché nel merge ci sono sia a che b.  */

/* USANDO L'IF per LEFT JOIN  */

/*ricordarti sempre di ordinare il database  */

PROC SORT DATA = a; 
	BY num;
RUN;

PROC SORT DATA = b; 
	BY num;
RUN;

DATA merge_ab_sistema_IF; 
	MERGE a (IN = a) b (IN = b); 
		BY num;
		IF A;
	
	AA = a;
	BB = b;
RUN;

PROC PRINT DATA = merge_ab_sistema_IF; 
title6 underlin=2 color=red "MERGE A e B di tipo LEFT";
RUN;
title6;

/* Mettendo IF A sto dicendo a sas di inserire nella tabella combinata 
solo i valori di A uniti con B (LEFT JOIN). */

/* USANDO L'IF e AND per INNER JOIN  */

DATA merge_ab_sistema_AND; 
	MERGE a (IN = a) b (IN = b); 
		BY num;
		IF A AND B;
	
	AA = a;
	BB = b;
RUN;

PROC PRINT DATA = merge_ab_sistema_AND NOOBS;
title7 underlin=2 color=red "MERGE A e B di tipo INNER";
RUN;
title7;

/* In questo caso si prendono i valori che 
sono intersecati tra A e B (INNER JOIN)  */

/*USO IL RENAME  */

DATA merge_ab_sistema_rename; 
	MERGE a (IN = a) b (IN = b); 
		BY num;
	
	AA = a;
	BB = b;
	RENAME AA = varibiledisistemaA;
	RENAME BB = variabiledisistemaB;
RUN;

PROC PRINT DATA = merge_ab_sistema_rename NOOBS;
title8 underlin=2 color=red "MERGE A e B di tipo FULL + RENAME";
RUN;





