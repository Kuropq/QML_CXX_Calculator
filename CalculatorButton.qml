import QtQuick 2.7
import "utils.js" as Utils

Rectangle {
    id: button
    width: 60
    height: 60
    signal clicked
    property alias text: text.text
    radius: width / 2
    property real textHeight: height * 2 / 5
    property bool pressed: mouse.pressed
    property real implicitMargin: (width - text.implicitWidth) / 2
    property string buttonColor: "#000000"
    property string textColor: "#000000"
    color: buttonColor

    Text {
        id: text
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        height: parent.textHeight
        font.pixelSize: parent.textHeight
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: textColor
        font.family: Utils.fontFamily()
    }

    Timer {
        id: timer
        interval: 100
        running: false
        repeat: false
        onTriggered: button.color = button.buttonColor
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        onClicked: {
            button.clicked()
            timer.start()
        }
    }

}
