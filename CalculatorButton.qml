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

    FontLoader { id: sansFamili; source: "C:\\develop\\QT\\SimplrCalculator\\OpenSans-VariableFont_wdth,wght.ttf" }

    // Button text
    Text {
        // ID
        id: text
        // Anchors
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        // Text-Aligment
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        // Color
        color: textColor
        // Font
        font.family: sansFamili.font.family
        font.styleName: "Normal"
        font.weight: 600
        font.pixelSize: 24
        font.letterSpacing: 1
        lineHeight: 30
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

