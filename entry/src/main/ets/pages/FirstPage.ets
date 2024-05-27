import router from '@ohos.router'
import { firstButton } from '../module/firstButton'
@Entry
@Component
struct FirstPage {
  @State message: string = '人事E通'

  build() {
    Column() {
      Text(this.message)
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
      .padding({top:90})

    }
    .width('100%')
    .height('100%')
    .backgroundImage($r("app.media.MainBackground"))
    .backgroundImageSize({width:'100%',height:'100%'})
  }
}