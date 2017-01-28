*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

%include '.\STAT6250-01_w17-team-6_project_data_preparation.sas';

title1
"Research Question 1: Does the number of campaign calls affect if they obtain a subscription?"
;
title2
"Rationale: The number of phone calls necessary for effective marketing may vary depending on a client's age."
;
*Methodology: Use PROC FREQ to find frequency of subscription status with previous campaign calls.;

proc freq data = bank_data;
  tables campaign*subscription/nocum norow nocol list;
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
  tables duration*subscription/nocum norow nocol list;
  format duration durfmt.;
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
  tables pdays*subscription/nocum norow nocol list;
  format pdays pdfmt.;
run;
title;
