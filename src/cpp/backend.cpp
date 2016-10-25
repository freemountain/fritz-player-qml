#include "backend.h"

#include <QDebug>
#include <QCoreApplication>
#include <QFileInfo>
#include <QTimer>
Backend::Backend(QProcessEnvironment env, QObject *parent) : QObject(parent)
{
    this->env = env;
    this->proc = new QProcess();
    this->proc->setProcessChannelMode(QProcess::ForwardedChannels);
    this->running = false;

    connect(this->proc, static_cast<void(QProcess::*)(int, QProcess::ExitStatus)>(&QProcess::finished), [=](int exitCode) {
        qDebug() << "backend stopped " << exitCode;
        this->running = false;
    });
}

QString Backend::getShell() {
    return env.value("SHELL", "/bin/bash");
}

QString Backend::getBundledCommand(QString name) {
    QString binPath = QFileInfo( QCoreApplication::applicationFilePath() ).absolutePath();
    QString path = binPath + "/" + name;
    QFileInfo info = QFileInfo(path);

    if(info.exists() && info.isFile()) return path;

    return NULL;
}

QString Backend::getSystemCommand(QString name) {
    QString files[] = {"/bin/", "/usr/bin/", "/usr/local/bin/"};

    for( unsigned int i = 0; i < sizeof(files); i = i + 1 )
    {
        QString current = files[i] + name;
        QFileInfo info = QFileInfo(current);
        bool isFile = info.exists() && info.isFile();
        if(isFile) return current;
    }

    return NULL;
}

QString Backend::getCommand(QString name) {
    QString envCmd = this->env.value("FRITZ_CMD_" + name.toUpper(), NULL);

    if(envCmd != NULL) return envCmd;

    QString bundledCmd = this->getBundledCommand(name);

    if(bundledCmd != NULL) return bundledCmd;

    QString shellCmd = this->getShellCommand(name);

    if(shellCmd != NULL) return shellCmd;

    return this->getSystemCommand(name);
}

QString Backend::getShellCommand(QString name) {
    QProcess proc;
    QString cmd = "which " + name;
    proc.start(this->getShell(), QStringList() << "-c" << cmd);

    if (!proc.waitForStarted()) {
        qDebug() << "not started";
        return nullptr;
    }

    if (!proc.waitForFinished()) {
        qDebug() << "not finished";
            return nullptr;
    }

    QString result =  proc.readAll(); // contains \n
    int n = result.size() - 1;
    return result.left(n);
}

QString Backend::getBackendPath() {
    QString binPath = QFileInfo( QCoreApplication::applicationFilePath() ).absolutePath();
    QString defaultPath = binPath + "/../Resources/fritz-backend/src/server.js";

    return this->env.value("FRITZ_BACKEND", defaultPath);
}

void Backend::start() {
    this->proc->start(this->getCommand("node"), QStringList() << this->getBackendPath());
}

bool Backend::waitForStarted() {
    bool started = this->proc->waitForStarted();
    if(!started) return false;

    return true;
}

void Backend::close() {
    QTimer *timer = new QTimer(this);

    this->proc->terminate();

    connect(timer, SIGNAL(timeout()), this, SLOT(kill()));
    timer->start(100);
}

void Backend::kill() {
    this->proc->kill();
}
