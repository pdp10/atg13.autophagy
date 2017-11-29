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


source('../utilities/plots.R')


sync_tc_main <- function(location, csv.file, readout) {
  print(paste("Parsing", readout))
  
  df <- read.table( paste0(location, csv.file), header=TRUE, na.strings="NA", dec=".", sep="," )
  # remove rows and columns containing only NA
  df <- df[colSums(!is.na(df)) > 0]

  filenameout <- paste0(file_path_sans_ext(csv.file))
  # plot original time courses
  plot_original_tc(df, filenameout, readout)    
  # synchronise time courses
  sync_tc_fun(df, location, filenameout, readout)
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
  sync_tc_main(location, paste0(filenames[i], suffix), yaxis.label[i])
}

