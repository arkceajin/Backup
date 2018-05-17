#ifndef FILE_H
#define FILE_H

#include <QObject>
#include <QFile>
#include <QTextStream>
class File : public QObject
{
    Q_OBJECT
public:
    explicit File(QObject *parent = 0);

signals:
    void ready(QList<QString> data);
public slots:
    Q_INVOKABLE QList<QString> read();
    Q_INVOKABLE void ready();
    Q_INVOKABLE void write(QString);
    Q_INVOKABLE void closeFile();

private:
    QFile file;
    QTextStream out;
};

#endif // FILE_H
