export class Department{
  dep_ID:number
  dep_name:string
  dep_phone:string
  creat_date:string
  detail:string
  constructor(dep_ID:number,dep_name:string,dep_phone:string,creat_date:string,detail:string) {
    this.dep_ID=dep_ID
    this.dep_name=dep_name
    this.dep_phone=dep_phone
    this.creat_date=creat_date
    this.detail=detail
  }


}