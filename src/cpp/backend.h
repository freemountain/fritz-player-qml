#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include <QProcessEnvironment>
#include <QString>

class Backend : public QObject
{
    Q_OBJECT
public:
    explicit Backend(QProcessEnvironment = QProcessEnvironment::systemEnvironment() ,QObject *parent = 0);

    QString getCommand(QString name);
    QString getShellCommand(QString name);
    QString getBundledCommand(QString name);
    QString getSystemCommand(QString name);

    QString getShell();
    QString getBackendPath();

    void start();
    bool waitForStarted();
private:
    QProcessEnvironment env;
    QProcess *proc;
    bool running;

signals:

private slots:
    void kill();
public slots:
    void close();
};

#endif // BACKEND_H
