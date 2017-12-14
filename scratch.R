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
