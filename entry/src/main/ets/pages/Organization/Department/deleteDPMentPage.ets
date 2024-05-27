import { Department } from '../../../entity/Department'
import { Delete_dep } from '../../../httpRequest/Department/depDelete'
@Entry
@Component
struct DeleteDPMentPage {
  @State message: string = '删除部门'
  @State delete_id:number = 0

  build() {
    Column({space:20}) {
      Text(this.message)
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .margin({top:50})
      TextInput({placeholder:'请输入需要删除的部门ID'})
        .onChange((value)=>{
          const valueId=parseInt(value)
          this.delete_id=valueId
        })
        .width('85%')
        .backgroundColor('gray')
        .margin({top:40})
      Button('删除')
        .width(100)
        .margin({top:30})
        .onClick(()=>{
          if(this.delete_id!=0){
            AlertDialog.show({
              title:'提示',
              message:'是否确认删除该部门',
              primaryButton:{
                value:'No',
                action:()=>{}
              },
              secondaryButton:{
                value:'Yes',
                action:()=>{
                  //先查询部门内人员是否为空，为空再进行删除操作
                  Delete_dep(this.delete_id)
                    .then((response)=>{
                      if(response){
                        console.log('successed delete')
                      }else{
                        console.log('failed delete')
                      }
                    })
                }
              }
            })
          }else {
            AlertDialog.show({
              title: '错误',
              message: '请填写需要删除部门的ID',
              primaryButton: {
                value: 'Yes',
                action: () => {
                }
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