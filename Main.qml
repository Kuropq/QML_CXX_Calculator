import QtQuick 2.7
import QtQuick.Window 2.2
import "utils.js" as Utils

import CLogic

// Main Window
Window {
    // ID
    id: mainWindow
    // Visibility
    visible: true
    // Size
    width: 360
    height: 640
    // Title
    title: qsTr("Calculator")
    // Flags
    //flags: Qt.FramelessWindowHint

    // Keyboard-Control
    Item {
        id: keyboardInputArea
        width: mainWindow.width
        height: mainWindow.height
        focus: true

        // Key-Input
        Keys.onReleased:
        {

            // Deubg-log
            console.log( "Key pressed #" + event.text );

            // Logic
            if ( event.key === Qt.Key_Enter )
                resultText.text = logic.doMath( );
            else if ( event.key === Qt.Key_Plus )
                resultText.text = logic.setOperationType( "+" )
            else if ( event.key === Qt.Key_Minus )
                resultText.text = logic.setOperationType( "-" )
            else if ( event.text === "/" ) // Can be replaced with key-code.
                resultText.text = logic.setOperationType( "/" )
            else if ( event.text === "*" ) /// Numpad multiply-key not respond.
                resultText.text = logic.setOperationType( "*" )
            else if ( event.text === "." )
                resultText.text = logic.onDot( );
            else if ( event.text === "," )
                resultText.text = logic.onDot( );
            else
                resultText.text = logic.onKeyboardInput( event.text );

            // Mark Event as handled.
            event.accepted = true;

        } // Keys.onReleased

    } // Keyboard-Control

    // Logic
    CLogic {
        id: logic
    }

    // Upper Background
    Rectangle {
        id: upperBackground
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        height: ( ( parent.height * 28 ) / 600)
        color: Utils.upperBackgroundColor()
    } // Upper Background

    // Lower Background
    Rectangle {
        anchors.top: upperBackground.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        color: Utils.lowerBackgroundColor()
    } // Lower Background

    // GUI
    Rectangle {
        // ID
        id: box
        // Anchors
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        // Size
        //width: parent.width // Not required, because anchors left & right are set.
        height: ( ( parent.height * 28 ) / 100 ) // (1/3 + 10px of Window-Height)
        // Radius
        radius: ( ( parent.height * 28 ) / 600 )
        // Color
        color: Utils.upperBackgroundColor()

        // Result-Text (Label)
        Text {
            // ID
            id: resultText
            // Anchors
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.leftMargin: mainWindow.width / 9
            anchors.rightMargin: mainWindow.width / 9
            anchors.bottomMargin: mainWindow.height / 40
            // Text-Alignment
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
            // Default-Text
            text: qsTr( "0" )
            // Color
            color: Utils.lightSimbolsColor()
            // Text0Size
            font.pixelSize: 51
                //Utils.answerText0Size();
            // Font-Style
            font.family: Utils.fontFamily()
            // Text Size-Mode
            fontSizeMode: Text.Fit
        } // Result-Text (Label)

        // FirstArgument-Text (Label)
        Text {
            // ID
            id: inputText
            // Anchors
            anchors.right: parent.right
            anchors.bottom: resultText.top
            anchors.leftMargin: mainWindow.width / 9
            anchors.rightMargin: mainWindow.width / 9
            anchors.bottomMargin: mainWindow.height / 64
            // Text-Alignment
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
            // Default-Text
            text: qsTr( "0" )
            // Color
            color: Utils.lightSimbolsColor()
            // Text0Size
            font.pixelSize: 30
                //Utils.answerText0Size();
            // Font-Style
            font.family: Utils.fontFamily()
            // Text Size-Mode
            fontSizeMode: Text.Fit
        } // FirstArgument-Text (Label)

    } // GUI

    // Buttons
    Item {
        // ID
        id: buttons
        // Anchors
        anchors.top: box.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        //Layout
        Grid {
            // Anchors
            anchors.fill: parent
            anchors.topMargin:  ( ( mainWindow.height - box.height ) / rows ) - 60
            anchors.leftMargin: ( ( mainWindow.width / columns ) - 60 ) / 2
            // Positioners
            columns: 4
            rows: 6
            columnSpacing: ( mainWindow.width / columns ) - 60
            rowSpacing: ( ( mainWindow.height - box.height ) / rows ) - ( 60 * 5 / 6 )
            // Erase
            CalculatorButton {
                id: erase_Btn
                text: "<--"
                buttonColor: Utils.mathButtonsCollor()
                textColor: Utils.lightSimbolsColor()
                onClicked: {
                    color = Utils.clickedButtonsCollor();
                    resultText.text = logic.onRemoveLastNumber( );

                } // onClicked
            }
            // sqrt
            CalculatorButton {
                id: reverse_Btn
                text: "+/-"
                buttonColor: Utils.mathButtonsCollor()
                textColor: Utils.lightSimbolsColor()
                onClicked: {
                    color = Utils.clickedButtonsCollor( );
                    resultText.text = logic.onReverseSign( );
                } // onClicked
            }
            // C
            CalculatorButton {
                id: procent_Btn
                text: "%"
                buttonColor: Utils.mathButtonsCollor()
                textColor: Utils.lightSimbolsColor()
                onClicked: {
                    color = Utils.clickedButtonsCollor( );
                    inputText.text = logic.onNumberInput("%");
                    resultText.text = logic.onTakeProcent( );
                } // onClicked
            }
            // / (÷)
            CalculatorButton {
                id: btn_div
                text: "÷"
                buttonColor: Utils.mathButtonsCollor()
                textColor: Utils.lightSimbolsColor()
                onClicked: {
                    color = Utils.clickedButtonsCollor( );
                    inputText.text = logic.setOperationType( "/" );
                } // onClicked
            }
            // 7
            CalculatorButton {
                id: btn_7
                text: "7"
                buttonColor: Utils.numberButtonsColor()
                textColor: Utils.lowerBackgroundColor()
                onClicked: {
                    color = Utils.clickedButtonsCollor( );
                    resultText.text = logic.onNumberInput( "7" );
                } // onClicked
            }
            // 8
            CalculatorButton {
                id: btn_8
                text: "8"
                buttonColor: Utils.numberButtonsColor()
                textColor: Utils.lowerBackgroundColor()
                onClicked: {
                    color = Utils.clickedButtonsCollor( );
                    resultText.text = logic.onNumberInput( "8" );
                } // onClicked
            }
            // 9
            CalculatorButton {
                id: btn_9
                text: "9"
                buttonColor: Utils.numberButtonsColor()
                textColor: Utils.lowerBackgroundColor()
                onClicked: {
                    color = Utils.clickedButtonsCollor( );
                    resultText.text = logic.onNumberInput( "9" );
                } // onClicked
            }
            // * (×)
            CalculatorButton {
                id: btn_mult
                text: "×"
                buttonColor: Utils.mathButtonsCollor()
                textColor: Utils.lightSimbolsColor()
                onClicked: {
                    color = Utils.clickedButtonsCollor( );
                    inputText.text = logic.setOperationType( "*" );
                } // onClicked
            }
            // 4
            CalculatorButton {
                id: btn_4
                text: "4"
                buttonColor: Utils.numberButtonsColor()
                textColor: Utils.lowerBackgroundColor()
                onClicked: {
                    color = Utils.clickedButtonsCollor( );
                    resultText.text = logic.onNumberInput( "4" );
                } // onClicked
            }
            // 5
            CalculatorButton {
                id: btn_5
                text: "5"
                buttonColor: Utils.numberButtonsColor()
                textColor: Utils.lowerBackgroundColor()
                onClicked: {
                    color = Utils.clickedButtonsCollor( );
                    resultText.text = logic.onNumberInput( "5" );
                } // onClicked
            }
            // 6
            CalculatorButton {
                id: btn_6
                text: "6"
                buttonColor: Utils.numberButtonsColor()
                textColor: Utils.lowerBackgroundColor()
                onClicked: {
                    color = Utils.clickedButtonsCollor( );
                    resultText.text = logic.onNumberInput( "6" );
                } // onClicked
            }
            // -
            CalculatorButton {
                id: btn_sub
                text: "-"
                buttonColor: Utils.mathButtonsCollor()
                textColor: Utils.lightSimbolsColor()
                onClicked: {
                    color = Utils.clickedButtonsCollor( );
                    inputText.text = logic.setOperationType( "-" );
                } // onClicked
            }
            // 1
            CalculatorButton {
                id: btn_1
                text: "1"
                buttonColor: Utils.numberButtonsColor()
                textColor: Utils.lowerBackgroundColor()
                onClicked: {
                    color = Utils.clickedButtonsCollor( );
                    resultText.text = logic.onNumberInput( "1" );
                } // onClicked
            }
            // 2
            CalculatorButton {
                id: btn_2
                text: "2"
                buttonColor: Utils.numberButtonsColor()
                textColor: Utils.lowerBackgroundColor()
                onClicked: {
                    color = Utils.clickedButtonsCollor( );
                    resultText.text = logic.onNumberInput( "2" );
                } // onClicked
            }
            // 3
            CalculatorButton {
                id: btn_3
                text: "3"
                buttonColor: Utils.numberButtonsColor()
                textColor: Utils.lowerBackgroundColor()
                onClicked: {
                    color = Utils.clickedButtonsCollor( );
                    resultText.text = logic.onNumberInput( "3" );
                } // onClicked
            }
            // +
            CalculatorButton {
                id: btn_sum
                text: "+"
                buttonColor: Utils.mathButtonsCollor()
                textColor: Utils.lightSimbolsColor()
                onClicked: {
                    color = Utils.clickedButtonsCollor( );
                    inputText.text = logic.setOperationType( "+" );
                } // onClicked
            }
            // C
            CalculatorButton {
                id: clear_Btn
                text: "C"
                buttonColor: Utils.cancelButtonColor()
                textColor: Utils.lightSimbolsColor()
                onClicked: {
                    color = Utils.clickedCancelButtonColor();
                    logic.resetLogic( );
                    inputText.text = "0";
                    resultText.text = "0";
                } // onClicked
            }
            // --0--
            CalculatorButton {
                id: btn_0
                text: "0"
                buttonColor: Utils.numberButtonsColor()
                textColor: Utils.lowerBackgroundColor()
                onClicked: {
                    color = Utils.clickedButtonsCollor( );
                    resultText.text = logic.onNumberInput( "0" );
                } // onClicked
            }
            // -.--- (dot, separator)
            CalculatorButton {
                id: btn_dot
                text: "."
                buttonColor: Utils.numberButtonsColor()
                textColor: Utils.lowerBackgroundColor()
                onClicked: {
                    color = Utils.clickedButtonsCollor( );
                    resultText.text = logic.onDot( );
                } // onClicked
            }
            // =
            CalculatorButton {
                id: result_btn
                text: "="
                buttonColor: Utils.mathButtonsCollor()
                textColor: Utils.lightSimbolsColor()
                // Signals
                onClicked: {
                    color = Utils.clickedButtonsCollor( );
                    inputText.text = logic.getOutput( );
                    resultText.text = logic.doMath( );
                } // onClicked


                // Secret panel open sequence
                signal pressAndHold()

                // Hold timer
                Timer {
                    // ID
                    id: longPressTimer
                    // Timer
                    interval: 4000
                    repeat: false
                    running: false
                    // Signals
                    onTriggered: {
                        result_btn.pressAndHold();
                        parent.color = "#000000";
                        logic.resetLogic( );
                        inputText.text = "0";
                        resultText.text = "0";
                        codeReader.start();
                    }
                } // Hold timer

                onPressedChanged: {
                    if ( pressed ) {
                        longPressTimer.running = true;
                    } else {
                        longPressTimer.running = false;
                    }
                } // onPressedChanged

            } // =

        } //Layout

    } // Buttons

    // Code Reader
    Timer {
        // ID
        id: codeReader
        // Timer
        interval: 5000
        running: false
        repeat: false
        // Signals
        onTriggered: secretPanel.visible = (resultText.text == "123") ? true : false
    } // Code Reader

    // SecretPanel
    SecretPanel {
        // ID
        id: secretPanel
        // Size
        width: mainWindow.width
        height: mainWindow.height
    } // SecretPanel

} // Main Window
