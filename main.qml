import QtQuick 2.3
import QtQuick.Controls 1.2

import "qml/components/material"

ApplicationWindow {
    id: root
    width: isMobile ? 320 : 360
    height: isMobile ? 480 : 720
    visible: true
    title: "Tasks"
    color: "white"

    Rectangle{
        id: rootRect
        state: "defview"
        states: [
            State{
                name: "defview"
                PropertyChanges {target: taskList; visible: true}
                PropertyChanges {target: taskAdd; visible: false}
                PropertyChanges {target: rightButton; visible: false}
                PropertyChanges {target: actionBar; text: "Заметки"}
                PropertyChanges {target: leftButton; iconSource: "qrc:/qml/components/assets/icon_menu.svg"}
            },
            State {
                name: "addview"
                PropertyChanges {target: taskList; visible: false}
                PropertyChanges {target: taskAdd; visible: true}
                PropertyChanges {target: rightButton; visible: true}
                PropertyChanges {target: actionBar; text: "Добавить заметки"}
                PropertyChanges {target: leftButton; iconSource: "qrc:/qml/components/assets/icon_back.svg"}
            }

        ]
        width: parent.width
        height: parent.height

        ActionBar{
            id: actionBar
            color: "#2196F3"
            text: "Заметки"
            raised: contents.contentY > height
            z: 2

            IconButton {
                id: leftButton
                anchors.left: parent.left
                anchors.leftMargin: 16 * dp
                anchors.verticalCenter: parent.verticalCenter
                iconSource: "qrc:/qml/components/assets/icon_menu.svg"

                onClicked: {
                    if(rootRect.state == "addview")
                    {
                        rootRect.state = "defview"
                    }
                }
            }

            IconButton{
                id: rightButton
                anchors.right: parent.right
                anchors.rightMargin: 16 * dp
                anchors.verticalCenter: parent.verticalCenter
                iconSource: "qrc:/qml/components/assets/check.svg"
                visible: false

                onClicked: {
                    if(rootRect.state == "addview")
                    {
                        rootRect.state = "defview"
                    }
                }
            }
        }

        Rectangle {
            id: contents
            anchors.fill: parent
            anchors.topMargin: actionBar.height
            width: parent.width;
            height: parent.height-actionBar.height
            anchors{
                top: actionBar.bottom
            }

            Rectangle {
                id: taskList
                color: "#F3F3F3"
                anchors{
                    fill: parent
                }
            }

            Rectangle {
                id: taskAdd
                color: "white"
                visible: false;
                anchors{
                    top: parent.top
                    left: parent.left
                    right: parent.right
                    margins: 16 * dp
                }

                Text{
                    text: "ADD"
                }
            }
        }


        FloatingActionButton {
            id: addButton
            anchors {
                right: parent.right
                bottom: parent.bottom
                margins: 16 * dp
            }
            transform: Translate {
                y: taskAdd.visible ? 72 * dp : 0

                Behavior on y {
                    NumberAnimation {
                        duration: 200
                        easing.type: Easing.Bezier; easing.bezierCurve: [0.4, 0, 0.2, 1, 1, 1]
                    }
                }
            }

            color: "#FFEB3B"
            iconSource: "qrc:/qml/components/assets/icon_add.svg"
            onClicked: {
                rootRect.state = "addview"
            }
        }
    }

}

