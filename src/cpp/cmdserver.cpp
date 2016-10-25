#include "cmdserver.h"
#include "QtWebSockets/qwebsocketserver.h"
#include "QtWebSockets/qwebsocket.h"
#include <QtCore/QDebug>

QT_USE_NAMESPACE

CmdServer::CmdServer(quint16 port, bool debug, QObject *parent) :
    QObject(parent),
    m_pWebSocketServer(new QWebSocketServer(QStringLiteral("Echo Server"),
                                            QWebSocketServer::NonSecureMode, this))
   // m_clients(),
    //m_debug(debug)
{
    if (m_pWebSocketServer->listen(QHostAddress::Any, port)) {
        qDebug() << "Echoserver listening on port" << port;
        connect(m_pWebSocketServer, &QWebSocketServer::newConnection, this, &CmdServer::onNewConnection);
        connect(m_pWebSocketServer, &QWebSocketServer::closed, this, &CmdServer::closed);
    }
}

CmdServer::~CmdServer()
{
    m_pWebSocketServer->close();
}

void CmdServer::onNewConnection()
{
    QWebSocket *pSocket = m_pWebSocketServer->nextPendingConnection();

    connect(pSocket, &QWebSocket::textMessageReceived, this, &CmdServer::processTextMessage);
    //connect(pSocket, &QWebSocket::binaryMessageReceived, this, &EchoServer::processBinaryMessage);
    connect(pSocket, &QWebSocket::disconnected, this, &CmdServer::socketDisconnected);

    //m_clients << pSocket;
}

void CmdServer::processTextMessage(QString message)
{
    emit setUrl(message);
    qDebug() << "Set url" << message;
}

void CmdServer::socketDisconnected()
{
    /*QWebSocket *pClient = qobject_cast<QWebSocket *>(sender());
    if (m_debug)
        qDebug() << "socketDisconnected:" << pClient;
    if (pClient) {
        m_clients.removeAll(pClient);
        pClient->deleteLater();
    }*/
}
