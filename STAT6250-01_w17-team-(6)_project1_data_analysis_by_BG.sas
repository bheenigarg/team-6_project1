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
Research Question: What category(job, age, education, etc.) of clients should be targeted to achieve maximum subscriptions?  

Rationale:  A right mix of relevant categories will help the bank expand their their target group of customers. 

Methodology: Identify the significant variables using statistical modelling via logistic regression.                                    
;

*
Research Question: Which feature is the biggest contributor to prediction of subscription and how is it related to it? 

Rationale:  By determining the feature that is the most significant to the success of a campaign and its relation to the outcome, 
            the bank can better understand the causal effects and strategize accordingly. 

Methodology: Identify the most significant variable using logistic /logit model.
;

*
Research Question: What are the average number of contacts performed during this and previous campaigns and their impact on the subscriptions? 

Rationale: This will help the bank identify whether the number of times a client is contacted impacts the campaign outcome and later optimize the number of contacts to 
           achieve highest conversion. 

Methodology: Calculate the mean calls for the previous and current campaign which have resulted in a subscription and then compare the outcomes.
;
