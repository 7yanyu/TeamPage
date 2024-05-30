import router from '@ohos.router'
import { Position } from '../../../entity/Position'
import {Delete_pos} from '../../../httpRequest/Position/posDelete'
@Entry
@Component
struct DetailsPage {
  @State message: string = '岗位详情'
  @State pos:Position| null=null

  onPageShow() {
    console.log('onInit called'); // 确认 onInit 被调用
    const params = router.getParams() as { pos: string }; // 类型断言
    console.log('Params:', params); // 打印整个 params 对象
    if (params && params.pos) {
      const positionJson = params.pos;
      console.log('Department JSON:', positionJson); // 打印 department 参数
      try {
        const positionData = JSON.parse(positionJson);
        this.pos = new Position(
          positionData.pos_ID,
          positionData.pos_name,
          positionData.creat_date,
          positionData.dep_ID,
          positionData.dep_name,
          positionData.detail
        );
        console.log('Department Phone:', this.pos.pos_name); // 确认数据解析成功
      } catch (e) {
        console.error('Failed to parse position data', e);
      }
    }
  }

  build() {
    Column() {


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

      Row() {
        Column() {
          Image($r("app.media.test6"))
            .width(80)
        }.width('30%')
        .alignItems(HorizontalAlign.Start)
        .padding({ top: 20, left: 10 })

      }

    if(this.pos){
      Column() {
        Row() {
          Text('岗位名称')
            .fontSize(25)
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Start)
            .width('40%')
            .padding({top:5})
          Text(this.pos.pos_name)
            .fontSize(25)
            .textAlign(TextAlign.Start)
            .width('70%')
            .padding({top:5})
        }

        Row() {
          Text('岗位ID')
            .fontSize(25)
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Start)
            .width('40%')
            .padding({top: 10});
          Text(this.pos.pos_ID.toString())
            .fontSize(25)
            .textAlign(TextAlign.Start)
            .width('70%')
            .padding({top: 10,left:15});
        }

        Row() {
          Text('成立时间')
            .fontSize(25)
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Start)
            .width('40%')
            .padding({top: 10})
          // .backgroundColor('green')
          Text(this.pos.creat_date)
            .fontSize(25)
            .textAlign(TextAlign.Start)
            .width('70%')
            .padding({top: 10});
        }

        Row() {
          Text('部门ID')
            .fontSize(25)
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Start)
            .width('40%')
            .padding({top: 10})
          Text(this.pos.dep_ID)
            .fontSize(25)
            .textAlign(TextAlign.Start)
            .width('70%')
            .padding({top: 10,left:15});
        }

        Row() {
          Text('部门名称')
            .fontSize(25)
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Start)
            .width('40%')
            .padding({top: 10})
          Text(this.pos.dep_name)
            .fontSize(25)
            .textAlign(TextAlign.Start)
            .width('70%')
            .padding({top: 10});
        }


        Row() {
          Text('岗位简介:')
            .fontSize(25)
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Start)
            .width('100%')
            .padding({top: 15, bottom: 15})

        }
        Row(){
          //简介
          Text(this.pos.detail)
            .fontSize(25)
            .textAlign(TextAlign.Start)
            .width('80%')
            .padding({top: 10, bottom: 15});
        }
      }
      .width('100%')
      .height('55%')
      .padding({ left: 25, top: 15 })
      // .backgroundColor('red')
      .alignItems(HorizontalAlign.Start)
      .shadow({ color: 'gray', radius: 15 })
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
                  //先查询岗位内人员是否为空，为空再进行删除操作
                  Delete_pos(this.pos.pos_ID)
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