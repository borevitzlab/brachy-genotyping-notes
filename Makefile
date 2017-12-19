TARGETS = $(patsubst %.Rmd,%.html,$(shell find -name \*.Rmd -not -path \*data\*))
UPLOAD_TO = edmund.anu.edu.au:~/public_html/brachy_geno/notes/
FIGSHARE_DATA= data/2017-11-30_bhybridum_filtered_default.vcf.gz

.PHONY: all clean upload

all: $(TARGETS)

data/2017-11-30_bhybridum_filtered_default.vcf.gz:
	wget -O $@  https://s3-eu-west-1.amazonaws.com/pfigshare-u-files/10039258/20171130_bhybridum_filtered_default.vcf.gz

clean:
	rm -f $(TARGETS)

upload: $(TARGETS)
	scp -r $(TARGETS) out $(UPLOAD_TO)

%.html: %.Rmd $(FIGSHARE_DATA)
	@Rscript -e 'rmarkdown::render("$<", output_file="$(@F)", output_format="html_document")' >/dev/null
	@echo "   KNIT\t$<"
