import QtQuick 2.5

Item {
    id: root

    Image {
        id: image
        anchors {
            top: parent.top
            topMargin: parent.height / 2 - image.height - sumarryLabel.height - webSiteLabel.height
            horizontalCenter: parent.horizontalCenter
        }
        fillMode: Image.PreserveAspectFit
        source: "qrc:/images/images/about.png"
    }

    Text {
        id: sumarryLabel
        text: qsTr("Made in <b>Ankara</b> With Love")
        anchors {
            top: image.bottom
            topMargin: sumarryLabel.height
            horizontalCenter: parent.horizontalCenter
        }
        font {
            pointSize: 20
        }
        color: "#bba45d"
    }

    Text {
        id: webSiteLabel
        text: qsTr("zerronlabs.com")
        anchors {
            top: sumarryLabel.bottom
            topMargin: webSiteLabel.height / 2
            horizontalCenter: parent.horizontalCenter
        }
        font {
            pointSize: 20
        }
        color: "#bba45d"
    }
}
