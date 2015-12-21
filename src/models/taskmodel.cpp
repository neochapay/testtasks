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
    query.prepare("SELECT title,body FROM tasks WHERE id=:id");
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
        task->m_title = query.value(0).toString();
        task->m_body = query.value(1).toString();
        cache.insert(id,task);
        return task;
    }
    cache.insert(id,0);
    return 0;
}

void Task::insert()
{

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
    query.prepare("UPDATE tasks SET title=:title, body=:body WHERE id=:id");
    query.bindValue(":title",this->m_title);
    query.bindValue(":body",this->m_body);
    query.bindValue(":id",this->id);

    bool ok = query.exec();
    if(!ok)
    {
        qDebug() << query.lastQuery() << query.lastError().text();
    }
}


