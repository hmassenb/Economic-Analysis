* Project Econ Anal *
cd "C:\Users\Hannah\Documents\Econ anal"
import excel using Votes0.xlsx, sheet("DATA") firstrow clear

* Dropping variables we dont need for our project
drop d2e1 d2e2 d2e3 d3e1 d3e2 d3e3 gesch_nr curiavistade curiavistafr ///
 datmessage datparl  datforce dauer_bv urheber datpreexam datstart datlimit ///
 sammelfrist unterquorum datsubmit datsuccess idauer_samm idauer_br ///
 frdauer_samm  frdauer_tot unter_g  unter_u  info_brde info_brfr info_bren ///
 info_depde info_depfr info_depen info_amtde info_amtfr info_amten ///
 poster_ja_mfg poster_nein_mfg poster_ja_sa  poster_nein_sa  annahme  berecht ///
   ungultig  gultig   bkresultsde ///
 bkresultsfr bfsmapde bfsmapfr 

 *more variables we dont need are berecht, gultig, ja & nein (absolut)
drop zhberecht beberecht luberecht urberecht szberecht owberecht nwberecht ///
glberecht zgberecht frberecht soberecht bsberecht blberecht shberecht ///
arberecht aiberecht sgberecht grberecht agberecht tgberecht tiberecht ///
vdberecht vsberecht neberecht geberecht juberecht 

drop zhgultig begultig lugultig urgultig szgultig owgultig nwgultig glgultig ///
zggultig frgultig sogultig bsgultig blgultig shgultig argultig aigultig ///
sggultig grgultig aggultig tggultig tigultig vdgultig vsgultig negultig ///
gegultig jugultig

drop zhja beja luja urja szja owja nwja glja zgja frja soja bsja blja shja ///
arja aija sgja grja agja tgja tija vdja vsja neja geja juja

drop zhnein benein lunein urnein sznein ownein nwnein glnein zgnein frnein /// 
sonein bsnein blnein shnein arnein ainein sgnein grnein agnein tgnein tinein ///
vdnein vsnein nenein genein junein

drop titel_kurz_f titel_off_d titel_off_f stichwort kurzbetitel anneepolitique bkchronode bkchronofr dep legislatur

* pdev(party)_canton  describes if there is a deviation from the mother party, splitted into every canton and party (in case its later again relevant that we know what its about)
drop pdevbdp_NW pdevbdp_OW pdevcvp_NW pdevcvp_OW pdevfdp_NW pdevfdp_OW pdevglp_NW pdevglp_OW pdevgps_NW pdevgps_OW pdevmitte_NW pdevmitte_OW pdevjmitte_NW pdevjmitte_OW pdevsps_NW pdevsps_OW pdevsvp_NW pdevsvp_OW pdevcsp_OW pdevedu_NW pdevedu_OW pdevevp_NW pdevevp_OW pdevbdp_AG pdevbdp_AI pdevbdp_AR pdevbdp_BE pdevbdp_BL pdevbdp_BS pdevbdp_FR pdevbdp_GE pdevbdp_GL pdevbdp_GR pdevbdp_JU pdevbdp_LU pdevbdp_NE pdevbdp_SG pdevbdp_SH pdevbdp_SO pdevbdp_SZ pdevbdp_TG pdevbdp_TI pdevbdp_UR pdevbdp_VD pdevbdp_VS pdevbdp_VSr pdevbdp_VSo pdevbdp_ZG pdevbdp_ZH pdevjbdp_CH pdevcvp_frauen pdevcvp_AG pdevcvp_AI pdevcvp_AR pdevcvp_BE pdevcvp_BL pdevcvp_BS pdevcvp_FR pdevcvp_GE pdevcvp_GL pdevcvp_GR


drop pdevcvp_JU pdevcvp_LU pdevcvp_NE  pdevcvp_SG pdevcvp_SH pdevcvp_SO pdevcvp_SZ pdevcvp_TG pdevcvp_TI pdevcvp_UR pdevcvp_VD pdevcvp_VS pdevcvp_VSr pdevcvp_VSo pdevcvp_ZG pdevcvp_ZH pdevjcvp_CH pdevjcvp_AG pdevjcvp_BE pdevjcvp_GR pdevjcvp_LU pdevjcvp_SO pdevjcvp_ZH pdevfdp_Frauen pdevfdp_AG pdevfdp_AI pdevfdp_AR pdevfdp_BE pdevfdp_BL pdevfdp_BS pdevfdp_FR pdevfdp_GE pdevfdp_GL pdevfdp_GR pdevfdp_JU pdevfdp_LU pdevfdp_NE pdevfdp_SG pdevfdp_SH pdevfdp_SO pdevfdp_SZ pdevfdp_TG pdevfdp_TI pdevfdp_UR pdevfdp_VD pdevfdp_VS pdevfdp_VSr pdevfdp_Vso pdevfdp_ZG pdevfdp_ZH pdevjfdp_CH pdevjfdp_AG pdevjfdp_BL pdevjfdp_FR pdevjfdp_GR pdevjfdp_JU pdevjfdp_LU pdevjfdp_SH pdevjfdp_TI pdevjfdp_VD pdevjfdp_ZH pdevglp_AG pdevglp_AI pdevglp_AR pdevglp_BE pdevglp_BL pdevglp_BS pdevglp_FR pdevglp_GE pdevglp_GL pdevglp_GR pdevglp_JU pdevglp_LU pdevglp_NE pdevglp_SG pdevglp_SH pdevglp_SO pdevglp_SZ pdevglp_TG pdevglp_TI pdevglp_UR pdevglp_VD pdevglp_VS pdevglp_VSr pdevglp_VSo pdevglp_ZG  pdevglp_ZH pdevjglp_CH pdevgps_AG pdevgps_AI pdevgps_AR pdevgps_BE pdevgps_BL pdevgps_BS pdevgps_FR pdevgps_GE pdevgps_GL pdevgps_GR pdevgps_JU


drop pdevgps_LU pdevgps_NE  pdevgps_SG pdevgps_SH pdevgps_SO pdevgps_SZ pdevgps_TG pdevgps_TI pdevgps_UR pdevgps_VD pdevgps_VS pdevgps_VSr pdevgps_VSo pdevgps_ZG pdevgps_ZH pdevjgps_CH pdevmitte_frauen pdevmitte_AG pdevmitte_AI pdevmitte_AR pdevmitte_BE pdevmitte_BL pdevmitte_BS pdevmitte_FR pdevmitte_GE pdevmitte_GL pdevmitte_GR pdevmitte_JU pdevmitte_LU pdevmitte_NE pdevmitte_SG pdevmitte_SH pdevmitte_SO pdevmitte_SZ pdevmitte_TG pdevmitte_TI pdevmitte_UR pdevmitte_VD pdevmitte_VS pdevmitte_VSr pdevmitte_VSo pdevmitte_ZG pdevmitte_ZH pdevjmitte_CH pdevjmitte_AG pdevjmitte_AI pdevjmitte_AR pdevjmitte_BE pdevjmitte_BL pdevjmitte_BS pdevjmitte_FR pdevjmitte_GE pdevjmitte_GL pdevjmitte_GR pdevjmitte_JU pdevjmitte_LU pdevjmitte_NE  pdevjmitte_SG pdevjmitte_SH pdevjmitte_SO pdevjmitte_SZ pdevjmitte_TG pdevjmitte_TI pdevjmitte_UR pdevjmitte_VD pdevjmitte_VS pdevjmitte_VSr pdevjmitte_VSo pdevjmitte_ZG pdevjmitte_ZH pdevsps_AG pdevsps_AI pdevsps_AR pdevsps_BE pdevsps_BL pdevsps_BS pdevsps_FR pdevsps_GE pdevsps_GL pdevsps_GR pdevsps_JU pdevsps_LU pdevsps_NE pdevsps_SG pdevsps_SH pdevsps_SO pdevsps_SZ pdevsps_TG pdevsps_TI pdevsps_UR pdevsps_VD pdevsps_VS pdevsps_VSr pdevsps_VSo pdevsps_ZG pdevsps_ZH pdevjuso_CH


drop pdevjuso_BE pdevjuso_GE pdevjuso_JU pdevjuso_TI pdevjuso_VS pdevjuso_ZH pdevsvp_AG pdevsvp_AI pdevsvp_AR pdevsvp_BE pdevsvp_BL pdevsvp_BS pdevsvp_FR pdevsvp_GE pdevsvp_GL pdevsvp_GR pdevsvp_JU pdevsvp_LU pdevsvp_NE pdevsvp_SG pdevsvp_SH pdevsvp_SO pdevsvp_SZ pdevsvp_TG pdevsvp_TI pdevsvp_UR pdevsvp_VD pdevsvp_VS pdevsvp_VSr pdevsvp_VSo pdevsvp_ZG pdevsvp_ZH pdevjsvp_CH pdevjsvp_AG pdevjsvp_BE pdevjsvp_GE pdevjsvp_SH pdevjsvp_UR pdevjsvp_ZH pdevcsp_FR pdevcsp_GR pdevcsp_JU pdevcsp_LU  pdevcsp_SG pdevcsp_VS pdevcsp_VSr pdevcsp_VSo pdevcsp_ZH pdevedu_AG pdevedu_AI pdevedu_AR pdevedu_BE pdevedu_BL pdevedu_BS pdevedu_FR pdevedu_GE pdevedu_GL pdevedu_GR pdevedu_JU pdevedu_LU pdevedu_NE pdevedu_SG pdevedu_SH pdevedu_SO pdevedu_SZ pdevedu_TG pdevedu_TI pdevedu_UR pdevedu_VD pdevedu_VS pdevedu_VSr pdevedu_VSo pdevedu_ZG pdevedu_ZH pdevevp_AG pdevevp_AI pdevevp_AR pdevevp_BE pdevevp_BL pdevevp_BS pdevevp_FR pdevevp_GE pdevevp_GL pdevevp_GR pdevevp_JU pdevevp_LU pdevevp_NE

drop pdevevp_SG pdevevp_SH pdevevp_SO pdevevp_SZ pdevevp_TG pdevevp_TI pdevevp_UR pdevevp_VD pdevevp_VS pdevevp_ZG pdevevp_ZH pdevjevp_CH pdevfps_AG pdevfps_AI pdevfps_BE pdevfps_BL pdevfps_BS pdevfps_SG pdevfps_SH pdevfps_SO pdevfps_TG pdevfps_ZH pdevkvp_SG pdevlps_BE pdevlps_BL pdevlps_BS pdevlps_FR pdevlps_GE pdevlps_JU pdevlps_NE pdevlps_SG pdevlps_TI pdevlps_VD pdevlps_VS pdevlps_ZH pdevjlps_CH pdevjlps_SO pdevjlps_TI pdevldu_AG pdevldu_AR pdevldu_BE pdevldu_BL pdevldu_BS pdevldu_GR pdevldu_LU pdevldu_NE pdevldu_SG pdevldu_SH pdevldu_SO pdevldu_TG pdevldu_VD pdevldu_ZG pdevldu_ZH pdevjldu_CH pdevpoch_SO pdevpoch_ZH pdevpda_BE pdevpda_BL pdevpda_BS pdevpda_GE pdevpda_JU pdevpda_NE pdevpda_SG pdevpda_TI pdevpda_VD pdevpda_ZH pdevjpda_CH pdevrep_AG pdevrep_GE pdevrep_NE pdevrep_TG pdevrep_VD pdevrep_ZH pdevsd_AG pdevsd_BE pdevsd_BL pdevsd_BS pdevsd_FR pdevsd_GE pdevsd_GR pdevsd_LU pdevsd_NE pdevsd_SG pdevsd_SO pdevsd_TG pdevsd_TI pdevsd_VD pdevsd_ZH pdevjsd_CH pdevsgb_AG pdevsgb_JU pdevsgb_VS pdevsgv_AG pdevsgv_BS pdevsgv_SH pdevvpod_GE pdevvpod_VD

drop nach_cockpit_f nach_cockpit_e // Evaluation after voting 

destring mediarestot, replace //  amount of inserates total 
destring mediaresd, replace // amount of inserates in suisse allemanique
destring  mediaresd, replace // amount of inserates in suisse roamndie
destring mediatontot, replace // Tonality of inserates total
destring mediatond, replace // Tonality in suisse allemanique
destring mediatonf, replace //  Tonality in suisse romandie
destring stimmen, replace // total ammoung of votes
destring bet, replace // participation 
destring d1e2, replace // categories of voting topic
destring d1e2, replace
* Probably more variables need to be destring 
label values ktjaproz  cantons_that_voted_yes


* global variable for the participation in cantons 
global cantons_bet ///  * Cantonal data only available until 2020 
zhbet bebet lubet urbet szbet owbet nwbet glbet zgbet frbet sobet  bsbet blbet shbet arbet aibet sgbet grbet agbet tgbet tibet vdbet vsbet nebet gebet jubet
destring $cantons_bet, replace

* global variable for the yes share in cantons 
global cantons_yshare /// 
zhjaproz bejaproz lujaproz urjaproz szjaproz owjaproz nwjaproz gljaproz zgjaproz frjaproz sojaproz bsjaproz bljaproz shjaproz arjaproz sgjaproz grjaproz agjaproz tgjaproz vdjaproz vsjaproz nejaproz gejaproz jujaproz

destring $cantons_yshare, replace 

* making bet absolute 
gen volkneinproz = 100 - volkjaproz
gen diff = volkjaproz - volkneinproz
gen abs_diff=abs(diff)


*********
** Log **
*********

gen log_diff = log(abs_diff)
gen log_bet = log(bet)


* Saving new data set
save Votes1, replace

* abbrevation of all cantons in case i need it once more zh be lu ur sz ow nw gl zg fr so bs bl sh ar ai sg gr ag tg ti vd vs ne ge ju





