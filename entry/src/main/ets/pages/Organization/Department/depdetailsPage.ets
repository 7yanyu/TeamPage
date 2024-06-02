import {Department} from '../../../entity/Department'
import router from '@ohos.router';
import { Delete_dep } from '../../../httpRequest/Department/depDelete'

@Entry
@Component
struct introduceDPMPage {
  @State message: string = '部门详情'
  @State department: Department | null = null
  onPageShow() {
    console.log('onInit called'); // 确认 onInit 被调用
    const params = router.getParams() as { department: string }; // 类型断言
    console.log('Params:', params); // 打印整个 params 对象
    if (params && params.department) {
      const departmentJson = params.department;
      console.log('Department JSON:', departmentJson); // 打印 department 参数
      try {
        const departmentData = JSON.parse(departmentJson);
        this.department = new Department(
          departmentData.dep_ID,
          departmentData.dep_name,
          departmentData.dep_phone,
          departmentData.creat_date,
          departmentData.detail
        );
        console.log('Department Phone:', this.department.dep_phone); // 确认数据解析成功
      } catch (e) {
        console.error('Failed to parse department data', e);
      }
    }
  }

  build() {
    Column() {

      Row(){
        Column(){
          Image($r("app.media.back"))
            // .fitOriginalSize(true)
            .width(30)
            .onClick(()=>{
              router.back()
            })
        }.width('30%')
        .alignItems(HorizontalAlign.Start)
        Text(this.message)
          .fontSize(30)
          .textAlign(TextAlign.Center)

      }.padding({top:15})
      .width('90%')


      Row(){
        Column(){
          Image($r("app.media.test4"))
            .width(80)
        }.width('30%')
        .alignItems(HorizontalAlign.Start)
        .padding({top:20,left:10})

      }


      if(this.department){
        Column() {
          Row() {
            Text('部门名称:')
              .fontSize(25)
              .fontWeight(FontWeight.Bold)
              .textAlign(TextAlign.Start)
              .width('40%')
              .padding({top: 15, bottom: 15});
            Text(this.department.dep_name)
              .fontSize(25)
              .textAlign(TextAlign.Start)
              .width('70%')
              .padding({top: 15, bottom: 15});
          }
          Row() {
            Text('部门ID:')
              .fontSize(25)
              .fontWeight(FontWeight.Bold)
              .textAlign(TextAlign.Start)
              .width('40%')
              .padding({top: 15, bottom: 15});
            Text(this.department.dep_ID.toString())
              .fontSize(25)
              .textAlign(TextAlign.Start)
              .width('70%')
              .padding({top: 15, bottom: 15});
          }


          Row() {
            Text('部门电话:')
              .fontSize(25)
              .fontWeight(FontWeight.Bold)
              .textAlign(TextAlign.Start)
              .width('40%')
              .padding({top: 15, bottom: 15});
            Text(this.department.dep_phone)
              .fontSize(25)
              .textAlign(TextAlign.Start)
              .width('70%')
              .padding({top: 15, bottom: 15});
          }

          Row() {
            Text('成立时间:')
              .fontSize(25)
              .fontWeight(FontWeight.Bold)
              .textAlign(TextAlign.Start)
              .width('40%')
              .padding({top: 15, bottom: 15});
            Text(this.department.creat_date)
              .fontSize(25)
              .textAlign(TextAlign.Start)
              .width('70%')
              .padding({top: 15, bottom: 15});
          }

          Row() {
            Text('部门简介:')
              .fontSize(25)
              .fontWeight(FontWeight.Bold)
              .textAlign(TextAlign.Start)
              .width('100%')
              .padding({top: 15, bottom: 15})
          }
          Row(){
            Text(this.department.detail)
              .fontSize(25)
              .textAlign(TextAlign.Start)
              .width('80%')
              .padding({top: 10, bottom: 15});
          }
        }  .width('100%')
        .height('60%')
        .padding({left:25,top:15})
        // .backgroundColor('red')
        .alignItems(HorizontalAlign.Start)
        .shadow({color:'gray',radius:15})

      }

      Row(){
        Text('删除')
          .fontColor('red')
          .fontSize('20')
          .padding({top:28})
          .onClick(()=>{
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
                  Delete_dep(this.department.dep_ID)
                    .then((response)=>{
                      if(response){
                        AlertDialog.show({
                          title:'提示',
                          message:'删除成功',
                          primaryButton:{
                            value:'确认',
                            action:()=>{
                              router.back()
                            }
                          }
                        })

                        console.log('successed delete')
                      }else{
                        console.log('failed delete')
                      }
                    })
                }
              }
            })


          })
      }


    }
    .width('100%')
    .height('100%')
    .backgroundImageSize({width:'100%',height:'100%'})
  }
}