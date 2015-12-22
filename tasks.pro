TEMPLATE = app

QT += qml quick svg sql

SOURCES += main.cpp \
    src/models/taskmodel.cpp \
    src/dbadapter.cpp \
    src/models/tasksqlmodel.cpp

RESOURCES += qml.qrc

HEADERS += \
    src/models/taskmodel.h \
    src/dbadapter.h \
    src/models/tasksqlmodel.h

OTHER_FILES += qml/tasks/main.qml \
                qml/tasks/components/material/*.qml