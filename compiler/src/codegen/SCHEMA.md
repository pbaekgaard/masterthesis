# SCHEMA for metadata in codegen
after .word:
0x10000000 @ int_val = stmt,
0xa+pcstart = start pc,
0xb+pcend   = endpc,
0x00000001 @ var_name = assignment,
0x00000002 @ cond = if-statement,
0x00000003 @ neg_cond = else,
0xffffffff = end_of_metadata 


# example
.word 0x10000000 @ 0
.word 0xa+1
.word 0xb+3
.word 0x00000001 @ auth
.word 0xffffffff
