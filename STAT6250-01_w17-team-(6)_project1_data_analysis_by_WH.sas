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
Q1: How effective were marketing campaigns based on phone calls? 
(Rationale: Assessing the effectiveness of marketing campaigns with phone calls can assist the bank in decisions to stay with phone calls or not)

Q2: In comparison, which marketing campaign is more successful: previous or current? 
(Rationale: This would help the bank to know if a better strategy is needed)

Q3: In reference to bank clients job occupation, which job occupation of clients was the most to subscribe a term deposit? 
(Rationale: This would help the bank with a target market to consider for future marketing campaigns)
;
