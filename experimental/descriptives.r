data <- read.csv('/Users/mnelimar/Downloads/Islamophobia_Pilot.csv')

data$treat[ data$Control==1 ] <- 1
data$treat[ data$Security.1==1 ] <- 2
data$treat[ data$Security.2==1 ] <- 3
data$treat[ data$Culture.1==1 ] <- 4
data$treat[ data$Q32==1 ] <- 5

data$treat <- as.factor( data$treat )

library(ggplot2)

p <- ggplot( data , aes( data$Q38_3 ) ) +
  geom_histogram( bins = 100 ) +
  xlab('Time on news story, seconds') +
  geom_vline(xintercept = 30) +
  ## annotate("text", 100, 50, label = "30 seconds") +
  theme_minimal()

## remove people who had too little time on tests
## data$treat[ data$Q38_3 < 30 ] <- NA

ggsave( p, file = 'time_on_page.png')

## Gender

library(lattice)
library(FSA)

Summarize( Q14 ~ treat, data = data)

png('age.png')

histogram( ~ Q14 | treat,
          data=data, layout=c(1,5) )

dev.off()

kruskal.test(data$Q14 ~ data$treat)

png('sex.png')

## Age

data$gender_recode <- as.factor(data$Gender)
data$gender_recode[ data$gender_recode == 3 ] <- NA

table( data$gender_recode, data$treat )

chisq.test( data$gender_recode, data$treat )

dev.off()

### Religion

png('religion.png')

data$religion_recode <- as.factor(data$Religion)
data$religion_recode[ data$religion_recode == 10 ] <- NA

table( data$religion_recode, data$treat )

chisq.test( data$religion_recode, data$treat )

dev.off()


##

png('religion.png')

data$education_recode <- as.factor(data$Education)

table( data$education_recode, data$treat )

chisq.test( data$education_recode, data$treat )

dev.off()

#### Q48 Please indicate whether you agree or disagree with each of the following statements:

for( i in 54:58 ){

  print( names( data )[i] )
  c = data[,i]
  print(  mean( c ) )

  print( chisq.test( data[,i], data$treat) )
  print( kurskal.test( data[,i], data$treat) )

}

## Policies Some people have proposed the following policies in the United States.  For each policy, please indicate whether you agree or disagree:


for( i in 42:46 ){

  print( names( data )[i] )
  c = data[,i]
  print(  mean( c ) )

  print( chisq.test( data[,i], data$treat) )

  print( table(  data[,i], data$treat  ) )
  print( kurskal.test( data[,i], data$treat) )

}
