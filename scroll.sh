osascript -e '
delay 3
tell application "System Events"
    tell process "DevTools Companion App"
        set frontmost to true
        repeat 20 times
            key code 125 -- down arrow
            delay 0.1
        end repeat
    end tell
end tell
'
