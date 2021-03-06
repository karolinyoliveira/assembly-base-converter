# # # # # # # # BIBLIOTECA DE FUNÇÕES AUXILIARES # # # # # # # #

    # -------- SUMÁRIO -------- #
    # t0 → base ORIGINAL
    # t1 → base FINAL
    # t2 → endereço para comparações
    # t3 → número a ser convertido
    # t4 → guarda o endereço de 'input_number'
    # t5 → contador para conversões


# ✤ -------- Funções de IMPRESSÃO -------- ✤ #

# Imprime um '\n' (quebra de linha)
print_newline:              
    la   $a0, newline       # carrega o endereço de newline ('\n')
    li   $v0, 4             
    syscall
    jr   $ra                # return


# Realiza a impressão de uma string
print_string:
    li   $v0, 4             
    syscall
    jr   $ra                # return


# Imprime uma mensagem de erro
print_error_message:
    la   $a0, invalid_input_text    # carrega o endereço da mensagem de erro
    jal  print_string
    j    exit                       # interrompe a execução do programa

# Imprime uma mensagem de erro (caso a base inserida seja inválida)
invalid_base:
    la   $a0, invalid_base_text
    jal  print_string
    j exit

# Se as bases forem iguais, imprime o mesmo resultado, sem modificações
print_same_base:
    la   $a0, output_result_text    # carrega o endereço da mensagem de saída
    jal  print_string
    la   $a0, input_number          # carrega o endereço do número de input (não é necessário converter)
    jal  print_string
    j    exit
        

# ✤ -------- Funções de SAÍDA DO PROGRAMA -------- ✤ #

# Recebe o número decimal (em $a0) e o imprime
output_integer:             
    move $a1, $a0                   # guarda o valor de $a0 em $a1 (auxiliar)
    la   $a0, output_result_text    # carrega ["O novo valor obtido é: "]
    jal  print_string               # chamada do método 'print_string'

    move $a0, $a1                   # input_number = 0
    li   $v0, 1                     # print_string syscall code = 4
    syscall
    j    exit

# Imprime um valor número representado por uma string 
# Utilizado para exibir o valor de bases BINÁRIAS e HEXADECIMAIS
output_string:
    la   $a0, output_result_text   # carrega ["O novo valor obtido é: "]
    jal  print_string              # chamada do método 'print_string'

    la   $a0, output_result
    jal  print_string              # chamada do método 'print_string'
    j    exit

# ✤ -------- Funções de LEITURA -------- ✤ #

# Realiza a leitura da string de base
read_base_input:
    li   $v0, 12            # read_string syscall code = 8
    syscall
    jr   $ra                # return


# Realiza a leitura de um número (inteiro positivo)
read_input_number:
    la   $a0, input_number      # carrega o endereço de input_number para $a0
    li   $v0, 8                 # read_string syscall code = 8            
    li   $a1, 32                # aloca espaço para input_original_base
    syscall
    jr   $ra                    # return


# Retorna o tamanho de uma string em $t9
# Recebe $a1 → aux_array
# Retorna o tamanho em $t9
strlen:
    li $t6, 0 # contador = 0
    li $t7, 0
    loop:
        lb $t7, 0($a1)   # carrega 1-byte de $a1 em $t3
        beqz $t7, return # checa se está no final do array
        addi $a1, $a1, 1 # a1++
        addi $t6, $t6, 1 # t6++
        j loop # Continua o loop

    jr $ra


# ✤ -------- Funções da APLICAÇÃO -------- ✤ #

# Interrompe a execução da aplicação
exit:
    jal print_newline
    li   $v0, 10         # exit
    syscall


# Retorna o último endereço salvo
return:
    jr  $ra             # $ra = return address      


# ✤ -------- Funções de manipulação de arrays -------- ✤ #

# Copia um valor ($a0) para o array auxiliar ($a1)
copy_to_aux:
    la   $a1, aux_array
    j    copy_loop

    copy_loop:
        lb   $t9, 0($a0)
        beq  $t9, $zero, return
        sb   $t9, 0($a1)
        addi $a0, $a0, 1
        addi $a1, $a1, 1
        j    copy_loop


# Inverte um array. Utilizado para as obter as
# strings de resultado em HEXADECIMAL e BINÁRIO
# -- a0 → output_result, a1 → aux_array
transpose_array:
    la   $a0, output_result      # acessa o endereço da string de saída (o resultado da conversão)
    li   $t0, 0                  # i = 0 (aponta para a última posição)

    transpose_array_loop:
    subi $a1, $a1, 1        # aux_array-- (decrementa posição)
    lb   $t0, 0($a1)        # acessa um byte de 'aux_array'
    beqz $t0, return        # nenhum byte lido (nulo), quebra o loop e imprime o resultado
    sb   $t0, 0($a0)        # salva o caractere em 'output_result'
    addi $a0, $a0, 1        # output_result++ (incrementa posição)
    j transpose_array_loop  # continua o loop
    

