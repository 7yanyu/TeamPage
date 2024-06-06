import router from '@ohos.router'
import { DimUser } from '../../../entity/DimUser'
import { Process } from '../../../entity/Process'
import { agreeDim } from '../../../httpRequest/Dimission/agreeDim'
import {Delete_dim} from  '../../../httpRequest/dimission/Delete_dim'
import { rejectDim } from '../../../httpRequest/Dimission/rejectDim'
@Entry
@Component
struct DetailsPage {
  @State message: string = '离职详情'
  @State dimuser:DimUser=new DimUser()
  @State empId:string=''
  @State depId:string=''
  @State posId:string=''

  @State process:Process=new Process(0,'')
  private selectedDate: Date = new Date()


  onPageShow() {
    console.log('onInit called'); // 确认 onInit 被调用
    const params = router.getParams() as { dimuser: string }; // 类型断言
    console.log('Params:', params); // 打印整个 params 对象
    if (params && params.dimuser) {
      const dimuserJson = params.dimuser;
      console.log('Department JSON:', dimuserJson); // 打印 department 参数
      try {
        const dimuserData = JSON.parse(dimuserJson);
        this.dimuser=dimuserData
        this.empId=this.dimuser.emp_ID.toString()
        this.depId=this.dimuser.dep_ID.toString()
        this.posId=this.dimuser.pos_ID.toString()

        console.log('empId:'+this.empId)
        console.log('dimuser:'+JSON.stringify(this.dimuser))
      } catch (e) {
        console.error('Failed to dimuser data', e);
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
        Image($r("app.media.test9"))
          .width(80)

        if(this.dimuser){
          Text(this.dimuser.emp_name)
            .fontSize(30)
            .textAlign(TextAlign.Start)

        }
      }.width('100%')
      .padding({top:10,left:60})

      if(this.dimuser){
        Column(){
          Row() {
            Text('员工ID')
              .fontSize(25)
              .fontWeight(FontWeight.Bold)
              .textAlign(TextAlign.Start)
              .width('40%')
              .padding({top:8})
            Text(this.empId)
              .fontSize(25)
              .textAlign(TextAlign.Start)
              .width('70%')
              .padding({top:8})
          }
          Row() {
            Text('性别')
              .fontSize(25)
              .fontWeight(FontWeight.Bold)
              .textAlign(TextAlign.Start)
              .width('40%')
              .padding({top:8})
            Text(this.dimuser.gender)
              .fontSize(25)
              .textAlign(TextAlign.Start)
              .width('70%')
              .padding({top:8})
          }
          Row() {
            Text('离职日期')
              .fontSize(25)
              .fontWeight(FontWeight.Bold)
              .textAlign(TextAlign.Start)
              .width('40%')
              .padding({top:8})
            // Text(this.dimuser.process_date)
            //   .fontSize(25)
            //   .textAlign(TextAlign.Start)
            //   .width('70%')
            //   .padding({top:8})

            Button(this.process.date|| ' 年 / 月 / 日 ')
              .backgroundColor('#F5F5F5')
              .fontColor('#459ED4')
              .onClick(() => {
                DatePickerDialog.show({
                  start: new Date("2000-1-1"),
                  end: new Date("2100-12-31"),
                  selected: this.selectedDate,
                  onAccept: (value: DatePickerResult) => {
                    // 通过Date的setFullYear方法设置按下确定按钮时的日期，这样当弹窗再次弹出时显示选中的是上一次确定的日期
                    this.selectedDate.setFullYear(value.year, value.month, value.day)
                    console.info("DatePickerDialog:onAccept()" + `${value.year}-${value.month + 1}-${value.day}`)
                    this.process.date = `${value.year}-${value.month + 1}-${value.day}`
                  }
                })
              })

          }
          .width('100%')


          Row() {
            Text('原岗位ID')
              .fontSize(25)
              .fontWeight(FontWeight.Bold)
              .textAlign(TextAlign.Start)
              .width('40%')
              .padding({top:8})
            Text(this.posId)
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
            Text(this.dimuser.pos_name)
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
            Text(this.depId)
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
            Text(this.dimuser.dep_name)
              .fontSize(25)
              .textAlign(TextAlign.Start)
              .width('70%')
              .padding({top:8})
          }
          Row() {
            Text('入职日期')
              .fontSize(25)
              .fontWeight(FontWeight.Bold)
              .textAlign(TextAlign.Start)
              .width('40%')
              .padding({top:8})
            Text(this.dimuser.date)
              .fontSize(25)
              .textAlign(TextAlign.Start)
              .width('70%')
              .padding({top:8})
          }
          if (this.dimuser.confirm_date !== null ){
            Row() {
              Text('转正日期')
                .fontSize(25)
                .fontWeight(FontWeight.Bold)
                .textAlign(TextAlign.Start)
                .width('40%')
                .padding({top:8})

              Text(this.dimuser.confirm_date)
                .fontSize(25)
                .textAlign(TextAlign.Start)
                .width('70%')
                .padding({top:8})


            }
          }



          Row() {
            Text('离职原因:')
              .fontSize(25)
              .fontWeight(FontWeight.Bold)
              .textAlign(TextAlign.Start)
              .width('100%')
              .padding({top: 8})

          }
          Row(){
            if (this.dimuser.reason !== null ){
              Text(this.dimuser.reason)
                .fontSize(25)
                .textAlign(TextAlign.Start)
                .width('80%')
                .padding({top: 8, bottom: 15});
            }
            //简介

          }


        }
        .width('100%')
        .height('55%')
        .padding({ left: 20,})
        // .backgroundColor('red')
        .alignItems(HorizontalAlign.Center)
        .shadow({ color: 'gray', radius: 15 })
        Row(){
          Text('同意')
            .fontColor('blue')
            .fontSize(20)
            .padding({top:28})
            .onClick(()=>{
              AlertDialog.show({
                title:'提示',
                message:'同意该员工的离职',
                primaryButton:{
                  value:'No',
                  action:()=>{}
                },
                secondaryButton:{
                  value:'Yes',
                  action:()=>{
                    this.process.id=this.dimuser.emp_ID
                    agreeDim(this.process)
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
          Text('拒绝')
            .fontColor('red')
            .fontSize('20')
            .padding({top:28})
            .onClick(()=>{
              AlertDialog.show({
                title:'提示',
                message:'拒绝该员工的离职',
                primaryButton:{
                  value:'No',
                  action:()=>{}
                },
                secondaryButton:{
                  value:'Yes',
                  action:()=>{
                    this.process.id=this.dimuser.emp_ID
                    rejectDim(this.process)
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
        .width(250)
        .justifyContent(FlexAlign.SpaceAround)


      }

    } .width('100%')
    .height('100%')
    .backgroundImageSize({width:'100%',height:'100%'})
  }
}