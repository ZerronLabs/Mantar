import QtQuick 2.5
import "qrc:/js/js/dataStorage.js" as DS

/*
  @brief: Displays the three goals of the given day. The goals are editable and automatically saved when edited.
 */
Item {
    property date dayDate

    id: root

    Column {
        id: goalsColumn
        width: parent.width
        spacing: 2
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
        }

        Repeater {
            id: columnRepeater
            model: 3
            delegate: goalDelegate
        }
    }

    Component {
        id: goalDelegate

        LineTextBox {
            id: outcome
            width: root.width
            height: root.height / 3
            text: DS.getDailyGoals(mainWindow.weekView.currentYear, mainWindow.weekView.weekNumber, dayDate.getDay())[index].text
            done: DS.getDailyGoals(mainWindow.weekView.currentYear, mainWindow.weekView.weekNumber, dayDate.getDay())[index].done
            onEditingFinished: DS.saveDailyGoals(mainWindow.weekView.currentYear, mainWindow.weekView.weekNumber, dayDate.getDay(), index, text, isDone)
        }
    }

    Text {
        id: dayLabel
        text: dayDate.toLocaleDateString(Qt.locale(), "dddd")
        y: parent.height - (parent.height - dayLabel.width) / 2
        anchors {
            left: parent.left
            leftMargin: -height * 1.5
        }
        font {
            pointSize: 10
        }
        color: "#e2c377"
        transform: Rotation {
            origin.x: 0
            origin.y: 0
            angle: -90
        }
    }

    function saveCurrentStatus() {
        for (var i = 0; i < columnRepeater.model; i++) {
            columnRepeater.itemAt(i).editingFinished(columnRepeater.itemAt(i).done);
        }
    }
}
