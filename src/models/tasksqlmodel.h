#ifndef TASKSQLMODEL_H
#define TASKSQLMODEL_H

#include <QSqlQueryModel>

class TaskSqlModel : public QSqlQueryModel
{
    Q_OBJECT
public:
    explicit TaskSqlModel(QObject *parent = 0);
    QVariant data(const QModelIndex &index, int role) const;
    QHash<int, QByteArray> roleNames() const { return hash; }
private:
    const static char* SQL_SELECT;
    QHash<int,QByteArray> hash;

public slots:
    void refresh();
    void searchQuery(QString name);
    void cleanQuery();
};

#endif // TASKSQLMODEL_H
