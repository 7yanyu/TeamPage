import router from '@ohos.router'
import { firstButton } from '../../module/firstButton'
@Entry
@Component
struct OrganizationPage {
  @State message: string = '组织结构'

  build() {
    Row() {
      Column({space:50}) {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
        .padding({bottom:60})
        Row(){
          Image($r('app.media.manage'))
            .height(50)
            .backgroundColor('#4492E6')
            .fitOriginalSize(true)
          firstButton({msg:'部门管理'})
            .onClick(()=>{
              router.pushUrl({
                url:'pages/Organization/departmentPage'
              })
            })
        }
        Row(){
          Image($r('app.media.manage'))
            .height(50)
            .backgroundColor('#4492E6')
            .fitOriginalSize(true)
          firstButton({msg:'岗位管理'})
            .onClick(()=>{
              router.pushUrl({
                url:'pages/Organization/positionPage'
              })
            })
        }
      }
      .width('100%')
      .height('70%')
    }
    .height('100%')
    .backgroundImage($r("app.media.MainBackground"))
    .backgroundImageSize({width:'100%',height:'100%'})
  }
}