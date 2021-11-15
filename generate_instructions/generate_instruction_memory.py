from typing import List
import re

opcodes = {
    'lw': '010101',
    'add': '100100',
    'sw': '010100',
    'sub': '101100'
}

type = {
    'lw': 'I',
    'sw': 'I',
    'add': 'R',
    'sub': 'R'
}

# parse instructions into 2D array of lowercase, comma-less tokens
with open('./generate_instructions/instructions.s', 'r') as instr_file:
    instr_list = [ [ token.replace(',', '').lower() for token in line[0:-1].split(' ')] for line in instr_file.readlines()]



def reg2bin(reg_str: str) -> str:
    return format(int(reg_str[1:]), "05b")

# returns 2s complement
def int2bin(num_str: str, num_len: int) -> str:
    num = int(num_str)
    if num < 0:
        num *= -1
        num ^= (1 << num_len) - 1
        num += 1
    return format(num, "0%db" % num_len)

def i_type(instr: List[str]) -> str:
    imm_rs_regex = re.compile("(-?\d+)\((x\d+)\)").search(instr[2])
    imm = int2bin(imm_rs_regex.group(1), 16)
    rs = reg2bin(imm_rs_regex.group(2))
    rt = reg2bin(instr[1])
    machine_instr = "32'b%s_%s_%s_%s" % (opcodes[instr[0]], rs, rt, imm)
    return machine_instr


def r_type(instr: List[str]) -> str:
    rd = reg2bin(instr[1])
    rs = reg2bin(instr[2])
    rt = reg2bin(instr[3])
    machine_instr = "32'b%s_%s_%s_%s_%s" % (opcodes[instr[0]], rs, rt, rd, 11*'0')
    return machine_instr


def parse_instruction(instr: List[str]) -> str:
    instr_type = type[instr[0]]
    if instr_type == 'I' and len(instr) == 3:
        return i_type(instr)
    elif instr_type == 'R' and len(instr) == 4:
        return r_type(instr)
    
    return 'Unrecognized Instruction'


for instruction_line in instr_list:
    print("%-20s %s" % (" ".join(instruction_line), parse_instruction(instruction_line)))