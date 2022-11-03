********************
** Fixed effect ***
*******************
clear all
cd "C:\Users\Hannah\Documents\Econ anal"
use "C:\Users\Hannah\Documents\Econ anal\Dataprep1_2.dta"
twoway scatter  bet date || lfit bet date, title(Participation over time ) // indicates upward trend over time and indicates use of time FE makes sense!!!


reghdfe




xtset date anr 
xtreg