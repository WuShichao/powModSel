#' @title Thermodynamic integration
#' @description This function produces a thermodynamic integration estimate of the marginal likelihood given a set of log-likelihood values at different temperatures.
#' @name ti
#' @usage ti(x, actPlot = FALSE, temp = NULL)
#' @param x A data frame with the folloging columns: \code{logL} and \code{invTemp}, which contain the log-likelihood and inverse temperature values, respectively.
#' @param actPlot If it is \code{TRUE}, the function plots the temperatures against  the log-likelihood means at the different temperatures.
#' @param temp It indicates the temperatures to be used in the analysis, for instance, c(1,3,K) considers the temperatures at those positions, where \eqn{K} is the number of temperatures.  In this case, the temperatures must be sorted in an increasing order.  Note that samples from the prior and posterior must be included in the process.  "NULL" stands for all the temperatures in \code{x}.
#' @details Power posterior methods, among them thermodynamic integration, rely on a set of samples from different transitional distributions, connecting the prior and the posterior distributions, which is defined by the power posterior density
#'          \deqn{p(\theta) \propto L(x|\theta)^{\beta} \pi(\theta), }
#'          where \eqn{\theta} is the parameter vector, \eqn{0 \le \beta \le 1} is the inverse temperature, \eqn{x} is the data, \eqn{p(\theta)} is the power posterior density, \eqn{L(x|\theta)} is the likelihood function, and \eqn{\pi(\theta)} is the prior density.
#'          \code{ti} uses the trapezoidal rule in the estimation (see more details in Lartillot and Philippe (2006)).
#' @author Patricio Maturana Russel \email{p.russel@auckland.ac.nz}
#' @references Lartillot, N., and Philippe, H. 2006.  Computing Bayes factors using Thermodynamic Integration. \emph{Systematic Biology} \bold{55}(2), 195--207.
#' @return Thermodynamic integration estimate (numeric value), and an optional plot
#' @examples
#' \dontrun{
#' data(ligoVirgoSim)
#' ti(ligoVirgoSim, actPlot = TRUE, temp = NULL)
#' }
#' @export
ti = function(x, actPlot = FALSE, temp = NULL){

  if( !is.null(temp)){ # selecting certain temperatures (temp)
    #count = aggregate(logL~invTemp, data = x, FUN = length);
    index = which(diff(x$invTemp)!=0);
    index = cbind(c(1, index + 1), c(index, dim(x)[1]));
    index = index[temp,];
    newX  = unlist(apply(index, 1, function(x)seq(x[1],x[2], by = 1)));
    newX  = x[as.character(newX),];
    #rownames(newX) = NULL; # reseting rownames
    x = newX;
  }

  rownames(x) = NULL; # reseting rownames

  Rti = stats::aggregate(logL~invTemp, FUN = mean, data = x); # Mean per temperature

  if( actPlot == TRUE){
    graphics::plot(Rti$invTemp, Rti$logL, xlab = "Inverse temperature",
                   ylab = "Log-likelihood mean")
  }

  return( sum( diff(Rti$invTemp) *
          (Rti$logL[-length(Rti$logL)] + Rti$logL[-1]) )/2 );

}
