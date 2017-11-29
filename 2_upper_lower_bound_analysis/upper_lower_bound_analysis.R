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


library(ggplot2)

source('../utilities/plots.R')


# return the upper values of the oscillations (the peaks)
hv <- function(vec, thres=0.5, ini.tp=0) {
  vec <- vec[!is.na(vec) & as.numeric(names(vec))>=ini.tp & vec>thres]
  return(vec)
}

# return the lower values of the oscillations
lv <- function(vec, thres=0.5, ini.tp=0) {
  vec <- vec[!is.na(vec) & as.numeric(names(vec))>=ini.tp & vec<thres]
  return(vec)  
}



##########
# DATA SET
##########

suffix <- '.csv'
location <- '../data/'
filenames <- c('atg13_int_mean_ctrl_sync', 'atg13_int_mean_wrtm_sync')



####################
# Extract the delays
####################

# thresholds. [1] ctrl, [2] wrtm
thres.hv <- c(2000,1200)
thres.lv <- c(1000,1000)

for(i in 1:length(filenames)) {

  print(paste0('Processing ', location, filenames[i], suffix))
  
  # import the data
  data <- read.table( paste0(location, filenames[i], suffix), header=TRUE, na.strings="NA", dec=".", sep=",", row.names=1)

  # EXTRACT THE UPPER VALUES
  
  # extract the delays from the time courses
  data.plot.hv <- data.frame(time=numeric(0), val=numeric(0))
  for(j in 1:ncol(data)) {
   col.j <- data[,j]
   names(col.j) <- row.names(data)
   hv.j <- hv(col.j, thres=thres.hv[i])
   hv.tc.j <- as.numeric(names(hv.j))
   data.plot.hv <- rbind(data.plot.hv, data.frame(time=hv.tc.j, val=hv.j))
  }
  data.plot.hv <- cbind(data.plot.hv, pos=rep('top', nrow(data.plot.hv)))
  
  # plot
  g <- ggplot() + 
    geom_point(data=data.plot.hv, aes(x=time, y=val)) +  
    labs(title='Upper Values', x='Time [s]', y='Intensity [a.u.]') +
    theme_basic(base_size = 16)
  ggsave(paste0(filenames[i], '_upper_values.png'), width=4, height=3, dpi=300)
  write.table(data.plot.hv, file=paste0(filenames[i], '_upper_values', suffix), row.names=FALSE, quote=FALSE, sep=',')
  
  # density plot
  g <- ggplot(data.plot.hv, aes(x=val)) + 
    geom_density(colour = "black", fill = "#56B4E9", alpha=0.5) +
    labs(title='Density of upper values', x='signal intensity [a.u.]') +
    theme_basic(base_size = 16)
  ggsave(paste0(filenames[i], '_upper_values_density.png'), width=4, height=3, dpi=300)
  
  
  ## --------- ## 
  
  
  # EXTRACT THE LOWER VALUES
  
  # extract the delays from the time courses
  data.plot.lv <- data.frame(time=numeric(0), val=numeric(0))
  for(j in 1:ncol(data)) {
    col.j <- data[,j]
    names(col.j) <- row.names(data)
    lv.j <- lv(col.j, thres=thres.lv[i])
    lv.tc.j <- as.numeric(names(lv.j))
    data.plot.lv <- rbind(data.plot.lv, data.frame(time=lv.tc.j, val=lv.j))
  }
  data.plot.lv <- cbind(data.plot.lv, pos=rep('bottom', nrow(data.plot.lv)))
  
  # plot
  g <- ggplot() + 
    geom_point(data=data.plot.lv, aes(x=time, y=val)) +  
    labs(title='Lower values', x='Time [s]', y='Intensity [a.u.]') +
    theme_basic(base_size = 16)
  ggsave(paste0(filenames[i], '_lower_values.png'), width=4, height=3, dpi=300)
  write.table(data.plot.lv, file=paste0(filenames[i], '_lower_values', suffix), row.names=FALSE, quote=FALSE, sep=',')
  
  # density plot
  g <- ggplot(data.plot.lv, aes(x=val)) + 
    geom_density(colour = "black", fill = "#56B4E9", alpha=0.5) +
    labs(title='Density of lower values', x='signal intensity [a.u.]') +
    theme_basic(base_size = 16)
  ggsave(paste0(filenames[i], '_lower_values_density.png'), width=4, height=3, dpi=300)
  
  
  # write the peaks stats
  
  peaks.stats <- data.frame(type=c('top', 'bottom'), mean=c(mean(data.plot.hv$val), mean(data.plot.lv$val)), 
                            sd=c(sd(data.plot.hv$val), sd(data.plot.lv$val)))
  write.table(peaks.stats, file=paste0(filenames[i], '_peaks_stats', suffix), row.names=FALSE, col.names=TRUE, quote=FALSE, sep=',')

  
}


