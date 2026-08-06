import QtQuick
import QtQuick.Controls as Qqc
import SddmComponents

Rectangle {
    id: main

    readonly property color borderCol: "#5C0120"
    readonly property color bgCol: "#0D0E13"
    readonly property color textCol: "#7D1292"
    readonly property color iconCol: "gray"
    readonly property color focusedCol: textCol

    color: "black"
    width: Window.width
    height: Window.height

    Connections {
        target: sddm

        // function onLoginSucceeded() {
        // }
        // function onLoginFailed() {
        // }
    }

    Image {
        anchors.fill: parent
        source: "background.jpg"  // Replace with your background image file
        fillMode: Image.PreserveAspectCrop
    }

    Column {
        spacing: 15
        anchors.centerIn: parent

        Text {
            text: "Ｕｓｅｒ ＩD"
            color: main.textCol
            font.pixelSize: 48
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Qqc.TextField {
            id: username
            font.pixelSize: 36
            font.family: "Liberation Mono"
            text: userModel.lastUser
            width: 400
            color: main.textCol
            background: Rectangle {
                color: "transparent"
                border.color: main.borderCol
                border.width: 4
            }
            KeyNavigation.tab: password
            Keys.onPressed: {
                if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                    sddm.login(username.text, password.text, session.index);
                    event.accepted = true;
                }
            }
        }

        Text {
            text: "Ｐａｓｓｗｏｒｄ"
            color: main.textCol
            font.pixelSize: 48
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Qqc.TextField {
            id: password
            font.pixelSize: 28
            width: 400
            echoMode: TextInput.Password
            color: main.textCol
            background: Rectangle {
                color: "transparent"
                border.color: main.borderCol
                border.width: 4
            }
            KeyNavigation.tab: session
            Keys.onPressed: {
                if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                    sddm.login(username.text, password.text, session.index);
                    event.accepted = true;
                }
            }
        }
    }

    ComboBox {
        id: session
        width: 625
        height: username.height
        font.pixelSize: 42
        font.family: "Liberation Mono"
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.verticalCenter: shutdownBtn.verticalCenter
        anchors.topMargin: 20
        anchors.leftMargin: 20
        model: sessionModel
        index: sessionModel.lastIndex
        KeyNavigation.tab: rebootBtn
        color: "black"
        textColor: main.textCol
        borderColor: main.borderCol
        borderWidth: 4
        hoverColor: main.borderCol
        focusColor: main.borderCol
        menuColor: "black"
        arrowColor: "black"
        arrowIcon: Qt.resolvedUrl("angle-down.png")
    }

    Rectangle {
        id: shutdownBtn
        width: 80
        height: 80
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.rightMargin: 20
        color: "black"
        border.color: main.borderCol
        border.width: 4
        Text {
            id: shutdownText
            text: ""
            anchors.centerIn: parent
            color: main.iconCol
            font.pointSize: 36
        }
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                shutdownText.color = main.focusedCol;
            }
            onExited: {
                shutdownText.color = main.iconCol;
            }
            onClicked: sddm.powerOff()
        }
    }

    Rectangle {
        id: rebootBtn
        width: 80
        height: 80
        anchors.right: shutdownBtn.left
        anchors.top: parent.top
        anchors.rightMargin: 20
        anchors.topMargin: 20
        color: "black"
        border.color: main.borderCol
        border.width: 4
        Text {
            id: rebootText
            text: ""
            anchors.centerIn: parent
            color: main.iconCol
            font.pointSize: 36
        }
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onClicked: sddm.reboot()
            onEntered: {
                rebootText.color = main.focusedCol;
            }
            onExited: {
                rebootText.color = main.iconCol;
            }
        }
    }

    Component.onCompleted: {
        if (username.text === "") {
            username.focus = true;
        } else {
            password.focus = true;
        }
    }
}
