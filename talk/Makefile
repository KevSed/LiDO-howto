all: clean1 compile clean2

compile:build
	@lualatex --output-directory=build presentation.tex
	@lualatex --output-directory=build presentation.tex

build:
	@mkdir -p build/

clean1:
	@rm -rf build/

clean2:
	@rm build/*.aux build/*.out build/*.nav build/*.log build/*.toc build/*.snm
	@mv build/presentation.pdf ./
