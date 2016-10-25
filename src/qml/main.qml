import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtGraphicalEffects 1.0

import VLCQt 1.0

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
        onSources: function(sources) {
            srcModel.clear();
            sources.forEach(function(src) {
                srcModel.append(src);
            });
        }

        onPlayer: function(player) {
            vidwidget.url = player.url
        }
    }

    Model {
        id: srcModel
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
            anchors.fill: parent
            anchors.leftMargin: 10
            anchors.rightMargin: 10

            clip: true

            SourceListView {
                width: menuPane.childrenRect.width
                height: window.height
                model: client.flatStreams
                onClicked: function(source) {
                    vidwidget.url = source.url
                    console.log(source.url);
                }
            }
        }



    }

    VlcVideoPlayer {
        z: 100
        id: vidwidget
        objectName: "player"

        contentsSize.height: 100
        contentsSize.width: 100
        contentsScale: 1
        anchors.fill: parent
        anchors.top: parent.top
        anchors.left: parent.left
        // url: "rtsp://192.168.0.17:554/?freq=122&bw=8&msys=dvbc&mtype=64qam&sr=6900&specinv=0&pids=0,16,17,18,20,153,4471,109,4472"
        url: "http://video.blendertestbuilds.de/download.blender.org/peach/trailer_400p.ogg"
        function setUrl(msg) {
            console.log("Got message:", msg)
            return "some return value"
        }
    }
}
