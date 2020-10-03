
*** Code to accompany "Institutional pluralism and water user behaviour in rural Africa".
*** Includes code for the regression models, the marginal effects calculations and plots. 
*** The required files that accompany the code are also included here.


***Model 1 - individual household level intent to contract (sign up)

*** Read in the file on household level data

drop if functionality_status==3

*** logistic regression for 'want to sign-up' for the entrepreneurial model for those who have not signed up in the first year of the service. 
*** In order to account for higher variation between households of different waterpoints than within the waterpoint user group, standard errors were clustered at user group level (190 clusters) in Model 1.

logistic want_sign_up_survey ///
i.management_final club rules_made_majority_decision women_on_committee exclusion_not_observing_rules penalties_no_pay ///
regular_pay_either spare_parts_stored ///
poorest_quintile_8var subjective_poor final_wtp_mean water_concern_costly think_vulnerable_free_water ///
distance_hp_hp dist_bomani_office_km water_concern_reliability ///
low_ec high_ph poor_taste water_concern_safe_to_drink geology_coral hp_age ///
high_vol_use hp_water_drinking hp_water_lvstk hh_grow_crops ///
alt_source_hp alt_source_open_well alt_source_river_stream_pond alt_source_piped_tap ///
free_repair_y_n satisfied_maintenance_prov if sign_up_2016==0, vce(cluster pump_code) 

fitstat

*** 'best-case' scenario marginal effects with all significant variables, including increasing distance to next handpump

margins, at(regular_pay_either=1 water_concern_costly=0 think_vulnerable_free_water=0  ///
hp_water_drinking=1 distance_hp_hp=(0.7030158 1 1.5 2 2.5 3 3.5 4 4.5 5))

marginsplot, noci

*** 'worst-case' scenario marginal effects with all significant variables, including decreasing distance to next handpump

margins, at(regular_pay_either=0 water_concern_costly=1 think_vulnerable_free_water=1 ///
hp_water_drinking=0 distance_hp_hp=(0.7030158 0.6 0.5 0.4 0.3 0.2 0.1))

marginsplot, noci



***Model 2 - waterpoint user group level contract commitment

*** Read in the file on waterpoint user group level data


drop if functionality_status==3

*** logistic regression for 'sign-up' for the maintenance service provider (MSP)

logistic sign_up_2016 ///
i.management_final club rules_made_majority_decision women_on_committee exclusion_not_observing_rules penalties_no_pay ///
regular_pay_either spare_parts_stored ///
poorest_quintile_8var subjective_poor final_wtp_mean water_concern_costly think_vulnerable_free_water ///
distance_hp_hp dist_bomani_office_km water_concern_reliability ///
low_ec high_ph poor_taste water_concern_safe_to_drink geology_coral ///
high_vol_use hp_water_drinking hp_water_lvstk hh_grow_crops ///
alt_source_hp alt_source_open_well alt_source_river_stream_pond alt_source_piped_tap ///
free_repair_y_n satisfied_maintenance_prov ///
missing_penalty_no_pay, robust

fitstat

*** 'best-case' scenario marginal effects with all significant variables, including decreasing distance to the office of the maintenance service provider

margins, at(club=1 women_on_committee=1 regular_pay_either=1 spare_parts_stored=0 ///
low_ec=1 high_ph=1 geology_coral=0 hh_grow_crops=1 dist_bomani_office_km=(17.70303 15 10 5 1))

marginsplot, noci

*** 'worst-case' scenario marginal effects with all significant variables, including increasing distance to the office of the maintenance service provider

margins, at(club=0 women_on_committee=0 regular_pay_either=0 spare_parts_stored=1 ///
low_ec=0 high_ph=0 geology_coral=1 hh_grow_crops=0 dist_bomani_office_km=(17.70303 20 25 30 35 40))

marginsplot, noci

