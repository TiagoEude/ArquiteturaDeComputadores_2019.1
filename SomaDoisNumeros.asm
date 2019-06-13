DADOS SEGMENT
    msg1 db ' + $'
    msg2 db ' = $'
    resposta db 4 ;vetor de 4 bits  
DADOS ENDS

CODIGO SEGMENT
    Assume CS:CODIGO,DS:DADOS
    Org 100H
    
Entrada: JMP SOMANDO

SOMANDO PROC NEAR
    
    MOV AX,DADOS
    MOV DS,AX       ;inicializacao do segmento de dados

    CALL Lertecla   ;le o numero e salva em AL
    MOV BH,AL       ;salva em BH
    
    CALL Lertecla   ;le o numero e salva em AL
    MOV BL,AL       ;salva em BL
    
    MOV AH,09
    MOV DX, OFFSET msg1
    INT 21H         ;mosta na tela o conteudo de msg1
    
    CALL Lertecla   ;le o numero e salva em AL
    MOV CH,AL       ;salva em CH
    
    CALL Lertecla   ;le o numero e salva em AL
    MOV CL,AL       ;salva em CL
    
    CALL SOMA
    
    MOV AH,09
    MOV DX, OFFSET msg2
    INT 21H         ;mosta na tela o conteudo de msg2
    
    MOV DL,resposta+2
    CALL Mostrarchar ;imprime na tela a centena
    
    MOV DL,resposta+3
    CALL Mostrarchar ;imprime na tela a dezena
    
    MOV DL,resposta+4
    CALL Mostrarchar ;imprime na tela a unidade
    
    INT 20
SOMANDO ENDP

Lertecla PROC NEAR
    MOV AH,01
    INT 21H
    RET
Lertecla ENDP

SOMA PROC NEAR
    
    ADD BL,CL   ;SOMA DAS UNIDADES
    MOV AH,0    ;zera o AH para evitar falhas de ajuste
    MOV AL,BL   ;move BL pra AL pois AL ser? usado como registrador padrao de ajuste para decimal
    AAA         ;ajuste para decimal - exclusivamente no registrador AL
   
    MOV DX,AX    ;salva o resultado em DX para ser convertido para ASCII 
    ADD DX,3030H ;converte para ASCII
    MOV resposta+4,DL ;salva o resultado da soma das unidades no vetor resposta (posicao 4)
   
    MOV BL,DH    ;salva em BL o valor do [vai 1] resultante da soma das unidades
   
    ADD BH,CH    ;SOMA DAS DEZENAS
    MOV AH,0     ;zera o AH para evitar falhas de ajuste
    MOV AL,BH    ;move BL pra AL pois AL ser? usado como registrador padrao de ajuste para decimal
    AAA          ;ajuste para decimal - exclusivamente no registrador AL
   
    MOV DX,AX    ;salva o resultado em DX para ser convertido para ASCII 
    ADD DX,3030H  ;converte para ASCII
    MOV resposta+3,DL ;salva o resultado da soma das dezenas no vetor resposta (posicao 3)
    
    MOV CH,DH    
   
    ADD BL,resposta+3 ;soma a soma das dezenas com o [vai 1] das unidades
    MOV AH,0     ;zera o AH para evitar falhas de ajuste 
    MOV AL,BL    ;move BL pra AL pois AL ser? usado como registrador padrao de ajuste para decimal
    AAA          ;ajuste para decimal - exclusivamente no registrador AL
    
    MOV DX,AX    ;salva o resultado em DX para ser convertido para ASCII 
    ADD DX,3030H  ;converte para ASCII
    MOV resposta+3,DL ;pega a parte baixa (dezena) e salva no vetor resposta (posicao 3)
    MOV resposta+2,CH ;pega o restante da soma de dezena (centena) e salva no vetor resposta (posicao 2)
    RET
SOMA ENDP
    
Mostrarchar PROC NEAR
    MOV AH,02
    INT 21H
    RET
Mostrarchar ENDP

Codigo ENDS
END Entrada