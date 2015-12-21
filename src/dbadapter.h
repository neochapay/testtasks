#ifndef DBADAPTER_H
#define DBADAPTER_H

#include <QObject>
#include <QtSql>
#include <QSqlQueryModel>

class dbAdapter : public QObject
{
    Q_OBJECT
public:
    explicit dbAdapter(QObject *parent = 0);
    ~dbAdapter();

    static dbAdapter& instance();
    QSqlDatabase db;

    QSqlQueryModel *getTable(QString table);
private:
    QSqlQuery query;
    QMutex lock;
    void initDB();

signals:
     void baseCreate();

public slots:
};

#endif // DBADAPTER_H
