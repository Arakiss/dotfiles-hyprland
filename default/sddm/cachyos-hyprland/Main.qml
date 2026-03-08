import QtQuick 2.15
import SddmComponents 2.0

Rectangle {
    id: root
    width: 640
    height: 480
    color: "#1a1b26"

    property string currentUser: userModel.lastUser
    property int sessionIndex: {
        for (var i = 0; i < sessionModel.rowCount(); i++) {
            var name = (sessionModel.data(sessionModel.index(i, 0), Qt.DisplayRole) || "").toString()
            if (name.toLowerCase().indexOf("hyprland") !== -1)
                return i
        }
        return sessionModel.lastIndex
    }

    Connections {
        target: sddm
        function onLoginFailed() {
            errorMessage.text = "Authentication failed"
            errorMessage.opacity = 1
            password.text = ""
            password.focus = true
            shakeAnimation.start()
        }
        function onLoginSucceeded() {
            errorMessage.text = ""
            successAnimation.start()
        }
    }

    // Subtle gradient overlay
    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#1a1b26" }
            GradientStop { position: 0.4; color: "#1a1b26" }
            GradientStop { position: 1.0; color: "#16161e" }
        }
    }

    // Accent line at top
    Rectangle {
        width: parent.width
        height: 2
        color: "#7aa2f7"
        opacity: 0.6
        anchors.top: parent.top
    }

    Column {
        id: loginColumn
        anchors.centerIn: parent
        spacing: root.height * 0.035
        width: parent.width

        // Hostname / branding
        Text {
            text: "CachyOS"
            color: "#7aa2f7"
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: root.height * 0.06
            font.weight: Font.Bold
            font.letterSpacing: root.height * 0.008
            anchors.horizontalCenter: parent.horizontalCenter
            opacity: 0.9
        }

        // Thin separator
        Rectangle {
            width: root.width * 0.12
            height: 1
            color: "#565f89"
            anchors.horizontalCenter: parent.horizontalCenter
            opacity: 0.5
        }

        // Username
        Text {
            text: root.currentUser
            color: "#a9b1d6"
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: root.height * 0.022
            font.letterSpacing: root.height * 0.002
            anchors.horizontalCenter: parent.horizontalCenter
        }

        // Password row
        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: root.width * 0.008

            // Lock icon
            Text {
                text: "\uf023"
                color: "#565f89"
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: root.height * 0.022
                anchors.verticalCenter: parent.verticalCenter
            }

            // Password field
            Rectangle {
                width: root.width * 0.18
                height: root.height * 0.042
                color: "#16161e"
                radius: 4
                border.color: password.activeFocus ? "#7aa2f7" : "#565f89"
                border.width: password.activeFocus ? 2 : 1

                Behavior on border.color {
                    ColorAnimation { duration: 200 }
                }

                TextInput {
                    id: password
                    anchors.fill: parent
                    anchors.margins: root.height * 0.008
                    verticalAlignment: TextInput.AlignVCenter
                    echoMode: TextInput.Password
                    font.family: "JetBrainsMono Nerd Font"
                    font.pixelSize: root.height * 0.018
                    font.letterSpacing: root.height * 0.003
                    passwordCharacter: "\u2022"
                    color: "#c0caf5"
                    selectionColor: "#7aa2f7"
                    focus: true

                    Keys.onPressed: function(event) {
                        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                            sddm.login(root.currentUser, password.text, root.sessionIndex)
                            event.accepted = true
                        }
                    }
                }

                // Placeholder
                Text {
                    anchors.fill: parent
                    anchors.margins: root.height * 0.008
                    verticalAlignment: Text.AlignVCenter
                    text: "Password"
                    color: "#565f89"
                    font.family: "JetBrainsMono Nerd Font"
                    font.pixelSize: root.height * 0.016
                    visible: password.text.length === 0 && !password.activeFocus
                }
            }
        }

        // Error message
        Text {
            id: errorMessage
            text: ""
            color: "#f7768e"
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: root.height * 0.016
            anchors.horizontalCenter: parent.horizontalCenter
            opacity: 0

            Behavior on opacity {
                NumberAnimation { duration: 300 }
            }
        }
    }

    // Session indicator (bottom left)
    Text {
        text: {
            var name = sessionModel.data(sessionModel.index(root.sessionIndex, 0), Qt.DisplayRole) || ""
            return " " + name.toString()
        }
        color: "#565f89"
        font.family: "JetBrainsMono Nerd Font"
        font.pixelSize: root.height * 0.016
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.margins: root.height * 0.025
    }

    // Clock (bottom right)
    Text {
        id: clock
        color: "#565f89"
        font.family: "JetBrainsMono Nerd Font"
        font.pixelSize: root.height * 0.016
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: root.height * 0.025

        Timer {
            interval: 1000
            running: true
            repeat: true
            triggeredOnStart: true
            onTriggered: {
                var d = new Date()
                clock.text = Qt.formatDateTime(d, "HH:mm")
            }
        }
    }

    // Accent line at bottom
    Rectangle {
        width: parent.width
        height: 2
        color: "#7aa2f7"
        opacity: 0.3
        anchors.bottom: parent.bottom
    }

    // Shake animation on failed login
    SequentialAnimation {
        id: shakeAnimation
        NumberAnimation { target: loginColumn; property: "anchors.horizontalCenterOffset"; to: -20; duration: 50 }
        NumberAnimation { target: loginColumn; property: "anchors.horizontalCenterOffset"; to: 20; duration: 50 }
        NumberAnimation { target: loginColumn; property: "anchors.horizontalCenterOffset"; to: -10; duration: 50 }
        NumberAnimation { target: loginColumn; property: "anchors.horizontalCenterOffset"; to: 10; duration: 50 }
        NumberAnimation { target: loginColumn; property: "anchors.horizontalCenterOffset"; to: 0; duration: 50 }
    }

    // Fade out on successful login
    SequentialAnimation {
        id: successAnimation
        NumberAnimation { target: root; property: "opacity"; to: 0; duration: 400; easing.type: Easing.InQuad }
    }

    Component.onCompleted: password.forceActiveFocus()
}
