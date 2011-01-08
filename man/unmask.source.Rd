\name{unmask.source}
\alias{unmask.source}
\title{Restore the real source code from the masked text.}
\usage{unmask.source(text.mask)
}
\description{Restore the real source code from the masked text.}
\value{the real source code (a character vector)}
\author{Yihui Xie <\url{http://yihui.name}>}
\arguments{\item{text.mask}{the masked source code}
}
\examples{library(formatR)

src = c("    # a single line of comments is preserved", 
    "1+1", "  ", "if(TRUE){", "x=1  # comments begin with at least 2 spaces!", 
    "}else{", "x=2;print('Oh no... ask the right bracket to go away!')}", 
    "1*3 # this comment will be dropped!", "2+2+2    # 'short comments'", 
    "lm(y~x1+x2)  ### only 'single quotes' are allowed in comments", 
    "1+1+1+1+1+1+1+1+1+1+1+1+1+1+1+1+1+1+1+1+1+1+1  ## comments after a long line")

x = tidy.source(text = src, output = FALSE)$text.mask

cat(x, sep = "\n")

cat(unmask.source(x), sep = "\n")}















