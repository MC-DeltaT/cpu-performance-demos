compile = gcc -masm=intel -g

all : minimal-loop counter-loop 1-chain 4-chain multiple-chains

minimal-loop : minimal-loop.s
	$(compile) -o minimal-loop minimal-loop.s

counter-loop : counter-loop.s
	$(compile) -o counter-loop counter-loop.s

1-chain : 1-chain.s
	$(compile) -o 1-chain 1-chain.s

4-chain : 4-chain.s
	$(compile) -o 4-chain 4-chain.s

multiple-chains : multiple-chains.s
	$(compile) -o multiple-chains multiple-chains.s

.PHONY: clean
clean :
	rm -f minimal-loop counter-loop 1-chain 4-chain multiple-chains
