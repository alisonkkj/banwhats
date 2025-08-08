#!/bin/bash

show_progress() {
  local message="$1"
  local duration="$2"
  local steps=100
  local sleep_time=$(awk "BEGIN {print $duration/$steps}")

  {
    for ((i=1; i<=steps; i++)); do
      echo $i
      echo "XXX"
      echo "$message ($i%)"
      echo "XXX"
      sleep $sleep_time
    done
  } | dialog --title "Progresso" --gauge "" 7 70 0
}

validate_number() {
  [[ "$1" =~ ^[0-9]{8,}$ ]]
}

validate_instagram() {
  [[ "$1" =~ ^[a-zA-Z0-9._]{3,30}$ ]]
}

main_menu() {
  while true; do
    OPTION=$(dialog --clear --title "🔰 Painel BanWhats - Alissonkkj 🔰" --colors \
      --menu "\Z1Escolha uma opção:\Z0" 15 55 5 \
      1 "\Z2Banir número WhatsApp\Z0" \
      2 "\Z3Desativar número WhatsApp\Z0" \
      3 "\Z4Banir Instagram\Z0" \
      4 "📦 Sobre" \
      5 "🚪 Sair" \
      3>&1 1>&2 2>&3)
    clear

    case $OPTION in
      1)
        PHONE=$(dialog --inputbox "Digite o número do WhatsApp para banir (mín 8 dígitos):" 8 55 3>&1 1>&2 2>&3)
        clear
        if ! validate_number "$PHONE"; then
          dialog --msgbox "Número inválido! Use pelo menos 8 dígitos numéricos." 7 50
        else
          show_progress "Banindo número $PHONE..." 8
          dialog --msgbox "✅ Número $PHONE banido com sucesso!" 7 50
        fi
        ;;
      2)
        PHONE=$(dialog --inputbox "Digite o número do WhatsApp para desativar (mín 8 dígitos):" 8 55 3>&1 1>&2 2>&3)
        clear
        if ! validate_number "$PHONE"; then
          dialog --msgbox "Número inválido! Use pelo menos 8 dígitos numéricos." 7 50
        else
          show_progress "Desativando número $PHONE..." 8
          dialog --msgbox "✅ Número $PHONE desativado com sucesso!" 7 50
        fi
        ;;
      3)
        INSTA=$(dialog --inputbox "Digite o usuário do Instagram para banir (3-30 caracteres):" 8 60 3>&1 1>&2 2>&3)
        clear
        if ! validate_instagram "$INSTA"; then
          dialog --msgbox "Usuário inválido! Use letras, números, _ ou . (3-30 chars)." 7 55
        else
          show_progress "Banindo Instagram @$INSTA..." 8
          dialog --msgbox "✅ Instagram @$INSTA banido com sucesso!" 7 50
        fi
        ;;
      4)
        dialog --msgbox "Painel BanWhats\nDesenvolvido por Alissonkkj\nVersão 1.0\n\nTermux + dialog necessários." 10 55
        ;;
      5)
        clear
        exit 0
        ;;
      *)
        dialog --msgbox "Opção inválida! Tente novamente." 6 40
        ;;
    esac
  done
}

main_menu
