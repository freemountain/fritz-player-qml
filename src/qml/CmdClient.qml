import QtQuick 2.5
import QtWebSockets 1.0

import QSyncable 1.0

WebSocket {
    id: client
    active: true
    url: "ws://127.0.0.1:8002"

    property var sources:[]
    property var player;

    property Timer timer: Timer {
        id: timer
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            if(client.status == WebSocket.Open) return;
            client.active = false;
            client.active = true;
            console.log("reconnect")
        }
    }

    onTextMessageReceived: function(data) {
        const msg = JSON.parse(data);
        const topic = msg.topic;
        const payload = msg.data;

        if(topic === 'player') player = payload;
        if(topic === 'sources') sources = payload;
    }

    onStatusChanged: {
        if(this.status == WebSocket.Connecting) console.log('WS connecting\n');
        if(this.status == WebSocket.Open) {
            timer.running = false;
            console.log('WS open\n');
            return;
        }

        timer.running = true;
        if(this.status == WebSocket.Closing) console.log('WS closing\n');
        if(this.status == WebSocket.Closed) console.log('WS closed\n');
        if(this.status == WebSocket.Error) console.log('WS Error:', this.errorString , '\n');
    }

    function send(topic, data) {
        const msg = {
            topic: topic,
            data: data
        };
        const payload = JSON.stringify(msg);

        this.sendTextMessage(payload);
    }
}
