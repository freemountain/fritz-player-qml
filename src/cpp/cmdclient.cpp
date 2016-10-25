#include "CmdClient.h"
#include <QtCore/QDebug>
#include <QJsonDocument>
#include <QJsonObject>

QT_USE_NAMESPACE

CmdClient::CmdClient(const QUrl &url, bool debug, QObject *parent) :
    QObject(parent),
    m_url(url),
    m_debug(debug)
{
    if (m_debug)
        qDebug() << "WebSocket server:" << url;
    connect(&m_webSocket, &QWebSocket::connected, this, &CmdClient::onConnected);
    connect(&m_webSocket, &QWebSocket::disconnected, this, &CmdClient::closed);
    m_webSocket.open(QUrl(url));
}

void CmdClient::onConnected()
{
    if (m_debug)
        qDebug() << "WebSocket connected";
    connect(&m_webSocket, &QWebSocket::textMessageReceived,
            this, &CmdClient::onTextMessageReceived);
    //m_webSocket.sendTextMessage(QStringLiteral("Hello, world!"));
}

void CmdClient::onTextMessageReceived(QString message)
{
     QJsonDocument doc = QJsonDocument::fromJson(message.toUtf8());
     QJsonObject msg = doc.object();
     QString topic = msg.value("topic").toString();
     QJsonObject data = msg.value("data").toObject();

     if(topic == "player") {
         Stream stream;
         stream.title = data.value("title").toString();
         stream.url = data.value("url").toString();

         qDebug() << "onPlayer: " <<stream.url;
         emit onPlayer(stream);
     }

     if(topic == "player") {
         qDebug() << "oSources: " <<data;
         emit onSources(QVariant(data));
     }

}
