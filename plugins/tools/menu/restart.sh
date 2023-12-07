#!/bin/bash

# READ AUTH
if [ -f "/root/TELEXWRT/AUTH" ]; then
    IFS=$'\n' read -d '' -r -a lines < "/root/TgBotWRT/AUTH"
    if [ "${#lines[@]}" -ge 2 ]; then
        BOT_TOKEN="${lines[0]}"
        CHAT_ID="${lines[1]}"
    else
        echo "Berkas auth harus memiliki setidaknya 2 baris (token dan chat ID Anda)."
        exit 1
    fi
else
    echo "Berkas auth tidak ditemukan."
    exit 1
fi

# Buat pesan notifikasi
MSG="bot success to restar"

# Kirim pesan notifikasi ke bot Telegram
curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" -d "chat_id=$CHAT_ID" -d "text=$MSG"

service edy restart
