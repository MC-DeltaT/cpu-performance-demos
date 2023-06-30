compile = gcc -masm=intel -g

superscalar : superscalar.s
	$(compile) -o superscalar superscalar.s

.PHONY: clean
clean :
	rm -f superscalar
