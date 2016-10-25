import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtGraphicalEffects 1.0

Item {
    id: item
    property ListModel model

    Column {
        z: 200
        id: listView

        Repeater {
            model: item.model
            Item {
                width: item.width
                height: childrenRect.height

                Column {
                    Label {
                        text: "Source: " + name
                    }
                    Column {

                        Repeater {
                            model: streams
                            Item {
                                width: item.width
                                height: 30
                                property color background: Material.background
                                property double opac: 0


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
