import router from '@ohos.router'
import {EmployeeMov} from '../../../entity/EmployeeMov'
import {Delete_Mov} from '../../../httpRequest/move/Delete_Mov'
@Entry
@Component
struct moveDetailsPage{
  @State message: string = '调动详情'
  @State empmov:EmployeeMov| null=null
  onPageShow() {
    console.log('onInit called'); // 确认 onInit 被调用
    const params = router.getParams() as { empmov: string }; // 类型断言
    console.log('Params:', params); // 打印整个 params 对象
    if (params && params.empmov) {
      const empmovJson = params.empmov;
      console.log('Department JSON:', empmovJson); // 打印 department 参数
      try {
        const empmovData = JSON.parse(empmovJson);
        this.empmov=empmovData
      } catch (e) {
        console.error('Failed to empmov data', e);
      }
    }
  }
  build(){
    Column(){
      Row() {
        Column() {
          Image($r("app.media.back"))
            // .fitOriginalSize(true)
            .width(30)
            .onClick(() => {
              router.back()
            })
        }.width('30%')
        .alignItems(HorizontalAlign.Start)

        Text(this.message)
          .fontSize(30)
          .textAlign(TextAlign.Center)

      }.padding({ top: 15 })
      .width('90%')
      Row({space:25}) {
        Image($r("app.media.test13"))
          .width(80)

        if (this.empmov) {
          Column() {
            Text(this.empmov.emp_name.toString())
              .fontSize(30)
              .textAlign(TextAlign.Start)
            Row({ space: 5 }) {
              Text('员工ID:')
                .fontSize('16')
                .padding({ top: 10 })
                .textAlign(TextAlign.Start)

              Text(this.empmov.emp_ID.toString())
                .fontSize('16')
                .padding({ top: 10 })
                .textAlign(TextAlign.Start)


            }

          }

        }
      }.width('100%')
      .padding({top:10,left:60})
      if(this.empmov){
        Column(){
          Row() {
            Text('调动单号')
              .fontSize(25)
              .fontWeight(FontWeight.Bold)
              .textAlign(TextAlign.Start)
              .width('40%')
              .padding({top:8})
            Text(this.empmov.mov_ID.toString())
              .fontSize(25)
              .textAlign(TextAlign.Start)
              .width('70%')
              .padding({top:8})
          }
          Row() {
            Text('调动类型')
              .fontSize(25)
              .fontWeight(FontWeight.Bold)
              .textAlign(TextAlign.Start)
              .width('40%')
              .padding({top:8})
            Text(this.empmov.movtype.toString())
              .fontSize(25)
              .textAlign(TextAlign.Start)
              .width('70%')
              .padding({top:8})
          }
          Row() {
            Text('调动时间')
              .fontSize(25)
              .fontWeight(FontWeight.Bold)
              .textAlign(TextAlign.Start)
              .width('40%')
              .padding({top:8})
            Text(this.empmov.mov_date.toString())
              .fontSize(25)
              .textAlign(TextAlign.Start)
              .width('70%')
              .padding({top:8})
          }
          Row() {
            Text('原部门ID')
              .fontSize(25)
              .fontWeight(FontWeight.Bold)
              .textAlign(TextAlign.Start)
              .width('40%')
              .padding({top:8})
            Text(this.empmov.before_dep.toString())
              .fontSize(25)
              .textAlign(TextAlign.Start)
              .width('70%')
              .padding({top:8})
          }
          Row() {
            Text('原部门名称')
              .fontSize(25)
              .fontWeight(FontWeight.Bold)
              .textAlign(TextAlign.Start)
              .width('40%')
              .padding({top:8})
            Text(this.empmov.before_depname.toString())
              .fontSize(25)
              .textAlign(TextAlign.Start)
              .width('70%')
              .padding({top:8})
          }
          Row() {
            Text('现部门ID')
              .fontSize(25)
              .fontWeight(FontWeight.Bold)
              .textAlign(TextAlign.Start)
              .width('40%')
              .padding({top:8})
            Text(this.empmov.after_dep.toString())
              .fontSize(25)
              .textAlign(TextAlign.Start)
              .width('70%')
              .padding({top:8})
          }
          Row() {
            Text('现部门名称')
              .fontSize(25)
              .fontWeight(FontWeight.Bold)
              .textAlign(TextAlign.Start)
              .width('40%')
              .padding({top:8})
            Text(this.empmov.after_depname.toString())
              .fontSize(25)
              .textAlign(TextAlign.Start)
              .width('70%')
              .padding({top:8})
          }

          Row() {
            Text('原岗位ID')
              .fontSize(25)
              .fontWeight(FontWeight.Bold)
              .textAlign(TextAlign.Start)
              .width('40%')
              .padding({top:8})
            Text(this.empmov.before_pos.toString())
              .fontSize(25)
              .textAlign(TextAlign.Start)
              .width('70%')
              .padding({top:8})
          }
          Row() {
            Text('原岗位名称')
              .fontSize(25)
              .fontWeight(FontWeight.Bold)
              .textAlign(TextAlign.Start)
              .width('40%')
              .padding({top:8})
            Text(this.empmov.before_posname.toString())
              .fontSize(25)
              .textAlign(TextAlign.Start)
              .width('70%')
              .padding({top:8})
          }

          Row() {
            Text('现岗位ID')
              .fontSize(25)
              .fontWeight(FontWeight.Bold)
              .textAlign(TextAlign.Start)
              .width('40%')
              .padding({top:8})
            Text(this.empmov.after_pos.toString())
              .fontSize(25)
              .textAlign(TextAlign.Start)
              .width('70%')
              .padding({top:8})
          }
          Row() {
            Text('现岗位名称')
              .fontSize(25)
              .fontWeight(FontWeight.Bold)
              .textAlign(TextAlign.Start)
              .width('40%')
              .padding({top:8})
            Text(this.empmov.after_posname.toString())
              .fontSize(25)
              .textAlign(TextAlign.Start)
              .width('70%')
              .padding({top:8})
          }
          Row() {
            Text('调动原因:')
              .fontSize(25)
              .fontWeight(FontWeight.Bold)
              .textAlign(TextAlign.Start)
              .width('100%')
              .padding({top: 8})

          }
          Row() {
            if (this.empmov.reason !== null) {
              Text(this.empmov.reason)
                .fontSize(20)
                .textAlign(TextAlign.Start)
                .width('80%')
                .padding({ top: 8, bottom: 15 });
            }
          }

        }
        .width('100%')
        .height('65%')
        .padding({ left: 20,})
        // .backgroundColor('red')
        .alignItems(HorizontalAlign.Center)
        .shadow({ color: 'gray', radius: 15 })

        Row(){
          Text('删除')
            .fontColor('red')
            .fontSize('20')
            .padding({top:28})
            .onClick(()=>{
              AlertDialog.show({
                title:'提示',
                message:'是否确认删除该调动信息',
                primaryButton:{
                  value:'No',
                  action:()=>{}
                },
                secondaryButton:{
                  value:'Yes',
                  action:()=>{
                    //先查询部门内人员是否为空，为空再进行删除操作
                    Delete_Mov(this.empmov.mov_ID)
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






















    }.width('100%')
    .height('100%')
    .backgroundImageSize({width:'100%',height:'100%'})
  }


}