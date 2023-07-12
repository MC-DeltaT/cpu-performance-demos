compile = gcc -masm=intel -g

all : same-register diff-register true-dep

same-register : same-register.s
	$(compile) -o same-register same-register.s

diff-register : diff-register.s
	$(compile) -o diff-register diff-register.s

true-dep : true-dep.s
	$(compile) -o true-dep true-dep.s

.PHONY: clean
clean :
	rm -f same-register diff-register true-dep
