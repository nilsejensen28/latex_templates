SHELL=/bin/bash

path=Examples

files = letter_example.tex contract_example.tex labels_example.tex

pdf:
	mkdir -p build
	for file in $(files); do \
		filename=$$(basename $$file .tex); \
		latexmk -lualatex  -interaction=nonstopmode -file-line-error --shell-escape -f -outdir=build ${path}/$$filename.tex; \
		mv build/$$filename.pdf ./Examples/$$filename.pdf; \
	done

clean:
	rm -f -r build