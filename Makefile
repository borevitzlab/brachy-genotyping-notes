TARGETS = $(patsubst %.Rmd,%.html,$(shell find -name \*.Rmd -not -path \*data\*))
UPLOAD_TO = edmund.anu.edu.au:~/public_html/brachy_geno/notes/

.PHONY: all clean upload

all: $(TARGETS)

clean:
	rm -f $(TARGETS)

upload: $(TARGETS)
	scp -r $(TARGETS) out $(UPLOAD_TO)

%.html: %.Rmd
	@Rscript -e 'rmarkdown::render("$<", output_file="$(@F)", output_format="html_document")' >/dev/null
	@echo "   KNIT\t$<"
