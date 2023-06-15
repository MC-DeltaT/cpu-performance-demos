compile = gcc -masm=intel -g

all : with-fusion without-fusion

with-fusion : with-fusion.s
	$(compile) -o with-fusion with-fusion.s

without-fusion : without-fusion.s
	$(compile) -o without-fusion without-fusion.s

.PHONY: clean
clean :
	rm -f with-fusion without-fusion
