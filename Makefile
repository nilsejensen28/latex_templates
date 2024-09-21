SHELL=/bin/bash

path=Examples
filename=letter_example

pdf:
	mkdir -p build
	latexmk -lualatex  -interaction=nonstopmode -file-line-error --shell-escape -f -outdir=build ${path}/${filename}.tex 
	mv build/${filename}.pdf ./Examples/${filename}.pdf

read:
	evince build/${filename}.pdf &

clean:
	rm -f -r build