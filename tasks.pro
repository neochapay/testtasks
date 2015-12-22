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

DISTFILES += \
    android/AndroidManifest.xml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android