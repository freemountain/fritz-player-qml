#ifndef CMDCLIENT_H
#define CMDCLIENT_H

#include <QObject>


#include <QtCore/QObject>
#include <QtWebSockets/QWebSocket>
#include <QJsonObject>

struct Stream {
    QString url;
    QString title;
};

class CmdClient : public QObject
{
    Q_OBJECT
public:
    explicit CmdClient(const QUrl &url, bool debug = false, QObject *parent = Q_NULLPTR);

Q_SIGNALS:
    void closed();
    void onPlayer(Stream stream);
    void onSources(QVariant sources);

private Q_SLOTS:
    void onConnected();
    void onTextMessageReceived(QString message);

private:
    QWebSocket m_webSocket;
    QUrl m_url;
    bool m_debug;
};

#endif // CMDCLIENT_H
