
import router from '@ohos.router'


@Entry
@Component
struct Join_Rec{
  @State message: string = '岗位报表生成'
  private  selectedDate: Date = new Date()
  @State reportUrl: string = ''
  @State posId:number=0

  build() {
    Column(){
      Row(){
        Image($r('app.media.back'))
          .width(30)
          .onClick(()=>{
            router.back()
          })
        Text('岗位报表生成')
          .fontSize(30)
          .margin({left:50})
      }
      .width('90%')
      .margin({top:10})

      Divider()
        .strokeWidth(5)
        .margin({top:5})

      Row(){
        Text('岗位ID')
          .width(100)
        TextInput({placeholder:'请输入岗位ID'})
          .width(200)
          .onChange((value)=>{
            const id=parseInt(value)
            this.posId=id
          })
      }.width('95%')
      .margin(20)

      Button('查询报表')
        .width(100)
        .fontColor('black')
        .backgroundColor('#99D9EA')
        .onClick(() => {
          if (this.posId!=0) {
            this.reportUrl = `     http://182.92.245.184:8018/api/reportsemployees/position/{pos_ID}?pos_ID=${this.posId}`
          } else {
            console.log('请选择起始和结束日期')
          }
        })
        .margin({ top: 30 })


      // 显示生成的超链接
      if (this.reportUrl) {
        Column() {
          Text('查看报表: ')
            .fontSize(20)
            .fontColor('black')
            .width('80%')
          Text(this.reportUrl)
            .fontSize(20)
            .fontColor('blue')
            .width('95%')
        }
        .margin({ top: 20 })
      }

    }
    .height('100%')
    .height('100%')
  }
}


















