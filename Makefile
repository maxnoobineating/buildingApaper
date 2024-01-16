objfiles := gwen.pdf gwenpdf.jpg index.html
srcfiles := gwen.html gwentext.txt gwenpic.jpg gwen.tex

SAY := echo "\033[0;31m\n"
END := "\033[0m\n"
TIME := $(date)

all: $(objfiles)

.PHONY: all clean

gwen.pdf: $(srcfiles)
	@$(SAY) "building pdfs..." $(END)
	@pdflatex gwen.tex

gwenpdf.jpg: gwen.pdf
	@$(SAY) "building pdf into jpg" $(END)
	@pdftoppm -jpeg gwen.pdf gwenpdf

index.html: gwenpdf.jpg gwen.html
	@$(SAY) "building index.html" $(END)
	@cat gwen.html \
		| sed 's/building_template_1/$</g' \
		| sed "/building_template_2/a<p>$(TIME)</p>" \
		> index.html

clean:
	rm gwen.aux gwen.log gwen.pdf