#include <QDateTime>

#include "taskmodel.h"
#include "../dbadapter.h"

Task::Task(QObject *parent) : QObject(parent)
{

}

QHash<int, Task*> Task::cache;

Task* Task::toInt(int id)
{
    if(cache.contains(id))
    {
        return cache.value(id);
    }

    QSqlDatabase db = dbAdapter::instance().db;
    QSqlQuery query(db);
    query.prepare("SELECT id as task_id, create_timestamp,body FROM tasks WHERE id=:id");
    query.bindValue(":id",id);

    bool ok = query.exec();
    if(!ok)
    {
        qDebug() << query.lastQuery() << query.lastError().text();
    }
    if(query.next())
    {
        Task* task = new Task();
        task->id = id;
        task->create_timestamp = query.value(1).toInt();
        task->m_body = query.value(2).toString();
        cache.insert(id,task);

        return task;
    }
    cache.insert(id,0);
    return 0;
}

int Task::insert()
{
    QSqlDatabase db = dbAdapter::instance().db;
    QSqlQuery query(db);
    query.prepare("INSERT INTO tasks (`body`, `create_timestamp`) VALUES (:body, :create_timestamp)");
    query.bindValue(":body",this->m_body);
    query.bindValue(":create_timestamp",QDateTime::currentMSecsSinceEpoch());

    bool ok = query.exec();
    if(!ok)
    {
        qDebug() << query.lastQuery() << query.lastError().text();
    }

    query.prepare("SELECT seq FROM sqlite_sequence where name='tasks'");
    bool ok2 = query.exec();
    if(!ok2)
    {
        qDebug() << query.lastQuery() << query.lastError().text();
    }
    else if(query.next())
    {
        return query.value("seq").toInt();
    }
    return 0;
}

void Task::remove()
{
    QSqlDatabase db = dbAdapter::instance().db;
    QSqlQuery query(db);
    query.prepare("DELETE FROM tasks WHERE id=:id");
    query.bindValue(":id",this->id);

    bool ok = query.exec();

    if(!ok)
    {
        qDebug() << query.lastQuery() << query.lastError().text();
    }
}

void Task::update()
{
    QSqlDatabase db = dbAdapter::instance().db;
    QSqlQuery query(db);
    query.prepare("UPDATE tasks SET body=:body WHERE id=:id");
    query.bindValue(":body",this->m_body);
    query.bindValue(":id",this->id);

    bool ok = query.exec();
    if(!ok)
    {
        qDebug() << query.lastQuery() << query.lastError().text();
    }
}


