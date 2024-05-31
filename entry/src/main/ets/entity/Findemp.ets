

export class Findemp{
  dep_ID:number
  pos_ID:number
  datea:string  //after
  dateb:string  //before
  entermode:string
  emp_type:string
  confirm_datea:string
  confirm_dateb:string
  intern_situaiton:string

  constructor(dep_ID:number,pos_ID:number,datea:string,dateb:string,entermode:string,emp_type:string,confirm_datea:string,confirm_dateb: string,  intern_situaiton:string) {
    this.dep_ID=dep_ID
    this.pos_ID=pos_ID
    this.datea=datea
    this.dateb=dateb
    this.entermode=entermode
    this.emp_type=emp_type
    this.confirm_datea=confirm_datea
    this.confirm_dateb=confirm_dateb
    this.intern_situaiton=intern_situaiton
  }

}