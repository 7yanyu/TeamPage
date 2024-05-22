import router from '@ohos.router';

@Entry
@Component
struct Index {
  @State msg1: string = '人事管理系统'
  @State msg2: string = '帮助你更好的管理员工信息'
  @State message: string = '跳转登陆'



  build() {
    Column() {
      Row(){
      }
      .height(40)
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
    .backgroundColor(Color.White)
    //跳转需要改成计时器，计数完成之后自动跳转到登陆页面
    .onClick(()=>{
      router.replaceUrl({
        url:'pages/LoadPage'
      })
    })

     // setTimeout(function (){})

    /*let timeoutMs = 700;  // change it to be correct.
    try {
      tag.getIsoDep(tagInfo).setTimeout(timeoutMs);
      console.log("tag setTimeout success");
    } catch (busiError) {
      console.log("tag setTimeout busiError: " + busiError);
    }*/

  }
  /*timeoutID = setTimeout(function() {
    console.log('do after 1s delay.');
  }, 1000);
  clearTimeout(timeoutID);*/
}