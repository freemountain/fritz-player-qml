#include <QQmlApplicationEngine>
#include <QApplication>
#include <QtGui/QGuiApplication>
#include <QObject>

#include <QtDebug>

#include <VLCQtCore/Common.h>
#include <VLCQtQml/QmlVideoPlayer.h>
#include <VLCQtQml/QmlPlayer.h>
#include <VLCQtQml/QmlVideoOutput.h>

#include <QQuickStyle>
#include "backend.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    QQuickStyle::setStyle("Material");

    QQmlApplicationEngine engine;
    Backend backend;

    engine.load(QUrl("qrc:/src/qml/main.qml"));

    QStringList vlcArgs;
    vlcArgs << "--intf=dummy"
              << "--no-media-library"
              << "--no-stats"
              << "--no-osd"
              << "--loop"
              << "--network-caching=10000"
              << "--no-video-title-show"
#if defined(Q_OS_DARWIN)
              << "--vout=macosx"
#endif
              << "--drop-late-frames";

    QString vlcArgsStr = vlcArgs.join(" ");
    qputenv("VLC_ARGS", vlcArgsStr.toLocal8Bit());

    VlcCommon::setPluginPath(app.applicationDirPath() + "/plugins" );
    VlcQmlPlayer::registerUserData();
    VlcQmlVideoOutput::registerUserData();

    QObject::connect(&app, SIGNAL(aboutToQuit()), &backend, SLOT(close()));

    qDebug() << "node:" << backend.getCommand("node");
    qDebug() << "backend:" << backend.getBackendPath();
    qDebug() << "libvlcArg:" << VlcCommon::args();

    backend.start();

    if (!backend.waitForStarted()) {
           qDebug() <<"Could not start backend";
    }

    return app.exec();
}
