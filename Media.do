* Media * 

use data_diff.dta

drop in 1/531 // Those are the observations until 3.3.2013 where the media numbers are started to be observed 

* What data do we have about media? 
** Media ** 
corr diff1 mediarestot // negative (more media inserates lead to a smaller difference), interpretation = if the difference is small an increasing number of media inserates lowers differences 
corr diff5 mediarestot // pos (more media announcement has a positiv correlation with the difference of votes)
corr diff10 mediarestot // pos (more media announcement has a positiv correlation with the difference of votes)

corr diff1 mediatontot // pos 0.238
corr diff5 mediatontot // pos 0.1882
corr diff10 mediatontot // neg -0.2153


/*

corr mediarestot volkja // negative; if there are more media inserates the correlation displays a decrease of volkja 
corr mediarestot volkjaproz // negative correlation 

corr mediatontot volkja // if the media tonality is more towards yes there is a positive correlation (0,618)
corr mediatontot volkjaproz // positive correlation (0,767)
*/ 