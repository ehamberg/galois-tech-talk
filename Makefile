MD_FILE=galois-tech-talk-2013-03-12.md
BEAMER_FILE=out/galois-tech-talk-2013-03-12.tex
PDF_FILE=galois-tech-talk-2013-03-12.pdf

.PHONY: all
all:
	pandoc --to=beamer -V theme:Singapore \
		--output=galois-tech-talk-2013-03-12.pdf \
		--incremental \
		galois-tech-talk-2013-03-12.md
