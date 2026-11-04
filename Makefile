CC = gcc
CFLAGS = -m32
ASM = nasm
ASMFLAGS = -f elf -I$(SRC)/
SRC = src

all: task1 task1_2 task2a task2b task2c

task1: $(SRC)/driver.o $(SRC)/task1.o $(SRC)/asm_io.o
	$(CC) $(CFLAGS) $^ -o task1

task1_2: $(SRC)/driver.o $(SRC)/task1_2.o $(SRC)/asm_io.o
	$(CC) $(CFLAGS) $^ -o task1_2

task2a: $(SRC)/driver.o $(SRC)/task2a.o $(SRC)/asm_io.o
	$(CC) $(CFLAGS) $^ -o task2a

task2b: $(SRC)/driver.o $(SRC)/task2b.o $(SRC)/asm_io.o
	$(CC) $(CFLAGS) $^ -o task2b

task2c: $(SRC)/driver.o $(SRC)/task2c.o $(SRC)/asm_io.o
	$(CC) $(CFLAGS) $^ -o task2c

$(SRC)/driver.o: $(SRC)/driver.c
	$(CC) $(CFLAGS) -c $(SRC)/driver.c -o $(SRC)/driver.o

$(SRC)/asm_io.o: $(SRC)/asm_io.asm
	$(ASM) $(ASMFLAGS) $(SRC)/asm_io.asm -o $(SRC)/asm_io.o

$(SRC)/%.o: $(SRC)/%.asm
	$(ASM) $(ASMFLAGS) $< -o $@

clean:
	rm -f $(SRC)/*.o task1 task1_2 task2a task2b task2c