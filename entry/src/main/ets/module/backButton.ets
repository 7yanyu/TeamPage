import router from '@ohos.router'
@Component
export struct backButton{

  @State msg:string=''
  build(){
    Row(){
      Button('< Back')
        .fontSize(20)
        .onClick(()=>{
          router.showAlertBeforeBackPage({
            message:`确认返回${this.msg}界面？`
          })
          router.back()
        })
    }
    .width('100%')
    .height(100)
    .padding(15)
    .alignItems(VerticalAlign.Top)
  }
}