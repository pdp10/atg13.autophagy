# The MIT License
# 
# Copyright (c) 2017 Piero Dalle Pezze
# 
# Permission is hereby granted, free of charge, 
# to any person obtaining a copy of this software and 
# associated documentation files (the "Software"), to 
# deal in the Software without restriction, including 
# without limitation the rights to use, copy, modify, 
# merge, publish, distribute, sublicense, and/or sell 
# copies of the Software, and to permit persons to whom 
# the Software is furnished to do so, 
# subject to the following conditions:
# 
# The above copyright notice and this permission notice 
# shall be included in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES 
# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR 
# ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, 
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


# synchronise time courses by maximum value


#library(tools)

# readxl does not require the crappy rJava dependency like xlsx.
#library(readxl)
#library(moments)

source('../utilities/plots.R')



sync_tc_main <- function(location, xlsxname.file, xlsxname.sheets) {
  for (i in 1:length(xlsxname.sheets)) {
    print(paste("Parsing", xlsxname.sheets[i]))
    # read a sheet in the worksheet
    # xlsx
    #df <- read.xlsx(xlsxname.file, sheetName=xlsxname.sheets[i])
    # readxl
    df <- read_excel(paste0(location, xlsxname.file), sheet=xlsxname.sheets[i])
    
    #print(df)    
    # remove rows and columns containing only NA
    df <- df[colSums(!is.na(df)) > 0]
    #df <- df[rowSums(!is.na(df)) > 0]    
    #print(df)
    
    
    # plot original time courses
    filenameout <- paste0(file_path_sans_ext(xlsxname.file), "_", xlsxname.sheets[i])
    
    plot_original_tc(df, filenameout, xlsxname.sheets[i])    
    
    sync_tc_fun(df, filenameout, xlsxname.sheets[i])
  }
  
}


sync_tc_main_csv <- function(location, csv.file, readout) {
  print(paste("Parsing", readout))
  
  df <- read.table( paste0(location, file.path(csv.file)), header=TRUE, na.strings="NA", dec=".", sep="," )
  
  # remove rows and columns containing only NA
  df <- df[colSums(!is.na(df)) > 0]
  #print(df)
  
  # plot original time courses
  filenameout <- paste0(file_path_sans_ext(csv.file), "_", readout)
  
  plot_original_tc(df, filenameout, readout)    
  
  sync_tc_fun(df, filenameout, readout)
}




###########
# LOAD DATA 
###########

suffix <- '.csv'
location <- '../data/'
filenames <- c('atg13_int_mean_ctrl', 'atg13_int_mean_wrtm')
yaxis.label <- c('IntensityMean','IntensityMean')

# filenames <- c('atg13_int_mean_ctrl', 'atg13_int_mean_wrtm', 'atg1_int_sum_ctrl.csv', 'atg1_int_sum_wrtm.csv')
# yaxis.label <- c('IntensityMean','IntensityMean','IntensitySum','IntensitySum')


################
# Synchronise tc
################

for(i in 1:length(filenames)) {
  sync_tc_main_csv(location, paste0(filenames[i], suffix), yaxis.label[i])
}

