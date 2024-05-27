import router from '@ohos.router';
import {secondsSub} from '../module/setInterval'
@Entry
@Component
struct Index {
  @State msg1: string = '人事管理系统'
  @State msg2: string = '帮助你更好的管理员工信息'
  @State message: string = '跳转登陆'
  @State seconds:number=5

  build() {
    Column() {
      Row(){

        Button(`跳过  ${this.seconds}s`)

          .fontColor('black')
          .backgroundColor('green')
          .onClick(()=> {
            router.replaceUrl({
              url: 'pages/LoadPage'
            })
          })
        // this.seconds=secondsSub(this.seconds)

      }
      .width('90%')
      .padding({top:10})
      // .height(40)
      .justifyContent(FlexAlign.End)


      Row(){
        Text(this.msg1)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
      }
      .height(360)
      .alignItems(VerticalAlign.Center)
      Row(){
        Text(this.msg2)
          .fontSize(17)
      }
      Row(){
        Image($r('app.media.app_icon'))
          .width(300)
      }
      .height(360)
      .alignItems(VerticalAlign.Bottom)
    }
    .width('100%')
    .height('100%')
  }
}
