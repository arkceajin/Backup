#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include "File.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<File>("Jiu", 1, 0, "JFile");
    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:///main.qml")));

    return app.exec();
}
