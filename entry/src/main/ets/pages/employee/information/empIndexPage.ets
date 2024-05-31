import router from '@ohos.router'
import { Item } from '../../FirstPage'
@Entry
@Component
struct EmpIndexPage {
  @State message: string = '员工信息'

  private  list01:Array<Item>=[
    new Item($r('app.media.try'),'试用管理','pages/employee/information/tryPage'),
    new Item($r('app.media.query'),'员工查询','pages/employee/information/queryPage'),
    new Item($r('app.media.career'),'职业生涯','pages/employee/information/careerPage')
  ]
  private  list02:Array<Item>=[
    new Item($r('app.media.language'),'外语能力','pages/employee/information/languagePage'),
    new Item($r('app.media.family'),'家庭关系','pages/employee/information/familyPage'),
    new Item($r('app.media.monthlyReport'),'人事月报','pages/employee/information/monthlyReportPage')
  ]

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
        //try,query,career
        ForEach(
          this.list01,
          (item:Item)=>{
            Column({space:15}){
              Image(item.img)
                // .fitOriginalSize(true)
                .width(60)
                .onClick(()=>{
                  router.pushUrl({
                    url:item.url,
                  })
                })
              Text(item.msg)
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
            }
          })
      }
      .width('85%')
      .height(100)
      .justifyContent(FlexAlign.SpaceBetween)
      .margin(50)

      Row(){
        //language,family,monthlyReport
        ForEach(
          this.list02,
          (item:Item)=>{
            Column({space:15}){
              Image(item.img)
                // .fitOriginalSize(true)
                .width(60)
                .onClick(()=>{
                  router.pushUrl({
                    url:item.url,
                  })
                })
              Text(item.msg)
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
            }
          })
      }
      .width('85%')
      .height(100)
      .justifyContent(FlexAlign.SpaceBetween)
      .margin(5)


    }
    .width('100%')
    .height('100%')
  }
}