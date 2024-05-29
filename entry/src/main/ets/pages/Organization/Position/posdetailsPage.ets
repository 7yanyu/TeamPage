import router from '@ohos.router'
import { Position } from '../../../entity/Position'
@Entry
@Component
struct DetailsPage {
  @State message: string = '岗位详情'
  @State detail:string=''
  @State pos:Position=new Position(0,'','','','','')

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
      Text(this.message)
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .margin({top:40,bottom:35})
      Column({space:30}){
        Row(){
          Text('岗位名称')
            .fontSize(25)
            .fontWeight(FontWeight.Bold)
          Text(this.pos.pos_name)
            .fontSize(25)
            .margin({left:60})
        }

        Row(){
          Text('岗位ID')
            .fontSize(25)
            .fontWeight(FontWeight.Bold)
          Text(this.pos.pos_ID.toString())
            .fontSize(25)
            .margin({left:60})
        }

        Row(){
          Text('成立时间')
            .fontSize(25)
            .fontWeight(FontWeight.Bold)
            // .backgroundColor('green')
          Text(this.pos.creat_date)
            .fontSize(25)
            .margin({left:60})
        }

        Row(){
          Text('所属部门ID')
            .fontSize(25)
            .fontWeight(FontWeight.Bold)
          Text(this.pos.dep_ID)
            .fontSize(25)
            .margin({left:60})
        }

        Row(){
          Text('所属部门名称')
            .fontSize(25)
            .fontWeight(FontWeight.Bold)
          Text(this.pos.dep_name)
            .fontSize(25)
            .margin({left:60})
        }

        Row(){
          //简介
          Text(this.pos.detail)
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
            // .backgroundColor('blue')
            .margin({left:55})
        }
      }
      .width('100%')
      .height('75%')
      .padding({left:25,top:15})
      // .backgroundColor('red')
      .alignItems(HorizontalAlign.Start)
      .shadow({color:'gray',radius:15})
    }
    .width('100%')
    .height('100%')
    .backgroundImage($r("app.media.MainBackground"))
    .backgroundImageSize({width:'100%',height:'100%'})
  }
}