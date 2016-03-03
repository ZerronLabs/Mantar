import QtQuick 2.5
import "qrc:/js/js/dateUtils.js" as DU

Item {
    property int currentWeekNumber: new Date().getWeekNumber()
    property int spacing: 10
    property bool isCurrentYear: true

    id: root
    visible: !(opacity === 0)
    Component.onCompleted: {
        weekGrid.model = DU.getWeekCountCurrentYear();
    }

    Text {
        id: viewLabel
        text: qsTr("Weeks")
        anchors {
            top: parent.top
            topMargin: viewLabel.height * 0.5
            horizontalCenter: parent.horizontalCenter
        }
        font {
            pointSize: 15
        }
        color: "#bba45d"
    }

    YearSelector {
        id: yearSelector
        height: viewLabel.height
        anchors {
            top: viewLabel.bottom
            topMargin: viewLabel.height * 0.5
            horizontalCenter: parent.horizontalCenter
        }
        onSelectedYearChanged: {
            weekGrid.model = DU.getWeekCount(selectedYear);
            root.isCurrentYear = new Date().getFullYear() === yearSelector.selectedYear;
        }
    }

    GridView {
        id: weekGrid
        width: root.width * 0.7
        height: root.height - viewLabel.height - viewLabel.anchors.topMargin - yearSelector.height - yearSelector.anchors.topMargin - mainWindow.bottomMargin / 2
        anchors {
            top: yearSelector.bottom
            topMargin: yearSelector.height
            horizontalCenter: parent.horizontalCenter
        }
        interactive: false
        cellWidth: Math.min(width / 6, height / 9)
        cellHeight: cellWidth
        delegate: weekDelegate
    }

    Component {
        id: weekDelegate

        Rectangle {
            color: index + 1 === currentWeekNumber && root.isCurrentYear === true ? "#e2c377" : "#fddb99"
            width: weekGrid.cellWidth - spacing
            height: weekGrid.cellHeight - spacing

            Behavior on color { ColorAnimation { duration: 300 } }

            Text {
                id: weekNumberLabel
                text: index + 1
                anchors.centerIn: parent
                font {
                    pointSize: 15
                }
                color: index + 1 === currentWeekNumber && isCurrentYear ? "#292929" : "#bba45d"

                Behavior on color { ColorAnimation { duration: 300 } }
            }

            MouseArea {
                anchors.fill: parent
                propagateComposedEvents: true
                onClicked: {
                    mainWindow.weekView.weekNumber = index + 1;
                    mainWindow.weekView.currentYear = yearSelector.selectedYear;
                    mainWindow.showView(mainWindow.views.Week);
                }
            }
        }
    }
}
