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

* macro to set output destination;
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

* current ODS destination to HTML output only;
  %setOutputDestination(html)

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


*********************************************************************************;
* Research Question Analysis Starting Point;
*********************************************************************************;
* IL: don't wrap your string literals;
title1
"Research Question: What percentage of clients with housing and personal loans apply for a subscription?" 
;

title2
"Rationale: This will help the bank understand whether a client with (or without) 
loans ia a lucrative target." 
;

footnote1
"Out of 4,640 clients who have subscribed for the term deposit, 37.76% have 
neither of the loans and 8.81% have both loans." 
;

footnote2
"It is rather curious to note that 45.22% of clients who have subscribed for
the term deposit have a housing loan but not a personal loan. On the other
hand, only 5.91% of clients with personal loan but no housing loan, have
subscribed."
;

Footnote3
"Out of 36,548 clients who haven't subscribed for the term deposit, 8.98% of clients
have both loans while 39.16% have neither."
;
*
Methodology: Use PROC FREQ to create a 3-way table. Two tables are generated for
each of the subscription status (Yes, No) with rows indicating housing loan (yes,
no, unknown) and columns indicating personal loan (yes, no, unknown) for each 
client.
;

proc freq data = bank_data_analytic_file;
          *IL: change Y to a more meaningful variable name;
          *IL: consider using a format to spell out data values;
          tables y*housing*loan/norow nocol ;
          label loan = "Personal"
                   y = "Subscription Status";
          *IL: don't embed titles b/c all titles are global;
          title 'Subscription Status by Loans';
run;
title;
footnote;



title1
"Research Question: Which age group of clients have maximum subscriptions?"  
;

title2
"Rationale:  This will help the bank identify the target age group for maximum 
subscriptions." 
;

footnote1
"The age group with maximum subscriptions is 30-35 (1000) followed by 35-40(715)
and 25-30(666)."
;
 
footnote2
"It is also interesting to note that clients in age group, >60, comprises of 
substantial amount of subscriptions(414)."
;

*
Methodolgy: Use PROC FORMAT to divide the clients age into 5-year bins with
9 categories - <25, 25-30, 30-35, 35-40, 40-45, 45-50, 50-55, 55-60 and >60. 
Then use PROC FREQ to view the counts of subscriptions for each age group.
;

proc freq data = bank_data_analytic_file;
          
          tables y*age/nocum norow nocol list out=by_age;
          format age agefmt.;
          where Y = "yes";
run;

title1
"Research Question: What factors(job, age, education, marital status,
credit default, housing loan, personal loan) pertaining to clients should are 
important to achieve maximum subscriptions?"  
;

title2
"Rationale:  A right mix of relevant features will help the bank expand their 
their target group of customers." 
;

footnote1
"The likelihood ratio chi-square of 1748.9181 with a p-value <0.0001 tells us
that our model as a whole fits significantly better than an empty model."
;

footnote2
"The Type 3 Analysis of Effects table shows the hypothesis tests for each of the
variables in the model individually. The chi-square test statistics and associated 
p-values shown in the table indicate that five(with p-values <0.0001) of the seven
categorical variables in the model significantly improve the model fit."
;

footnote3
"The variables Housing(loan) and Loan(personal) have p-values 0.3112 and 0.1841
respectively which are greater than the significance level of 0.05 and hence do not 
contribute to the model"
;
 
footnote4
"The age, job type, marital status, education level and credit default of customers, 
are important factors in anticipating a potential subscription by them."
;

*
Methodology: Use PROC FORMAT to encode the subscription status- '1' indicates 'yes' 
and '0' indicates 'no'. Then use PROC LOGISTIC regression to build a statistical model
and identify statistically significant variables. The explanatory variables used here
are all categorical. The significance level decided is 0.05.
;

proc logistic data = bank_data_analytic_file descending;
              class age 
                    job 
                    marital  
                    education 
                    default  
                    housing
                    loan / param=ref;
           model y = age
                 job
                 marital
                 education
                 default
                 housing
                 loan;
              
              format y $yfmt. age agefmt.;
run;
title;
footnote;

*IL: there's no reason for the blank lines -- usually one is enough;








