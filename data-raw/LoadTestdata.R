# This file loads all testdata used by the testthat scripts into R/sysdata
# there is also code to load all required libraries

library(dplyr)
library(devtools)
library(readxl)
library(usethis)




########################################
######### CREATE TEST DATA #############
########################################

##############
## EXTERNAL ##
##############

# esp2013
esp2013 <- c(5000,5500,5500,5500,6000,6000,6500,7000,7000,7000,7000,6500,6000,5500,5000,4000,2500,1500,1000)


##############
## INTERNAL ##
##############

# quantile lookup
qnames <- data.frame(quantiles = c(2L,3L,4L,5L,6L,7L,8L,10L,12L,16L,20L),
                     qname     = c("Half","Tertile","Quartile","Quintile","Sextile","Septile",
                                  "Octile","Decile","Duo-decile","Hexadecile","Ventile"),
                     stringsAsFactors = FALSE)


# quantile test data
test_quantiles <- read_excel(".\\tests\\testthat\\testdata_Quantiles.xlsx",
                             sheet="testdata_Quantiles",   col_names=TRUE)  %>%
  select(-Rank, -RevValue, -Sex, -RowsInGrp)

test_quantiles$Polarity[test_quantiles$Polarity == "RAG - High is good"] <- FALSE
test_quantiles$Polarity[test_quantiles$Polarity == "RAG - Low is good"] <- TRUE
test_quantiles$Value <- as.numeric(test_quantiles$Value, digits = 10)

test_quantiles_ug <- test_quantiles %>%
  filter(substr(Test,1,4) == "Good")

test_quantiles_g <-test_quantiles_ug %>%
  group_by(IndSexRef)

test_quantiles_fail <- test_quantiles %>%
  filter(Test == "BadPolarity")



# Byars Wilson test data
test_BW <- read_excel(".\\tests\\testthat\\testdata_Byars_Wilson.xlsx", sheet="testdata_B_W",   col_names=TRUE)

# Funnel proportions
test_fp <- read_excel(".\\tests\\testthat\\testdata_funnel_prop.xlsx", sheet="Plot",   col_names=TRUE)

test_fs <- read_excel(".\\tests\\testthat\\testdata_funnel_prop.xlsx", sheet="Sig",   col_names=TRUE)
test_fs[is.na(test_fs)]<-""
test_fs$Area<-as.factor(test_fs$Area)

# Proportions test data
test_Prop   <- read_excel(".\\tests\\testthat\\testdata_Proportion.xlsx", sheet="testdata_Prop",   col_names=TRUE)

test_Prop_g <- test_Prop %>%
  group_by(Area)

test_Prop_g_results   <- read_excel(".\\tests\\testthat\\testdata_Proportion.xlsx", sheet="testdata_Prop_g",   col_names=TRUE)




#Rates test data
test_Rate <- read_excel(".\\tests\\testthat\\testdata_Rate.xlsx", sheet="testdata_Rate", col_names=TRUE)

test_Rate_g <- test_Rate %>%
  group_by(Area)

test_Rate_g_results   <- read_excel(".\\tests\\testthat\\testdata_Rate.xlsx", sheet="testdata_Rate_g",   col_names=TRUE)




#Means test data
test_Mean         <- read_excel(".\\tests\\testthat\\testdata_Mean.xlsx", sheet="testdata_Mean",         col_names=TRUE)
test_Mean_results <- read_excel(".\\tests\\testthat\\testdata_Mean.xlsx", sheet="testdata_Mean_results", col_names=TRUE)

test_Mean_Grp <- group_by(test_Mean,area)





# DSRs, ISRs and SMRs test data
test_multiarea   <- read_excel(".\\tests\\testthat\\testdata_DSR_ISR_SMR.xlsx", sheet="testdata_multiarea", col_names=TRUE) %>%
  group_by(area)
test_DSR_1976    <- read_excel(".\\tests\\testthat\\testdata_DSR_ISR_SMR.xlsx", sheet="testdata_1976",   col_names=TRUE)
test_err1        <- read_excel(".\\tests\\testthat\\testdata_DSR_ISR_SMR.xlsx", sheet="testdata_err1",   col_names=TRUE)
test_err2        <- read_excel(".\\tests\\testthat\\testdata_DSR_ISR_SMR.xlsx", sheet="testdata_err2",   col_names=TRUE) %>%
  group_by(area)
test_err3        <- read_excel(".\\tests\\testthat\\testdata_DSR_ISR_SMR.xlsx", sheet="testdata_err3",   col_names=TRUE)
test_DSR_results <- read_excel(".\\tests\\testthat\\testdata_DSR_ISR_SMR.xlsx", sheet="testresults_DSR", col_names=TRUE)
test_multigroup  <- read_excel(".\\tests\\testthat\\testdata_DSR_ISR_SMR.xlsx", sheet="testdata_multigroup", col_names=TRUE) %>%
  group_by(area,year)

test_ISR_results <- read_excel(".\\tests\\testthat\\testdata_DSR_ISR_SMR.xlsx", sheet="testresults_ISR", col_names=TRUE)
test_ISR_refdata <- read_excel(".\\tests\\testthat\\testdata_DSR_ISR_SMR.xlsx", sheet="refdata",         col_names=TRUE)
test_ISR_ownref  <- read_excel(".\\tests\\testthat\\testdata_DSR_ISR_SMR.xlsx", sheet="testdata_multiarea_isrsmr", col_names=TRUE) %>%
                      group_by(area)

# SII
SII_test_data <- read_excel("tests/testthat/testdata_SII.xlsx")

# Grouped SII test data
SII_test_grouped <- SII_test_data %>%
     group_by(Area, Grouping1, Grouping2)


########################################
###### SAVE TEST DATA TO PACKAGE #######
########################################

# SAVE EXTERNALLY AVAILABLE DATA IN data\XXXXXX.rda - data available to user
usethis::use_data(esp2013, LE_data, DSR_data, prevalence_data,
                  internal=FALSE, overwrite=TRUE)


# SAVE INTERNAL DATA IN R\Sysdata.rda - data available to functions and test scripts but not available to user:
usethis::use_data(qnames, test_BW, test_Prop, test_Prop_g, test_Prop_g_results,
                  test_quantiles_g, test_quantiles_ug, test_quantiles_fail,
                  test_Rate, test_Rate_g, test_Rate_g_results,
                  test_Mean, test_Mean_Grp, test_Mean_results,
                  test_multiarea, test_multigroup, test_DSR_1976, test_err1, test_err2, test_err3, test_DSR_results,
                  test_ISR_refdata, test_ISR_results, test_ISR_ownref,
                  SII_test_data, SII_test_grouped,test_fp, test_fs,
                  internal = TRUE, overwrite = TRUE)
