*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

%include '.\STAT6250-01_w17-team-6_project_data_preparation.sas';

*Research Question 1: Does the number of campaign calls affect if they obtain a subscription?;
*Rationale: The number of phone calls necessary for effective marketing may vary depending on a client's age.;
*Methodology: Find frequency of subscription status with previous campaign calls.;

proc freq data = bank_data;
  tables campaign*subscription/nocum norow nocol list;
run;

*Research Question 2: Is there a relationship between duration of phone call and subscription?;
*Rationale: If the duration of the phone call affects the likelihood of successful marketing, phone calls can be tailored for success.;
*Methodology: Format duration to minutes that the call lasts. Then observe the frequency of subscriptions for each interval.;

proc format ;
  value durfmt low- 60 = '< 1 minute'
	       61 - 120 = '1 - 2 minutes'
	       121 - 180 = '2 - 3 minutes'
			   181 - 240 = '3 - 4 minutes'
			   241 - 300 = '4 - 5 minutes'
			   301 - 360 = '5 - 6 minutes'
			   361 - 420 = '6 - 7 minutes'
			   421 - 480 = '7 - 8 minutes'
         481 - 540 = '8 - 9 minutes'
         541 - 600 = '9 - 10 minutes'
			   601 - high = '> 10 minutes';
         
proc freq data = bank_data;
  tables duration*subscription/nocum norow nocol list;
  format duration durfmt.;
run;

*Research Question 3: Does the amount of time between being contacted by campaings (pdays) affect the rate of subscription?;
*Rationale: This can allow for a standard to be set for the amount of days that should elapse before contacting a client.;
*Methodology: 

proc format ;
  value pdfmt 1 = '1 day'
	       2 = '2 days'
	       3 = '3 days'
			   4 = '4 days'
			   5 = '5 days'
			   6 = '6 days'
			   7 = '7 days'
			   8 = '8 days'
         9 = '9 days'
         10 - 998 = 'More than 10 days'
			   999 = 'Not previously contacted';

proc freq data = bank_data;
  tables pdays*subscription/nocum norow nocol list;
  format pdays pdfmt.;
run;
