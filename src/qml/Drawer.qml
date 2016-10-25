import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtQuick.Controls.Universal 2.0

Drawer {
    id: drawer
    width: Math.min(window.width, window.height) / 3 * 2
    height: window.height
    visible: true

    ListView {
        id: listView
        currentIndex: -1
        anchors.fill: parent

        delegate: ItemDelegate {
            width: parent.width
            text: model.title
            highlighted: ListView.isCurrentItem
            onClicked: {/*
                if (listView.currentIndex != index) {
                    listView.currentIndex = index
                    titleLabel.text = model.title
                    stackView.replace(model.source)
                }*/
                drawer.close()
            }
        }

        model: ListModel {
            ListElement { title: "BusyIndicator" }
            ListElement { title: "Button" }
            /*
            ListElement { title: "BusyIndicator"; source: "qrc:/pages/BusyIndicatorPage.qml" }
            ListElement { title: "Button"; source: "qrc:/pages/ButtonPage.qml" }
            ListElement { title: "CheckBox"; source: "qrc:/pages/CheckBoxPage.qml" }
            ListElement { title: "ComboBox"; source: "qrc:/pages/ComboBoxPage.qml" }
            ListElement { title: "Dial"; source: "qrc:/pages/DialPage.qml" }
            ListElement { title: "Delegates"; source: "qrc:/pages/DelegatePage.qml" }
            ListElement { title: "Drawer"; source: "qrc:/pages/DrawerPage.qml" }
            ListElement { title: "Frame"; source: "qrc:/pages/FramePage.qml" }
            ListElement { title: "GroupBox"; source: "qrc:/pages/GroupBoxPage.qml" }
            ListElement { title: "Menu"; source: "qrc:/pages/MenuPage.qml" }
            ListElement { title: "PageIndicator"; source: "qrc:/pages/PageIndicatorPage.qml" }
            ListElement { title: "Popup"; source: "qrc:/pages/PopupPage.qml" }
            ListElement { title: "ProgressBar"; source: "qrc:/pages/ProgressBarPage.qml" }
            ListElement { title: "RadioButton"; source: "qrc:/pages/RadioButtonPage.qml" }
            ListElement { title: "RangeSlider"; source: "qrc:/pages/RangeSliderPage.qml" }
            ListElement { title: "ScrollBar"; source: "qrc:/pages/ScrollBarPage.qml" }
            ListElement { title: "ScrollIndicator"; source: "qrc:/pages/ScrollIndicatorPage.qml" }
            ListElement { title: "Slider"; source: "qrc:/pages/SliderPage.qml" }
            ListElement { title: "SpinBox"; source: "qrc:/pages/SpinBoxPage.qml" }
            ListElement { title: "StackView"; source: "qrc:/pages/StackViewPage.qml" }
            ListElement { title: "SwipeView"; source: "qrc:/pages/SwipeViewPage.qml" }
            ListElement { title: "Switch"; source: "qrc:/pages/SwitchPage.qml" }
            ListElement { title: "TabBar"; source: "qrc:/pages/TabBarPage.qml" }
            ListElement { title: "TextArea"; source: "qrc:/pages/TextAreaPage.qml" }
            ListElement { title: "TextField"; source: "qrc:/pages/TextFieldPage.qml" }
            ListElement { title: "ToolTip"; source: "qrc:/pages/ToolTipPage.qml" }
            ListElement { title: "Tumbler"; source: "qrc:/pages/TumblerPage.qml" }*/
        }

        ScrollIndicator.vertical: ScrollIndicator { }
    }
}
