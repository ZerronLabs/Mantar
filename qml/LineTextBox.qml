import QtQuick 2.5

Item {
    // Determines whether the text box should have bullet points or numbers
    property bool useNumbers: false
    //Available If useNumbers is true. This determines the number label
    property int order: 0
    property color orderSignColor: "#e2c377"

    //TextEdit aliases
    property alias font: textBox.font
    property alias text: textBox.text
    property bool done: false

    signal editingFinished(bool isDone)

    id: root

    Text {
        id: pointLabel
        text: order + "."
        anchors {
            left: parent.left
            bottom: parent.bottom
        }
        font {
            pointSize: 15
        }
        color: orderSignColor
        visible: useNumbers
    }

    Rectangle {
        id: bulletCircle
        width: parent.height * 0.4
        height: width
        anchors {
            left: parent.left
            verticalCenter: parent.verticalCenter
        }
        radius: 360
        visible: !useNumbers
        color: orderSignColor
    }

    MouseArea {
        anchors.fill: parent
        onClicked: textBox.forceActiveFocus(Qt.MouseFocusReason);
        propagateComposedEvents: true
        onPressAndHold: {
            mainWindow.weekView.saveCurrentStatus();
            if (textBox.text.length > 0) {
                done = !done;
                root.editingFinished(done);
            }
        }
    }

    TextInput {
        id: textBox
        width: parent.width - (useNumbers ? pointLabel.width : bulletCircle.width)
        height: parent.height * 0.8
        anchors {
            left: useNumbers ? pointLabel.right : bulletCircle.right
            leftMargin: useNumbers ? pointLabel.width * 0.4 : bulletCircle.width * 0.4
            bottom: parent.bottom
        }
        selectByMouse: true
        clip: true
        font {
            pointSize: 13
            strikeout: root.done
        }
        onEditingFinished: {
            root.editingFinished(false);
            focus = false;
        }
        color: done ? "#e2c377" : mainWindow.textColor
        selectedTextColor: "#292929"
        selectionColor: "#fddb99"

        Behavior on color { ColorAnimation { duration: 250 } }
    }

    Rectangle {
        id: textBoxLine
        width: textBox.width
        height: 1
        anchors {
            top: textBox.bottom
            left: textBox.left
        }
        color: orderSignColor
    }
}
