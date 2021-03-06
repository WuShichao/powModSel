% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ti.R
\name{ti}
\alias{ti}
\title{Thermodynamic integration}
\usage{
ti(x, actPlot = FALSE, temp = NULL)
}
\arguments{
\item{x}{A data frame with the folloging columns: \code{logL} and \code{invTemp}, which contain the log-likelihood and inverse temperature values, respectively.}

\item{actPlot}{If it is \code{TRUE}, the function plots the temperatures against  the log-likelihood means at the different temperatures.}

\item{temp}{It indicates the temperatures to be used in the analysis, for instance, c(1,3,K) considers the temperatures at those positions, where \eqn{K} is the number of temperatures.  In this case, the temperatures must be sorted in an increasing order.  Note that samples from the prior and posterior must be included in the process.  "NULL" stands for all the temperatures in \code{x}.}
}
\value{
Thermodynamic integration estimate (numeric value), and an optional plot
}
\description{
This function produces a thermodynamic integration estimate of the marginal likelihood given a set of log-likelihood values at different temperatures.
}
\details{
Power posterior methods, among them thermodynamic integration, rely on a set of samples from different transitional distributions, connecting the prior and the posterior distributions, which is defined by the power posterior density
         \deqn{p(\theta) \propto L(x|\theta)^{\beta} \pi(\theta), }
         where \eqn{\theta} is the parameter vector, \eqn{0 \le \beta \le 1} is the inverse temperature, \eqn{x} is the data, \eqn{p(\theta)} is the power posterior density, \eqn{L(x|\theta)} is the likelihood function, and \eqn{\pi(\theta)} is the prior density.
         \code{ti} uses the trapezoidal rule in the estimation (see more details in Lartillot and Philippe (2006)).
}
\examples{
\dontrun{
data(ligoVirgoSim)
ti(ligoVirgoSim, actPlot = TRUE, temp = NULL)
}
}
\references{
Lartillot, N., and Philippe, H. 2006.  Computing Bayes factors using Thermodynamic Integration. \emph{Systematic Biology} \bold{55}(2), 195--207.
}
\author{
Patricio Maturana Russel \email{p.russel@auckland.ac.nz}
}
