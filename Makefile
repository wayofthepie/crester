
all: crester

crester: main.o
	gcc -lm -o crester src/main.o src/lib.o -lulfius -ljansson -lyder

main.o: src/main.c src/lib.o libulfius.so
	gcc  -O -c src/main.c -o src/main.o

lib.o: src/lib.c src/lib.h
	gcc -O -c src/lib.c -o src/lib.o

libulfius.so:

clean:
	rm **/*.o

install:
	cp crester $(INSTALL)
