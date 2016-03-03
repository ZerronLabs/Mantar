import QtQuick 2.5

Row {
    property int currentYear: new Date().getFullYear()
    property int selectedYear: currentYear
    property int currentYearIndex: 1
    property var labelWidths: []

    id: root
    width: labelWidths[0] + labelWidths[1] + labelWidths[2]
    spacing: 10

    Repeater {
        id: yearRepeater
        model: 3
        delegate: yearDelegate
    }

    Component {
        id: yearDelegate

        Text {
            id: yearLabel
            text: currentYear - 1 * (-index + 1)
            font {
                pointSize: 15
            }
            color: index === currentYearIndex ? "#292929" : "#e2c377"
            Component.onCompleted: {
                labelWidths[index] = yearLabel.width;
                if (index === currentYearIndex) {
                    currentYear = parseInt(yearLabel.text);
                }
            }

            Behavior on color { ColorAnimation { duration: 300 } }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    currentYearIndex = index;
                    selectedYear = parseInt(yearLabel.text);
                }
            }
        }
    }
}
