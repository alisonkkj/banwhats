#!/bin/bash

# banwhats.sh - Painel BanWhats com simulação de banimento
# Autor: Alissonkkj (adaptado pelo ChatGPT)
# Versão: 1.6

show_logo() {
  clear
  cat << "EOF"
 ____    _    _   _ _    _    _   _ _____ 
| __ )  / \  | \ | | |  | |  | | | | ____|
|  _ \ / _ \ |  \| | |  | |  | | | |  _|  
| |_) / ___ \| |\  | |__| |__| |_| | |___ 
|____/_/   \_\_| \_|____|_____\___/|_____|

                by alisonkkjj yt
EOF
  echo
}

input_numero() {
  while true; do
    numero=$(dialog --stdout --inputbox "Digite o número (somente números, ex: 5511999998888):" 8 50)
    if [[ "$numero" =~ ^[0-9]{10,15}$ ]]; then
      break
    else
      dialog --msgbox "Número inválido. Tente novamente." 6 40
    fi
  done
}

input_usuario() {
  while true; do
    usuario=$(dialog --stdout --inputbox "Digite o usuário do Instagram (ex: usuario123):" 8 50)
    if [[ -n "$usuario" && ! "$usuario" =~ [[:space:]] ]]; then
      break
    else
      dialog --msgbox "Usuário inválido. Não pode estar vazio ou conter espaços." 6 50
    fi
  done
}

barra_progresso() {
  {
    for ((i=0; i<=100; i++)); do
      echo $i
      sleep 1.5  # 1.5s * 100 = 150 segundos
    done
  } | dialog --gauge "Processando..." 10 60 0
}

ban_whatsapp() {
  input_numero
  barra_progresso
  dialog --msgbox "Número $numero banido no WhatsApp com sucesso!" 6 50
}

ban_instagram() {
  input_usuario
  barra_progresso
  dialog --msgbox "Usuário $usuario banido no Instagram com sucesso!" 6 50
}

while true; do
  show_logo
  opcao=$(dialog --stdout --menu "Painel BanWhats - Escolha uma opção:" 15 50 6 \
    1 "Ban WhatsApp" \
    2 "Ban Instagram" \
    3 "Sair")

  case $opcao in
    1) ban_whatsapp ;;
    2) ban_instagram ;;
    3) clear; exit 0 ;;
    *) dialog --msgbox "Opção inválida!" 5 30 ;;
  esac
done
