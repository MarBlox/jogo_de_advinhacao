#!/bin/bash

numero=$((RANDOM % 100 + 1))
palpite=0
tentativa=1
maior=150
menor=1

ren1=^[0-3]$
ren=^[0-9]+$
rem=^[A-Z][a-z]+$

echo "Olá bem-vindo ao jogo criado por Marco Melo"
echo "Escolha uma opção"

while true
do 
    echo "1 - Ver os resultados dos outros jogadores"
    echo "2 - Modo fácil - 1 a 100 com 20 tentativas"
    echo "3 - Modo difícil - 1 a 150 com 10 tentativas"
    read opcao
    if [[ $opcao =~ $ren1 ]]; then
        if [[ $opcao -eq 1 ]]; then
            clear
            cat registo_das_vitorias.txt
            break
        elif [[ $opcao -eq 2 ]]; then
            clear
            while true; do
                echo "Qual é o seu nome?"
                read nome
                clear
                if [[ $nome =~ $rem ]]; then
                    while true; do
                        echo "Tentativa $tentativa"
                        echo "Adivinhe o número"
                        read palpite
                        clear
                        if [[ $palpite =~ $ren ]]; then
                            if (( $palpite >= 0 && $palpite <= 100 )); then
                                if [[ $tentativa -ne 20 ]]; then
                                    if [[ $palpite -eq $numero ]]; then
                                        clear
                                        echo "$nome, você ganhou! Parabéns, conseguiu em $tentativa tentativas!"
                                        echo "$nome conseguiu em $tentativa tentativas, e o número era $palpite no modo facil no dia $(date +'%Y-%m-%d') as $(date +'%H:%M:%S')" >> registo_das_vitorias.txt
                                        break
                                    elif [[ $palpite -lt $numero ]]; then
                                        clear
                                        echo "Seu palpite foi $palpite, no entanto, o número é maior."
                                    else
                                        clear
                                        echo "Seu palpite foi $palpite, no entanto, o número é menor."
                                    fi
                                    tentativa=$((tentativa + 1))
                                else
                                    clear
                                    echo "$nome, você perdeu. Excedeu o número máximo de tentativas."
                                    break
                                fi
                            else
                                echo "Número fora do intervalo 0 a 100. Tente novamente."
                            fi
                        else
                            clear
                            echo "Entrada inválida. Tente novamente com um número inteiro!"
                        fi
                    done
                    break
                else
                    clear
                    echo "Formato incorreto. Deve ser por exemplo assim: Marco"
                fi
            done
        else
            clear
            while true; do
                echo "Qual é o seu nome?"
                read nome
                clear

                if [[ $nome =~ $rem ]]; then
                    while true; do
                        echo "Tentativa $tentativa"
                        echo "Adivinhe o número"
                        read palpite1
                        clear

                        if [[ $palpite1 =~ $ren ]]; then
                            if (( $palpite1 >= 0 && $palpite1 <= 150 )); then
                                if [[ $tentativa -ne 10 ]]; then
                                    if [[ $palpite1 -eq $numero_hard ]]; then
                                        clear
                                        echo "$nome, você ganhou! Parabéns, conseguiu em $tentativa tentativas!"
                                        echo "$nome conseguiu em $tentativa tentativas, e o número era $palpite1 no mode hard no dia $(date +'%Y-%m-%d') as $(date +'%H:%M:%S')" >> registo_das_vitorias.txt
                                        break
                                    elif [[ $palpite1 -lt $numero_hard ]]; then
                                        clear
                                        menor=$((palpite1 + 1))
                                        echo "Seu palpite foi $palpite1, no entanto, o número é maior."
                                        echo "$numero_hard"
                                    else
                                        clear
                                        maior=$((palpite1 - 1))
                                        echo "Seu palpite foi $palpite1, no entanto, o número é menor."
                                        echo "$numero_hard"
                                    fi
                                    numero_hard=$((RANDOM % ($maior - $menor + 1) + $menor))
                                    tentativa=$((tentativa + 1))
                                else
                                    clear
                                    echo "$nome, você perdeu. Excedeu o número máximo de tentativas."
                                    break
                                fi
                            else
                                echo "Número fora do intervalo de 0 a 150. Tente novamente."
                            fi
                        else
                            clear
                            echo "Entrada inválida. Tente novamente com um número inteiro!"
                        fi
                    done
                    break
                else
                    clear
                    echo "Formato incorreto. Deve ser, por exemplo, assim: Marco"
                fi
            done
        fi
        break
    else
        clear
        echo "Tem de ser uma das opções que apareceu"
    fi
done
