@Entry
@Component
struct ChangePosPage {
  @State message: string = '修改岗位信息'

  build() {
    Column({space:10}) {
      Text(this.message)
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .margin({top:20})

      Row(){
        Text('岗位ID')
          .fontSize(25)
          .fontWeight(FontWeight.Bold)
      }
      .width('90%')
      .justifyContent(FlexAlign.Start)
      TextInput({placeholder:'请输入岗位ID'})
        .width('85%')
        .backgroundColor('gray')

      Row(){
        Text('岗位名称')
          .fontSize(25)
          .fontWeight(FontWeight.Bold)
      }
      .width('90%')
      .justifyContent(FlexAlign.Start)
      TextInput({placeholder:'请输入岗位名称'})
        .width('85%')
        .backgroundColor('gray')
      Row(){
        Text('岗位成立时间')
          .fontSize(25)
          .fontWeight(FontWeight.Bold)
      }
      .width('90%')
      .justifyContent(FlexAlign.Start)
      TextInput({placeholder:'请输入岗位成立时间'})
        .width('85%')
        .backgroundColor('gray')

      Row(){
        Text('岗位所属部门ID')
          .fontSize(25)
          .fontWeight(FontWeight.Bold)
      }
      .width('90%')
      .justifyContent(FlexAlign.Start)
      TextInput({placeholder:'请输入岗位所属部门ID'})
        .width('85%')
        .backgroundColor('gray')

      Row(){
        Text('岗位所属部门名称')
          .fontSize(25)
          .fontWeight(FontWeight.Bold)
      }
      .width('90%')
      .justifyContent(FlexAlign.Start)
      TextInput({placeholder:'请输入岗位所属部门名称'})
        .width('85%')
        .backgroundColor('gray')
      Row(){
        Text('岗位介绍')
          .fontSize(25)
          .fontWeight(FontWeight.Bold)
      }
      .width('90%')
      .justifyContent(FlexAlign.Start)
      TextArea({placeholder:'请输入该岗位的相关介绍'})
        .width('85%')
        .backgroundColor('gray')

      Button('提交')
        .onClick(() => {
          //调用接口，新增岗位
        })
        .width(100)
        .margin(20)
    }
    .width('100%')
    .height('100%')
    .backgroundImage($r("app.media.MainBackground"))
    .backgroundImageSize({width:'100%',height:'100%'})
  }
}