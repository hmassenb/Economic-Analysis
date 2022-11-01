* Data Prep 1 * 
* Creating further variables * 
* Majorz voting >=50%

clear all
cd "C:\Users\Hannah\Documents\Econ anal"
use "C:\Users\Hannah\Documents\Econ anal\data_diff.dta"

*****************************************************************
**** Did one close call affected participation in the other *****
**** votes at the same day? *************************************
*****************************************************************

* Categorical variable which how many close calls there were at this vote

egen closegroup = total(diff10du > 0 ), by(date) 
tab closegroup

gen check_var = 0
replace check_var = 1 if diff10du == 1
tab closegroup check_var
tab closegroup check_var if check_var == 0 

* Mini Regression
reg bet i.closegroup

* Some visualizations
twoway scatter bet closegroup if closegroup == 1 ||  scatter bet closegroup if closegroup == 2 ||  scatter bet closegroup if closegroup == 3 ||  scatter bet closegroup if closegroup == 4


twoway kdensity bet if closegroup >= 1, ylabel(0 "0%" 0.02 "20%"  0.04 "40%" 0.06 "60%") xtitle("Participation share") ytitle("Density of participation share" ) title("Participation if close call at election day") // 


reg bet closegroup diff10du
reg bet closegroup diff5du
reg bet closegroup diff1du

*Results = closegroup always significant and positive between[1.2;1.5] and dummy variable of how close the turnover was, was insignificant on the 10% level and more and more positive towards the 1% level. 

*controlling reg results without the outlier of 1992 
drop if anr == 388 

reg bet closegroup diff10du
reg bet closegroup diff5du
reg bet closegroup diff1du

* Now diff variable not significant anymore but the sign of the coefficent of the dummy variable exhibit same behaviour towards from slightly negative towards more and more positive. In fact, it displays a stronger effect than the closegroup, BUT closegroup ist NOT significant. 


* Result = Yes there have been an effect of having an closecall on a voting day


*****************************************************************
* If the outcome was close between cantons (12-16 canton yes) ***
*****************************************************************
* variable if referendum was accepted or not `canton'annahme
global canton_accepted ///
zhannahme beannahme luannahme urannahme szannahme owannahme nwannahme  ///
glannahme zgannahme frannahme soannahme bsannahme blannahme shannahme  ///
vdannahme vsannahme neannahme geannahme juannahme
 
destring $global_accepted, replace

egen cantons_yes = rowtotal($canton_accepted)

* Creating subsample variable where [12,14] said yes
gen closecanton = 0 
replace closecanton = 1 if cantons_yes >= 12
replace closecanton = 0 if cantons_yes > 14

* There are 31 cases where the cantons were close 




















