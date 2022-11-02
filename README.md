# enem_polution
A case-study on the application of fix effects model  for the analysis Air quality and individual-level academic performance in Brazil

This repository stores the updated R code and data to reproduce the analyisis of the case study presented in the article:

Gardin, Thiago; Requia, Weeberb. Air quality and individual-level academic performance in Brazil: A nationwide study of more than 15 million students between 2000 and 2020. XXXXXXX

Several studies seek to determine the association between pollution and its health effects. This article reports a study that investigates the association between air pollution and academic performance at the individual level of Brazilian students. From a sample of more than 15 million students who took the  brazilian National High School Examination (ENEM) between 2000 and 2020, it was possible to assess the association between three pollutants and exam scores. It was concluded that from an analysis of mixed effects using the geographic level as a random effect that there is a negative association between the pollutant O³ and the results in the exam. Assssss….


Specifically, the folder data includes the following datasets:

ENEM_merged.rds: original datasets (as rds file) merged in with comom variables contain anual scores.
Base_de_referencia.rds: original dadaset with ambiental variables.

R code

The five R scripts reproduces all the steps of the analysis and the full results. Specifically:

00.pkg.R loads the packages.
01.tsprep.R prepares the data in a case time series format starting from the original mortality data.
02.linktmean.R links the gridded temperature data.
03.mainmof.R performs the main model and a comparison with the standard time series model on fully aggregated data.
04.intmod.R investigates the differential risks by deprivation score.
