*******************************************************************************;
/******************************************************************************/;
* This file prepares the dataset described below for analysis answering various research questions 

  Dataset Name: Bank Marketing 

  Experimental Units: Bank Clients

  Number of Observations: 4119

  Number of Features: 21

  Data Source : UCI Machine Learning Repository(http://archive.ics.uci.edu/ml/datasets/Bank+Marketing#)

  The data is related with direct marketing campaigns of a Portuguese banking institution. The marketing campaigns were based on phone calls. Often, more than one contact to the same client was required, in order to access if the product (bank term deposit) would be ('yes') or not ('no') subscribed. 

  Data Dictionary: https://www2.1010data.com/documentationcenter/prod/Tutorials/MachineLearningExamples/BankMarketingDataSet.html

  Unique ID Schema: Client ID(randomly generated) is the primary key.

*******************************************************************************;

*setting up environmetal parameters;

%let inputDatasetURL=
https://raw.githubusercontent.com/stat6250/team-6_project1/master/bank-additional-full.csv 
; *link to raw data;

*Load raw data over the wire;

filename bank TEMP;

proc http method = "get"
             url = "&inputDatasetURL."
	         out = bank;
run;

proc import file = bank 
            out= bank_data
	        dbms = csv replace;
		    delimiter = ";";
			getnames= yes; 
run;

filename bank clear;






