#include "dbadapter.h"

#include <QtSql>
#include <QSqlQueryModel>
#include <QDir>

static dbAdapter *dbAdapterInstance = 0;

dbAdapter::dbAdapter(QObject *parent) : QObject(parent)
{
    QString db_dir = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
    QMutexLocker locker(&lock);
    db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName(db_dir+"/db.sqlite");

    //Проверяем наличие дирректории
    QDir dir(db_dir);
    if(!dir.exists())
    {
        dir.mkpath(db_dir);
    }

    //Проверяем наличие базы
    if(!db.open())
    {
          qDebug() << "CAN`T OPEN DB: " << db.lastError().driverText();
    }

    query = QSqlQuery(db);

    if(QFile(db_dir+"/db.sqlite").size() == 0)
    {
        initDB();
    }
}

dbAdapter::~dbAdapter()
{
    db.close();
}

dbAdapter& dbAdapter::instance(){
    static QMutex mutex;
    QMutexLocker locker(&mutex);
    if(!dbAdapterInstance) dbAdapterInstance = new dbAdapter();
    return *dbAdapterInstance;
}

void dbAdapter::initDB()
{
    db.exec("CREATE TABLE `tasks` (`id` INTEGER PRIMARY KEY AUTOINCREMENT,`create_timestamp` NUMERIC NOT NULL,`body` TEXT)");
    emit baseCreate();
}
