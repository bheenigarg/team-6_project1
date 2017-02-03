*******************************************************************************;
****************80-character banner for column width reference ****************;
*   set window width to banner width to calibrate line length to 80 characters*;
*******************************************************************************;

* 

This file prepares the dataset described below for analysis 
 
Dataset Name: Bank Marketing 

Experimental Units: Bank Clients

Number of Observations: 41188

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

Unique ID Schema: Client ID(made equal to Observation) is the primary key
;


*setting up environmetal parameters;

%let inputDatasetURL=
https://raw.githubusercontent.com/stat6250/team-6_project1/master/bank-additional-full.csv
; 

* create output formats;
* formatting the age variables into buckets of 5 years;
* formatting response variable, Y (subscription status) as 1 (yes)
  and 0(no);


proc format ;
  value agefmt low- 24 = '< 25'
	           25 - 29 = '25 - 30'
	           30 - 34 = '30 - 35'
	           35 - 39 = '35 - 40'
	           40 - 44 = '40 - 45'
	           45 - 49 = '45 - 50'
		   50 - 54 = '50 - 55'
		   55 - 60 = '55 - 60'
		   60 - high = '> 60';

   value $yfmt 'yes' = '1'
	       'no'  = '0';
run;


* load raw Bank Marketing data over the wire;

filename bank TEMP;

proc http method = "get"
             url = "&inputDatasetURL."
	         out = bank
     ;
 run;

proc import file = bank 
            out= bank_data
	        dbms = csv replace;
			delimiter = ";";
	        getnames= yes
     ; 
 run;

filename bank clear;

* build analytical dataset from BANK dataset with the least number of colmns and
minimal cleaning/transformation needed to address research questions in 
corresponding data-analysis files;
data bank_data_analytic_file;
    Client_ID = _N_;
    retain Client_ID
           Campaign
	   Y
	   Previous
	   Job
	   Age
	   Duration
	   Pdays
           Housing
           Loan
           Marital
           Education
           Default;
    keep   Client_ID
           Campaign
	   Y
	   Previous
	   Job
	   Age
	   Duration
	   Pdays
           Housing
           Loan
           Marital
           Education
           Default;
         
    set bank_data;
run;

