#ifndef TASK_H
#define TASK_H

#include <QObject>
#include <QString>
#include <QHash>

class Task : public QObject
{
    Q_OBJECT
public:
    explicit Task(QObject *parent = 0);

signals:

public slots:
    static Task* toInt(int task_id);
    void remove();
    void update();
    void insert();

    void setTitle(QString title){m_title = title;}
    void setBody(QString body){m_body = body;}

private:
    QString m_title;
    QString m_body;

    static QHash<int, Task*> cache;

protected:
    int id;
};

#endif // TASK_H
