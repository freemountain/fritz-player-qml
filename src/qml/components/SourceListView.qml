import QtQuick 2.5
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0

import SortFilterProxyModel 0.1
import QSyncable 1.0

Item {
    id: item
    clip: true

    property var sources
    signal clicked(var source)

    QtObject {
        id: internal
        property var streams:[]
        property var hidden: []
        property var active
    }

    function filterStreams(hidden, streams) {
        return streams.filter(function(stream) {
            if(stream.section === true) return true;

            return hidden.indexOf(stream.source) === -1;
        });
    }

    JsonListModel {
        id: jsonModel
        keyField: "id"
        source: filterStreams(internal.hidden, internal.streams)
        fields: [ "id", "source", "url", "title", "section" ]
    }

    function makeSection(title) {
        return { "id": "section:" + title , "source": title, url: "", title: title, section: true};
    }

    function makeElement(source, stream) {
        return {
            id: "element:" + source + stream.url + stream.title ,
            source: source,
            url: stream.url,
            title: stream.title,
            section: false
        };
    }

    onSourcesChanged: {
        internal.streams = sources.map(function(source) {
            const elements = source.streams.map(function(stream) {
                return makeElement(source.name, stream);
            });

            console.log('section', JSON.stringify(makeSection(source.name)));
            return [ makeSection(source.name) ].concat(elements)
        }).reduce(function(prev, current) {
            return prev.concat(current);
        }, []);
    }

    //onClicked:

    ListView {
        id: listView
        anchors.fill: parent
        clip: true
        focus: true
        model: jsonModel
        delegate: itemDelegate
        section.property: "source"
        section.delegate: sectionDelegate
    }

    Component {
        id: itemDelegate

        Rectangle {
            id: rect
            height: model.section !== true ? 20 : 0
            width: parent.width
            visible: model.section !== true
            property bool hovered: false

            states: [
                State { when: hovered;
                        PropertyChanges {   target: label; font.pixelSize: 18    }},
                State { when: !hovered;
                        PropertyChanges {   target: label; font.pixelSize: 14    }}
            ]

            MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: rect.hovered = true
                    onExited: rect.hovered = false
                    onClicked: {
                        internal.active = id;
                        item.clicked({ source: source, url: url, title: title})
                    }
            }

            Label {
                id: label
                anchors.verticalCenter : parent.verticalCenter
                anchors.leftMargin: 10
                font.pixelSize: 14
                font.bold: internal.active === id
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
            property bool isHidden: internal.hidden.indexOf(section) !== -1

            Label {
                anchors.verticalCenter : parent.verticalCenter

                font.pixelSize: 10
                text: section
                font.bold: true
                color: Material.accent
            }

            MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if(internal.hidden === undefined) internal.hidden = [];

                        if(parent.isHidden) {
                            internal.hidden = internal.hidden.filter(function(n) {
                            return n !== section;
                        });
                        } else {
                            internal.hidden = internal.hidden.concat([section]);
                        }
                    }
            }
        }
    }
}
