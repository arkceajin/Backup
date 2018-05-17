import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Controls 1.0
import QtQuick.Dialogs 1.1
import Jiu 1.0
Window {
    visible: true; title: "JiuCML"
    width: 1065
    height: 700

    onClosing: {
        close.accepted = false
        var d, i, str
        jFile.ready()
        for(i = 0; i < dataModel.count; i++){
            d = dataModel.get(i)
            str = d["custom"] + "," +
                  d["type"] + "," +
                  d["transId"] + "," +
                  d["amount"] + "," +
                  d["price"] + "," +
                  d["total"] + "," +
                  d["date"] + "," +
                  d["ref"] + "\n"
            jFile.write(str)
        }
        jFile.closeFile
        Qt.quit()
    }

    Loader {
       id: config
       source: "file:Config.qml"
    }

    JFile{
        id: jFile
        Component.onCompleted: {
            var d, data = jFile.read()
            for(var i in data){
                d = data[i].split(',')
                dataModel.append({  "custom": d[0],
                                      "type": d[1],
                                   "transId": d[2],
                                    "amount": d[3],
                                     "price": d[4],
                                     "total": d[5],
                                      "date": d[6],
                                       "ref": d[7]})
            }
        }
    }

    ListModel{
        id: dataModel
    }

    Column{
        anchors.fill: parent
        Item{
            height: 20; width: parent.width
        }

        Row{
            anchors.horizontalCenter: parent.horizontalCenter
            width: 900; spacing: 10
            Label{
                text: "收货"
                font.pixelSize: 20
                height:30
                verticalAlignment: Text.AlignVCenter
            }
            ComboBox {
                id: custom
                height:30; width: 120
                model: config.item.customer
            }
            Label{
                text: "合同号"
                font.pixelSize: 20
                height:30
                verticalAlignment: Text.AlignVCenter
            }
            InputBox{
                id: transId
                height:30; width: 190
                validator: null
            }
            Label{
                text: "数量"
                font.pixelSize: 20
                height:30
                verticalAlignment: Text.AlignVCenter
            }
            InputBox{
                id: amount
                height:30; width: 80
                onInputChanged: total.update()
            }
            Label{
                text: "单价"
                font.pixelSize: 20
                height:30
                verticalAlignment: Text.AlignVCenter
            }
            InputBox{
                id: price
                height:30; width: 80
                onInputChanged: total.update()
            }
            Label{
                text: "金额"
                font.pixelSize: 20
                height:30
                verticalAlignment: Text.AlignVCenter
            }
            InputBox{
                id: total
                height:30; width: 80
                function update(){
                    total.setInput(price.input * amount.input)
                }
            }
        }
        Item{
            height: 20; width: parent.width
        }
        Row{
            anchors.horizontalCenter: parent.horizontalCenter
            width: 900; spacing: 10
            Label{
                text: "型号"
                font.pixelSize: 20
                height:30
                verticalAlignment: Text.AlignVCenter
            }
            ComboBox {
                id: type
                height:30; width: 120
                model: config.item.type
            }
            Label{
                text: "交货日期"
                font.pixelSize: 20
                height:30
                verticalAlignment: Text.AlignVCenter
            }
            ComboBox {
                id: year
                height:30; width: 50
                model: [2015,2016,2017,2018,2019,2020,2021,2022,2023,2024,2025]
                currentIndex: (new Date().getFullYear()) - 2015
                onCurrentIndexChanged: day.daysInMonth()
            }
            Label{
                text: "年"
                font.pixelSize: 20
                height:30
                verticalAlignment: Text.AlignVCenter
            }
            ComboBox {
                id: month
                height:30; width: 50
                model: [1,2,3,4,5,6,7,8,9,10,11,12]
                currentIndex: (new Date().getMonth())
                onCurrentIndexChanged: day.daysInMonth()
            }
            Label{
                text: "月"
                font.pixelSize: 20
                height:30
                verticalAlignment: Text.AlignVCenter
            }
            ComboBox {
                id: day
                height:30; width: 50
                model: []
                function daysInMonth() {
                    var m = [];
                    for(var i = 1; i<=new Date(year.currentText, month.currentText, 0).getDate(); i++)
                        m.push(i)
                    model = m
                    currentIndex = new Date().getDate() - 1
                }
            }
            Label{
                text: "日"
                font.pixelSize: 20
                height:30
                verticalAlignment: Text.AlignVCenter
            }

            Label{
                text: "备注"
                font.pixelSize: 20
                height:30
                verticalAlignment: Text.AlignVCenter
            }
            InputBox{
                id: ref
                height:30; width: 320
                validator: null
            }
        }
        Item{
            height: 20; width: parent.width
        }
        Button{
            anchors.right: parent.right
            anchors.rightMargin: 50
            text: "添加"
            height:30; width: 100
            onClicked: {
                if(amount.input == ""){
                    amount.focus()
                } else if(price.input == ""){
                    price.focus()
                } else if(total.input == ""){
                    total.focus()
                } else {
                    dataModel.append({  "custom": custom.currentText,
                                          "type": type.currentText,
                                       "transId": transId.input,
                                        "amount": amount.input,
                                         "price": price.input,
                                         "total": total.input,
                                          "date": year.currentText + "-" + month.currentText + "-" + day.currentText,
                                           "ref": ref.input})
                }
            }
        }
        Item{
            height: 40; width: parent.width
        }
        TableView {
            width: parent.width; height: parent.height - 200
            sortIndicatorVisible: true
            TableViewColumn {
                role: "custom"
                title: "收货"
            }
            TableViewColumn {
                role: "type"
                title: "型号"
                width: 100
            }
            TableViewColumn {
                role: "transId"
                title: "合同号"
            }
            TableViewColumn {
                role: "amount"
                title: "数量"
                width: 100
            }
            TableViewColumn {
                role: "price"
                title: "单价"
                width: 100
            }
            TableViewColumn {
                role: "total"
                title: "金额"
                width: 100
            }
            TableViewColumn {
                role: "date"
                title: "交货日期"
            }
            TableViewColumn {
                role: "ref"
                title: "备注"
            }
            model: dataModel
            onDoubleClicked: {
                messageDialog.deleteIndex = row
                messageDialog.open()
            }
        }
    }

    MessageDialog {
        id: messageDialog
        property int deleteIndex: -1
        title: "确认"
        text: "是否删除该行记录？"
        //standardButtons: StandardButton.Yes | StandardButton.No
        onAccepted: {
            dataModel.remove(deleteIndex)
            messageDialog.close()
        }
        onDiscard: {
            messageDialog.close()
        }
    }
}
