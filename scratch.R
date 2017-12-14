# scratch space only

a = genocall %>% 
    select(group, accession) %>% 
    group_by(group) %>% 
    summarise(accessions = paste(accession, collapse = "; "))
write_delim(a, "groups.txt")


plot(genocall$missing ~ genocall$group)
ggplot(genocall, aes(group, missing.rate)) +
    geom_violin(scale="count")

?geom_violin

library(tidyverse)
dodgy = read.csv("data/dodgy-samples.csv")$anon.name
readstats = read.delim("data/2017-12-12_br-readstats.tsv") %>% 
    mutate(anon.name = sub('^.+/(BR\\d\\d[A-H]\\d\\d).*', '\\1', filename)) %>% 
    select(-filename) %>% 
    filter(anon.name %in% filt.dis$samps) %>% 
    mutate(dodgy = ifelse(anon.name %in% dodgy, "FAIL", "PASS"),
           missing = filt.dis$miss.samp[match(filt.dis$samps, anon.name)])
str(readstats)

ggplot(readstats, aes(x=dodgy, y=bases)) +
    geom_violin(scale="count")

ggplot(readstats, aes(x=dodgy, y=missing)) +
    geom_violin(scale="count")

t.test(bases ~ dodgy, data=readstats)
t.test(missing ~ dodgy, data=readstats)
