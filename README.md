# SSAND <img src="man/figures/logo.png" align="right" height="138" alt="" />
This package (pronounced "sand") strives to provide universal code that can provide consistent outputs (such as plots and tables) for multiple stock assessment models. SSAND currently works with Stock Synthesis and DDUST, and could be extended to include more models. SSAND may be incompatible with updates to Stock Synthesis and r4ss (after V3.30.22.00 and v1.50.0 respectively) although we hope to improve compatiblity soon.

You can install the development version of SSAND from GitHub with:

``` r
# install.packages("devtools")
devtools::install_github("QLD-Fisheries/SSAND")
```

There are generally two kinds of functions you will find in SSAND:
* Data preparation functions, specific to the stock assessment model used (e.g. Stock Synthesis or DDUST)
* Plotting functions, agnostic to the model that is used

There are also a series of plots that can be used to explore raw catch and effort data.

Calling `catalogue()` will produce a guide of all the plots on offer within the package. 

Calling `template()` will produce a full stock assessment report with all plots, tables and calculated values in place. The report works from the pre-loaded Stock Synthesis example data, but you can easily enter your own model outputs.

Calling `investigate(data = format_logbooks(raw_data))` will produce a suite of plots and tables that can be used to interrogate raw catch and effort logbook data. 

``` r
library(SSAND)
catalogue()
template()

# To look at raw logbook data (using example logbook data)
SSAND::investigate(SSAND::format_logbooks(logbooks), 
                   species_of_interest = "Glitterfin snapper",
                   filter_days_lower = 1,
                   upset_n_trips = 1)



# To look at model outputs (using Stock Synthesis as an example)
ss_mle <- list(r4ss::SS_output(dir1), r4ss::SS_output(dir2), r4ss::SS_output(dir3))
ss_mcmc <- list(r4ss::SSgetMCMC(dir1), r4ss::SSgetMCMC(dir2), r4ss::SSgetMCMC(dir3))
data <- biomassplot_prep_SS(ss_mle,ss_mcmc)
biomassplot(data)
```

## Suggested SSAND workflow

``` mermaid
flowchart TB

        direction TB
		A("(External) Logbook pull"):::External--> B("SSAND: Logbook data formatting"):::SSAND
        B--> C("SSAND: Logbook data investigation plots"):::SSAND
        C--> D("(External) Prepare model inputs"):::External
        D--> E("SSAND: CPUE diagnostics (in development)"):::SSAND
        E--> F("(External) Stock assessment MLE modelling"):::External
        F--> G("SSAND: MLE diagnostics (in development)"):::SSAND
        G--> H("(External) Stock assessment MCMC modelling"):::External
        H--> I("SSAND: MCMC diagnostics"):::SSAND
        I--> J("SSAND: Load report template"):::SSAND
        J--> K("SSAND: Generate plots, tables and values for report"):::SSAND
        K--> L("SSAND: Communication package"):::SSAND

	
        B---b("format_logbooks()"):::Functions
        b---C
        C---c("investigate() and 
        functions in resulting investigate.Rmd"):::Functions
        c---D
        E---e("In development influenceplot()"):::Functions
        e---F
        G---g("In development.
        likelihoodplot(), pinerplot(), 
        sensitivityplot(), correlationplot()"):::Functions
        g---H
        I---i("mcmc_rhatplot(), mcmc_traceplot(), 
        mcmc_posteriordensityplot(), correlationplot()"):::Functions
        i---J
        J---j("template()"):::Functions
        j---K
        K---k("See functions in context inside 
        template.Rtex, produced by template()"):::Functions
        k---L
        L---l("managementplot(), webcatchplot()"):::Functions


    classDef SSAND fill:#005672,stroke:#0085b8,color:#ffffff
    classDef External fill:#006A4B,stroke:#00925B,color:#ffffff
    classDef Functions fill:#f8bc57,stroke:#e0a54e,color:#000000


linkStyle default stroke:black
linkStyle 11,13,15,17,19,21,23 stroke-width:2px,stroke:#e0a54e
linkStyle 12,14,16,18,20,22,24 stroke-width:0px,stroke:white
```
