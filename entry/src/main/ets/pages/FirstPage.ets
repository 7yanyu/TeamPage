import router from '@ohos.router'

@Entry
@Component
struct FirstPage {
  private swiperController:SwiperController=new SwiperController()
  private  list01:Array<Item>=[
    new Item($r('app.media.icon'),'部门管理','pages/Organization/Department/selectDPMentPage'),
    new Item($r('app.media.icon'),'岗位管理','pages/Organization/Position/selectPosPage'),
    new Item($r('app.media.icon'),'员工信息','pages/employee/information/empIndexPage')
  ]
  private  list02:Array<Item>=[
    new Item($r('app.media.icon'),'离职管理','pages/employee/dimission/dimIndexPage'),
    new Item($r('app.media.icon'),'入职管理','pages/employee/joined/joinIndexPage'),
    new Item($r('app.media.icon'),'员工调动','pages/employee/move/moveIndexPage')
  ]

  private list03:Array<message>=[
    new message($r('app.media.icon'),'1','1.1'),
    new message($r('app.media.icon'),'2','2.1')
  ]

  build() {
    Column() {
      Row(){
        //轮播图
        Swiper(this.swiperController){
          Image($r('app.media.swiper01'))
            .objectFit(ImageFit.Contain)
          Image($r('app.media.swiper02'))
            .objectFit(ImageFit.Contain)
        }
        .autoPlay(true)
      }
      .width('100%')
      .height(200)

      Row(){
        //department,position,employee
        ForEach(
          this.list01,
        (item:Item)=>{
          Column({space:10}){
            Image(item.img)
              // .fitOriginalSize(true)
              .width(60)
              .onClick(()=>{
                router.pushUrl({
                  url:item.url,
                })
              })
            Text(item.msg)
          }
        })
      }
      .width('85%')
      .height(100)
      .justifyContent(FlexAlign.SpaceBetween)

      Row(){
        //dimission,add_employee
        ForEach(
          this.list02,
          (item:Item)=>{
            Column({space:10}){
              Image(item.img)
                // .fitOriginalSize(true)
                .width(60)
                .onClick(()=>{
                  router.pushUrl({
                    url:item.url,
                  })
                })
              Text(item.msg)
            }
          })
      }
      .width('85%')
      .height(100)
      .justifyContent(FlexAlign.SpaceBetween)
      .margin(10)

      Column(){
        Text('公告信息')
          .fontWeight(FontWeight.Bold)
          .fontSize(30)
          .margin({bottom:30})
        Row(){
          Blank()
          Text('更多')
            .onClick(()=>{
              //更多公告信息
            })
        }
        .width('90%')

        List({space:20}){
          ForEach(this.list03,
            (item:message)=>{
            ListItem(){
              Row(){
                Image(item.img)
                  .width(100)
                Column({space:10}){
                  Text(item.msg01)
                  Text(item.msg02)
                }
                .height('15%')
                // .backgroundColor('red')
                .justifyContent(FlexAlign.SpaceBetween)
              }
              .width('100%')
              // .backgroundColor(Color.Pink)
            }
          })
        }
        .width('100%')
        .height('100%')
        .layoutWeight(1)
      }


    }
    .width('100%')
    .height('100%')
  }
}

export class Item{
  img:ResourceStr
  msg:string
  url:string

  constructor(img: ResourceStr, msg: string,url:string) {
    this.img=img
    this.msg=msg
    this.url=url
  }
}

export class message{
  img:ResourceStr
  msg01:string
  msg02:string

  constructor(img: ResourceStr, msg01: string, msg02: string) {
    this.img=img
    this.msg01=msg01
    this.msg02=msg02
  }
}


/*Text(this.message)
        .fontSize(70)
        .fontWeight(FontWeight.Bold)
        .padding({top:100})
      Column({space:70}){
        Row(){
          Image($r('app.media.organization'))
            .height(50)
            .backgroundColor('#4492E6')
            .fitOriginalSize(true)
          firstButton({msg:'组织结构'})
            .onClick(()=>{
              router.pushUrl({
                url:'pages/Organization/OrganizationPage'
              })
            })
        }
        Row(){
          Image($r('app.media.persons'))
            .height(50)
            .backgroundColor('#4492E6')
            .fitOriginalSize(true)
          firstButton({msg:'人事信息'})
            .onClick(()=>{
              router.pushUrl({
                url:'pages/Organization/OrganizationPage'
              })
            })
        }

        Row(){
          Image($r('app.media.person'))
            .height(50)
            .backgroundColor('#4492E6')
            .fitOriginalSize(true)
          firstButton({msg:'员工信息中心'})
            .onClick(()=>{
              router.pushUrl({
                url:'pages/Organization/OrganizationPage'
              })
            })
        }

        Row(){
          Image($r('app.media.Excel'))
            .height(50)
            .backgroundColor('#4492E6')
            .fitOriginalSize(true)
          firstButton({msg:'报表管理'})
            .onClick(()=>{
              router.pushUrl({
                url:'pages/Organization/OrganizationPage'
              })
            })
        }



      }
      .padding({top:90})*/