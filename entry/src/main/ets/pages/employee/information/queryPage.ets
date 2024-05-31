import router from '@ohos.router'
@Entry
@Component
struct QueryPage {
  @State message: string = '员工查询'
  private list01:string[]=['员工ID','岗位ID','部门ID']


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
          .margin({left:70})
      }
      .width('90%')
      .margin({top:10})

      Divider()
        .strokeWidth(5)
        .margin({top:5})

      Row(){
        ForEach(
          this.list01,
          (item:string)=>{
            Column(){

            }
          })
      }

    }
    .width('100%')
    .height('100%')
  }
}