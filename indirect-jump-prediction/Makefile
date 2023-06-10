compile = gcc -masm=intel -g

all : predictable unpredictable

predictable : predictable.s
	$(compile) -o predictable predictable.s

unpredictable : unpredictable.s
	$(compile) -o unpredictable unpredictable.s

.PHONY: clean
clean :
	rm -f predictable unpredictable
