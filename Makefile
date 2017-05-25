
all: crester

crester: main.o
	gcc -lm -o crester src/main.o src.lib.o

main.o: src/main.c src/lib.o libulfius.so
	gcc -I . -O -c src/main.c

lib.o: src/lib.c src/lib.h
	gcc -O -c src/lib.c

libulfius.so:
	git clone https://github.com/babelouest/ulfius &&	cd ulfius/src && make debug CURLFLAG=-DU_DISABLE_CURL

clean:
	rm **/*.o
