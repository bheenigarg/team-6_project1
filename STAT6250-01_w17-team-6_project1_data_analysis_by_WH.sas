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

* environmental setup;
%let dataPrepFileName = STAT6250-01_w17-team-6_project1_data_preparation.sas;
%let sasUEFilePrefix = team-6_project1;

* load external file that generates analytic dataset bank_data_analytic_file
using a system path dependent on the host operating system, after setting the
relative file import path to the current directory, if using Windows;
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
"Research Question: How effective were overall marketing campaigns based on phone calls?"
;
title2
"Rationale: Assessing the effectiveness of overall marketing campaigns with phone calls can assist the bank in decisions to stay with phone calls or not."
;
footnote1
"Average phone calls for campaign was 2.56 calls with a minimum of 1 and a maximum of 56 calls for a client client."
;
footnote2
"With overall campaign, 36,548 clients (88.73%) did not subscribe and 4,640 clients (11.27%) did subscribe for term deposits."
;
*
Methodology: Use PROC means to find average of variable "campaign". Use PROC 
freq to find % of variable "y" with respect to variable "campaign".
;
proc means data = bank_data_analytic_file;
           var campaign;
run;

proc freq data = bank_data_analytic_file;
          tables y*campaign;
	  label y = "Subscription Status";
	  title 'Current Campaign Status';
run;
title;
footnote;


title1
"Research Question: With the previous campaign, was the campaign successful?"
;
title2
"Rationale: This would help the bank to know if a better strategy is needed."
;
footnote1
"Two variables are being analyzed: previous and y."
;
footnote2
"Average number of calls for previous campaign for a client was .17 which is less than 1. It is a low average."
;
footnote3
"Minimum calls were 0 and Maximum calls were 7 for previous campaign."
;
*
Methodology: Use PROC means to find average of phone calls for the "previous"
variable. Use PROC freq to find the % of the "previous" variable with respect to "y" variable.
;
proc means data = bank_data_analytic_file;
           var previous;
run;

proc freq data = bank_data_analytic_file;
          tables y*previous;
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
proc sort data = bank_data_analytic_file  out = work.bankQ3;
          by housemaid services admin. blue-collar technician retired;
run;

proc means data = bank_data_analytic_file mode;
           var job;
	   by housemaid services admin. blue-collar technician retired;
run;
title;
footnote;
