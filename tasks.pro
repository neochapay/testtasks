TEMPLATE = app

QT += qml quick sql
CONFIG += c++11

SOURCES += main.cpp \
    src/models/taskmodel.cpp \
    src/dbadapter.cpp \
    src/models/tasksqlmodel.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

DISTFILES += \
    qml/components/assets/lawyer_cat.jpg \
    qml/components/assets/icon_add.svg \
    qml/components/assets/icon_back.svg \
    qml/components/assets/icon_camera.svg \
    qml/components/assets/icon_comment.svg \
    qml/components/assets/icon_location-colored.svg \
    qml/components/assets/icon_location.svg \
    qml/components/assets/icon_menu.svg \
    qml/components/assets/icon_refresh.svg \
    qml/components/assets/icon_send-colored.svg \
    qml/components/assets/icon_send.svg \
    qml/components/assets/LICENSE.md \
    qml/components/material/qmldir \
    qml/components/material/ActionBar.qml \
    qml/components/material/Card.qml \
    qml/components/material/Dialog.qml \
    qml/components/material/FlatButton.qml \
    qml/components/material/FloatingActionButton.qml \
    qml/components/material/IconButton.qml \
    qml/components/material/Label.qml \
    qml/components/material/Menu.qml \
    qml/components/material/MenuItem.qml \
    qml/components/material/MenuItemSeparator.qml \
    qml/components/material/PaperRipple.qml \
    qml/components/material/PaperShadow.qml \
    qml/components/material/Popup.qml \
    qml/components/material/RaisedButton.qml \
    qml/components/material/TextField.qml \
    qml/components/material/UIConstants.qml

HEADERS += \
    src/models/taskmodel.h \
    src/dbadapter.h \
    src/models/tasksqlmodel.h

