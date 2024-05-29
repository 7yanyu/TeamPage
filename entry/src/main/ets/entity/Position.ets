export class Position{
  //岗位id
  pos_ID:number
  //岗位名称
  pos_name:string
  // 岗位成立时间
  creat_date:string
  // 岗位所属部门id
  dep_ID:string
  // 岗位所属部门名称
  dep_name:string
  // 岗位简介
  detail:string

  constructor(pos_ID:number, pos_name:string,create_date:string,belong_depID:string,belong_depNA:string,detail:string) {
    this.pos_ID=pos_ID
    this.pos_name=pos_name
    this.creat_date=create_date
    this.dep_ID=belong_depID
    this.dep_name=belong_depNA
    this.detail=detail
  }



}