TEMPLATE = app

QT += qml widgets websockets quickcontrols2
CONFIG += c++11

SOURCES += src/cpp/main.cpp \
    src/cpp/cmdclient.cpp \
    src/cpp/backend.cpp

HEADERS += \
    src/cpp/cmdclient.h \
    src/cpp/backend.h

RESOURCES += qml.qrc

mac: LIBS += -framework VLCQtCore -framework VLCQtWidgets -framework VLCQtQml

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
