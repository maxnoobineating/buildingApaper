objfiles := README.md gwen.pdf gwenpdf.jpg index.html
srcfiles := gwen.html gwentext.txt gwenpic.jpg gwen.tex

SAY := echo "\033[0;31m\n"
END := "\033[0m\n"
TIME := $(shell date)

all: $(objfiles)

.PHONY: all clean

gwen.pdf: $(srcfiles)
	@$(SAY) "building pdfs..." $(END)
	@pdflatex gwen.tex

gwenpdf.jpg: gwen.pdf
	@$(SAY) "building pdf into jpg" $(END)
	@pdftoppm -jpeg gwen.pdf gwenpdf
	@rm ./gwenpdf.jpg
	@mv ./gwenpdf*.jpg ./gwenpdf.jpg

index.html: gwenpdf.jpg gwen.html
	@$(SAY) "building index.html" $(END)
	@cat gwen.html \
		| sed 's/building_template_1/$</g' \
		| sed "/building_template_2/a<p>$(TIME)</p>" \
		> index.html

README.md: index.html
	@$(SAY) "finalising README" $(END)
	@pandoc -s -f html -t markdown index.html -o README.md

clean:
	rm gwen.aux gwen.log gwen.pdf