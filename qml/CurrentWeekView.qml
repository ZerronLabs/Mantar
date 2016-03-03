import QtQuick 2.5
import "qrc:/js/js/dateUtils.js" as DU

Item {
    property int weekNumber: new Date().getWeekNumber()
    property int currentYear: new Date().getFullYear()

    id: root
    visible: !(opacity === 0)

    Text {
        id: weekLabel
        text: qsTr("Week ") + weekNumber
        anchors {
            top: parent.top
            topMargin: weekLabel.height * 0.3
            horizontalCenter: parent.horizontalCenter
        }
        font {
            pointSize: 15
        }
        color: "#fddb99"
    }

    WeekOutcomes {
        id: weekOutcomes
        width: root.width * 0.8
        height: root.height * 0.15
        anchors {
            top: weekLabel.bottom
            topMargin: weekLabel.height * 0.5
            horizontalCenter: parent.horizontalCenter
        }
    }

    /** Daily Goals **/

    Text {
        id: dailyGoalsLabel
        text: qsTr("Daily Goals")
        anchors {
            top: weekOutcomes.bottom
            topMargin: weekOutcomes.height * 0.3
            left: weekOutcomes.left
        }
        font {
            pointSize: 17
        }
        color: "#bba45d"
    }

    Column {
        id: outcomesColumn
        spacing: {
            var dailyGoalsHeight = (root.height * 0.08) * 5 + dailyGoalsLabel.height;
            var weekOutcomesHeight = weekLabel.height + weekOutcomes.height;
            return (root.height - mainWindow.bottomMargin - weekOutcomesHeight - dailyGoalsHeight) / 6
        }
        anchors {
            top: dailyGoalsLabel.bottom
            topMargin: dailyGoalsLabel.height * 0.5
            horizontalCenter: parent.horizontalCenter
        }

        Repeater {
            id: columnRepeater
            model: 5
            delegate: goalsDelegate
        }
    }

    Component {
        id: goalsDelegate

        DailyGoals {
            id: dailyGoals
            width: root.width * 0.8
            height: root.height * 0.1
            anchors {
                horizontalCenter: parent.horizontalCenter
            }
            dayDate: DU.getFirstDay(currentYear, weekNumber).addDays(index);
        }
    }

    function saveCurrentStatus() {
        for (var i = 0; i < columnRepeater.model; i++) {
            columnRepeater.itemAt(i).saveCurrentStatus();
        }

        weekOutcomes.saveCurrentStatus();
    }
}
