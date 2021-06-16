# # # # # # # # Conversão de um INTEIRO DECIMAL para uma base de saída  # # # # # # # # 

    # -------- SUMÁRIO -------- #
    # t0 → base recebida 
    # t2 → endereço para comparações
    # t3 → número a ser convertido
    # t4 → guarda o endereço de 'input_number'
    # t5 → contador para conversões
    

# -------- Conversão BINÁRIO → DECIMAL -------- #

final_binary:
    li   $t0, 2              # t0 = 2 (divisor BINÁRIO)
    la   $a1, aux_array      # carrega o endereço de output_result em uma variável auxiliar
    j    decimal_to_binary

decimal_to_binary:




# -------- Conversão DECIMAL → HEXA -------- #

final_hexa:
    li   $t0, 16             # t0 = 16 (divisor HEXADECIMAL)
    la   $a1, aux_array      # carrega o endereço de output_result em uma variável auxiliar
    j    decimal_to_hexa

decimal_to_hexa: 

