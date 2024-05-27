import { backButton } from '../module/backButton'
@Entry
@Component
struct ProtocolPage {
  @State message: string = '《用户协议》与《隐私政策》:'

  build() {
    Column() {
      backButton({msg:'登陆'})
      Row(){
        Text(this.message+'')
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)



    }
    .width('100%')
    .height('100%')
    // .backgroundColor('grey')
  }
}