# Makefile script with commands to generate the benchmark assembly and binaries.
# Description of the targets:
# x86-ptc: produce lazart object files with oracle PTC
# x86-auth: produce lazart object files with oracle AUTH
# clean: clean generated files, including output binaries

.PHONY: clean x86-ptc x86-auth

TARGET = verifypin_0
FILES = src/countermeasure.c src/initialize.c src/oracle.c src/code.c src/main.c

INC_DIR = -I../share -Iinclude
BIN_DIR = bin

CFLAGS = $(INC_DIR) -Wall -Wextra

x86-auth:
	@mkdir -p $(BIN_DIR)
	@clang -DAUTH $(FILES) $(CFLAGS) -o $(BIN_DIR)/$(TARGET)

x86-ptc:
	@mkdir -p $(BIN_DIR)
	@clang -DPTC $(FILES) $(CFLAGS) -o $(BIN_DIR)/$(TARGET)

clean: 
	@rm -rf $(BIN_DIR) 
