#include "File.h"
#include <QDate>
#include <QTextStream>
#include <QDebug>
#define DATA QString("./data_")
#define CSV QString(".csv")

File::File(QObject *parent) :
    QObject(parent)
  , file(DATA + QString::number(QDate::currentDate().month()) + CSV)
  , out()
{

}

QList<QString> File::read()
{
    file.open(QIODevice::ReadOnly);
    QList<QString> list;
    QTextStream in(&file);
    QString line = in.readLine();
    while (!line.isNull()) {
        list << line;
        line = in.readLine();
    }
    file.close();
    return list;
}

void File::ready()
{
    file.open(QIODevice::WriteOnly | QIODevice::Truncate);
    out.setDevice(&file);
}

void File::write(QString s)
{
    out << s;
}

void File::closeFile()
{
    file.close();
}
