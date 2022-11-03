* Data Prep 1 * 
* Creating further variables * 
* Majorz voting >=50%

clear all
cd "C:\Users\Hannah\Documents\Econ anal"
use "C:\Users\Hannah\Documents\Econ anal\data_diff.dta"

drop in 378/459 // dont knoy why yet but there exist additional obs where closegroup becomes 82
drop if anr == 388
*****************************************************************
**** Did one close call affected participation in the other *****
**** votes at the same day? *************************************
*****************************************************************

* Categorical variable which how many close calls there were at this vote

egen closegroup = total(diff10du > 0 ), by(date) 
tab closegroup

/*
gen check_var = 0
replace check_var = 1 if diff10du == 1
tab closegroup check_var
tab closegroup check_var if check_var == 0 
*/

***********************
*** Mini Regression ***
***********************
reg bet i.closegroup
reg bet closegroup if closegroup>=0  // b = 1,445, t=30.7
* Mini regression when population vote have been close

tab bet if diff10du==1 // controlling how many obs we have for the following [Obs = 43]

reg bet closegroup if diff10du == 1 // b=0,46, t=0,48 non signi 
* Results: if there have been a close population vote then the closeness of the outcome between cantons do not display a signifcant effect

* Some visualizations
graph box bet, over(closegroup) // mean increase and 50% lay even closer if more closegroups exist -> kinda obvious 

twoway kdensity bet if closegroup >= 1, ylabel(0 "0%" 0.02 "20%"  0.04 "40%" 0.06 "60%") xtitle("Participation share") ytitle("Density of participation share" ) title("Participation if close call at election day") // 

*Results = closegroup always significant and positive between[1.2;1.5] and dummy variable of how close the turnover was, was insignificant on the 10% level and more and more positive towards the 1% level. 



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




*******************
*** Regressions ***
*******************
reg bet closecanton 

eststo clear
foreach canton in $cantons_bet{
eststo: reg `canton' closecanton 
}

esttab _all using closecanton.tex, replace

* Transposing table so it is possible to look at all outcomes at once
mat list r(coefs)
mat rename r(coefs) Participation
mat list Participation
esttab matrix(Participation, transpose) using transposed_closecanton.tex, replace ///
	se mtitle noobs nocons ///
	posthead(Close call cantonal & &  \\hline ) 
* Result = positive impact if the cantons who votes yes were a close call [12-14] on the participation in voting on a cantonal level 

* Realised I forgot to check it how it would look like on a national level 
reg bet closecanton // similarly positive as the others but sign only 10%



* If there was a close call on cantonal level under the circumstance that also on the national level it was a close call, then coefficient almost doubles AND becomes significant on a 5% level
reg bet closecanton if diff10du == 1
reg bet closecanton if diff5du == 1 // Even larger but again only sign on 10% can be also traced back to the smaller sample 
reg bet closecanton if diff1du == 1 // Becomes 6 times larger but not even significant on the 10% level 


* Now looking how the cantonal participation was affected by the closeness of cantons
foreach canton in $cantons_bet{
	eststo: reg `canton' closecanton
}

esttab _all using closecanton.tex, replace

************
** Plots ***
************
twoway scatter bet abs_diff || lfit bet abs_diff

twoway histogram bet if closecanton == 1 ||  kdensity bet , ylabel(0 "0%" 0.02 "20%"  0.04 "40%" 0.06 "60%") xtitle("Participation share") ytitle("Density of participation share ") title("Distribution of votes if canton close call")

graph box bet, over(closecanton) // if the cantonal vote was close [12;14] then the participation is slightly higher
graph box bet if diff10du==1 , over(closecanton) // if it was on the national popu level close (10%) then the effect of cantons close is even higher

















