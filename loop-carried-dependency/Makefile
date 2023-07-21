compile = gcc -masm=intel -g

all : minimal-loop 1-chain 1-1-chains 1-3-chains

minimal-loop : minimal-loop.s
	$(compile) -o minimal-loop minimal-loop.s

1-chain : 1-chain.s
	$(compile) -o 1-chain 1-chain.s

1-1-chains : 1-1-chains.s
	$(compile) -o 1-1-chains 1-1-chains.s

1-3-chains : 1-3-chains.s
	$(compile) -o 1-3-chains 1-3-chains.s

.PHONY: clean
clean :
	rm -f minimal-loop 1-chain 1-1-chains 1-3-chains
