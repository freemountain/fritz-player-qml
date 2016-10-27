TEMPLATE = app

QT += qml widgets websockets quickcontrols2
CONFIG += c++11

SOURCES += src/cpp/main.cpp \
    src/cpp/backend.cpp

HEADERS += \
    src/cpp/backend.h

RESOURCES += qml.qrc

include(dependencies/SortFilterProxyModel/SortFilterProxyModel.pri)
include(dependencies/qsyncable/qsyncable.pri)

mac: LIBS += -framework VLCQtCore -framework VLCQtWidgets -framework VLCQtQml
unix:!macx: LIBS += -lVLCQtCore -lVLCQtWidgets -lVLCQtQml

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

