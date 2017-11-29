
# ATG13 mitophagy data analysis


### Summary
Data analysis for generic autophagy events targetting ATG13 as readout with and without Wortmanning drug. These data were quantified by Vana and analysed by me (Piero).


### Pipeline structure

- data/: data sets for data analysis.

- utilities/: R files containing common functions.

- 1_synchronise_by_maxval/: synchronise the time courses by maximum value. 

- 2_upper_lower_bound_analysis/: extract the upper and lower values.

- 3_time_courses_data_for_copasi/: generate the data sets for parameter estimation using Copasi.


### Other folders

- raw_data/: data files generated by Vana using Imaris.

