import QtQuick 2.0
import QtWebSockets 1.0

WebSocket {
    id: client
    active: true
    url: "ws://127.0.0.1:8002"
    signal player(var data)
    signal sources(var data)
    property ListModel flatStreams: ListModel {}

    onTextMessageReceived: function(data) {
        const msg = JSON.parse(data);
        const topic = msg.topic;
        const payload = msg.data;

        if(topic === 'player') player(payload);
        if(topic === 'sources') sources(payload);
    }

    onStatusChanged: {
        if(this.status == WebSocket.Connecting) console.log('WS connecting\n');
        if(this.status == WebSocket.Open) console.log('WS open\n');
        if(this.status == WebSocket.Closing) console.log('WS closing\n');
        if(this.status == WebSocket.Closed) console.log('WS closed\n');
        if(this.status == WebSocket.Error) console.log('WS Error:', this.errorString , '\n');
    }

    onSources: function(sources) {
        const streams = sources.map(function(source) {
            return source.streams.map(function(stream) {
                stream.source = source.name;

                return stream;
            });
        }).reduce(function(prev, current) {
            return prev.concat(current);
        }, []);

        client.flatStreams.clear();

        streams.forEach(function(stream) {
            client.flatStreams.append(stream);
        });
        console.log("sorce", flatStreams);
    }

    function send(topic, data) {
        const msg = {
            topic: topic,
            data: data
        };
        console.log('sending: ', msg);
        const payload = JSON.stringify(msg);

        this.sendTextMessage(payload);
    }
}
