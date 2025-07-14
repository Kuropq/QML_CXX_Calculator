import QtQuick 2.7
import "utils.js" as Utils

Rectangle {
    // ID
    id: button
    // Size
    width: 60
    height: 60
    radius: width / 2
    // Color
    property string buttonColor: "#000000"
    color: buttonColor
    //Text
    property real textHeight: height * 2 / 5
    property string textColor: "#000000"
    property alias text: text.text
    //Signals
    signal clicked
    property bool pressed: mouse.pressed

    // Button text
    Text {
        // ID
        id: text
        // Anchors
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        // Size
        height: parent.textHeight
        font.pixelSize: parent.textHeight
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        // Text
        color: textColor
        font.family: Utils.fontFamily()
    }

    // Click timer
    Timer {
        // ID
        id: timer
        // Timer
        interval: 100
        running: false
        repeat: false
        // Signals
        onTriggered: button.color = button.buttonColor
    }

    // Mous area
    MouseArea {
        // ID
        id: mouse
        // Anchors
        anchors.fill: parent
        // Signals
        onClicked: {
            button.clicked()
            timer.start()
        }

    }

}

