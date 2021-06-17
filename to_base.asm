# # # # # # # # Conversão de um INTEIRO DECIMAL para uma base de saída  # # # # # # # # 

    # -------- SUM�?RIO -------- #
    # t0 → base recebida 
    # t2 → endereço para comparações
    # t3 → número a ser convertido
    # t4 → guarda o endereço de 'input_number'
    # t5 → contador para conversões
    

# -------- Conversão BIN�?RIO → DECIMAL -------- #

final_binary:
    li   $t0, 2              # t0 = 2 (divisor BIN�?RIO)
    la $a2, output_result    # guarda o endere�o de 'output_result'
    j    decimal_to_binary

decimal_to_binary:
    div  $a0, $a0, $t0       # divide numero a ser convertido e guarda o quociente em a0
    mfhi $t6                 # guarda o resto da opera��o em t6
    addi $t6, $t6, 48        # converte pra char
    sb   $t6, ($a2)          # armazena o valor na string de output
    addi $a2, $a2, 1
    bgt  $a0, $zero, decimal_to_binary # continua o loop
    j output_string          # imprime o resultado




# -------- Conversão DECIMAL → HEXA -------- #

final_hexa:
    li   $t0, 16             # t0 = 16 (divisor HEXADECIMAL)
    la   $a1, aux_array      # carrega o endereço de output_result em uma variável auxiliar
    j    decimal_to_hexa

decimal_to_hexa: 

