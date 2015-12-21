#include "tasksqlmodel.h"

#include <QSqlQueryModel>

TaskSqlModel::TaskSqlModel(QObject *parent) : QSqlQueryModel(parent)
{
    hash.insert(Qt::UserRole,QByteArray("id"));
    hash.insert(Qt::UserRole+1,QByteArray("body"));
    hash.insert(Qt::UserRole+1,QByteArray("create_timestamp"));
    refresh();
}

const char* TaskSqlModel::SQL_SELECT = "SELECT * FROM tasks ORDER BY create_timestamp ASC";

QVariant TaskSqlModel::data(const QModelIndex &index, int role) const{
    QVariant value = QSqlQueryModel::data(index, role);
    if(role < Qt::UserRole)
    {
        value = QSqlQueryModel::data(index, role);
    }
    else
    {
        int columnIdx = role - Qt::UserRole;
        QModelIndex modelIndex = this->index(index.row(), columnIdx);
        value = QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
    }
    return value;
}


void TaskSqlModel::searchQuery(QString name)
{
    SQL_SELECT = QString("SELECT * FROM tasks WHERE `body` LIKE '%%1%' ORDER BY create_timestamp ASC").arg(name).toUtf8();
}

void TaskSqlModel::cleanQuery()
{
    SQL_SELECT = "SELECT * FROM tasks ORDER BY create_timestamp ASC";
}

void TaskSqlModel::refresh()
{
    this->setQuery(SQL_SELECT);
}
