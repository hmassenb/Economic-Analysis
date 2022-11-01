clear all
cd "C:\Users\Hannah\Documents\Econ anal"
do "C:\Users\Hannah\Documents\Econ anal\Data prep 0.do"
use "Votes1" // 223 Var, 680 Obs
drop in 1/55 // dropping data out which lacks information since to old (before 1900) -> now 625 Obs
drop in 1/248 // Until Jura is part 


* changing date
gen date = date(datum, "DMY")
format date %tdDD.mon.CCYY // why is %tdDD.MM.CCYY not working? it displays for the month 00 then??

**********************************************
**** Creating shares of yes and no voters ****
**********************************************
* standardizing volkjaproz into shares [0;1]
* gen popyesperc = volkjaproz / 100 // population that votes for yes transformed [0,1] so that we have shares

* Share of voters that vote no is not existent thus I create it 
* gen popnoperc = 1- popyesperc



********************
*** descriptives ***
********************
* about participation of voters
/*
sum popyesperc 
hist popyesperc // almost normal distributed
graph box popyesperc

sum popnoperc 
hist popnoperc 
graph box popnoperc


twoway scatter popyesperc date || lfit popyesperc date  // seems like increase of votes 

twoway bar anzahl date, title("Increase in Votes to do per election") xtitle("1900-2022") ytitle("Number of Votes per Election") ,tlabel(20may1900(122)25sep2022) xlabel(, angle(45) ) tlabel(20may1900(2300)25sep2022)


**** Creating a variable for differences in Outcome of Votes ****
*gen diff = popyesperc - popnoperc
* summarize diff

* Multiplying diff by 100 to obtain a value between [0;100]
*gen diffperc = diff * 100
* sum diffperc

*/ // everything canceled because diff is now in abs and immediately from volkjaproz instead of breaking it down to [0,1]

***************************
*** Creating close call ***
***************************
** Close call 10% = Outcome < 10% 
gen diff10 = abs_diff if abs_diff <= 10
replace diff10 = . if abs_diff > 10

* dummy for close call on 10% level 
gen diff10du = 1 if diff10 != .
replace diff10du = 0 if diff10 == .

/*
hist diff10, bin(10)
save diff10.jpg, replace
*/

** Close call 5% = Outcome < 5% 
gen diff5 = abs_diff if abs_diff <= 5
replace diff5 = . if abs_diff > 5

* dummy for close call on 5% level 
gen diff5du = 1 if diff5 != .
replace diff5du = 0 if diff5 == .

/*
hist diff5, bin(10)
save diff5.jpg, replace
*/

** Close call 1% =  Outcome < 1% 
gen diff1 = abs_diff if abs_diff <= 1
replace diff1 = . if abs_diff > 1

* dummy for close call on 1% level 
gen diff1du = 1 if diff1 != .
replace diff1du = 0 if diff1 == .


/*
hist diff1, bin(10)
save diff1.jpg, replace
*/

* Creating a variable to get a overview how many close calls there where
gen distri_off_diff = .
replace distri_off_diff = 4 if diff10du == 0 // all values of votings which were not close

replace distri_off_diff = 3 if diff10du == 1 // value 3 for votings which had a 10%  difference

replace distri_off_diff = 2 if diff5du == 1 // same as before but reducing the bandwitdh so the prior group doesnt get overlaid 

replace distri_off_diff = 1 if diff1du == 1

label define distri_off_difflab 4 "Not close" 3 "10% Gap" 2 "5% Gap" 1 "1% Gap"

label values distri_off_diff distri_off_difflab

* log using analy_desc.txt, replace text
tab distri_off_diff 
/* Results of distri_off_diff
     1% Gap |          9        1.44       
     5% Gap |         26        4.16       
    10% Gap |         21        3.36        
  Not close |        569 		91.04 
*/
* log close





********************************************
********************************************
** Doing descriptives but on canton level ** 
********************************************

* creating a variable for closeness at cantonlevel 
foreach canton in $cantons_yshare{
	gen noshare_`canton' = .
}

global noshare ///
noshare_zhjaproz noshare_bejaproz noshare_lujaproz noshare_urjaproz noshare_szjaproz noshare_owjaproz noshare_nwjaproz noshare_gljaproz noshare_zgjaproz noshare_frjaproz noshare_sojaproz noshare_bsjaproz noshare_bljaproz noshare_shjaproz noshare_arjaproz noshare_sgjaproz noshare_grjaproz noshare_agjaproz noshare_tgjaproz noshare_vdjaproz noshare_vsjaproz noshare_nejaproz noshare_gejaproz noshare_jujaproz

* replace $noshare = 100 - $cantons_yshare // This way didnt work out neither with loop nor so 

*foreach canton in $noshare{
*	replace `canton' = 100 - $cantons_yshare
*}
                 
 replace noshare_zhjaproz = 100 - zhjaproz
 replace noshare_bejaproz = 100 - bejaproz
 replace noshare_lujaproz = 100 -  lujaproz
 replace noshare_urjaproz = 100 - urjaproz
 replace noshare_szjaproz = 100 - szjaproz
 replace noshare_owjaproz = 100 - owjaproz
 replace noshare_nwjaproz = 100 - nwjaproz
 replace noshare_gljaproz = 100 - gljaproz
 replace noshare_zgjaproz = 100 - zgjaproz
 replace noshare_frjaproz = 100 - frjaproz
 replace noshare_sojaproz = 100 - sojaproz
 replace noshare_bsjaproz = 100 - bsjaproz
 replace noshare_bljaproz = 100 - bljaproz
 replace noshare_shjaproz = 100 - shjaproz
 replace noshare_arjaproz = 100 - arjaproz
 replace noshare_sgjaproz = 100 - sgjaproz
 replace noshare_grjaproz = 100 - grjaproz
 replace noshare_agjaproz = 100 - agjaproz
 replace noshare_tgjaproz = 100 - tgjaproz
 replace noshare_vdjaproz = 100 - vdjaproz
 replace noshare_vsjaproz = 100 - vsjaproz
 replace noshare_nejaproz = 100 - nejaproz
 replace noshare_gejaproz = 100 - gejaproz
 replace noshare_jujaproz = 100 - jujaproz

global noshare ///
noshare_zhjaproz noshare_bejaproz noshare_lujaproz noshare_urjaproz noshare_szjaproz noshare_owjaproz noshare_nwjaproz noshare_gljaproz noshare_zgjaproz noshare_frjaproz noshare_sojaproz noshare_bsjaproz noshare_bljaproz noshare_shjaproz noshare_arjaproz noshare_sgjaproz noshare_grjaproz noshare_agjaproz noshare_tgjaproz noshare_vdjaproz noshare_vsjaproz noshare_nejaproz noshare_gejaproz noshare_jujaproz

global cantons_vote ///
$noshare $cantons_yshare

* differences 
foreach canton in $noshare{
gen diff_`canton'= .

}

 replace diff_noshare_zhjaproz = noshare_zhjaproz  - zhjaproz
 replace diff_noshare_bejaproz = noshare_bejaproz - bejaproz
 replace diff_noshare_lujaproz = noshare_lujaproz -  lujaproz
 replace diff_noshare_urjaproz = noshare_urjaproz - urjaproz
 replace diff_noshare_szjaproz = noshare_szjaproz - szjaproz
 replace diff_noshare_owjaproz = noshare_owjaproz - owjaproz
 replace diff_noshare_nwjaproz = noshare_nwjaproz  - nwjaproz
 replace diff_noshare_gljaproz = noshare_gljaproz  - gljaproz
 replace diff_noshare_zgjaproz = noshare_zgjaproz  - zgjaproz
 replace diff_noshare_frjaproz = noshare_frjaproz  - frjaproz
 replace diff_noshare_sojaproz = noshare_sojaproz - sojaproz
 replace diff_noshare_bsjaproz = noshare_bsjaproz  - bsjaproz
 replace diff_noshare_bljaproz = noshare_bljaproz  - bljaproz
 replace diff_noshare_shjaproz = noshare_shjaproz  - shjaproz
 replace diff_noshare_arjaproz = noshare_arjaproz  - arjaproz
 replace diff_noshare_sgjaproz = noshare_sgjaproz - sgjaproz
 replace diff_noshare_grjaproz = noshare_grjaproz  - grjaproz
 replace diff_noshare_agjaproz = noshare_agjaproz  - agjaproz
 replace diff_noshare_tgjaproz = noshare_tgjaproz - tgjaproz
 replace diff_noshare_vdjaproz = noshare_vdjaproz  - vdjaproz
 replace diff_noshare_vsjaproz = noshare_vsjaproz  - vsjaproz
 replace diff_noshare_nejaproz = noshare_nejaproz  - nejaproz
 replace diff_noshare_gejaproz = noshare_gejaproz  - gejaproz
 replace diff_noshare_jujaproz = noshare_jujaproz  - jujaproz

global diff_canton ///
diff_noshare_zhjaproz diff_noshare_bejaproz diff_noshare_lujaproz diff_noshare_urjaproz diff_noshare_szjaproz diff_noshare_owjaproz diff_noshare_nwjaproz diff_noshare_gljaproz diff_noshare_zgjaproz diff_noshare_frjaproz diff_noshare_sojaproz diff_noshare_bsjaproz diff_noshare_bljaproz diff_noshare_shjaproz diff_noshare_arjaproz diff_noshare_sgjaproz diff_noshare_grjaproz diff_noshare_agjaproz diff_noshare_tgjaproz diff_noshare_vdjaproz diff_noshare_vsjaproz diff_noshare_nejaproz diff_noshare_gejaproz diff_noshare_jujaproz

foreach canton in $diff_canton{
 gen abs_diff_`canton' = abs(`canton')	
}


***************************
*** Creating close call *** MUST BE ADAPTED TO THE CANTONAL LEVEL
***************************

** Close call 10% = -5% < Outcome < 5%
foreach canton in $diff_canton{
gen diff10_`canton' = `canton'  
replace diff10_`canton'  = . if `canton' >= 5
replace diff10_`canton' = . if `canton' <= -5 
}


* dummy for close call on 10% level 
foreach canton in $diff_canton{
gen diff10du_`canton' = 1 if diff10_`canton' != .
replace diff10du_`canton' = 0 if diff10_`canton' == .
}


** Close call 5% = -2.5% < Outcome < 2.5% 
foreach canton in $diff_canton{
gen diff5_`canton' = `canton'  
replace diff5_`canton'  = . if `canton' >= 2.5
replace diff5_`canton' = . if `canton' <= -2.5 
}


* dummy for close call on 10% level 
foreach canton in $diff_canton{
gen diff5du_`canton' = 1 if diff5_`canton' != .
replace diff5du_`canton' = 0 if diff5_`canton' == .
}


** Close call 1% = -0.5% < Outcome < 0.5% 
foreach canton in $diff_canton{
gen diff1_`canton' = `canton'  
replace diff1_`canton'  = . if `canton' >= 0.5
replace diff1_`canton' = . if `canton' <= -0.5 
}

* dummy for close call on 10% level 
foreach canton in $diff_canton{
gen diff1du_`canton' = 1 if diff1_`canton' != .
replace diff1du_`canton' = 0 if diff1_`canton' == .
}

twoway scatter  bet date


* Descriptive how many close calls there are
* National
outreg2 using descriptives_diff.doc, replace sum(log) keep(diff10 diff5 diff1) eqkeep(N mean) 

* Cantonal 
outreg2 using des_canton_diff.doc, replace sum(log) keep($diff10_canton $diff5_canton $diff1_canton) eqkeep(N mean) 



save data_diff, replace

