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



# analyse the lower and upper values of the time courses


# retrieve this script path 
args <- commandArgs(trailingOnly=FALSE)
SCRIPT_PATH <- dirname(sub("^--file=", "", args[grep("^--file=", args)]))
if(length(SCRIPT_PATH) > 0) {
  # we use this when Rscript is used from a different directory
  SCRIPT_PATH <- normalizePath(SCRIPT_PATH)
  source(file.path(SCRIPT_PATH, '../utilities/plots.R'))
} else {
  # we use this when Rscript is used from this directory
  source('../utilities/plots.R')
}



###########
# LOAD DATA 
###########

args <- commandArgs(trailingOnly=TRUE)
if(length(args) == 0) {
  location.data <- file.path('..', '..', 'data')
  location.results <- '.'
  location <- '../../data/'
  filenames <- c('atg13_int_mean_ctrl_sync', 'atg13_int_mean_wrtm_sync')
  # extract values
  # thresholds. [1] ctrl, [2] wrtm
  thres.hv <- c(2000,1200)
  thres.lv <- c(1000,1000)  
  for(i in 1:length(filenames)) {
    extract_min_max(location.data, location.results, filenames[i], thres.hv[i], thres.lv[i])
  }
} else {
  location.data <- dirname(normalizePath(args[1]))
  location.results <- SCRIPT_PATH  
  filename <- sub("^([^.]*).*", "\\1", basename(args[1]))
  thres.lv <- as.numeric(args[2])
  thres.hv <- as.numeric(args[3])
  extract_min_max(location.data, location.results, filename, thres.hv, thres.lv)
}
