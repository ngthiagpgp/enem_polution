A case-study on the application of mixed-effects regression models for air quality and individual-level academic performance in Brazil

This repository stores the updated R code and data to reproduce the analysis of the case study presented in the article:

Gardin, Thiago; Requia, Weeberb. Air quality and individual-level academic performance in Brazil: A nationwide study of more than 15 million students between 2000 and 2020. XXXXXXX

The folder data includes the following datasets end R codes:

ENEM_merged_samplereport.rds: a sample dataset (as rds file) from the main dataset that contains Academic Performance and SES variables used in the analysis.
Modelo em looping.R: reproduces all the steps of the analysis and the full results.

Dictionary variables: 

NU_NOTA_REDACAO: Essay Score

NU_NOTA_OBJETIVA: General subjects Score

no2_ppb: Mean concentration of NO2 (ppb)

o3_ppb: Mean concentration of O3 (ppb)

pm25_ugm3: Mean concentration of PM2.5 (μg/m³)

NU_ANO: Year of the test score

IDHM: Human Development Index for each municipality in 2010

Q15: Income

Q10: parental education

TP_DEPENDENCIA_ADM_ESC: Type of management: 1- Federal, 2- State, 3- Municipality, 4- Private

TP_SEXO: gender M Male F Female

TP_LOCALIZACAO_ESC: School Zone 1 Urban 2 Rural
