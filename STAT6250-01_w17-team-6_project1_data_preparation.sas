*******************************************************************************;
****************80-character banner for column width reference ****************;
*   set window width to banner width to calibrate line length to 80 characters*;
*******************************************************************************;

* This file prepares the dataset described below for analysis answering various 
research questions 

Dataset Name: Bank Marketing 

Experimental Units: Bank Clients

Number of Observations: 4119

Number of Features: 21

Data Source : The file http://archive.ics.uci.edu/ml/machine-learning-databases/
00222/bank-additional.zip was downloaded. An excel file bank-additional-full.
xlsx from zip file was edited and formatted to have data in proper columns.
The data is related with direct marketing campaigns of a Portuguese banking 
institution. The marketing campaigns were based on phone calls. Often, more than
one contact to the same client was required, in order to access if the product 
(bank term deposit) would be ('yes') or not ('no') subscribed. 

Data Dictionary: https://www2.1010data.com/documentationcenter/prod/Tutorials/
MachineLearningExamples/BankMarketingDataSet.html

Unique ID Schema: Client ID(randomly generated) is the primary key.

*******************************************************************************;

*setting up environmetal parameters;
%let inputDatasetURL=
https://github.com/stat6250/team-6_project1/blob/master/bank-additional-full.xlsx
; 

*Load raw data over the wire;
filename bank TEMP;

proc http method = "get"
             url = "&inputDatasetURL."
	         out = bank;
run;

proc import file = bank 
            out= bank_data
	        dbms = xlsx
	            getnames= yes; 
run;

filename bank clear;

* Check raw BANK dataset for duplicates with respect to primary key;
proc sort nodupkey data=bank_data dupout=bank_data_dups out=_null_;
         by Client_ID;
run;


* build analytical dataset from BANK dataset with the least number of colmns and
minimal cleaning/transformation needed to address research questions in 
corresponding data-analysis files;
data bank_data_analytic_file;
    retain
        Campaign
	Y
	Previous
	Job
	Age
	Duration
	Pdays
    ;
    keep
        Campaign
	Y
	Previous
	Job
	Age
	Duration
	Pdays
    ;
    set bank_data;
run;



