import router from '@ohos.router'
import { firstButton } from '../../module/firstButton'
@Entry
@Component
struct PositionPage {
  @State message: string = '岗位管理'

  build() {
    Column() {
      Text(this.message)
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .padding({top:90})
      Column({space:50}){
        Row(){
          Image($r('app.media.eye'))
            .height(50)
            .backgroundColor('#4492E6')
            .fitOriginalSize(true)
          firstButton({msg:'查询岗位'})
        }
        .onClick(()=>{
          router.pushUrl({
            url:'pages/Organization/Position/selectPosPage'
          })
        })
        Row(){
          Image($r('app.media.add'))
            .height(50)
            .backgroundColor('#4492E6')
            .fitOriginalSize(true)
          firstButton({msg:'增加岗位'})
        }
        .onClick(()=>{
          router.pushUrl({
            url:'pages/Organization/Position/addPosPage'
          })
        })
        Row(){
          Image($r('app.media.edit'))
            .height(50)
            .backgroundColor('#4492E6')
            .fitOriginalSize(true)
          firstButton({msg:'修改岗位信息'})
        }
        .onClick(()=>{
          router.pushUrl({
            url:'pages/Organization/Position/changePosPage'
          })
        })
        Row(){
          Image($r('app.media.delete'))
            .height(50)
            .backgroundColor('#4492E6')
            .fitOriginalSize(true)
          firstButton({msg:'删除岗位'})
        }
        .onClick(()=>{
          router.pushUrl({
            url:'pages/Organization/Position/deletePosPage'
          })
        })
      }
      .padding({top:90})
    }
    .width('100%')
    .height('100%')
    .backgroundImage($r("app.media.MainBackground"))
    .backgroundImageSize({width:'100%',height:'100%'})
  }
}