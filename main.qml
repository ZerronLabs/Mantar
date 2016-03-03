import QtQuick 2.5
import QtQuick.Window 2.2
import Qt.labs.settings 1.0
import "./qml"

Window {
    property color mainColor: "#fff8e8"
    property color textColor: "#292929"
    property size screenSize: Qt.size(Screen.width, Screen.height)
    property var views: { "Week": 0, "Weeks": 1, "About": 2 }

    property real hiddenOpacity: 0.2
    property real bottomMargin: mainWindow.height * 0.25

    property alias weekView: currentWeekView
    property alias appStorage: appSettings.storage

    id: mainWindow
    visible: true
    width: 1280
    height: 720
    color: mainColor

    Settings {
        id: appSettings

        property string storage: "{}"
    }

    Item {
        id: container
        width: parent.width
        height: parent.height
        anchors {
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
        }

        Behavior on anchors.bottomMargin { NumberAnimation { duration: 500; easing.type: Easing.OutExpo } }
        Behavior on opacity { NumberAnimation { duration: 500; easing.type: Easing.OutExpo } }

        CurrentWeekView {
            id: currentWeekView
            width: parent.width
            height: parent.height
        }

        Loader {
            id: aboutLoader
            width: parent.width
            height: parent.height
        }

        Loader {
            id: weeksLoader
            width: parent.width
            height: parent.height
        }

        SwipeArea {
            anchors.fill: parent
            onSwipeDown: {
                menu.open = false;
                weekView.saveCurrentStatus();
            }
            onSwipeUp: {
                menu.open = true;
                weekView.saveCurrentStatus();
            }
        }
    }

    MantarMenu {
        id: menu
        width: mainWindow.width
        menuHeight: mainWindow.height * 0.27
        anchors {
            bottom: parent.bottom
            horizontalCenter: mainWindow.horizontalCenter
        }
        onOpenChanged: {
            if (open) {
                weekView.saveCurrentStatus();
            }
            toggleMenu(open);
        }
    }

    function showView(view) {
        if (view === views.About) {
            if (aboutLoader.status == Loader.Ready) {
                aboutLoader.item.opacity = 1;
            }
            else {
                aboutLoader.source = "qrc:/qml/AboutView.qml";
            }
            if (weeksLoader.status == Loader.Ready) {
                weeksLoader.item.opacity = 0;
            }
            currentWeekView.opacity = 0;
        }
        else if (view === views.Week) {
            if (aboutLoader.status == Loader.Ready) {
                aboutLoader.item.opacity = 0;
            }
            if (weeksLoader.status == Loader.Ready) {
                weeksLoader.item.opacity = 0;
            }
            currentWeekView.opacity = 1;
        }
        else if (view === views.Weeks) {
            if (aboutLoader.status == Loader.Ready) {
                aboutLoader.item.opacity = 0;
            }
            if (weeksLoader.status == Loader.Ready) {
                weeksLoader.item.opacity = 1;
            }
            else {
                weeksLoader.source = "qrc:/qml/WeeksView.qml";
            }
            currentWeekView.opacity = 0;
        }
        menu.open = false;
    }

    function toggleMenu(isOpen) {
        container.anchors.bottomMargin = menu.open ? menu.height : 0;
        container.opacity = menu.open ? hiddenOpacity : 1;
    }
}
