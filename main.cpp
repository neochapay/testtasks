#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QScreen>

#include "src/dbadapter.h"
#include "src/models/taskmodel.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    app.setApplicationName("simpletask");
    app.setOrganizationName("simpletasks");

    dbAdapter *db = new dbAdapter();

    QScreen *screen = qApp->primaryScreen();
    int dpi = screen->physicalDotsPerInch() * screen->devicePixelRatio();
    qreal dp = dpi / 160.f;

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("dp", dp);
    engine.rootContext()->setContextProperty("isMobile", true);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}

