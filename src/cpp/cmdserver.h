#ifndef ECHOSERVER_H
#define ECHOSERVER_H

#include <QtCore/QObject>
#include <QtCore/QVariant>
#include <QtCore/QList>
#include <QtCore/QByteArray>

QT_FORWARD_DECLARE_CLASS(QWebSocketServer)
QT_FORWARD_DECLARE_CLASS(QWebSocket)

class CmdServer : public QObject
{
    Q_OBJECT
public:
    explicit CmdServer(quint16 port, bool debug = false, QObject *parent = Q_NULLPTR);
    ~CmdServer();

//Q_SIGNALS:

signals:
  void setUrl(QVariant text);
  void closed();

private Q_SLOTS:
    void onNewConnection();
    void processTextMessage(QString message);
    // void processBinaryMessage(QByteArray message);
    void socketDisconnected();

private:
    QWebSocketServer *m_pWebSocketServer;
    // QList<QWebSocket *> m_clients;
    // bool m_debug;
};

#endif //ECHOSERVER_H
