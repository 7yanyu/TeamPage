import router from '@ohos.router'

@Entry
@Component
struct FirstPage {
  private swiperController:SwiperController=new SwiperController()
  private  list01:Array<Item>=[
    new Item($r('app.media.department'),'部门管理','pages/Organization/Department/selectDPMentPage'),
    new Item($r('app.media.position'),'岗位管理','pages/Organization/Position/selectPosPage'),
    new Item($r('app.media.information'),'员工信息','pages/employee/information/empIndexPage')
  ]
  private  list02:Array<Item>=[
    new Item($r('app.media.dimission'),'离职管理','pages/employee/dimission/dimIndexPage'),
    new Item($r('app.media.join'),'入职管理','pages/employee/joined/joinIndexPage'),
    new Item($r('app.media.move'),'员工调动','pages/employee/move/moveIndexPage')
  ]

  private list03:Array<message>=[
    new message($r('app.media.duanwu'),'    关于2024年端午节放假安排的通知','      尊敬的全体员工，2024年端午节将至，根据国家相关规定，现将放假安排通知如下...'),
    new message($r('app.media.tijian'),'公司年度体检安排','为了保障员工的健康，公司将于2024年7月15日至20日组织年度体检，具体安排如下...'),
  ]
  private list04:Array<message> = [
    {
      img: 'https://example.com/image1.jpg',
      msg01: '  关于2024年端午节放假安排的通知',
      msg02: '  尊敬的全体员工，2024年端午节将至，根据国家相关规定，现将放假安排通知如下...'
    },
    {
      img: 'https://example.com/image2.jpg',
      msg01: '公司年度体检安排',
      msg02: '为了保障员工的健康，公司将于2024年7月15日至20日组织年度体检，具体安排如下...'
    },
    {
      img: 'https://example.com/image3.jpg',
      msg01: '2024年度优秀员工评选活动',
      msg02: '公司将于2024年8月1日启动年度优秀员工评选活动，欢迎大家踊跃参与，具体细则如下...'
    },
    {
      img: 'https://example.com/image4.jpg',
      msg01: '新员工入职培训通知',
      msg02: '欢迎新员工加入我们的团队！入职培训将于2024年6月10日开始，详细安排如下...'
    }
  ];

  build() {
    Column() {
      Row(){
        //轮播图
        Swiper(this.swiperController){
          Image($r('app.media.swiper01'))
            .objectFit(ImageFit.Contain)
          Image($r('app.media.people1'))
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
                .fontWeight(FontWeight.Bold)
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
                .fontWeight(FontWeight.Bold)
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
          .margin({bottom:15})
        Row(){
          Blank()
          Text('更多')
            .onClick(()=>{
              //更多公告信息
            })
        }
        .width('90%')
        .margin({bottom:10})
        List({space:30}){
          ForEach(this.list03,
            (item:message)=>{
              ListItem(){
                Row(){
                  Image(item.img)
                    .width(100)
                    .width('30%')
                  Column({space:10}){
                    Text(item.msg01).fontWeight(FontWeight.Bold).textAlign(TextAlign.Start)
                    Text(item.msg02)
                  }
                  .width('60%')
                  .height('15%')
                  .padding({left:10})
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
      }.padding({top:20})



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