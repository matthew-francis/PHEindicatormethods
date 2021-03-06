% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/funnel_prop_plot.R
\name{phe_fun_prop_plot}
\alias{phe_fun_prop_plot}
\title{Calculate confidence intervals/control limits and levels of significance}
\usage{
phe_fun_prop_plot(data, x, denom)
}
\arguments{
\item{data}{a data.frame containing the data to calculate control limits for;
unquoted string; no default}

\item{x}{field name from data containing the observed numbers of cases in the sample meeting the
required condition (the numerator for the CLs); unquoted string; no default}

\item{denom}{field name from data containing the population(s) in the sample
(the denominator for the CLs); unquoted string; no default}
}
\value{
returns the original data.frame with the following appended:
        lower 0.025 limit, upper 0.025 limit, lower 0.001 limit, upper 0.001 limit and
        baseline average
}
\description{
Calculates control limits adopting consistent method as per the PHE Fingertips Technical Guidance : https://fingertips.phe.org.uk/profile/guidance
}
\examples{

}
\seealso{
Other PHEindicatormethods package functions: 
\code{\link{phe_dsr}()},
\code{\link{phe_fun_prop_sig}()},
\code{\link{phe_isr}()},
\code{\link{phe_life_expectancy}()},
\code{\link{phe_mean}()},
\code{\link{phe_proportion}()},
\code{\link{phe_quantile}()},
\code{\link{phe_rate}()},
\code{\link{phe_sii}()},
\code{\link{phe_smr}()}
}
\concept{PHEindicatormethods package functions}
