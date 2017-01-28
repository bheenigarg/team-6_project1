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

proc format ;
value durfmt low- 60 = '< 1 minute'
	     61 - 120 = '1 - 2 minutes'
	     121 - 180 = '2 - 3 minutes'
             181 - 240 = '3 - 4 minutes'
	     241 - 300 = '4 - 5 minutes'
	     301 - 360 = '5 - 6 minutes'
   	     361 - 420 = '6 - 7 minutes'
	     421 - 480 = '7 - 8 minutes'
             481 - 540 = '8 - 9 minutes'
             541 - 600 = '9 - 10 minutes'
	     601 - high = '> 10 minutes';
value pdfmt 1 = '1 day'
	    2 = '2 days'
	    3 = '3 days'
	    4 = '4 days'
	    5 = '5 days'
	    6 = '6 days'
	    7 = '7 days'
	    8 = '8 days'
            9 = '9 days'
            10 - 998 = 'More than 10 days'
	    999 = 'Not previously contacted';
