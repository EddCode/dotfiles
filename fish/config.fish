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

