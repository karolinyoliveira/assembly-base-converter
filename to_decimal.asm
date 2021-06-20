# # # # # # # # Conversão de parâmetros para um inteiro decimal (normalização da base)  # # # # # # # # 

    # -------- SUMÁRIO -------- #
    # t0 → base recebida 
    # t2 → endereço para comparações
    # t3 → número a ser convertido
    # t4 → guarda o endereço de 'input_number'
    # t5 → contador para conversões
# -------- ############## FUNÇÕES DE TRATAMENTO das bases ORIGINAIS ############## -------- #

# → As bases são arrays (ou strings)
# → Identifica-se a base ORIGINAL
# → Tratamento caso ORIGINAL = FINAL
# → NORMALIZAÇÃO (converte para decimal)


# Base original é BINÁRIA
original_binary:
    # checa se é uma entrada binária válida 
    # -- O programa não aceita mais do que 32 bits para binário,
    # então não há necessidade de checar aqui
    verify_binary:
        
        # -- Checa se é um número positivo!
        bltz $a1, print_error_message # input_number < 0

        li $t9, 0 #contador
        
        vb_loop:
        lb   $t9, 0($a1)        # acessa um byte de 'aux_array'
        addi $a1, $a1, 1        # aux_array++ (incrementa)
        beqz $t9, vb_continue   # nenhum byte lido (nulo), quebra o loop e continua

        # -- Checa se é composto SOMENTE de '0' ou '1'!
        li   $t2, 0
        bltu $t9, $t2, print_error_message  # input_number < '0'

        li   $t2, 1
        bltu $t2, $t9, print_error_message  # input_number > '1'

        j vb_loop # Continua o loop

    vb_continue:
        # base final é a mesma (imprime o valor sem mudanças)
        la   $t2, binary
        lb   $t2, 0($t2)
        beq  $t2, $t1, print_same_base    # t1 → é a base FINAL
        
        la   $a0, input_number   # a0 = input_number
        j    binary_to_decimal

# Base original é HEXADECIMAL
original_hexa:
    # checa se é uma entrada hexadecimal válida 
    verify_hexa:

        # -- Checa se é um número positivo!
        bltz $a1, print_error_message # input_number < 0

        # -- Checa se o número digitado não possui mais de 8 dígitos
        jal strlen
        li   $t2, 8
        bltu $t2, $t9, print_error_message # O tamanho de strlen está em $t9

        li   $t9, 0 # contador = 0

        vh_loop:
        lb   $t9, 0($a1)        # acessa um byte de 'aux_array'
        addi $a1, $a1, 1        # aux_array++ (incrementa)
        beqz $t9, vh_continue   # nenhum byte lido (nulo), quebra o loop e continua

        #-- Checa se não há caracteres invalidos
        li   $t2, 0
        bltu $t9, $t2, print_error_message  # input_number < '0'

        li   $t2, 'H'
        bltu $t2, $t9, print_error_message  # input_number > 'H'

        j vh_loop # Continua o loop

    vh_continue:
        # base final é a mesma (imprime o valor sem mudanças)
        la   $t2, hexa
        lb   $t2, 0($t2)
        beq  $t2, $t1, print_same_base    # t1 → é a base FINAL

        j    hexa_to_decimal

# Base original é DECIMAL
original_decimal:
    # checa se é uma entrada decimal válida 
    verify_decimal:
        # -- Checa se está no intervalo aceito [0, 2^32]
        bltz $a1, print_error_message # input_number < 0

        li   $t9, 4294967296
        bgtu $a1, $t9, print_error_message  # input_number > 2^32

        li   $t9, 0 # contador = 0
        vd_loop:
            lb   $t9, 0($a1)        # acessa um byte de 'aux_array'
            addi $a1, $a1, 1        # aux_array++ (incrementa)
            beqz $t9, vd_continue   # nenhum byte lido (nulo), quebra o loop e continua

            # -- Checa se é um número! 
            li   $t2, 0
            bltu $t9, $t2, print_error_message  # input_number < '0'

            li   $t2, 9
            bltu $t2, $t9, print_error_message  # input_number > '9'

    vd_continue:
        # base final é a mesma (imprime o valor sem mudanças)
        la   $t2, decimal
        lb   $t2, 0($t2)
        beq  $t2, $t1, print_same_base    # t1 → é a base FINAL

        j    decimal_to_decimal

# -------- ############## FUNÇÕES DE CONVERSÃO ############## -------- #

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
    #j    hexa_to_decimal_loop       

    hexa_to_decimal_loop:
        lb   $t3, 0($t4)
        ble  $t3, '9', convert_hexa_input     # t3 <= '9'
        addi $t3, $t3, -55                    # conversão da string em um inteiro
        blt  $t3, $zero, finish_conversion    # print int if t3 < 0
        li   $t2, 10
        blt  $t3, $t2, print_error_message
        li   $t2, 15
        bgt  $t3, $t2, print_error_message
        j    increment_hexa_input

    increment_hexa_input:
        li   $t6, 16                    # t6 = 16
        mul  $a0, $a0, $t6              # t8 = t8 * t6
        add  $a0, $a0, $t3              # a0 = a0 + t3
        addi $t4, $t4, 1                # t4++ (incrementação)
        j    hexa_to_decimal_loop

    convert_hexa_input:
        addi $t3, $t3, -48                  # converte os caracteres hexadecimais: A, B, C, D, E, F
        blt  $t3, $zero, finish_conversion  # imprime o resultado se t3 < 0
        li   $t2, 0
        blt  $t3, $t2, print_error_message
        j    increment_hexa_input




# -------- Normalização DECIMAL(array) → DECIMAL -------- #
# → Conversão da STRING DECIMAL de entrada em um INTEIRO DECIMAL

decimal_to_decimal:
    la   $t8, input_number           # guarda o endereço de 'input_number'
    li   $t5, 1                      # inicia o contador (t5 = 1)
    li   $a0, 0                      # resultado (será enviado para 'finish_conversion')
    j    decimal_to_decimal_loop

decimal_to_decimal_loop:
    lb   $t3, 0($t8)
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
    addi $t8, $t8, 1                # t4++ (incrementação)
    j    decimal_to_decimal_loop    # continua o loop
