compile = gcc -masm=intel -g

all : sequential random

sequential : sequential.s
	$(compile) -o sequential sequential.s

random : random.s
	$(compile) -o random random.s

.PHONY: clean
clean :
	rm -f sequential random
