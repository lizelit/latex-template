TARGET = main

.PHONY: all clean clean-all watch

all: $(TARGET).pdf

$(TARGET).pdf: $(TARGET).tex *.tex
	latexmk $(TARGET)

watch:
	latexmk -pvc $(TARGET)

clean:
	latexmk -c $(TARGET)

clean-all:
	latexmk -C $(TARGET)
	rm -f $(TARGET).pdf
