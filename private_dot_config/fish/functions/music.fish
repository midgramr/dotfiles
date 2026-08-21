function music --description "XM5: LDAC, mic off"
    pactl set-card-profile bluez_card.58_18_62_16_3B_E9 a2dp-sink; and echo "🎵 LDAC (mic off)"
end
