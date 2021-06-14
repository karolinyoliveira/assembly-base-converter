# Programa criado no contexto da disciplina:
# >> SSC0902 - Organização e Arquitetura de Computadores (2021) << 

# -------- AUTORES -------- #
#  10368020 | Karoliny Oliveira
#           | Lourenço de Salles Roselino
#           | Luiz Fernando Santos
#   5588687 | Melissa Motoki Nogueira


.data
    # texts

    # → Mensagens de erro
    invalid_input_text:		 .asciiz "Entrada inválida" 

    # → Entrada de valores (para o input do usuário)
    input_number_text:       .asciiz "Digite um inteiro positivo: "
    input_original_base: 	 .asciiz "Selecione a base original (B H ou D): "
    input_final_base:	     .asciiz "Selecione a base final (B H ou D): "
    newline:                 .asciiz "\n"

    # → Saída de valores (após a conversão)
    output_result_text:     .asciiz "O novo valor obtido é: "

    # → Declaração de variáveis ("arrays") ocupando 32-bytes na memória
    input_number:		     .space 32
    output_result:	         .space 32
    aux_array:               .space 32
    
    # Definições
    .align 0        # alinha a localização atual
    .globl main

    # Tipos de base (para input do usuário)
    binary:             .byte   'B'
    decimal:            .byte   'D'
    hexa:               .byte   'H'


# código do programa
.text


main:

    # -------- LEITURA DA BASE ORIGINAL -------- #
   
    # Imprime input_original_base
	la $a0, input_original_base 
    jal print_string 

    jal read_base_input    # Leitura da base ORIGINAL	
	move $t0, $v0          # Guarda base ORIGINAL em $t0
    jal print_newline
 


    # -------- LEITURA DO NÚMERO A SER CONVERTIDO -------- #
	
    # Imprime input_number_text
    la $a0, input_number_text
    jal print_string
	
    # Lê o inteiro digitado pelo o usuário
    jal read_input_number



    # -------- LEITURA DA BASE FINAL -------- #
	
    # Imprime input_final_base
    la $a0, input_final_base
    jal print_string
	
    jal read_base_input     # Leitura da base FINAL
    move $t1, $v0           # Guarda base FINAL em $t1
    jal print_newline



    # -------- INICIA A CONVERSÃO -------- #

    # t0 → base ORIGINAL
    # t1 → base FINAL

    j start_conversion



# -------- CONVERSÕES DE BASE -------- #

# Identifica a base ORIGINAL
start_conversion:
    # t2 → endereço para comparações

    # if(t2 == 'B') → base original é BINÁRIA
    la  $t2, binary
    lb  $t2, 0($t2)
    beq $t2, $t0, original_binary

    # if(t2 == 'H') → base original é HEXADECIMAL
    la  $t2, binary
    lb  $t2, 0($t2)
    beq $t2, $t0, original_hexa

    # if(t2 == 'D') → base original é DECIMAL
    la  $t2, binary
    lb  $t2, 0($t2)
    beq $t2, $t0, original_decimal

    # else → valor de entrada para a base é INVÁLIDO
    j invalid_base


# Saída após os procedimentos de conversão
finish_conversion:                         

    # Modifica o endereço da base final para ser utilizada nas funções de conversão
    move $t0, $t1  

    # a0 → número a ser convertido (recebe das conversões de start_conversion)
    # t0 → endereço da base final 
    # t2 → endereço para comparações

    # if(t2 == 'B') → base original é BINÁRIA
    la   $t2, binary
    lb   $t2, 0($t2)
    beq  $t2, $t0, final_binary

    # if(t2 == 'H') → base original é HEXADECIMAL
    la   $t2, hexa
    lb   $t2, 0($t2)
    beq  $t2, $t0, final_hexa

    # if(t2 == 'D') → base original é DECIMAL
    la   $t2, decimal
    lb   $t2, 0($t2)
    beq  $t2, $t0, final_decimal

    # else → valor de entrada para a base é INVÁLIDO
    j invalid_base


# Funções auxiliares (utilidades)
.include "utilities.asm"

# Funções que performam a conversão entre as bases
.include "convert_functions.asm"
