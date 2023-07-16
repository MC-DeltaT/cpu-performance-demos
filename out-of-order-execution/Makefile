compile = gcc -masm=intel -g

all : out-of-order in-order

out-of-order : out-of-order.s
	$(compile) -o out-of-order out-of-order.s

in-order : in-order.s
	$(compile) -o in-order in-order.s

.PHONY: clean
clean :
	rm -f out-of-order in-order
