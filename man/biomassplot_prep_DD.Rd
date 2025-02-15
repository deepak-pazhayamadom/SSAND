% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/biomassplot_prep_DD.R
\name{biomassplot_prep_DD}
\alias{biomassplot_prep_DD}
\title{Prepare DDUST data for biomassplot()
If using MCMC, the "interval", "prob_lower" and "prob_upper" column will return NA when med="MCMC".}
\usage{
biomassplot_prep_DD(
  dd_mle,
  dd_mcmc = NULL,
  dd_sim = NULL,
  scenarios = NULL,
  intervals = c(0.2, 0.5, 0.7, 0.9, 0.95),
  biomass_type = "relative"
)
}
\arguments{
\item{dd_mle}{A list of outputs from DDUST::makefullreport() with one list element per scenario. Will automatically reformat as a list if a single DDUST::makefullreport() output (i.e. one scenario) is entered}

\item{dd_mcmc}{A list of model fits from tmbstan::tmbstan() with one list element per scenario. Only needed if MCMC was used.}

\item{dd_sim}{A list of outputs from DDUST::simulate_DD() with one list element per scenario. Only required if MCMC was used. Will automatically reformat as a list if a single DDUST::makefullreport() output (i.e. one scenario) is entered}

\item{scenarios}{A vector of scenarios to plot (numeric). Shows all scenarios if left blank. Can be overridden in the plotting function.}

\item{intervals}{A vector of credible interval values to be displayed on banded MCMC plot (numeric). For example, "0.9" denotes the 90\% credible interval.}

\item{biomass_type}{The type of biomass used. Options are "relative" or "absolute" (character).}
}
\value{
If MCMC is being used, returns a data frame with variables called rownum, scenario, year, value, med, interval, prob_lower, prob_upper, biomass_type, biomass_definition. If MLE, returns a data frame with variables called year, value, lower, upper, scenario, biomass_type, biomass_definition.
}
\description{
Prepare DDUST data for biomassplot()
If using MCMC, the "interval", "prob_lower" and "prob_upper" column will return NA when med="MCMC".
}
\examples{
data <- biomassplot_prep_DD(dd_mle)
biomassplot(data)

\dontrun{
# MCMC model
library(DDUST)
dd_sim <- simulate_DDUST(dd_mle,dd_mcmc)

data <- biomassplot_prep_DD(dd_mle, dd_mcmc, dd_sim,
                            intervals = c(0.2, 0.5, 0.7, 0.9, 0.95))
biomassplot(data)

# Ensemble model:
library(DDUST)
dd_sim <- simulate_DDUST(dd_mle,dd_mcmc)
dd_mcmc_ens <- mcmc_ensemble_DD(dd_mcmc,dd_sim)$dd_mcmc
dd_sim_ens <- mcmc_ensemble_DD(dd_mcmc,dd_sim)$dd_sim
data <- biomassplot_prep_DD(dd_mle, dd_mcmc_ens, dd_sim_ens)
biomassplot(data)
}
}
