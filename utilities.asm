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
    la   $a0, input_number  # load inputBase address to argument0
    li   $v0, 8                 # read_string syscall code = 8
    li   $a1, 32                # space allocated for inputBase
    syscall
    jr   $ra                    # return


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

# Provavelmente precisarão ser feitas funções como
    # -- Inverter array
    # -- Copiar array
    # -- Loops
    # -- etc
