import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtGraphicalEffects 1.0

import VLCQt 1.1
import "components"

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    color: "black"
    id:window
    Material.accent: Material.Red
    Material.theme: Material.Light

    CmdClient {
        id: client

        onPlayerChanged: {
            vidPlayer.url = player.url
        }
    }

    Rectangle {
        id: mouseHide
        height: parent.height
        width: parent.width / 2
        anchors.right: parent.right
        color: 'transparent'
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: menuPane.opened = false
        }
    }

    Rectangle {
        id: mouseShow
        height: parent.height
        width: parent.width / 2
        anchors.left: parent.left
        color: 'transparent'
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: menuPane.opened = true
        }
    }

    MenuPane {
        id: menuPane
        z: 200
        width: window.width / 2
        height: window.height

        Rectangle {
            clip: true

            anchors.fill: parent
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            color: "transparent"
            SourceListView {
                width: menuPane.childrenRect.width
                height: window.height
                sources: client.sources
                onClicked: function(source) {
                    vidPlayer.url = source.url
                }
            }
        }
    }

    VlcPlayer {
        id: vidPlayer

        onStateChanged: function() {
            if(vidPlayer.state < 6) return;

            vidPlayer.stop();
            vidPlayer.play();
        }
    }

    VlcVideoOutput {
        z: 100
        id: vidOutput
        source: vidPlayer
        anchors.fill: parent
        anchors.top: parent.top
        anchors.left: parent.left
    }
}
