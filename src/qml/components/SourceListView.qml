import QtQuick 2.5
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0

Item {
    id: item
    property ListModel model
    clip: true
    signal clicked(var source)

    ListView {
        id: listView
        anchors.fill: parent
        clip: true
        highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
        focus: true

        model: item.model

        delegate: spaceManDelegate

        section.property: "source"
        section.delegate: sectionDelegate
    }


    Component {
        id: spaceManDelegate

        Rectangle {
            height: 20
            width: parent.width
            Rectangle {
                id: background
                height: parent.height
                width: 5000
                color: Material.accent
                opacity: 0
            }
            MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: background.opacity = 1
                    onExited: background.opacity = 0
                    onClicked: {
                        listView.currentIndex = index
                        item.model.get(index)
                        item.clicked(item.model.get(index))
                    }
            }
            Label {
                anchors.verticalCenter : parent.verticalCenter
                anchors.leftMargin: 10
                font.pixelSize: 16
                font.bold: listView.currentIndex === index
                text: title
            }
        }



    }

    Component {
        id: sectionDelegate
        Rectangle {
            height: 20
            width: parent.width
            visible: true
            Label {
                anchors.verticalCenter : parent.verticalCenter

                font.pixelSize: 10
                text: section
                font.bold: true
                color: Material.accent
            }
        }
    }
}
