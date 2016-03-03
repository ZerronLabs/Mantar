import QtQuick 2.5
import "qrc:/js/js/dataStorage.js" as DS

/*
  @brief: Displays the three outcomes of the week. The outcomes are editable and automatically saved when editing.
 */
Item {
    id: root

    Text {
        id: labelHeader
        text: qsTr("Desired Outcomes")
        anchors {
            top: parent.top
            left: outcomesColumn.left
        }
        font {
            pointSize: 17
        }
        color: "#bba45d"
    }

    Column {
        id: outcomesColumn
        width: root.width
        spacing: 2
        anchors {
            top: labelHeader.bottom
            topMargin: labelHeader.height * 0.2
            horizontalCenter: parent.horizontalCenter
        }

        Repeater {
            id: columnRepeater
            model: 3
            delegate: outcomeDelegate
        }
    }

    Component {
        id: outcomeDelegate

        LineTextBox {
            id: outcome
            width: root.width
            height: (root.height - labelHeader.height - outcomesColumn.anchors.topMargin) / 3
            text: DS.getWeekOutcomes(mainWindow.weekView.currentYear, mainWindow.weekView.weekNumber)[index].text
            done: DS.getWeekOutcomes(mainWindow.weekView.currentYear, mainWindow.weekView.weekNumber)[index].done
            useNumbers: true
            order: index + 1
            onEditingFinished: DS.saveWeekOutcome(mainWindow.weekView.currentYear, mainWindow.weekView.weekNumber, index, text, isDone)
        }
    }

    function saveCurrentStatus() {
        for (var i = 0; i < columnRepeater.model; i++) {
            columnRepeater.itemAt(i).editingFinished(columnRepeater.itemAt(i).done);
        }
    }
}
