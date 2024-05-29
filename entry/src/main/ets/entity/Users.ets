export class Users{
  id:number
  account:string
  realname:string
  password:string
  sex:string
  constructor(id:number,account:string,realname:string,password:string,sex:string) {
    this.id=id
    this.account=account
    this.realname=realname
    this.password=password
    this.sex=sex
  }


}