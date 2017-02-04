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
"Rationale: There may be a number of phone calls necessary for effective marketing."
;
footnote1
"Based on the output, it appears that the highest frequency and percent of successful subscriptions occurs with just one campaign call."
;
footnote2
"As the number of campaign calls increases, the percent of subscriptions decreases, showing an inverse relationship."
;
footnote3
"This information can result in less wasted time by only focusing on campaigning to individuals who have previously received less phone calls."
;
*Methodology: Use PROC FREQ to find frequency of subscription status with previous campaign calls.;

proc freq data = bank_data_analytic_file;
  tables campaign*y/nocum norow nocol list;
  format y $yfmt.;
run;
title;
footnote;

title1
"Research Question 2: Is there a relationship between duration of phone call and subscription?"
;
title2
"Rationale: If the duration of the phone call affects the likelihood of successful marketing, phone calls can be tailored for success."
;
footnote1
"This output shows that the highest rate of successful subscriptions occurs for phone calls that last between 3-4 minutes and 4-5 minutes."
;
footnote2
"These results can be used to limit the amount of time spent on a phone call to avoid wasted time on an individual who is unlikely to subscribe."
;
*Methodology: Use PROC FREQ to observe the frequency of subscriptions for each interval.;
         
proc freq data = bank_data_analytic_file;
  tables duration*y/nocum norow nocol list;
  format duration durfmt.
         y $yfmt.;
run;
title;
footnote;

title1
"Research Question 3: Does the amount of time between being contacted by campaings (pdays) affect the rate of subscription?"
;
title2
"Rationale: This can allow for a standard to be set for the amount of days that should elapse before contacting a client."
;
footnote1
"The output shown indicates that the highest success occurs when individuals were not previously contacted."
;
footnote2
"However, those that subscribe on a later phone call, were more likely to do so when 3 or 6 days have passed between previous campaign calls."
;
footnote3
"This can be used to optimize the success rate by waiting the ideal amount of days between phone calls."
;
*Methodology: Format days between calls and compare to subscription status.;

proc freq data = bank_data_analytic_file;
  tables pdays*y/nocum norow nocol list;
  format pdays pdfmt.
         y $yfmt.;
run;
title;
footnote;
