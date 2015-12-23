import QtQuick 2.3
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.1

import "components/"
import "components/material"

import TaskAdapter 1.0

ApplicationWindow {
    id: root
    width: isMobile ? 320 : 360
    height: isMobile ? 480 : 720
    visible: true
    title: "Tasks"
    color: "white"

    Rectangle{
        id: rootRect

        property int current_task: 0;
        property variant check_task: [];

        signal backClicked();

        state: "defview"
        states: [
            State{
                name: "defview"
                PropertyChanges {target: taskList; visible: true}
                PropertyChanges {target: taskAdd; visible: false}
                PropertyChanges {target: rightButton; visible: false}
                PropertyChanges {target: actionBar; text: "Заметки"}
                PropertyChanges {target: leftButton; iconSource: "img/icon_menu.svg"}
                PropertyChanges {target: actionBar; color: "#2196F3"}
            },
            State {
                name: "addview"
                PropertyChanges {target: taskList; visible: false}
                PropertyChanges {target: taskAdd; visible: true}
                PropertyChanges {target: rightButton; visible: true}
                PropertyChanges {target: rightButton; iconSource: "img/check.svg"}
                PropertyChanges {target: actionBar; text: "Добавить заметки"}
                PropertyChanges {target: leftButton; iconSource: "img/icon_back.svg"}
                PropertyChanges {target: actionBar; color: "#2196F3"}
            },
            State {
                name: "checked"
                PropertyChanges {target: leftButton; iconSource: "img/icon_back.svg"}
                PropertyChanges {target: rightButton; visible: true}
                PropertyChanges {target: rightButton; iconSource: "img/rubbish.svg"}
                PropertyChanges {target: actionBar; color: "#949494"}
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
                iconSource: "img/icon_menu.svg"

                onClicked: {
                    if(rootRect.state != "defview")
                    {
                        rootRect.state = "defview"
                    }

                    rootRect.backClicked();
                }
            }

            IconButton{
                id: rightButton
                anchors.right: parent.right
                anchors.rightMargin: 16 * dp
                anchors.verticalCenter: parent.verticalCenter
                iconSource: "img/check.svg"
                visible: false

                onClicked: {
                    if(rootRect.state == "addview")
                    {
                        if(rootRect.current_task == 0)
                        {
                            newTask.setBody(taskBody.text)
                            newTask.insert();
                        }
                        else
                        {
                            var utask = newTask.toInt(rootRect.current_task)
                            utask.setBody(taskBody.text);
                            utask.update();
                            rootRect.current_task = 0;
                        }
                        TaskSqlModel.refresh();

                        rootRect.state = "defview"
                        taskBody.text = ""
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

                ListView{
                    id: taskListView
                    model: TaskSqlModel
                    anchors.fill: parent
                    delegate: TaskList{}
                    spacing: 6
                    anchors.topMargin: 6
                }

                function check()
                {
                    if(rootRect.check_task.length > 0)
                    {
                        rootRect.state = "checked"
                        actionBar.text = rootRect.check_task.length
                    }
                    else
                    {
                        rootRect.state = "default"
                    }
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

                Task{
                    id: newTask
                }

                TextArea{
                    id: taskBody
                    width: parent.width
                    height: root.height-actionBar.height-32*dp
                    anchors{
                        top: parent.top
                    }
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
            iconSource: "img/icon_add.svg"
            onClicked: {
                rootRect.state = "addview"
            }
        }
    }
}

