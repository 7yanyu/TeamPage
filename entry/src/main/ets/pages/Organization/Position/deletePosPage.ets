import { Position } from '../../../entity/Position'
import { Delete_pos } from '../../../httpRequest/Position/posDelete'
@Entry
@Component
struct DeletePosPage {
  @State message: string = '删除岗位'
  @State posId:number=0
  build() {
    Column({space:20}) {
      Text(this.message)
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .margin({top:50})
      TextInput({placeholder:'请输入需要删除的岗位ID'})
        .onChange((value)=>{
          const valueId=parseInt(value)
          this.posId=valueId
        })
        .width('85%')
        .backgroundColor('gray')
        .margin({top:40})
      Button('删除')
        .margin({top:30})
        .onClick(()=>{
          if(this.posId!=0){
            AlertDialog.show({
              title:'提示',
              message:'是否确认删除该岗位',
              primaryButton:{
                value:'No',
                action:()=>{}
              },
              secondaryButton:{
                value:'Yes',
                action:()=>{
                  //先查询岗位内人员是否为空，为空再进行删除操作
                  Delete_pos(this.posId)
                }
              }
            })
          }else{
            AlertDialog.show({
              title:'错误',
              message:'请填写需要删除部门的ID',
              primaryButton:{
                value:'Yes',
                action:()=>{}
              }
            })
          }

        })
    }
    .width('100%')
    .height('100%')
    .backgroundImage($r("app.media.MainBackground"))
    .backgroundImageSize({width:'100%',height:'100%'})
  }
}