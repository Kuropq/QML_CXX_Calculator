import QtQuick 2.7
import QtQuick.Window 2.2
import "utils.js" as Utils

// SecretPanel
Window {
    // ID
    id: secretPanel
    // Title
    title: qsTr("SecretPanel")
    // Visibility
    visible: false

    // GUI
    Rectangle {
        // ID
        id: box
        // Anchors
        anchors.fill: parent
        // Color
        color: Utils.secretBackground()
        // Border
        border.width: 3
        border.color: Utils.secretBorder()

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
            color: Utils.lowerBackgroundColor()
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
            property string buttonColor: Utils.secretButton()
            color: buttonColor
            //Text
            property real textHeight: height * 2 / 5
            property string textColor: Utils.lowerBackgroundColor()
            property alias text: text.text
            //Signals
            signal clicked
            onClicked: secretPanel.visible = false

            FontLoader { id: sansFamili; source: "C:\\develop\\QT\\SimplrCalculator\\OpenSans-VariableFont_wdth,wght.ttf" }

            // Button text
            Text {
                // ID
                id: text
                // Text
                text: "EXIT"
                // Anchors
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                // Aligment
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                // Font
                color: Utils.lowerBackgroundColor()
                height: parent.textHeight
                font.pixelSize: parent.textHeight
                font.family: sansFamili.name
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

    } // GUI

} // SecretPanel
