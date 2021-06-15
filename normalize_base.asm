# # # # # # # # Conversão de parâmetros para um inteiro decimal (normalização da base)  # # # # # # # # 

    # -------- SUMÁRIO -------- #
    # t0 → base recebida 
    # t2 → endereço para comparações
    # t3 → número a ser convertido
    # t4 → guarda o endereço de 'input_number'
    # t5 → contador para conversões


# -------- Normalização BINÁRIO → DECIMAL -------- #
binary_to_decimal:
    la   $t4, input_number           # guarda o endereço de 'input_number' 
    li   $t5, 1                      # inicia o contador (t5 = 1)
    li   $a0, 0                      # resultado (será enviado para 'finish_conversion')
    j    binary_to_decimal_loop

binary_to_decimal_loop:
    lb   $t3, 0($t4)
    addi $t3, $t3, -48                  # conversão array → int
    blt  $t3, $zero, finish_conversion  # finaliza o loop quando t3 < 0
    li   $t2, 0
    blt  $t3, $t2, print_error_message
    li   $t2, 1
    bgt  $t3, $t2, print_error_message
    mul  $t3, $t3, $t5              # t3 = t3 * t5
    add  $a0, $a0, $t3              # a0 = a0 + t3
    li   $t6, 2                     # t6 = 2
    mul  $t5, $t5, $t6              # t5 = t5 * t6
    addi $t4, $t4, 1                # t4++ (incrementação)

    j    binary_to_decimal_loop     # continua o loop

# -------- Normalização HEXADECIMAL → DECIMAL -------- #
hexa_to_decimal:
    la   $t4, input_number           # guarda o endereço de 'input_number'
    li   $t5, 1                      # inicia o contador (t5 = 1)
    li   $a0, 0                      # resultado (será enviado para 'finish_conversion')
    j    hexa_to_decimal_loop       

hexa_to_decimal_loop:
    lb   $t3, 0($t4)



# -------- Normalização DECIMAL(array) → DECIMAL -------- #
decimal_to_decimal:
    la   $t4, input_number           # guarda o endereço de 'input_number'
    li   $t5, 1                      # inicia o contador (t5 = 1)
    li   $a0, 0                      # resultado (será enviado para 'finish_conversion')
    j    decimal_to_decimal_loop

decimal_to_decimal_loop:
    lb   $t3, 0($t4)
    addi $t3, $t3, -48                  # conversão array → int
    blt  $t3, $zero, finish_conversion  # finaliza o loop quando t3 < 0
    li   $t4, 0
    blt  $t3, $t4, print_error_message
    li   $t4, 9
    bgt  $t3, $t4, print_error_message
    mul  $t3, $t3, $t5              # t3 = t3 * t5
    li   $t6, 10                    # t6 = 10
    mul  $a0, $a0, $t6              # t5 = t5 * t6
    add  $a0, $a0, $t3              # a0 = a0 + t3
    addi $t4, $t4, 1                # t4++ (incrementação)
    j    decimal_to_decimal_loop    # continua o loop