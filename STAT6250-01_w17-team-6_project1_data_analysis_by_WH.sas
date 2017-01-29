*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file uses the following analytic dataset to address several research
questions regarding term deposit subscriptions by clients as a result of a 
marketing campaign.

Dataset Name: Bank Marketing created in external file
STAT6250-01_w17-team-(6)_project1_data_preparation.sas, which is assumed to be
in the same directory as this file

See included file for dataset properties
;

* environmental setup;

* set relative file import path to current directory (using standard SAS trick;
X "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))""";

* load external file that generates analytic dataset CAASP1516_analytic_file;
%include '.\STAT6250-01_w17-team-(6)_project1_data_preparation.sas';

*
Research Question: How effective were current marketing campaigns based on phone calls? 

Rationale: Assessing the effectiveness of current marketing campaigns with phone calls can assist the bank in decisions to stay with phone calls or not.

Methodology: Use PROC means to find average of variable "campaign". Use PROC freq to find % of variable "y" with respect to variable "campaign".

Note: Do not include previous marketing campaign information.
;

/* Obtain the mean variable of "campaign" */

proc means data = bank_data;
               var campaign;
run;

/* Display the percentages of variable "y" (yes and no) with respect to variable "campaign" */

proc freq data = bank_data;
              tables y*campaign;
	          format y yfmt.;
run;

*
Research Question: In comparison, which marketing campaign was more successful: previous or current? 

Rationale: This would help the bank to know if a better strategy is needed.

Methodology: Use PROC means to find average of phone calls for both "previous" and "campaign" variables . Use PROC freq to find the % of both "previous" and "campaign" variables with respect to "y" variable.

Note: Three variables should be analyzed: previous, campaign, and y. 
;

/* Find total average of variable "previous" and "campaign" for comparison */

proc means data = bank_data;
               var previous campaign;
run;

/* Compare percentages of previous and current campaign subscribers */

proc freq data = bank_data;
              tables y*previous*campaign;
	          format y yfmt;
run;

*
Research Question: In reference to bank clients job occupation, which job occupation of clients was the most to subscribe a term deposit? 

Rationale: This would help the bank with a target market to consider for future marketing campaigns.

Methodology: Use PROC sort to organize data to "job" variable. Use PROC print to show group of job occupations with the sum of only subscribers.

Note: Important variables that should be analyzed: job and poutcome.
;

/* Sort the data of variable "job" */

proc sort data = bank_data out = bank_data;
              by descending job;
run;

/* Show "job" variable by groups of same occupation in different tables with the sum of only subscribers */

proc print data = bank_data;
               by job;
	           pageby job;
		       var job y;
		           where y = yes;
		               sum y;
run;

