import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtGraphicalEffects 1.0

Item {
    id: item

    property bool opened: true
    default property alias contents: placeholder.children

    Pane {
        id: pane
        anchors.fill: parent
        z: item.z


        Rectangle {
            anchors.fill: parent
            anchors.margins: -12
            Item {
                id: placeholder
                anchors.fill: parent
            }
        }
    }

    states: [
        State { when: opened;
                PropertyChanges {   target: item; opacity: 1.0    }},
        State { when: !opened;
                PropertyChanges {   target: item; opacity: 0.0    }}
    ]

    transitions: [
        Transition {
            NumberAnimation {
                property: "opacity"
                duration: 200
            }
        }
    ]

    DropShadow {
        anchors.fill: item
        horizontalOffset: 3
        verticalOffset: 3
        radius: 8.0
        samples: 17
        color: "#80000000"
        source: pane
    }
}
