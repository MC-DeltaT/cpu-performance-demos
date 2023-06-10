compile = gcc -masm=intel -g

all : with-mov without-mov

with-mov : with-mov.s
	$(compile) -o with-mov with-mov.s

without-mov : without-mov.s
	$(compile) -o without-mov without-mov.s

.PHONY: clean
clean :
	rm -f with-mov without-mov
