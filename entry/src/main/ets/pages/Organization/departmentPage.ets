import router from '@ohos.router'
import { firstButton } from '../../module/firstButton'
@Entry
@Component
struct DepartmentPage {
  @State message: string = '部门管理'

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
          firstButton({msg:'查询部门'})
        }
        .onClick(()=>{
          router.pushUrl({
            url:'pages/Organization/Department/selectDPMentPage'
          })
        })
        Row(){
          Image($r('app.media.add'))
            .height(50)
            .backgroundColor('#4492E6')
            .fitOriginalSize(true)
          firstButton({msg:'增加部门'})
        }
        .onClick(()=>{
          router.pushUrl({
            url:'pages/Organization/Department/addDPMentPage'
          })
        })
        Row(){
          Image($r('app.media.edit'))
            .height(50)
            .backgroundColor('#4492E6')
            .fitOriginalSize(true)
          firstButton({msg:'修改部门信息'})
        }
        .onClick(()=>{
          router.pushUrl({
            url:'pages/Organization/Department/changeDPMentPage'
          })
        })
        Row(){
          Image($r('app.media.delete'))
            .height(50)
            .backgroundColor('#4492E6')
            .fitOriginalSize(true)
          firstButton({msg:'删除部门'})
        }
        .onClick(()=>{
          router.pushUrl({
            url:'pages/Organization/Department/deleteDPMentPage'
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