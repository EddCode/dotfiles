function java17
    set -x JAVA_HOME (brew --prefix openjdk@17)/libexec/openjdk.jdk/Contents/Home
    echo "Switched to Java 17"
end

function java21
    set -x JAVA_HOME (brew --prefix openjdk@21)/libexec/openjdk.jdk/Contents/Home
    echo "Switched to Java 21"
end

function java22
    set -x JAVA_HOME (brew --prefix openjdk@22)/libexec/openjdk.jdk/Contents/Home
    echo "Switched to Java 22"
end

set -x JAVA_HOME (brew --prefix openjdk@21)/libexec/openjdk.jdk/Contents/Home

# Zenventory app environment variables
set -x ZENVENTORY_FIREBASE_APP_ID marelyn-c5407 #1:1083998552847:web:eb1bbcbb80cb4cd430347a
set -x ZENVENTORY_FIREBASE_SETTING_FILE /Users/edgarfigueroa/Projects/NirvanaCodeZen/firebaseSDK/marelyn-firebase-adminsdk.json

# ANDROID
set -x ANDROID_HOME /opt/android_sdk
set -x ANDROID_SDK_ROOT /opt/android_sdk


function duck -d "Search DuckDuckGo from the terminal"
    echo $argv
    function urlencode
        echo $argv | sed 's/ /%20/g'
    end

echo $argv
    set url "https://lite.duckduckgo.com/lite?kd=-1&kp=-1&q=$argv"
    exec lynx $url
end

function g -d "Search Google from the terminal"
    echo $argv
    function urlencode
        echo $argv | sed 's/ /%20/g'
    end

    set url "https://www.google.com/search?q=$argv"
    exec lynx $url
end

fastfetch
