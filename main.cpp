#include <QtGui/QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QScreen>
#include <QtQml>

#include "src/dbadapter.h"
#include "src/models/tasksqlmodel.h"
#include "src/models/taskmodel.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    app.setApplicationName("simpletask");
    app.setOrganizationName("simpletasks");

    dbAdapter *DbAdapter = new dbAdapter();
    TaskSqlModel *taskSqlModel = new TaskSqlModel();

    QScreen *screen = qApp->primaryScreen();
    int dpi = screen->physicalDotsPerInch() * screen->devicePixelRatio();
    qreal dp = dpi / 160.f;

    qmlRegisterType<Task>("taskAdapter",1,0,"Task");

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("dp", dp);
    engine.rootContext()->setContextProperty("TaskSqlModel", taskSqlModel);
    engine.rootContext()->setContextProperty("isMobile", true);
    engine.load(QUrl(QStringLiteral("qrc:/qml/tasks/main.qml")));

    return app.exec();
}

