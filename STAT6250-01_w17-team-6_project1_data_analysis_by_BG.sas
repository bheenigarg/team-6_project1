*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file uses the following analytic dataset to address several research
questions regarding term deposit subscriptions by clients as a result of a 
marketing campaign.

Dataset Name: bank_data_analytic_file created in external file
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
"Research Question: What category(job, age, education, etc.) of clients should be targeted to achieve maximum subscriptions?"  
;

title2
"Rationale:  A right mix of relevant categories will help the bank expand their their target group of customers." 
;

footnote1
""
;
 
/* Finding the age group of clients with maximum subscriptions*/

proc freq data = bank_data;
  tables y*age/nocum norow nocol list;
  format age agefmt.;
run;

proc logistic data = bank_data descending;
           class age job marital education default housing
                 loan contact month day_of_week poutcome / param=ref;
		   model y = 
         age
		 job
		 marital
		 education
		 default
		 housing
		 loan
		 contact
		 month
		 day_of_week
		 duration
		 campaign
		 pdays
		 previous
		 poutcome
		 emp_var_rate
		 cons_price_idx
		 cons_conf_idx
		 euribor3m
		 nr_employed
		 ;
run;

*
Methodology: Identify the significant variables using statistical modelling via logistic regression.                                    
;
title;
footnote;


title1
"Research Question: Which feature is the biggest contributor to prediction of subscription and how is it related to it?"
;

title2 
"Rationale:  By determining the feature that is the most significant to the success of a campaign and its relation to the outcome, 
            the bank can better understand the causal effects and strategize accordingly."
;

footnote1
""
; 


proc logistic data = bank_data descending;
           class job marital education default housing
                 loan contact month day_of_week poutcome / param=ref;
		   model y = 
         age
		 job
		 marital
		 education
		 default
		 housing
		 loan
		 contact
		 month
		 day_of_week
		 duration
		 campaign
		 pdays
		 previous
		 poutcome
		 emp_var_rate
		 cons_price_idx
		 cons_conf_idx
		 euribor3m
		 nr_employed
		 ;
run;
title;
footnote;

*
Methodology: Use PROC LOGISTIC regression to build a model and identify statistically
significant variables;

title1
"Research Question: What are the average number of contacts performed during this and previous campaigns and their impact on the subscriptions?" 
;

title2
"Rationale: This will help the bank identify whether the number of times a client is contacted impacts the campaign outcome and later optimize the number of contacts to 
           achieve highest conversion." 
;

footnote1
""
;

/* Average number of calls in current and previous campaigns split by subscriptions */

proc means data = bank_data;
           var campaign 
		       previous;
		   class y;
	       label campaign = "Calls in Current Campaign"
		         previous = "Calls in Previous Campaign"
                        y = "Subscribed";
	  		
	       title1 'Average Number of Calls in Current and Previous Campaigns';
run;

*
Methodology: Use PROC MEANS to calculate the mean calls for the previous and current
campaign which have resulted in a subscription and then compare the outcomes.
;

title;
footnote;
