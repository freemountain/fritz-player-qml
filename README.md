#fritz-player-qml

Qml based media player with node js backend.

## Building

### OSX
```bash
export PATH=$PATH:/path/to/Qt/5.7/clang_64/bin
export FRITZ_BACKEND=current/dir/build-deps/fritz-backend

git submodule update --init --recursive   

./tools/build_vlc-qt.sh
./tools/build_fritz-backend.sh

mkdir build
cd build
qmake ..
make
#if you want to deploy:
./../tools/deploy_mac.sh .
```
