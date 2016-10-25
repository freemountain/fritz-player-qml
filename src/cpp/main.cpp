#include <QQmlApplicationEngine>
#include <QApplication>
#include <QtGui/QGuiApplication>
#include <QObject>

#include <QtDebug>
#include <QProcessEnvironment>

// #include "prefix-deps/lib/VLCQtCore.framework/Headers/Common.h"
// #include "prefix-deps/lib/VLCQtQml.framework/Headers/QmlVideoPlayer.h"
// #include "prefix-deps/lib/VLCQtQml.framework/Headers/QmlPlayer.h"

#include <VLCQtCore/Common.h>
#include <VLCQtQml/QmlVideoPlayer.h>
#include <VLCQtQml/QmlPlayer.h>

#include <QQuickStyle>
#include <QProcess>
#include <QFileInfo>
#include "cmdserver.h"
#include "cmdclient.h"
#include "backend.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    QQuickStyle::setStyle("Material");

    Backend* backend = new Backend();

    qDebug() << "node:" << backend->getCommand("node");
    qDebug() << "backend:" << backend->getBackendPath();

    backend->start();

    if (!backend->waitForStarted()) {
            qDebug() <<"could not start backend";
           return false;
    }

    QQmlApplicationEngine engine;
    engine.load(QUrl("qrc:/src/qml/main.qml"));
    QObject::connect(&app, SIGNAL(aboutToQuit()), backend, SLOT(close()));
    VlcCommon::setPluginPath(app.applicationDirPath() + "/plugins" );
    VlcQmlVideoPlayer::registerPlugin();
    VlcQmlPlayer::registerUserData();

    return app.exec();
}
