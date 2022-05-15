footnote justify=left "18_Proc freq prove";

libname in "/pbr/sfw/sas/940/SASFoundation/9.4/maps";

proc contents data=in.italy;
run;

proc freq data = in.italy order=freq;
	table density * segment / nocol norow nopercent;
run;

proc freq data = in.italy order=freq;
	table density * segment / nocol norow nofreq;
run;

proc freq data = in.italy order=freq;
	table density * segment / nocum list;
run;

proc freq data = in.italy;
	table density * segment /crosslist;
run;



proc freq data = in.italy;
	table density * segment /crosslist;
	where density IN(1);
run;


/* out  */

/*__________________________________  */

proc freq data = in.italy order=freq;
	table density / nopercent out = out1;
run;

proc print data = out1 noobs; run;

proc freq data = in.italy order=freq;
	table density / nopercent plots = freqplot;
run;

proc freq data = in.italy order=freq;
	table density / nopercent plots = freqplot (orient = horizontal scale = percent);
run;

/*esportazione  */
option date;
ods rtf file = "/home/u61070631/export.doc" STYLE = journal;
		title1 "ESPORTAZIONE DI PROVA";
		proc print data = out1 noobs label split = "@";
		var count;
		label
			count = "frequenza @ assoluta"
		;
		footnote "esportazione delle frequenze assolute della variabile density";
		run;
ods rtf close;
/* fine esportazione 	 */

/*__________________________________  */

proc freq data = in.italy order=freq;
	table density * segment / nocol norow nopercent out = out2;
run;

proc print data = out2 noobs; run;
	