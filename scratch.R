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




dup.acc = metadata[match(genocall.best$anon.name, metadata$anon.name),]$accession %>% 
    as.character() %>% 
    table() 
dup.acc = names(dup.acc[dup.acc>1])
dup.acc

ginspect = genocall %>% 
    filter(anon.name %in% samps) %>% 
    arrange(accession) %>% 
    filter(accession %in% dup.acc)
geno.tab = genocall %>%
    group_by(samp.group) %>% 
    summarise(accessions = paste(paste(accession, anon.name), collapse = "; ")) %>%
    as.data.frame()
write_delim(geno.tab, "out/genogrouping.txt")


hist(colSums(struct.genos, na.rm = T))
table(colSums(struct.genos, na.rm = T)==2)
hist(colSums(is.na(struct.genos))/nrow(struct.genos))