CC=gcc
CFLAGS=-I.
DEPS=
OBJ=server.o
USERID=123456789
EXE_NAME=myhttpsserver



all: $(EXE_NAME)


$(EXE_NAME): $(OBJ)
	echo "Building $(EXE_NAME)"
	$(CC) -o $(EXE_NAME) $^ $(CFLAGS)

%.o: %.c $(DEPS)
	echo "Building $@"
	$(CC) -c -o $@ $< $(CFLAGS)
	
clean:
	echo "Cleaning up"
	rm -rf *.o $(EXE_NAME) *.tar.gz

run: $(EXE_NAME)
	echo "Killing existing $(EXE_NAME) processes"
	ps -ef | grep $(EXE_NAME) | grep -v grep | awk '{print $$2}' | xargs kill -9
	ifconfig | grep inet | grep 192
	echo "staart $(EXE_NAME) on port 80"
	sudo ./$(EXE_NAME) 80
	

dist: tarball
tarball: clean
	tar -cvzf /tmp/$(USERID).tar.gz --exclude=./.vagrant . && mv /tmp/$(USERID).tar.gz .