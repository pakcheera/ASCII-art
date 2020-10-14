library(tidyverse)
library(imager)
library(gtools)
im <- load.image("picture.jpg")
asc <- gtools::chr(38:126) 
g.chr <- function(chr) implot(imfill(50,50,val=1),text(25,25,chr,cex=5)) %>% grayscale %>% mean
g <- map_dbl(asc,g.chr)
n <- length(g)
char <- asc[order(g)]
d <- grayscale(im) %>% imresize(.1)  %>% as.data.frame
d <- mutate(d,qv=cut_number(value,n) %>% as.integer)
d <- mutate(d,char=char[qv])
ggplot(d,aes(x,y))+geom_text(aes(label=char),size=1)+scale_y_reverse()
