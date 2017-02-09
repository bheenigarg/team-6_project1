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

*macro to set ouput destination;
%macro setOutputDestination(destination);
    ods _all_ close;
    %if
        %upcase(&destination.) = HTML
    %then
        %do;
            ods html;
        %end;
    %else %if
        %upcase(&destination.) = LISTING
    %then
        %do;
            ods listing;
        %end;
    %else %if
        %upcase(&destination.) = PDF
    %then
        %do;
            ods pdf;
        %end;
    %else %if
        %upcase(&destination.) = RTF
    %then
        %do;
            ods rtf;
        %end;
    %else %if
        %upcase(&destination.) = EXCEL
    %then
        %do;
            ods excel;
        %end;
%mend;

* uncomment the line below to close all active output destinations and switch
  the current ODS destination to HTML output only;
/*%setOutputDestination(html)*/

* uncomment the line below to close all active output destinations and switch
  the current ODS destination to listing output only;
/*%setOutputDestination(listing)*/

* uncomment the line below to close all active output destinations and switch
  the current ODS destination to PDF output only;
/*%setOutputDestination(pdf)*/

* uncomment the line below to close all active output destinations and switch
  the current ODS destination to RTF output only;
/*%setOutputDestination(rtf)*/

* uncomment the line below to close all active output destinations and switch
  the current ODS destination to Excel output only;
/*%setOutputDestination(excel)*/

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


*******************************************************************************;
* Research Question Analysis Starting Point 1;
*******************************************************************************;
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


*******************************************************************************;
* Research Question Analysis Starting Point 2;
*******************************************************************************;
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


*******************************************************************************;
* Research Question Analysis Starting Point 3;
*******************************************************************************;
title1
"Research Question: In reference to bank clients job occupation, which job occupation of clients was the most to subscribe a term deposit?"
;
title2
"Rationale: This would help the bank with a target market to consider for future marketing campaigns."
;
footnote1
"The variables "y" and "job" are analyzed for this question."
;
footnote2
"Job occupation "Admin" had the highest subscription 1,352 out of 4,640 (29.14%) for term deposits."
;
footnote3
"Bank should consider about target marketing in job occupation "Admin"."
*
Methodology: Use PROC FREQ to obtain the percentages of all job occupation that subscribed to term deposits.
;
proc freq data = bank_data_analytic_file;
           tables y*job;
	   where y = "yes";
run;
title;
footnote;

* set output destination back to default HTML output;
%setOutputDestination(html)
