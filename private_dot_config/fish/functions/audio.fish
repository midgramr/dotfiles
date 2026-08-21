function audio --description "Show active BT audio profile"
    pactl list cards | grep -E "Name: bluez|Active Profile"
end
