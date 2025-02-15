% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dynamicB0plot_prep_SS.R
\name{dynamicB0plot_prep_SS}
\alias{dynamicB0plot_prep_SS}
\title{Prepare Stock Synthesis data for dynamicB0plot()}
\usage{
dynamicB0plot_prep_SS(ss_mle, scenarios = NULL)
}
\arguments{
\item{ss_mle}{A list of outputs from r4ss::SS_output() with one element per scenario. Will automatically reformat as a list if a single r4ss::SS_output() output (i.e. one scenario) is entered.}

\item{scenarios}{A vector of scenarios to plot (numeric). Shows all scenarios if left blank. Can be overridden in the plotting function.}
}
\value{
A data frame with variables called year (int), era (chr), SSB (num), SSB_nofishing (num), scenario (int)
}
\description{
Prepare Stock Synthesis data for dynamicB0plot()
}
\examples{
data <- dynamicB0plot_prep_SS(ss_mle)
dynamicB0plot(data)
}
