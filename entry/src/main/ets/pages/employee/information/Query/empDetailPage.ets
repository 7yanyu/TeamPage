import router from '@ohos.router'
@Entry
@Component
struct EmpDetailPage {
  @State message: string = '员工详细信息'

  build() {
    Column() {
      Row(){
        Image($r('app.media.back'))
          .width(30)
          .onClick(()=>{
            router.back()
          })
        Text(this.message)
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .margin({left:50})
        Blank()
        Text('修改')
          .fontColor('#36B8D0')
          .onClick(()=>{
            //update

          })

      }
      .width('95%')
      .margin({top:10})

      Divider()
        .strokeWidth(5)
        .margin({top:5})






    }
    .width('100%')
    .height('100%')
  }
}