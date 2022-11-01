# Economic-Analysis
Codes for the course economic analysis WS 2022/2023

First I started with the "Data prep 0" file In this I cleaned the data from all unnecessary variables Saved the resulting data as Votes 1

Second "Set formating and descriptive stuff 0 " Here I manipulated the data properly and created yes/ no shares on the national and cantonal level. Also created the variable of the difference between yes and no votes to capture if the outcome was close or not. On the cantonal level I used a loop to create for every canton a no share variable Log file: analy_desc Saved the resulting data as data_diff

Third "Correlations" Here I computed some correlations between the participation and whether it was a close call or not (plus intensity of closeness) Log file: corr

Forth, the "Data prep 1" contains codes regarding different measurements of closeness.
Thereby, I consider what happens if there was a close call at a voting date and how does this one (or more) close call affects the participation in voting for the other referendums of that day. Moreover, to look if the cantonal behaviour is influenced by a close call in terms of number of cantons who votes yes or no I created a variable which indicates whether the outcome of the vote was close in terms of number of cantons, which were in favor or against the referendum. The latter variable gets then regressed onto variable participation (bet) to observe if the closeness of cantons affected the participation on the national level but also on the cantonal level. To control a further channel, I implied the assumption that the national population vote was close and how the closeness of cantons affects then the participation. 
