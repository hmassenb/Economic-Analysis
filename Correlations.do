clear all 
cd "C:\Users\Hannah\Documents\Econ anal\"
use data_diff.dta // Years: 1978 - 2022 625x241

* creating variable that calculates the participation if the difference was small in the outcome - participation if it was not close >1% , 5% & 10%

*log using corr.txt, replace text
destring $cantons_bet, replace
destring bet, replace

global diff1_canton ///
 diff1_diff_noshare_zhjaproz diff1_diff_noshare_bejaproz diff1_diff_noshare_lujaproz diff1_diff_noshare_urjaproz diff1_diff_noshare_szjaproz diff1_diff_noshare_owjaproz diff1_diff_noshare_nwjaproz diff1_diff_noshare_gljaproz diff1_diff_noshare_zgjaproz diff1_diff_noshare_frjaproz diff1_diff_noshare_sojaproz diff1_diff_noshare_bsjaproz diff1_diff_noshare_bljaproz diff1_diff_noshare_shjaproz diff1_diff_noshare_arjaproz diff1_diff_noshare_sgjaproz diff1_diff_noshare_grjaproz diff1_diff_noshare_agjaproz diff1_diff_noshare_tgjaproz diff1_diff_noshare_vdjaproz diff1_diff_noshare_vsjaproz diff1_diff_noshare_nejaproz diff1_diff_noshare_gejaproz diff1_diff_noshare_jujaproz


global diff10_canton ///
 diff10_diff_noshare_zhjaproz diff10_diff_noshare_bejaproz diff10_diff_noshare_lujaproz diff10_diff_noshare_urjaproz diff10_diff_noshare_szjaproz diff10_diff_noshare_owjaproz diff10_diff_noshare_nwjaproz diff10_diff_noshare_gljaproz diff10_diff_noshare_zgjaproz diff10_diff_noshare_frjaproz diff10_diff_noshare_sojaproz diff10_diff_noshare_bsjaproz diff10_diff_noshare_bljaproz diff10_diff_noshare_shjaproz diff10_diff_noshare_arjaproz diff10_diff_noshare_sgjaproz diff10_diff_noshare_grjaproz diff10_diff_noshare_agjaproz diff10_diff_noshare_tgjaproz diff10_diff_noshare_vdjaproz diff10_diff_noshare_vsjaproz diff10_diff_noshare_nejaproz diff10_diff_noshare_gejaproz diff10_diff_noshare_jujaproz
 
********************
*** Correlations ***
********************
corr  bet diff10 // neg correlation 
corr diff10 $cantons_bet // in all cantons negative correlation 

corr  bet diff5 // neg correlation 
corr diff5 $cantons_bet // in all cantons neg correlation 

corr  bet diff1 // pos correlation -> if its closer the participation increases
corr diff1 $cantons_bet // in all countries pos correlation 

destring bet, replace 
destring d1e2, replace
destring d1e3, replace // wrote it again because it was string again even though in dataprep0 I already wrote it

corr d1e1 bet
corr d1e2 bet
corr d1e3 bet // all three have a negatice correlation 

corr abs_diff bet

*************
*** Plots ***
*************
twoway scatter bet diff || lfit bet diff
twoway scatter diff bet || lfit diff bet, mlabel(diff1 diff5 diff10)
twoway scatter diff10 bet || lfit diff10 bet
twoway scatter diff5 bet || lfit diff5 bet
twoway scatter diff1 bet || lfit diff1 bet

twoway scatter diff10 bet || lfit diff10 bet
twoway scatter diff5 bet || lfit diff5 bet
twoway scatter diff1 bet || lfit diff1 bet


twoway scatter diff10du bet if diff10du == 1 || lfit diff10du bet 
twoway scatter diff5du bet if diff5du == 1  || lfit diff5du bet
twoway scatter diff1du bet if diff1du == 1  || lfit diff1du bet

twoway scatter diff1du bet , xtitle("Participation share") ytitle("Difference ")

twoway scatter bet abs_diff  || lfit bet abs_diff, xtitle("Participation share") ytitle("Difference in Voting") legend()

twoway bar bet diff 
twoway bar bet diff, barw(0.00001)  

twoway hist bet , bin(10)

* diff is in percent [0,1]
twoway bar bet abs_diff, barw(1)


***********
* Kernel *
***********
log using densityvotes.txt, replace text
twoway kdensity bet, ylabel(0 "0%" 0.02 "20%"  0.04 "40%" 0.06 "60%") xtitle("Participation share") ytitle("Density of participation share ") title("Distribution of votes")
log close 

log using densityvotes1.txt, replace text
twoway kdensity bet if diff1du, ylabel(0 "0%" 0.02 "20%"  0.04 "40%" 0.06 "60%") xtitle("Participation share") ytitle("Density of participation share ") title("Distribution of votes if close call 1%")

twoway kdensity bet if diff5du, ylabel(0 "0%" 0.02 "20%"  0.04 "40%" 0.06 "60%") xtitle("Participation share") ytitle("Density of participation share ") title("Distribution of votes if close call 5%")

twoway kdensity bet if diff10du, ylabel(0 "0%" 0.02 "20%"  0.04 "40%" 0.06 "60%") xtitle("Participation share") ytitle("Density of participation share ") title("Distribution of votes if close call 10%")

log close 

** -> in the whole sample and 10% difference participation around 40% just on the 5% and 1% difference sample the distribution shifts towards 50%

* read in manual that the kernel is oversmoothed especially when a multi model distribution exist, thus trying it out with gaussian distribution

twoway kdensity bet if diff1du, ylabel(0 "0%" 0.02 "20%"  0.04 "40%" 0.06 "60%") xtitle("Participation share") ytitle("Density of participation share ") title("Distribution of votes if close call 1%") gaussian // pretty similar

 twoway histogram bet || kdensity bet
 
 twoway histogram bet if diff10du == 1|| kdensity bet, ylabel(0 "0%" 0.02 "20%"  0.04 "40%" 0.06 "60%") xtitle("Participation share") ytitle("Density of participation share ") title("Distribution of votes if close call 10%")
 
 twoway histogram bet if diff5du == 1 || kdensity bet , ylabel(0 "0%" 0.02 "20%"  0.04 "40%" 0.06 "60%") xtitle("Participation share") ytitle("Density of participation share ") title("Distribution of votes if close call 5%")
 
 twoway histogram bet if diff1du == 1 || kdensity bet , ylabel(0 "0%" 0.02 "20%"  0.04 "40%" 0.06 "60%") xtitle("Participation share") ytitle("Density of participation share ") title("Distribution of votes if close call 1%")
 
* Plot for whole sample 
* twoway histogram bet,  width(1)|| kdensity bet
 twoway histogram bet,  width(2.5)|| kdensity bet , ylabel(0 "0%" 0.02 "20%"  0.04 "40%" 0.06 "60%") xtitle("Participation share") ytitle("Density of participation share ") title("Distribution of votes")
*twoway histogram bet,  width(5)|| kdensity bet

* Plots for subsample where close call = 1%
 * twoway histogram bet if diff1du == 1, width(1)|| kdensity bet
 twoway histogram bet if diff1du == 1, width(2.5)|| kdensity bet if diff1du==1
 *twoway histogram bet if diff1du == 1, width(5)|| kdensity bet
 
 
********************************  
** Scatterplot for subgroups **
******************************** 
scatter bet diff10 if diff10du==1 || scatter bet diff5 if diff5du==1 || scatter bet diff1 if diff1du == 1, ///
legend(order(1 "10%" 2 "5%" 3 "1%")) xlabel(0 "0%" 1 "1%"  2 "2%" 3 "3%" 4 "4%" 5 "5%" 6 "6%" 7 "7%" 8 "8%" 9 "9%" 10 "10%") ytitle("Participation") xtitle("Difference in Voting outcome")

* Scatterplot for subgroups vs whole sample
scatter bet abs_diff || scatter bet diff10 if diff10du==1 || scatter bet diff5 if diff5du==1 || scatter bet diff1 if diff1du == 1 || lfit bet abs_diff,  ///
xlabel(0 "0%" 20 "20%" 40 "40%" 60 "60%" 80 "80%") ///
ylabel(30 "30%" 40 "40%" 50 "50%" 60 "60%" 70 "70%" 80 "80%" ) ///
ytitle("Participation") xtitle("Difference in Voting outcome") ///
legend(label(1 "All") label(2 "10% Gap") label(3 "5% Gap") label(4 "1% Gap"))

********************
*** Regressions  ***
********************
eststo: reg bet abs_diff
eststo: reg bet diff10 
eststo: reg bet diff5
eststo: reg bet diff1
esttab using all_reg_simple.tex, replace

/*
foreach canton in $cantons_bet{
	reg `canton' diff1_`canton'
}
*/
* This doesnt work as diff1_`canton' has partially no data

**************!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!**********
** Need some work on those regressions since the table doesnt deliever a nice result !!!**

foreach canton in $cantons_bet{
eststo: reg `canton' diff10
}

esttab using canton_bet_diff.tex, replace ///
beta


/*
* Dummies require probit
probit  diff1du  bet
probit  diff5du bet
probit  diff10du bet 
* -> nothing interesting 
*/

* i. to splitter variable up to obtain heterogenous effects

eststo clear
eststo: reg bet diff diff10du i.d1e1
esttab  using reg_bet_topic.tex, replace ///
	cells(b(star fmt(3)) se(par fmt(3))) star(* 0.1 ** 0.05 *** 0.01) ///
	nolines  ///
	collabels(none) ///
	stats(N r2, fmt(%9.0fc %9.3f) ///
	labels("N Households" "R$^{2}$")) ///
	posthead(Diff and Topic  \\ \hline ) 
	
	
* -> topic two has the strongest impact
eststo clear
eststo: reg bet diff diff10du i.anzahl 
esttab  using reg_bet_anzahl.tex, replace ///
	cells(b(star fmt(3)) se(par fmt(3))) star(* 0.1 ** 0.05 *** 0.01) ///
	nolines  ///
	collabels(none) ///
	stats(N r2, fmt(%9.0fc %9.3f) ///
	labels("N Households" "R$^{2}$")) ///
	posthead(Diff and Amount  \\ \hline ) 
* if there are more referendums people are more likely to participate


/*
twoway scatter $diff1_canton bet
twoway bar $diff1_canton bet

foreach canton in $cantons_bet{
	reg diff1 `canton'
}

/*
eststo $cantons_bet
esttab zhbet bebet lubet urbet szbet owbet nwbet glbet zgbet frbet sobet  bsbet blbet shbet arbet aibet sgbet grbet agbet tgbet tibet vdbet vsbet nebet gebet jubet
*/


twoway scatter diff1 $cantons_bet if diff1 == 1

reg diff1 $cantons_bet if diff1 == 1



 reg diff1 zhbet

 reg diff5 $cantons_bet
 
 xtset anr 
xtreg bet diff
 
* log close
