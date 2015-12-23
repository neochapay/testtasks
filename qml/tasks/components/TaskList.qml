import QtQuick 2.0
import QtGraphicalEffects 1.0

import "material"

Rectangle {
    id: listItem
    height: 120*dp
    width: parent.width-12

    x:6
    y:6

    states: [
        State{
            name: "default";
            PropertyChanges {target: listItem; color: "white"}
        },
        State{
            name: "selected";
            PropertyChanges {target: listItem; color: "#CCCCCC"}
        }
    ]

    layer.enabled: true
    layer.effect: DropShadow {
        radius: 2
        samples: radius * 2
        source: listItem
        color: Qt.rgba(0, 0, 0, 0.5)
        transparentBorder: true
    }

    Text{
        id: taskText
        text: body
        anchors{
            top: parent.top
            left: parent.left
            topMargin: 16*dp
            leftMargin: 14 *dp
        }
        font.pixelSize: 32*dp
        color: "#2E2E2E"
        height: 32*dp
        clip: true
    }

    Text{
        id: createTimeText
        text: Qt.formatDateTime(new Date(create_timestamp),"dddd, dd MMMM yyyy")
        anchors{
            bottom: parent.bottom
            left: parent.left
            bottomMargin: 16*dp
            leftMargin: 14 *dp
        }
        font.pixelSize: 18*dp
        color: "#2E2E2E"
    }

    MouseArea{
        anchors.fill: parent
        onClicked: {
            console.log(task_id);
            rootRect.current_task = task_id;
            rootRect.state = "addview"
            taskBody.text = body;
        }

        onPressAndHold: {
            if(listItem.state == "default")
            {
                listItem.state = "selected"
                rootRect.check_task.push(task_id)
            }
            else
            {
                listItem.state = "default"
                var index = rootRect.check_task.indexOf(task_id);
                if(index > -1)
                {
                    rootRect.check_task.splice(index, 1) // Я думаю можно проще
                }
            }

            taskList.check();
        }
    }
}

