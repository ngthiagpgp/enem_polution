# enem_polution
A case-study on the application of fix effects model  for the analysis Air quality and individual-level academic performance in Brazil

This repository stores the updated R code and data to reproduce the analyisis of the case study presented in the article:

Gardin, Thiago; Requia, Weeberb. Air quality and individual-level academic performance in Brazil: A nationwide study of more than 15 million students between 2000 and 2020. XXXXXXX

Several studies seek to determine the association between pollution and its health effects. This article reports a study that investigates the association between air pollution and academic performance at the individual level of Brazilian students. From a sample of more than 15 million students who took the  brazilian National High School Examination (ENEM) between 2000 and 2020, it was possible to assess the association between three pollutants and exam scores. It was concluded that from an analysis of mixed effects using the geographic level as a random effect that there is a negative association between the pollutant O³ and the results in the exam. Assssss….


Specifically, the folder data includes the following **dataset end R code:

ENEM_merged_samplereport.rds: a sample dataset (as rds file) from the main dataset that contains Academic Performance and SES variables used in the analysis.
    

Modelo em looping.R reproduces all the steps of the analysis and the full results.

**Dictionary of variables:**
  NU_NOTA_REDACAO:      Writing Score
  
  NU_NOTA_OBJETIVA:     Multiple-Choice Score
  
  no2_ppb:  Mean concentration of NO² ppb of Municipality of Subject
  
  o3_ppb: Mean concentration of O³ ppb of Municipality of Subject
  
  pm25_ugm3:Mean concentration of PM 2.5  μg/m³ of Municipality of Subject
  
  NU_ANO: Year of the test score
  
  IDHM: HDI of municipality in 2010
  
  Q15: Income interval in alphabetic order
  
  Q10: Scholarity of Father
    B From 1st to 4th grade of elementary school (former primary)
    C From 5th to 8th of elementary school (former gymnasium)
    D High school (2nd grade) incomplete
    E High School (2nd grade) completed
    F Incomplete Higher Education
    G Completed higher education
    H Graduate
    I do not know
        
  TP_DEPENDENCIA_ADM_ESC: Type of manegement:
    1	Federal
    2	Estadual
    3	Municipal
    4	Privada
    
  TP_SEXO: gender
    M Male
    F Female
    
  TP_LOCALIZACAO_ESC: School Zone
    1	Urban
    2	Rural
    

