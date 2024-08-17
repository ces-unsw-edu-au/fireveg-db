
CREATE TYPE method_surv1_vocabulary AS ENUM ('Direct field observation or measure (unknown sample size)', 'Direct observation (small sample)', 'Direct observation (large sample)', 'Estimated by extrapolation from observed values', 'Inferred from plant / organ / growth stage morphology', 'Inferred from related taxa', 'Manipulative experiment', 'Qualitative estimate', 'Unspecified methods');

COMMENT ON TYPE method_surv1_vocabulary IS
'{"Direct field observation or measure (unknown sample size)": "Estimates based on data observed or measured in the field (unknown number of individuals observed). Survival estimates based on counts of individuals tagged pre-fire or counts of resprouters and dead remains postfire",
 "Direct observation (small sample)": "Estimates based on data observed or measured in the field based on fewer than 10 individuals. Survival estimates based on counts of individuals tagged pre-fire or counts of resprouters and dead remains postfire",
 "Direct observation (large sample)": "Estimates based on data observed or measured in the field based on 10 or more individuals observed). Survival estimates based on counts of individuals tagged pre-fire or counts of resprouters and dead remains postfire",
 "Estimated by extrapolation from observed values": "Estimated by extrapolation from (time series) of observed values. High mortality from 100% scorch may be inferred if mortality is high from partial scorch",
 "Inferred from plant / organ / growth stage morphology": "Inference based on relevant morphological structures or traits. Inference based on structure of protective and regenerative organs ",
 "Inferred from related taxa": "Assigned to same category as congeners or confamilials that have similar visible features, pending direct evidence. Based on congeneric species with similar protective/recovery organs and habitats",
 "Manipulative experiment": "Manipulative experiment. Individuals sampled before and after fire treatment causing 100% scorch",
 "Qualitative estimate": "Guestimate from visual assessment of post-fire wild population. Guestimate from visual assessment of post-fire wild population",
 "Unspecified methods": "Methods unclear or undocumented."}';

CREATE TYPE method_surv2_vocabulary AS ENUM ('Direct field observation or measure (unknown sample size)', 'Direct observation (small sample)', 'Direct observation (large sample)', 'Trait evidence, but start date uncertain', 'Inferred from plant / organ / growth stage morphology', 'Inferred from related taxa', 'Manipulative experiment', 'Qualitative estimate', 'Unspecified methods');

COMMENT ON TYPE method_surv2_vocabulary IS
'{"Direct field observation or measure (unknown sample size)": "Estimates based on data observed or measured in the field (unknown number of individuals observed). Survival response based on counts of individuals tagged pre-fire or counts of resprouters and dead remains postfire",
 "Direct observation (small sample)": "Estimates based on data observed or measured in the field based on fewer than 10 individuals. Survival response based on counts of individuals tagged pre-fire or counts of resprouters and dead remains postfire",
 "Direct observation (large sample)": "Estimates based on data observed or measured in the field based on 10 or more individuals observed). Survival response based on counts of individuals tagged pre-fire or counts of resprouters and dead remains postfire",
 "Trait evidence, but start date uncertain": "Evidence of trait expression, but age of first expression uncertain. None",
 "Inferred from plant / organ / growth stage morphology": "Inference based on relevant morphological structures or traits. Inferred from plant morphology (e.g. bark thickness) or other means (specify)",
 "Inferred from related taxa": "Assigned to same category as congeners or confamilials that have similar visible features, pending direct evidence. Based on congeneric species with similar protective/recovery organs and habitats",
 "Manipulative experiment": "Manipulative experiment. Individuals sampled before and after fire treatment causing basal scorch",
 "Qualitative estimate": "Guestimate from visual assessment of post-fire wild population. Guestimate from visual assessment of post-fire wild population",
 "Unspecified methods": "Methods unclear or undocumented."}'
;

CREATE TYPE method_surv3_vocabulary AS ENUM ('Direct field observation or measure (unknown sample size)', 'Direct observation (small sample)', 'Direct observation (large sample)', 'Trait evidence, but start date uncertain', 'Inferred from plant / organ / growth stage morphology', 'Inferred from related taxa', 'Manipulative experiment', 'Qualitative estimate', 'Unspecified methods');

COMMENT ON TYPE method_surv3_vocabulary IS
'{"Direct field observation or measure (unknown sample size)": "Estimates based on data observed or measured in the field (unknown number of individuals observed). Survival estimates based on counts of individuals tagged pre-fire or counts of resprouters and dead remains postfire",
 "Direct observation (small sample)": "Estimates based on data observed or measured in the field based on fewer than 10 individuals. Survival estimates based on counts of individuals tagged pre-fire or counts of resprouters and dead remains postfire",
 "Direct observation (large sample)": "Estimates based on data observed or measured in the field based on 10 or more individuals observed). Survival estimates based on counts of individuals tagged pre-fire or counts of resprouters and dead remains postfire",
 "Trait evidence, but start date uncertain": "Evidence of trait expression, but age of first expression uncertain. None",
 "Inferred from plant / organ / growth stage morphology": "Inference based on relevant morphological structures or traits. Inference based on structure of protective and regenerative organs with reference to resprouting responses of species with similar organs",
 "Inferred from related taxa": "Assigned to same category as congeners or confamilials that have similar visible features, pending direct evidence. Based on congeneric species with similar protective/recovery organs and habitats",
 "Manipulative experiment": "Manipulative experiment. Individuals sampled before and after fire treatment causing <100% scorch",
 "Qualitative estimate": "Guestimate from visual assessment of post-fire wild population. Guestimate from visual assessment of post-fire wild population",
 "Unspecified methods": "Methods unclear or undocumented."}'
;

CREATE TYPE method_grow1_vocabulary AS ENUM ('Direct field observation or measure (unknown sample size)', 'Direct observation (small sample)', 'Direct observation (large sample)', 'Estimated by extrapolation from observed values', 'Trait evidence, but start date uncertain', 'Inferred from plant / organ / growth stage morphology', 'Inferred from related taxa', 'Manipulative experiment', 'No evidence of trait expression by specified age', 'Unspecified methods');

COMMENT ON TYPE method_grow1_vocabulary IS
'{"Direct field observation or measure (unknown sample size)": "Estimates based on data observed or measured in the field (unknown number of individuals observed). At least 50% survival calculated from field counts of live and killed individuals of known age(s) after a fire event that resulted in complete scorch",
 "Direct observation (small sample)": "Estimates based on data observed or measured in the field based on fewer than 10 individuals. Time series measurements of growth stage variables in relation to cohort age",
 "Direct observation (large sample)": "Estimates based on data observed or measured in the field based on 10 or more individuals observed). Time series measurements of growth stage variables in relation to cohort age",
 "Estimated by extrapolation from observed values": "Estimated by extrapolation from (time series) of observed values. Time series of organ/issue development requiring extrapolation to estimate an age at which survival would be at least 50%",
 "Trait evidence, but start date uncertain": "Evidence of trait expression, but age of first expression uncertain. Single temporal observation of >50% survival but uncertain if survival would be >50% if sampled plants were younger",
 "Inferred from plant / organ / growth stage morphology": "Inference based on relevant morphological structures or traits. Age of resistance inferred from one or few opportunitistic observations of organ dimensions (e.g. lignotuber diameter, bark thickness at known age)",
 "Inferred from related taxa": "Assigned to same category as congeners or confamilials that have similar visible features, pending direct evidence. Based on attainment of mature form for congeneric species with similar growth forms and habitats",
 "Manipulative experiment": "Manipulative experiment. Experimental heating applied to individuals of known age(s)",
 "No evidence of trait expression by specified age": "No evidence of trait expression by specified age. Reproductive/regenerative structures not yet observed since last fire",
 "Unspecified methods": "Methods unclear or undocumented."}';

CREATE TYPE method_grow2_vocabulary AS ENUM ('Direct field observation or measure (unknown sample size)', 'Direct observation (small sample)', 'Direct observation (large sample)', 'Estimated by extrapolation from observed values', 'Trait evidence, but start date uncertain', 'Inferred from plant / organ / growth stage morphology', 'Inferred from related taxa', 'No evidence of trait expression by specified age', 'Unspecified methods');

COMMENT ON TYPE method_grow2_vocabulary IS
'{"Direct field observation or measure (unknown sample size)": "Estimates based on data observed or measured in the field (unknown number of individuals observed). Time series measurements of growth stage variables in relation to cohort age",
 "Direct observation (small sample)": "Estimates based on data observed or measured in the field based on fewer than 10 individuals. Time series measurements of growth stage variables in relation to cohort age",
 "Direct observation (large sample)": "Estimates based on data observed or measured in the field based on 10 or more individuals observed). Time series measurements of growth stage variables in relation to cohort age",
 "Estimated by extrapolation from observed values": "Estimated by extrapolation from (time series) of observed values. Extrapolation from incomplete time series of growth stage variables in relation to cohort age",
 "Trait evidence, but start date uncertain": "Evidence of trait expression, but age of first expression uncertain. Single temporal observation of >50% survival but uncertain if survival would be >50% if sampled plants were younger",
 "Inferred from plant / organ / growth stage morphology": "Inference based on relevant morphological structures or traits. inferred from growth stage morphology without formal time series data (document assumptions) - Inferred qualitatively from one or few opportunistic observations of growth stage at known cohort ages (identify any similar species if used in the inference)",
 "Inferred from related taxa": "Assigned to same category as congeners or confamilials that have similar visible features, pending direct evidence. Based on attainment of mature form for congeneric species with similar growth forms and habitats",
 "No evidence of trait expression by specified age": "No evidence of trait expression by specified age. Reproductive/regenerative structures not yet observed since last fire",
 "Unspecified methods": "Methods unclear or undocumented."}'
;

CREATE TYPE method_repr3_vocabulary AS ENUM ('Direct field observation or measure (unknown sample size)', 'Direct observation (small sample)', 'Direct observation (large sample)', 'Trait evidence, but start date uncertain', 'No evidence of trait expression by specified age', 'Unspecified methods');

COMMENT ON TYPE method_repr3_vocabulary IS
'{"Direct field observation or measure (unknown sample size)": "Estimates based on data observed or measured in the field (unknown number of individuals observed). Time series measurements of flowering in relation to cohort age",
 "Direct observation (small sample)": "Estimates based on data observed or measured in the field based on fewer than 10 individuals. Time series measurements of flowering in relation to cohort age",
 "Direct observation (large sample)": "Estimates based on data observed or measured in the field based on 10 or more individuals observed). Time series measurements of flowering in relation to cohort age",
 "Trait evidence, but start date uncertain": "Evidence of trait expression, but age of first expression uncertain. Reproductive structures observed, but uncertain whether they were also produced earlier during post-fire regeneration",
 "No evidence of trait expression by specified age": "No evidence of trait expression by specified age. Reproductive/regenerative structures not yet observed since last fire",
 "Unspecified methods": "Methods unclear or undocumented."}';

CREATE TYPE method_repr3a_vocabulary AS ENUM ('Direct field observation or measure (unknown sample size)', 'Direct observation (small sample)', 'Direct observation (large sample)', 'Trait evidence, but start date uncertain', 'No evidence of trait expression by specified age', 'Unspecified methods');

COMMENT ON TYPE method_repr3a_vocabulary IS
'{"Direct field observation or measure (unknown sample size)": "Estimates based on data observed or measured in the field (unknown number of individuals observed). Time series measurements of flowering in relation to cohort age",
 "Direct observation (small sample)": "Estimates based on data observed or measured in the field based on fewer than 10 individuals. Time series measurements of flowering in relation to cohort age",
 "Direct observation (large sample)": "Estimates based on data observed or measured in the field based on 10 or more individuals observed). Time series measurements of flowering in relation to cohort age",
 "Trait evidence, but start date uncertain": "Evidence of trait expression, but age of first expression uncertain. Reproductive structures observed, but uncertain whether they were also produced earlier during post-fire regeneration",
 "No evidence of trait expression by specified age": "No evidence of trait expression by specified age. Reproductive/regenerative structures not yet observed since last fire",
 "Unspecified methods": "Methods unclear or undocumented."}';

CREATE TYPE method_repr4_vocabulary AS ENUM ('Direct field observation or measure (unknown sample size)', 'Direct observation (small sample)', 'Direct observation (large sample)', 'Estimated by extrapolation from observed values', 'Trait evidence, but start date uncertain', 'Inferred form other trait', 'Inferred from partial data', 'No evidence of trait expression by specified age', 'Unspecified methods');
COMMENT ON TYPE method_repr4_vocabulary IS
'{"Direct field observation or measure (unknown sample size)": "Estimates based on data observed or measured in the field (unknown number of individuals observed). Time series data for seedbank accumulation.",
 "Direct observation (small sample)": "Estimates based on data observed or measured in the field based on fewer than 10 individuals. Time series measurements of flowering in relation to cohort age.",
 "Direct observation (large sample)": "Estimates based on data observed or measured in the field based on 10 or more individuals observed). Time series measurements of flowering in relation to cohort age.",
 "Estimated by extrapolation from observed values": "Estimated by extrapolation from (time series) of observed values. Time series of flowering observations requiring extrapolation to estimate an age at which survival would be at least 50%.",
 "Trait evidence, but start date uncertain": "Evidence of trait expression, but age of first expression uncertain. reproductive structures observed, but uncertain whether they were also produced earlier during post-fire regeneration.",
 "Inferred form other trait": "Inferred from values of a different, but related trait. Inferred from first flower production - Derived from some function of Age at first flowering (e.g. 2x, 3x). Justification of assumption required.",
 "Inferred from partial data": "Inferred from incomplete or indirect information. None.",
 "No evidence of trait expression by specified age": "No evidence of trait expression by specified age. reproductive/regenerative structures not yet observed since last fire.",
 "Unspecified methods": "Methods unclear or undocumented."}';

CREATE TYPE method_germ8_vocabulary AS ENUM ('Direct field observation or measure (unknown sample size)', 'Direct observation (small sample)', 'Direct observation (large sample)', 'Inferred from plant / organ / growth stage morphology', 'Inferred from related taxa', 'Unspecified methods');
COMMENT ON TYPE method_germ8_vocabulary IS
'{"Direct field observation or measure (unknown sample size)": "Estimates based on data observed or measured in the field (unknown number of individuals observed). Direct observational evidence of physical, physiological or morphological control on dormancy.",
 "Direct observation (small sample)": "Estimates based on data observed or measured in the field based on fewer than 10 individuals. Direct observational evidence of physical, physiological or morphological control on dormancy.",
 "Direct observation (large sample)": "Estimates based on data observed or measured in the field based on 10 or more individuals observed). Direct observational evidence of physical, physiological or morphological control on dormancy.",
 "Inferred from plant / organ / growth stage morphology": "Inference based on relevant morphological structures or traits. Inferred from visible features of seeds (e.g. hard coats) or fruits (e.g. hard endocarp).",
 "Inferred from related taxa": "Assigned to same category as congeners or confamilials that have similar visible features, pending direct evidence. Assigned to same category as congeners or confamilials that have similar visible features, pending direct evidence.",
 "Unspecified methods": "Methods unclear or undocumented."}'
;

CREATE TYPE method_rect3_vocabulary AS ENUM ('Direct field observation or measure (unknown sample size)', 'Direct observation (small sample)', 'Direct observation (large sample)', 'Estimated by extrapolation from observed values', 'Trait evidence, but start date uncertain', 'Inferred from partial data', 'Unspecified methods');
COMMENT ON TYPE method_rect3_vocabulary IS
'{"Direct field observation or measure (unknown sample size)": "Estimates based on data observed or measured in the field (unknown number of individuals observed). Based on response in time series spanning the seedling emergence event(s).",
 "Direct observation (small sample)": "Estimates based on data observed or measured in the field based on fewer than 10 individuals. Based on response in time series spanning the seedling emergence event(s).",
 "Direct observation (large sample)": "Estimates based on data observed or measured in the field based on 10 or more individuals observed). Based on response in time series spanning the seedling emergence event(s).",
 "Estimated by extrapolation from observed values": "Estimated by extrapolation from (time series) of observed values. Based on one or few observations of seedling emergence that do not span the full duration of the emergence event.",
 "Trait evidence, but start date uncertain": "Evidence of trait expression, but age of first expression uncertain. Single temporal observation of seedlings but the month that they emerged is uncertain.",
 "Inferred from partial data": "Inferred from incomplete or indirect information. Inferred from indirect information before or after the emergence event.",
 "Unspecified methods": "Methods unclear or undocumented."}'
;

CREATE TYPE method_disp1_vocabulary AS ENUM ('Direct field observation or measure (unknown sample size)', 'Direct observation (small sample)', 'Direct observation (large sample)', 'Inferred from plant / organ / growth stage morphology', 'Manipulative experiment', 'Unspecified methods');
COMMENT ON TYPE method_disp1_vocabulary IS
'{"Direct field observation or measure (unknown sample size)": "Estimates based on data observed or measured in the field (unknown number of individuals observed). Direct field observation or empirical measurement of dispersal events.",
 "Direct observation (small sample)": "Estimates based on data observed or measured in the field based on fewer than 10 individuals. Direct field observation or empirical measurement of dispersal events.",
 "Direct observation (large sample)": "Estimates based on data observed or measured in the field based on 10 or more individuals observed). Direct field observation or empirical measurement of dispersal events.",
 "Inferred from plant / organ / growth stage morphology": "Inference based on relevant morphological structures or traits. Inferred qualitatively from morphological features in definitions of dispersal categories.",
 "Manipulative experiment": "Manipulative experiment. Based on experimantal exposure to one or more dispersal vectors.",
 "Unspecified methods": "Methods unclear or undocumented."}'
;
