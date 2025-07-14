import QtQuick 2.7
import QtQuick.Window 2.2
import "utils.js" as Utils

// SecretPanel
Rectangle {
    // ID
    id: secretPanel
    // Color
    color: Utils.lightSimbolsColor()
    // Border
    border.width: 3
    border.color: "#000000"
    // Visibility
    visible: false

    // MainText
    Text {
        // ID
        id: mainText
        // Anchors
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: parent.height / 10
        // Size
        height: parent.height / 20
        font.pixelSize: height
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        // Text
        text: "This is SecretPanel"
        color: "#000000"
        font.family: Utils.fontFamily()
    } // MainText

    //Exit button
    Rectangle {
        // ID
        id: button
        // Size
        width: parent.width / 2
        height: parent.height / 10
        radius: width / 10
        // Anchors
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height / 10
        // Color
        property string buttonColor: Utils.numberButtonsColor()
        color: buttonColor
        //Text
        property real textHeight: height * 2 / 5
        property string textColor: Utils.lowerBackgroundColor()
        property alias text: text.text
        //Signals
        signal clicked
        onClicked: parent.visible = false

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
            text: "EXIT"
            color: textColor
            font.family: Utils.fontFamily()
        } // Button text

        // Mous area
        MouseArea {
            // ID
            id: mouse
            // Anchors
            anchors.fill: parent
            // Signals
            onClicked: button.clicked()
        } // Mous area

    } //Exit button

} // SecretPanel
