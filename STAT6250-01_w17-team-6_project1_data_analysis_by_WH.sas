*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file uses the following analytic dataset to address several research
questions regarding term deposit subscriptions by clients as a result of a 
marketing campaign.

Dataset Name: Bank Marketing created in external file
STAT6250-01_w17-team-6_project1_data_preparation.sas, which is assumed to be
in the same directory as this file

See included file for dataset properties
;
%include '.\STAT6250-01_w17-team-6_project_data_preparation.sas';


title1
"Research Question: How effective were current marketing campaigns based on phone calls?"
;
title2
"Rationale: Assessing the effectiveness of current marketing campaigns with phone calls can assist the bank in decisions to stay with phone calls or not."
;
footnote1
"Do not include previous marketing campaign information."
;
*
Methodology: Use PROC means to find average of variable "campaign". Use PROC 
freq to find % of variable "y" with respect to variable "campaign".
;
proc means data=bank_data_analytic_file;
               var campaign;
run;

proc freq data= bank_data_analytic_file;
              tables y*campaign;
	          format y yfmt.;
run;
title;
footnote;



title1
"Research Question: In comparison, which marketing campaign was more successful: previous or current?"
;
title2
"Rationale: This would help the bank to know if a better strategy is needed."
;
footnote1
"Three variables should be analyzed: previous, campaign, and y."
;
*
Methodology: Use PROC means to find average of phone calls for both "previous"
and "campaign" variables . Use PROC freq to find the % of both "previous" and 
"campaign" variables with respect to "y" variable.
;
proc means data=bank_data_analytic_file;
               var previous campaign;
run;

proc freq data=bank_data_analytic_file;
              tables y*previous*campaign;
	          format y yfmt;
run;
title;
footnote;



title1
"Research Question: In reference to bank clients job occupation, which job occupation of clients was the most to subscribe a term deposit?"
;
title2
"Rationale: This would help the bank with a target market to consider for future marketing campaigns."
;
footnote1
"Important variables that should be analyzed: job and poutcome."
;
*
Methodology: Use PROC sort to organize data to "job" variable. Use PROC print to
show group of job occupations with the sum of only subscribers.
;
proc sort data = bank_data_analytic_file out=bank_data_analytic_file;
              by descending job;
run;

proc print data = bank_data;
               by job;
	           pageby job;
		       var job y;
		           where y = yes;
		               sum y;
run;
title;
footnote;
