* RENATE project - do file June 2020 *

drop project_name location
encode sex, generate(sex_)
drop age_unit
drop sex
rename sex_ sex
tab sex

encode tumour_location, gen(tumourlocation)
drop tumour_location

encode colon_rectum, gen(colonrectum)
drop colon_rectum

gen anatomlocal= colonrectum
replace anatom=0 if rightleft==2
label define anatom 0 "right" 1 "left" 2 "rectum"
label values anatom anatom 
tab anatom, 
tab anatom, nolabel
tab anatom colonrectum

encode tumour_preop, gen(tumourpreop)
drop tumour_preop

encode liver_preop, gen(liverpreop)
drop liver_preop

encode result_preop, gen(resultpreop)
drop resultpreop

encode lung_preop, gen(lungpreop)
drop lung_preop

encode result_preop, gen(resultpreop)
drop result_preop

encode treatment_preop, gen(treatmentpreop)
drop treatment_preop

encode type_of_treatment_preop, gen(typeoftreatmentpreop)
drop type_of_treatment_preop

encode right_left_location, gen(rightleft_location)
drop right_left_location

encode radical_surgery, gen(radicalsurgery)
drop radical_surgery

encode type_surgery, gen(typesurgery)
drop type_surgery

encode radical_micro, gen(radicalmicro)
drop radical_micro

encode differentiation_grade, gen(differentiationgrade)
drop differentiation_grade
replace differentiationgrade=0 if differentiationgrade==2
replace differentiationgrade=2 if differentiationgrade==1
replace differentiationgrade=1 if differentiationgrade==3
label define differentiationgrade 2 "high" 0 "low" 1 "medium", replace
tab differentiationgrade


encode type_mucinous, gen(typemucinous)
drop type_mucinous

encode stage_tnm, gen (stagetnm)
drop stage_tnm

encode m, gen(m_)
drop m
rename m_ m

encode type_tumour_deposit, gen(typetumourdeposit)
drop type_tumour_deposit

encode death_30_days, gen(death30days)
drop death_30_days

encode adjuvant_treat_planned, gen (adjuvanttreat_planned)
drop adjuvant_treat_planned

encode recurrence_crc, gen(recurrencecrc)
drop recurrence_crc

encode death_crc, gen(deathcrc)
drop death_crc

encode death, gen(died)
drop death

encode preop_result_liver, gen(preopresultsliver)
drop preop_result_liver

encode preop_result_lung, gen(preopresultlung)
encode m_other , gen(m_other_)
encode m_liver , gen(m_liver_)
encode m_lung , gen(m_lung_)
encode adjuvant_treat_cytostatics, gen(adjtreatcytostatics)
encode adjuvant_treat_antibiodies , gen(adjtreatantibodies)
encode adjuvant_treat_radiation , gen(adjtreatradiation)
encode adjuvant_treat_liver_resection , gen(adjtreatliverresection)
encode recurrance_local , gen(recurrencelocal)
encode recurrance_liver , gen(recurrenceliver)
encode recurrance_lung , gen(recurrencelung)
encode short_survival, gen(shortsurvival)
encode adjuvant_treat_sento, gen(adjtreatsento)
encode recurrence_localization, gen(recurrencelocalisation)

drop preop_result_lung m_other m_liver m_lung adjuvant_treat_cytostatics adjuvant_treat_antibiodies 
drop adjuvant_treat_radiation adjuvant_treat_liver_resection recurrance_local 
drop recurrance_liver recurrance_lung  short_survival 
drop adjuvant_treat_sento
drop recurrence_localization






gen agecat=age
replace agecat = 1 if age<65
replace agecat = 2 if agecat!=1 & age<75
replace agecat = 3 if age>74
tab age agecat, missing
tab agecat, missing
label define Agecat 1 "<65 years" 2 "65-74 years" 3 ">=75 years"
label values agecat Agecat


gen agecat2=age
replace agecat2 = 0 if age<60
replace agecat2 = 1 if age<69 & age>=60 & agecat2!=0
replace agecat2 = 2 if agecat2!=1 & agecat2!=0 & age<76
replace agecat2 = 3 if agecat2>75
tab age agecat2, missing
tab agecat, missing
label define Agecat2 0 "<60 years" 1 "60-69" 2 "70-75 years" 3 ">=75 years", replace
label values agecat2 Agecat2

tab agecat agecat2, missing



tab sex, missing
label define Gender 0 "female" 1 "male" 
label values gender Gender


tab surgery_date, missing
gen yearofsurgery=surgery_date
split yearofsurgery, parse(-) gen(year)
drop year2 year3
rename year1 surgery_year
drop yearofsurgery
drop surgery_year
rename surgeryyear yearsurgery
drop surgery_year

gen periodsurgery=yearsurgery
replace periodsurgery= 0 
replace periodsurgery= 1 if yearsurgery<2006
replace periodsurgery=2 if yearsurgery<2011 & periodsurgery!=1
replace periodsurgery=3 if yearsurgery<2018 & periodsurgery!=1 & periodsurgery!=2
tab yearsurgery periodsurgery , missing
label define periodsurgery 1 "1997-2005" 2 "2006-2010" 3 "2010-2017"
label values periodsurgery periodsurgery
drop yearofsurgery year1 yearsurgery

tab tumour
tab stage

tab survival_years, missing
gen survival_group=survival_years
replace survival_group=1 if survival_group<=3
replace survival_group=2 if survival_group>3
* note: only individuals in cohort with survival <2 y (up to 1.99) and >=6 years
tab survival_years survival_group , missing
rename survival_group survivalcategory
replace survivalcat=0 if survivalcat==2 
label define survivalcat 1 "<2 years" 0 ">=5 years", replace
label values survivalcat survivalcat
tab survivalcat, missing

tab colonvsrectum colonrectum
* 0=colon, 1= rectum (colonrectum 0nly 0 value)
tab tumourlocal rightvsleft , missing col
tab colonvsrectum rightvsleft, missing col
label define rightvsleft 0 "right" 1 "left"
label values rightvsleft rightvsleft
* no point of looking into the 10 more specific codes "tumourlocation" *

tab liversurgery, missing
* only 3 cases reported - so not useful

tab asa, missing
gen asacat=asa
recode asacat 4=3
recode asacat 0=1
label define asa 1 " healthy" 2 "mild systemic" 3 "severe systemic and worse"
label values asacat asa
tab asa asacat, missing

tab deathwithin30d
* 5 died within 30 days

tab heredity
* only 1 with family history

tab nposnodes
* 0 to 38
gen nposnodescat=nposnodes
label define nposnodes 0 "none" 1 "one or two" 2 "3 or more", replace
replace nposnodescat=1 if nposnodes==2
replace nposnodescat= 2 if nposnodes>=3
label values nposnodescat nposnodes
tab nposnodes nposnodescat

tab gradeofdifferentiation, missing
* 1 missing, 12 grade 1, 1 grade 1+2 (considered 2), 73 grade 2, 30 grade 3

tab cea, missing
* 35 missing
destring cea, generate(cea_cat) ignore(`"<"')
replace cea_cat=999 if cea_cat==.
replace cea_cat=0 if cea_cat==5 
replace cea_cat=1 if cea_cat>5 & cea_cat!=999
label define ceacat 0 "<=5" 1 ">5" 999 "missing", replace
label values cea_cat ceacat
tab cea cea_cat , missing

tab m, missing
destring m, generate(m_cat) ignore(`"+"')
label define m_cat 0 " no metastasis" 1 "metastasis", replace
label values m_cat m_cat
replace m_cat=1 if m_cat>1
tab m_cat, missing

tab n, missing
destring n, generate(n_cat) ignore(`"c"')
label define m_cat 0 " no lymphnodes" 1 "lymphnodes", replace
label values n_cat n_cat
replace n_cat=1 if n_cat>1
tab n_cat nposnodescat, missing
* N does not entirely correspond with variable nposlymphnodes!

drop animation
* all 1


order host_sub surgery_date yearsurgery periodsurgery survivalcat age agecat sex asacat asa



* Table 1

tab agecat survivalcat , missing  col
tab agecat2 survivalcat, missing col
tab sex survivalcat , missing  col
tab asacat survivalcat, missing col
tab periodsurgery survivalcat, missing col
tab colonrectum survivalcat, missing col
tab rightleft_location survivalcat, missing col
tab rightleft_loc colonrectum
tab anatom survivalcat, missing col
tab typemucinous survivalcat, missing col
tab stagetnm survivalcat, missing col
tab differentiationgrade survivalcat, missing col
tab radicalsurgery survivalcat, missing col
tab radicalmicro survivalcat, missing col
tab typeoftreatmentpreop survivalcat, missing col
tab treatmentpreop survivalcat, missing col



* Table 2 - predictors for survival * 
xi: logit survivalcat i.agecat2, or
xi: logit survivalcat i.sex, or
xi: logit survivalcat i.asacat, or
xi: logit survivalcat i.radicalsurgery, or
* SHOULD BE KEPT SINCE P<0.10
xi: logit survivalcat i.periodsurgery, or
xi: logit survivalcat i.anatom, or
xi: logit survivalcat i.typemucinous, or
xi: logit survivalcat i.stagetnm, or
* SHOULD BE KEPT SINCE P<0.10
xi: logit survivalcat i.differentiationgrade, or
* SHOULD BE KEPT SINCE P<0.10
xi: logit survivalcat i.treatmentpreop, or

* ADJUSTED FOR ALL ABOVE:
xi: logit survivalcat i.agecat2 sex i.asacat i.radicalsurge i.periodsurg i.anato i.typemu i.stagetnm i.diff i.treatmentpreop, or

xi: logit survivalcat i.agecat2 sex i.asacat i.radicalsurge i.periodsurg i.anato i.stagetnm i.diff, or
