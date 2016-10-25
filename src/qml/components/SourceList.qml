import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtGraphicalEffects 1.0

Item {
    z: 200

    Pane {
        width: window.width / 2
        height: window.height
        id: drawer
        z: 200
        VisibleAnimation {
            id: visibleAnimation
            state: true
        }
        DropShadow {
            anchors.fill: drawer
            horizontalOffset: 30
            verticalOffset: 3
            radius: 80.0
            samples: 17
            color: "#80000000"
            source: drawer
        }

        Flickable {
            id: scrollView
            anchors.fill: parent
            contentWidth: listView.width; contentHeight: listView.height
            Column {

                z: 200
                id: listView

                Repeater {
                    model: srcModel
                    Item {
                        width: scrollView.width
                        height: childrenRect.height

                        Column {
                            Label {
                                text: "Source: " + name
                            }
                            Column {
                                // leftPadding: 10
                                // topPadding: 5

                                Repeater {
                                    model: streams
                                    Item {
                                        width: scrollView.width
                                        height: 30
                                        property color background: Material.background
                                        property double opac: 0

                                        VisibleAnimation {
                                            state: visibleAnimation.state
                                        }
                                        MouseArea {
                                                anchors.fill: parent
                                                hoverEnabled: true
                                                onClicked: {
                                                    client.send('player', {
                                                        url: model.url,
                                                        title: model.title
                                                    });
                                                }
                                                onEntered: {
                                                    parent.background = Material.color(parent.background , Material.Shade300)
                                                    opac = 1
                                                }
                                                onExited: {
                                                    parent.background = Material.foreground
                                                    opac = 0
                                                }

                                        }
                                        Rectangle {
                                            anchors.fill: parent
                                            color: parent.background
                                            opacity: parent.opac
                                        }
                                        Label {
                                            anchors.verticalCenter: parent.verticalCenter
                                            text: model.title
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
