# Makefile script with commands to generate the benchmark assembly and binaries.
# Description of the targets:
# x86-rsa: produce lazart object files
# clean: clean generated files, including output binaries

.PHONY:  clean x86-rsa

TARGET = crt-rsa

FILES = src/countermeasure.c src/initialize.c  src/main.c src/oracle.c src/crt-rsa.c
FILES_INLINE = src/countermeasure.c src/initialize.c  src/main.c

INC_DIR = -I ../share -Iinclude
BIN_DIR = bin

CFLAGS = $(INC_DIR)-Wall -Wextra

x86-rsa:
	@mkdir -p $(BIN_DIR)
	@clang  -DMAKE_Rsa $(FILES) $(CFLAGS) -o $(BIN_DIR)/$(TARGET)

clean: 
	@rm -rf $(BIN_DIR) 
