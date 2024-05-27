@Entry
@Component
struct DetailsPage {
  @State message: string = '岗位详情'
  @State detail:string=''

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
          Text()
            .fontSize(25)
            .margin({left:60})
        }

        Row(){
          Text('岗位ID')
            .fontSize(25)
            .fontWeight(FontWeight.Bold)
          Text()
            .fontSize(25)
            .margin({left:60})
        }

        Row(){
          Text('成立时间')
            .fontSize(25)
            .fontWeight(FontWeight.Bold)
            .backgroundColor('green')
          Text()
            .fontSize(25)
            .margin({left:60})
        }

        Row(){
          Text('所属部门ID')
            .fontSize(25)
            .fontWeight(FontWeight.Bold)
          Text()
            .fontSize(25)
            .margin({left:60})
        }

        Row(){
          Text('所属部门名称')
            .fontSize(25)
            .fontWeight(FontWeight.Bold)
          Text()
            .fontSize(25)
            .margin({left:60})
        }

        Row(){
          //简介
          Text('gai')
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
            .backgroundColor('blue')
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