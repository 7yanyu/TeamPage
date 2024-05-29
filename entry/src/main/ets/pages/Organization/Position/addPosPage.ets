import { Position } from '../../../entity/Position'
import { Add_pos } from '../../../httpRequest/Position/posAdd'
@Entry
@Component
struct AddPosPage {
  @State message: string = '增加岗位'
  @State pos:Position=new Position(0,'','','','','')

  build() {
    Column({space:10}) {
      Text(this.message)
        .fontSize(50)
        .fontWeight(FontWeight.Bold)

      Row(){
        Text('岗位ID')
          .fontSize(25)
          .fontWeight(FontWeight.Bold)
      }
      .width('90%')
      .justifyContent(FlexAlign.Start)
      TextInput({placeholder:'请输入岗位ID'})
        .onChange((value)=>{
          const id=parseInt(value)
          this.pos.pos_ID=id
        })
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
        .onChange((value)=>{
          this.pos.pos_name=value
        })
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
        .onChange((value)=>{
          this.pos.creat_date=value
        })
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
        .onChange((value)=>{
          this.pos.dep_ID=value
        })
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
        .onChange((value)=>{
          this.pos.dep_name=value
        })
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
        .onChange((value)=>{
          this.pos.detail=value
        })
        .width('85%')
        .backgroundColor('gray')

      Button('提交')
        .onClick(() => {
          //调用接口，新增岗位
          Add_pos(this.pos)
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