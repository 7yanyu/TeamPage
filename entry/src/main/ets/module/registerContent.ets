import { Users } from '../entity/Users'
// @Entry
@Component
export struct registerContent{
  @State msg:string=''
  @Link user:Users// 初始化一个空的用户对象
  build() {
    // 输入??
    Row() {
      Text(this.msg)
      Column(){
        if(this.msg=='密码'){
          TextInput({ placeholder: `请输入${this.msg}` })
            .type(InputType.Password)
            .onChange((value: string) => {
              this.user.password = value
            })
            .padding({left:20})
        }else if(this.msg=='账号'){
          TextInput({ placeholder: `请输入${this.msg}` })
            .onChange((value: string) => {
              this.user.account = value
            })
            .padding({left:20})
        }else if(this.msg=='姓名'){
          TextInput({ placeholder: `请输入${this.msg}` })
            .onChange((value: string) => {
              this.user.realname = value
            })
            .padding({left:20})
        }else if(this.msg=='性别'){
          TextInput({ placeholder: `请输入${this.msg}` })
            .onChange((value: string) => {
              this.user.sex = value
            })
            .padding({left:20})
        }

      }
      .width('85%')
      .padding({left:15})
    }
    .width('90%')
    // .backgroundColor('green')

  }
}

