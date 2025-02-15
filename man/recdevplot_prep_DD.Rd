% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/recdevplot_prep_DD.R
\name{recdevplot_prep_DD}
\alias{recdevplot_prep_DD}
\title{Prepare DDUST data for recdevplot()}
\usage{
recdevplot_prep_DD(
  dd_mle,
  dd_mcmc = NULL,
  dd_sim = NULL,
  scenarios = NULL,
  intervals = c(0.2, 0.5, 0.7, 0.9, 0.95),
  CI_range = 0.95
)
}
\arguments{
\item{dd_mle}{A list of outputs from DDUST::makefullreport() with one list element per scenario. Will automatically reformat as a list if a single DDUST::makefullreport() output (i.e. one scenario) is entered}

\item{dd_mcmc}{A list of model fits from tmbstan::tmbstan() with one list element per scenario. Only needed if MCMC was used.}

\item{dd_sim}{A list of outputs from SSAND::simulate_DD() with one list element per scenario. Only required if MCMC was used. Will automatically reformat as a list if a single DDUST::makefullreport() output (i.e. one scenario) is entered}

\item{scenarios}{A vector of scenarios to plot (numeric). Shows all scenarios if left blank. Can be overridden in the plotting function.}

\item{intervals}{A vector of credible interval values to be displayed on banded MCMC plot (numeric). For example, "0.9" denotes the 90\% credible interval.}

\item{CI_range}{Specify credible interval range (numeric). Only activated if mcmc_style==CI.}
}
\value{
A data frame with variables called year (int), value (int), ub (num), lb (num), median (num, if MCMC==TRUE), scenario (factor), method (chr).
}
\description{
Prepare DDUST data for recdevplot()
}
\examples{
data <- recdevplot_prep_DD(dd_mle)
recdevplot(data)

\dontrun{
# MCMC model
library(DDUST)
dd_sim <- simulate_DDUST(dd_mle,dd_mcmc)
data <- recdevplot_prep_DD(dd_mle,dd_mcmc,dd_sim)
recdevplot(data)

# Ensemble model
dd_mcmc_ens <- mcmc_ensemble_DD(dd_mcmc,dd_sim,scenarios=c(1,2))$dd_mcmc
dd_sim_ens <- mcmc_ensemble_DD(dd_mcmc,dd_sim,scenarios=c(1,2))$dd_sim
data <- recdevplot_prep_DD(dd_mle,dd_mcmc_ens,dd_sim_ens)
recdevplot(data)
}
}
