# Prediction of Brain Region from Physiology

## Table of Contents
1. [Problem](#problem)
2. [Input Dataset](#input-dataset)
3. [Approach](#approach)
4. [Instructions](#instructions)
5. [Outputs](#outputs)
6. [Libraries Used](#libraries-used)
7. [Article Link](#article-link)
8. [SQL Script](#sql-script)

## Problem
Prediction of the brain region of brain cells ("neurons") based on their physiological properties, using the Allen Institute Neuropixel Dataset.\
Due to the distribution of the data samples, the problem is defined as a 2 group classification task (Visual Cortex vs Hippocampal Formation).\
For Allen Institute Neuropixel Dataset webpage, visit https://allensdk.readthedocs.io/en/latest/visual_coding_neuropixels.html \
For further details, here is the link for the technical white paper: https://brainmapportal-live-4cc80a57cd6e400d854-f7fdcae.divio-media.net/filer_public/80/75/8075a100-ca64-429a-b39a-569121b612b2/neuropixels_visual_coding_-_white_paper_v10.pdf 

## Input Dataset
Within Allen Institute Neuropixel Dataset, there are 2 datasets which include metrics computed from electrophysiological responses during visual stimulation.\
"Brain Observatory 1.1" and "Functional Connectivity" datasets are derived from different experimental protocols. For further details, visit webpage and the technical white paper.\
4 csv files will be used:
- units.csv
- channels.csv
- brain_observatory_1.1_analysis_metrics.csv
- functional_connectivity_analysis_metrics.csv \
These files are downloaded using the commands in the Colab notebook, provided in the "src" folder.


## Approach
1. Install Allen Software Development Kit, Download Data and Install/Import libraries
2. Read these csv files and pandas dataframes into the workspace 
3. Data Preparation
	- Filtering
	- Imputation
	- Normalization
	- Splitting into training, validation and test datasets
4. Modelling
	- Train 3 different models (Logistic Regression, Gradient Boosting, Deep Neural Networks) each for 2 datasets
	- Perform hyperparater tuning using the validation set
	- Compute performace (accuracy, f1 score) based on test sets
5. Display
	- Plot of regression weigths to visualize the influence of predictors
	- Comparison of prediction performance using 2 different datasets, based on 3 different models
	- Save figures as image files

For further details, see the notebook file "Prediction_of_Brain_Region_from_Physiology.ipynb" in the src folder. For best display, open the file with Colab.

## Instructions
Open the notebook file "Prediction_of_Brain_Region_from_Physiology.ipynb" in the src folder with Google Colab. Then run cells in the Google Colab environment.

## Outputs
	- Text and tabular displays in steps of the notebook (such as size of data, preprocessing results, performance of models etc.)
	- 2 figure files saved as image files (png format) to the Google Colab directory
	
## Libraries Used
Tensorflow, scikit-learn, statsmodels,pandas,numpy, matplotlib, plotly, os, allensdk, hypopt

## Article Link
For the article related to this project, visit https://medium.com/@ulas.ciftcioglu/can-you-locate-a-brain-cell-by-listening-to-it-3f8877d6c104  

## SQL Script
To store the related dataset in a PostgreSQL database and query the necessary portion of the dataset for this project from the database, please see the sql file "SQL_Script_Prediction_of_Brain_Region_from_Physiology.sql". See the comments on this file for further details.

For inquiries, email ciftciog@usc.edu.
