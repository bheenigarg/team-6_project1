*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

* environmental setup;
%let dataPrepFileName = STAT6250-01_w17-team-6_project1_data_preparation.sas;
%let sasUEFilePrefix = team-6_project1;

%macro setup;
%if
    &SYSSCP. = WIN
%then
    %do;
        X
        "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))"""
        ;           
        %include ".\&dataPrepFileName.";
    %end;
%else
    %do;
        %include "~/&sasUEFilePrefix./&dataPrepFileName.";
    %end;
%mend;
%setup

title1
"Research Question 1: Does the number of campaign calls affect if they obtain a subscription?"
;
title2
"Rationale: The number of phone calls necessary for effective marketing may vary depending on a client's age."
;
*Methodology: Use PROC FREQ to find frequency of subscription status with previous campaign calls.;

proc freq data = bank_data;
  tables campaign*y/nocum norow nocol list;
  format y $yfmt.;
run;
title;

title1
"Research Question 2: Is there a relationship between duration of phone call and subscription?"
;
title2
"Rationale: If the duration of the phone call affects the likelihood of successful marketing, phone calls can be tailored for success."
;
*Methodology: Use PROC FREQ to observe the frequency of subscriptions for each interval.;
         
proc freq data = bank_data;
  tables duration*y/nocum norow nocol list;
  format duration durfmt.
         y $yfmt.;
run;
title;

title1
"Research Question 3: Does the amount of time between being contacted by campaings (pdays) affect the rate of subscription?"
;
title2
"Rationale: This can allow for a standard to be set for the amount of days that should elapse before contacting a client."
;
*Methodology: Format days between calls and compare to subscription status.;

proc freq data = bank_data;
  tables pdays*y/nocum norow nocol list;
  format pdays pdfmt.
         y $yfmt.;
run;
title;
