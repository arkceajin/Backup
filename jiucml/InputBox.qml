import QtQuick 2.0

Rectangle {
    radius: height * 0.2
    border.color: (textInput.focus)? "#0066ff": "#c6c6c6"
    color: "#f9f9f9"
    property string input: textInput.text
    property var validator: DoubleValidator{ bottom: 0 }
    TextInput{
        id: textInput
        anchors.fill: parent;
        wrapMode: TextInput.WrapAnywhere
        verticalAlignment: TextInput.AlignVCenter
        horizontalAlignment: TextInput.AlignHCenter
        validator: parent.validator
        activeFocusOnPress: false
        font.pixelSize: 18
        color: "#333"
        MouseArea{
            anchors.fill: parent
            onPressed: {
                parent.forceActiveFocus()
            }
        }
    }
    function setInput(s){
        textInput.text = s;
    }
    function focus(){
        textInput.forceActiveFocus()
    }
}
