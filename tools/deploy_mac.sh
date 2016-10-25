PROJECT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/../"
TARGET_APP=$1

echo $TARGET_APP

macdeployqt $TARGET_APP -qmldir=$PROJECT_PATH/src/qml
cp -r $PROJECT_PATH/build-deps/vlc-qt/src/lib/VLCQtCore.framework/Versions/Current/lib/* $TARGET_APP/Contents/Frameworks
cp -r $PROJECT_PATH/build-deps/fritz-backend $TARGET_APP/Contents/Resources
