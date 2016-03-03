import QtQuick 2.5

Item {
    //Colors for each menu item
    property var menuColors: ["#fddb99", "#e2c377", "#bba45d"]
    property var menuTitles: [qsTr("This Week"), qsTr("Weeks"), qsTr("About")]
    property var closedMenuScales: [0.9, 0.8, 0.7]

    property bool open: false
    property int menuHeight

    id: root
    height: open ? menuHeight : parent.height * 0.07

    Column {
        id: menuColumn
        spacing: 0
        anchors {
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
        }

        Repeater {
            id: menuRepeater
            model: 3
            delegate: menuDelegate
        }
    }

    Component {
        id: menuDelegate

        Rectangle {
            id: menuItem
            width: root.width
            height: (root.height / menuRepeater.model) * (open ? 1 : closedMenuScales[index])
            color: menuColors[index]

            Behavior on height { NumberAnimation { duration: 500; easing.type: Easing.OutExpo } }

            Text {
                id: menuTitle
                text: menuTitles[index]
                anchors.centerIn: parent
                color: mainWindow.textColor
                font {
                    pointSize: 20
                }
                opacity: (open ? 1 : 0)
                visible: !(opacity === 0)

                Behavior on opacity { NumberAnimation { duration: 300; easing.type: Easing.OutExpo } }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (index === mainWindow.views.Week) {
                        mainWindow.showView(mainWindow.views.Week);
                    }
                    else if (index === mainWindow.views.About) {
                        mainWindow.showView(mainWindow.views.About);
                    }
                    else if (index === mainWindow.views.Weeks) {
                        mainWindow.showView(mainWindow.views.Weeks);
                    }
                }
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        visible: !root.open
        onClicked: {
            root.open = true;
        }
    }
}
