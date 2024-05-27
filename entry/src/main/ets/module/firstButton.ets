@Component
export struct firstButton{
  @State msg:string=''
  // @State src:string =''
  build(){
    Button(this.msg)
      .type(ButtonType.Normal)
      .fontSize(25)
      .width(200)
      .height(50)
      .fontColor('black')
      .backgroundColor('#4492E6')
  }
}