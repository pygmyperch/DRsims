#!/usr/bin/env Rscript
## generate plots for the simulations


main <- function() {
  
  args <- commandArgs(trailingOnly = TRUE)
  path <- args[1]
  cat(args, sep = "\n")

setwd(path)
nm <- basename(path) 
setwd(paste0(path,"/fst/"))
npops <- 3
#directories <- list.dirs('.', full.names = T, recursive = F)
files = list.files(all.files = TRUE, recursive=T, full.names=F, pattern = "\\.txt$")
files <- files[which(file.info(files)$size>0)]
numbers = as.numeric(regmatches(files, regexpr("[0-9]+", files)))
files <- files[order(numbers)]
files <- files[seq(5, length(files), 5)]



# make list of mean and sd for each generation
res <- lapply(files, function(i) {
  dat <- read.table(i)[,7]
  plot_table <- c(mean(dat), sd(dat))
})

tab <- as.data.frame(do.call(rbind, res[1:length(files)]))#set how many generations to plot here
CI <- as.data.frame(qnorm(0.975)*tab$V2/sqrt(length(files)))
CI <- setNames(CI, "CI")
tab <- as.data.frame(c(tab,CI))


setwd(paste0(path,"/pop1He/"))
pop1He.files = list.files(all.files = TRUE, recursive=T, full.names=F, pattern = "\\.pop1$")
pop1He.files <- pop1He.files[which(file.info(pop1He.files)$size>0)]
numbers = as.numeric(regmatches(pop1He.files, regexpr("[0-9]+", pop1He.files)))
pop1He.files <- pop1He.files[order(numbers)]
pop1He.files <- pop1He.files[seq(5, length(pop1He.files), 5)]

# make list of He for each generation
pop1He.res <- lapply(pop1He.files, function(i) {
  dat <- read.table(i)[,1]
  plot_table <- c(mean(dat), sd(dat))
})

pop1He.tab <- as.data.frame(do.call(rbind, pop1He.res[1:length(pop1He.files)]))
CI <- as.data.frame(qnorm(0.975)*pop1He.tab$V2/sqrt(length(pop1He.files)))
CI <- setNames(CI, "CI")
pop1He.tab <- as.data.frame(c(pop1He.tab,CI))


setwd(paste0(path,"/pop2He/"))
pop2He.files = list.files(all.files = TRUE, recursive=T, full.names=F, pattern = "\\.pop2$")
pop2He.files <- pop2He.files[which(file.info(pop2He.files)$size>0)]
numbers = as.numeric(regmatches(pop2He.files, regexpr("[0-9]+", pop2He.files)))
pop2He.files <- pop2He.files[order(numbers)]
pop2He.files <- pop2He.files[seq(5, length(pop2He.files), 5)]

# make list of He for each generation
pop2He.res <- lapply(pop2He.files, function(i) {
  dat <- read.table(i)[,1]
  plot_table <- c(mean(dat), sd(dat))
})

pop2He.tab <- as.data.frame(do.call(rbind, pop2He.res[1:length(pop2He.files)]))
CI <- as.data.frame(qnorm(0.975)*pop2He.tab$V2/sqrt(length(pop2He.files)))
CI <- setNames(CI, "CI")
pop2He.tab <- as.data.frame(c(pop2He.tab,CI))


setwd(paste0(path,"/pop3He/"))
pop3He.files = list.files(all.files = TRUE, recursive=T, full.names=F, pattern = "\\.pop3$")
pop3He.files <- pop3He.files[which(file.info(pop3He.files)$size>0)]
numbers = as.numeric(regmatches(pop3He.files, regexpr("[0-9]+", pop3He.files)))
pop3He.files <- pop3He.files[order(numbers)]
pop3He.files <- pop3He.files[seq(5, length(pop3He.files), 5)]

# make list of He for each generation
pop3He.res <- lapply(pop3He.files, function(i) {
  dat <- read.table(i)[,1]
  plot_table <- c(mean(dat), sd(dat))
})

pop3He.tab <- as.data.frame(do.call(rbind, pop3He.res[1:length(pop3He.files)]))
CI <- as.data.frame(qnorm(0.975)*pop3He.tab$V2/sqrt(length(pop3He.files)))
CI <- setNames(CI, "CI")
pop3He.tab <- as.data.frame(c(pop3He.tab,CI))

He.max <- 0.5
samples <- as.numeric(regmatches(pop3He.files, regexpr("[0-9]+", pop3He.files)))
x <- seq(samples[1], tail(samples, n=1), by=samples[2]-samples[1])


# uncomment here and in the plot call to add lines indicating the timing of each flood
#wet <- read.table(paste0(path,"/sim_meta/sim.meta_00.wet"), skip = 1)



pdf(file=paste0(path,"/",nm,".pdf"), width=6, height=6)
par(mar = c(5,5,2,5))
options(scipen = 999)
plot(x, tab$V1,
     ylim=range(0,1), type="l", 
     lwd = 2, col="black", xlab="Generation", ylab="Fst",xaxt="n")
axis(1, xaxp = c(100000, 120000, 4))
cix <- c(x, rev(x))
ciy <- c(tab$V1+tab$CI, rev(tab$V1-tab$CI))
polygon(cix, ciy, col=rgb(150/255,139/255,132/255,0.3), border = NA)


# add lines to indicate wet years
#for (i in wet$V1) {abline(v=i, lwd=0.1)}

par(new = T)
plot(x, pop1He.tab$V1,
     ylim=range(0,He.max), type="l", axes=F,
     lwd = 2, col=rgb(122/255,151/255,44/255,1), xlab=NA, ylab=NA,xaxt="n")
pop1He.ciy <- c(pop1He.tab$V1+pop1He.tab$CI, rev(pop1He.tab$V1-pop1He.tab$CI))
polygon(cix, pop1He.ciy, col=rgb(122/255,151/255,44/255,0.3), border = NA)


par(new = T)
plot(x, pop2He.tab$V1,
     ylim=range(0,He.max), type="l", axes=F,
     lwd = 2, col=rgb(45/255,96/255,124/255,1), xlab=NA, ylab=NA,xaxt="n")
pop2He.ciy <- c(pop2He.tab$V1+pop2He.tab$CI, rev(pop2He.tab$V1-pop2He.tab$CI))
polygon(cix, pop2He.ciy, col=rgb(45/255,96/255,124/255,0.3), border = NA)


par(new = T)
plot(x, pop3He.tab$V1,
     ylim=range(0,He.max), type="l", axes=F,
     lwd = 2, col=rgb(240/255,157/255,6/255,1), xlab=NA, ylab=NA,xaxt="n")
pop3He.ciy <- c(pop3He.tab$V1+pop3He.tab$CI, rev(pop3He.tab$V1-pop3He.tab$CI))
polygon(cix, pop3He.ciy, col=rgb(240/255,157/255,6/255,0.3), border = NA)


axis(side = 4)
mtext(side = 4, line = 3, 'He')


legend("topleft", bty = "n", cex = 0.7,
       legend=c(expression(F[ST]), "Pop1 He", "Pop2 He", "Pop3 He"),
       lty=c(1,1,1,1), lwd =c(2,2,2,2), col=c("black", 
                                              rgb(122/255,151/255,44/255,1), rgb(45/255,96/255,124/255,1), rgb(240/255,157/255,6/255,1)))
dev.off()

}

main()





