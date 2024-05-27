import router from '@ohos.router'
import { Department } from '../../../entity/Department'
import { Add_dep } from '../../../httpRequest/Department/depAdd'
@Entry
@Component
struct AddPage {
  @State message: string = '增加部门'
  @State department:Department=new Department(0,'','','','')
  // private item:Array<string>=['部门ID','部门名称','部门电话','成立时间','部门成立时间','部门简介']
  build() {
    Column({space:15}) {
      Text(this.message)
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .padding({top:40})


      /*List({space:15}){
        ForEach(this.item,
          (content:string)=>{
            ListItem(){
              Column({space:5}){
                Text(content)
                  .fontSize(25)
                  .fontWeight(FontWeight.Bold)
                if(content=='部门简介'){
                  TextArea({placeholder:`请输入${content}`})
                    .width('85%')
                    .backgroundColor('gray')
                }else{
                  TextInput({placeholder:`请输入${content}`})
                    .width('85%')
                    .backgroundColor('gray')
                }
              }
              .width('95%')
              .justifyContent(FlexAlign.Start)
            }
          })
      }*/

      Row(){
        Text('部门ID')
          .fontSize(25)
          .fontWeight(FontWeight.Bold)
      }
      .width('90%')
      .justifyContent(FlexAlign.Start)
      TextInput({placeholder:'请输入部门ID'})
        .onChange((value)=>{
          const id=parseInt(value)
          this.department.dep_ID=id
        })
        .width('85%')
        .backgroundColor('gray')

      Row(){
        Text('部门名称')
          .fontSize(25)
          .fontWeight(FontWeight.Bold)
      }
      .width('90%')
      .justifyContent(FlexAlign.Start)
      TextInput({placeholder:'请输入部门名称'})
        .onChange((value)=>{
          this.department.dep_name=value
        })
        .width('85%')
        .backgroundColor('gray')
      Row(){
        Text('部门电话')
          .fontSize(25)
          .fontWeight(FontWeight.Bold)
      }
      .width('90%')
      .justifyContent(FlexAlign.Start)
      TextInput({placeholder:'请输入部门电话'})
        .onChange((value)=>{
          this.department.dep_phone=value
        })
        .width('85%')
        .backgroundColor('gray')
      Row(){
        Text('部门成立时间')
          .fontSize(25)
          .fontWeight(FontWeight.Bold)
      }
      .width('90%')
      .justifyContent(FlexAlign.Start)
      TextInput({placeholder:'请输入部门成立时间'})
        .onChange((value)=>{
          this.department.creat_date=value
        })
        .width('85%')
        .backgroundColor('gray')
      Row(){
        Text('部门简介')
          .fontSize(25)
          .fontWeight(FontWeight.Bold)
      }
      .width('90%')
      .justifyContent(FlexAlign.Start)
      TextArea({placeholder:'请输入部门简介'})
        .onChange((value)=>{
          this.department.detail=value
        })
        .width('85%')
        .backgroundColor('gray')

      Button('提交')
        .onClick(() => {
          Add_dep(this.department)
            .then((response)=>{
              if(response.toString()=='添加成功'){
                AlertDialog.show({
                  title:'提示',
                  message:'添加成功,是否继续添加',
                  primaryButton:{
                    value:'返回',
                    action:()=>{
                      router.back()
                    }
                  },
                  secondaryButton:{
                    value:'继续',
                    action:()=>{}
                  }
                })
              }
          })
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