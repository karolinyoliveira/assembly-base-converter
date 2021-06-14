# # # # # # # # BIBLIOTECA DE FUNÇÕES PARA CONVERSÃO DE BASE # # # # # # # #
    
    # -------- SUMÁRIO -------- #
    # t0 → base recebida 
    # t2 → endereço para comparações
    # t3 → número a ser convertido
    # t4 → guarda o endereço de 'input_number'
    # t5 → contador para conversões


# -------- Tratamento das bases originais -------- #
# → As bases são arrays (ou strings)
# → Aqui, assume-se que a base final é sempre a decimal

# Base original é BINÁRIA
original_binary:
    # base final é a mesma (imprime o valor sem mudanças)
    la   $t2, binary
    lb   $t2, 0($t2)
    beq  $t2, $t1, same_base    
    la   $a0, input_number

    j    binary_to_decimal

# Base original é HEXADECIMAL
original_hexa:
    # base final é a mesma (imprime o valor sem mudanças)
    la   $t2, hexa
    lb   $t2, 0($t2)
    beq  $t2, $t1, same_base

    j    hexa_to_decimal

# Base original é DECIMAL
original_decimal:
    # base final é a mesma (imprime o valor sem mudanças)
    la   $t2, decimal
    lb   $t2, 0($t2)
    beq  $t2, $t1, same_base

    j    decimal_to_decimal


# ------- Funções que realizam a conversão de bases ------- #

# Conversão DECIMAL → BINÁRIO
final_binary:
    li   $t0, 2              # t0 = 2 (divisor)
    la   $a1, aux_array      # load outputArrayAddress
    j    decimal_to_value

# Conversão DECIMAL → HEXA 
final_hexa:
    li   $t0, 16             # load t0 with 16 to divide
    la   $a1, aux_array      # load outputArrayAddress
    j    decimal_to_hexa

# ??? ainda não sei se é necessário (por conta das funções de normalizar)
final_decimal:

decimal_to_hexa: 

decimal_to_value:


# Normaliza a base original, convertendo ela para um inteiro decimal
.include "normalize_base.asm"
