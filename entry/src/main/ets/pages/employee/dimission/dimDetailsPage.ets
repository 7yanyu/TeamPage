import router from '@ohos.router'
import { DimUser } from '../../../entity/DimUser'
@Entry
@Component
struct DetailsPage {
  @State message: string = '离职详情'
  @State dimuser:DimUser| null=null
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
          Text(this.dimuser.emp_name.toString())
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
            Text(this.dimuser.emp_ID.toString())
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
            Text(this.dimuser.gender.toString())
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
            Text(this.dimuser.dim_date.toString())
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
            Text(this.dimuser.pos_ID.toString())
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
            Text(this.dimuser.pos_name.toString())
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
            Text(this.dimuser.dep_ID.toString())
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
            Text(this.dimuser.dep_name.toString())
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
            Text(this.dimuser.date.toString())
              .fontSize(25)
              .textAlign(TextAlign.Start)
              .width('70%')
              .padding({top:8})
          }

          Row() {
            Text('转正日期')
              .fontSize(25)
              .fontWeight(FontWeight.Bold)
              .textAlign(TextAlign.Start)
              .width('40%')
              .padding({top:8})
            Text(this.dimuser.confirm_date.toString())
              .fontSize(25)
              .textAlign(TextAlign.Start)
              .width('70%')
              .padding({top:8})
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
            //简介
            Text(this.dimuser.dim_reason)
              .fontSize(25)
              .textAlign(TextAlign.Start)
              .width('80%')
              .padding({top: 8, bottom: 15});
          }


        }
        .width('100%')
        .height('55%')
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

            })
        }


      }




















    } .width('100%')
    .height('100%')
    .backgroundImageSize({width:'100%',height:'100%'})
  }












}