import QtQuick 2.4
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0

Item {
    width: 400
    height: 400

    GroupBox {
        id: groupBox1
        x: 54
        y: 28
        width: 227
        height: 272
        title: qsTr("Group Box")

        Dial {
            id: dial1
            x: 10
            y: 21
        }
    }
}
