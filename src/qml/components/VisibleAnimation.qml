import QtQuick 2.0

Item {
    property bool state

    states: [
        State { when: state;
                PropertyChanges {   target: drawer; opacity: 1.0    }},
        State { when: state;
                PropertyChanges {   target: parent; opacity: 1.0    }},
        State { when: !state;
                PropertyChanges {   target: drawer; opacity: 0.0    }},
        State { when: !state;
                PropertyChanges {   target: parent; opacity: 0.0    }}

    ]
    transitions: [
        Transition {
            NumberAnimation {
                property: "opacity"
                duration: 200
            }

        }
    ]
}
