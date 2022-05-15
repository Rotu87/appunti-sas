footnote justify=left "03_univariable";

/* ANALISI UNIVARIATA SENZA GRAFICO  */

data PrimaProva;
	input variabilea variabileb variabilec;
	datalines;
		10 10 10
		01 02 28
		25 01 06
		135 158 584
	;

proc univariate data = primaprova;
	var variabilea;
	title1 "analisi univariata";
	RUN;
	

/* ANALISI UNIVARIATA CON GRAFICO  */

data secondaProva;
	input variabilea variabileb variabilec;
	datalines;
		10 10 10
		01 02 28
		25 01 06
		135 158 584
	;

proc univariate plot data = secondaprova;
	var variabilea;
	title2 "con grafico";
	RUN;