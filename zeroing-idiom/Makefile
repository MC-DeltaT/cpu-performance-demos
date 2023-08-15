compile = gcc -masm=intel -g

all : zeroed-dep true-dep

zeroed-dep : zeroed-dep.s
	$(compile) -o zeroed-dep zeroed-dep.s

true-dep : true-dep.s
	$(compile) -o true-dep true-dep.s

.PHONY: clean
clean :
	rm -f zeroed-dep true-dep
