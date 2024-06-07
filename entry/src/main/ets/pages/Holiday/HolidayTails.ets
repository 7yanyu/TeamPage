import router from '@ohos.router';
import {Holiday} from '../../entity/Holiday'
import {Process} from '../../entity/Process'
import {  ADD_Process} from '../../httpRequest/HolidayCat'
import {ADD_Reject} from '../../httpRequest/HolidayCat'
import {employee} from '../../entity/employee'
import {queryRequest_1} from '../../httpRequest/employee/information/queryRequest_1'
@Entry
@Component
struct moveDetailsPage {
  @State message: string = '假期详情';
  @State holiday: Holiday | null = null;
  @State process: Process = new Process(0, '')
  @State selectDate:Date=new Date
  @State emp:employee=new employee(0,'','',0,0,'','','','','','','',0,0)

  onPageShow() {
    console.log('onInit called');
    const params = router.getParams() as { holiday: string };
    console.log('Params:', params);
    if (params && params.holiday) {
      const holidayJson = params.holiday;
      console.log('Employee Move JSON:', holidayJson);
      try {
        const holidayData = JSON.parse(holidayJson);
        this.holiday = holidayData;
        queryRequest_1(this.holiday.emp_ID).then(response=>{
          if(response){
            this.emp=response
          }
        })

      } catch (e) {
        console.error('Failed to parse holiday data', e);
      }
    }
  }

  build() {
    Column() {
      // Header
      Row() {
        Column() {
          Image($r('app.media.back'))
            .width(30)
            .onClick(() => {
              router.back();
            });
        }
        .width('10%')
        .alignItems(HorizontalAlign.Start);

        Text(this.message)
          .fontSize(30)
          .textAlign(TextAlign.Center)
          .width('80%');

        Column().width('10%'); // 用空的 Column 占位
      }
      .padding({ top: 15 })
      .width('100%');

      // Main content
      if (this.holiday) {
        Column() {
          // Employee Info
          Row({ space: 25 }) {
            if(this.emp.gender=='女'){
              Image($r("app.media.girl"))
                .width(80);
            }
            else {
              Image($r("app.media.boy"))
                .width(80);
            }


            Column() {
              Text(`姓名: ${this.holiday.emp_name}`)
                .fontSize(20)
                .textAlign(TextAlign.Start);
              Text(`员工ID: ${this.holiday.emp_ID}`)
                .fontSize(16)
                .padding({ top: 5 })
                .textAlign(TextAlign.Start);
            }
          }
          .width('100%')
          .padding({ top: 10, left: 60 });
          Row(){

          }.height(20)

          // Move details table
          Column({ space: 10}) {
            Row() {
              Text('请假单号:')
                .fontSize(20)
                .width('50%')

              Text(this.holiday.id.toString())
                .fontSize(20)
                .width('50%');
            }
            .padding({ bottom: 5 })
            .backgroundColor('#fff')
            Row() {
              Text('请假类型:')
                .fontSize(20)
                .width('50%');
              Text(this.holiday.type.toString())
                .fontSize(20)
                .width('50%');
            }.backgroundColor('#fff')
            .padding({ bottom: 5 });
            Row() {
              Text('开始时间:')
                .fontSize(20)
                .width('50%');
              Text(this.holiday.start_date.toString())
                .fontSize(20)
                .width('50%');
            }
            .padding({ bottom: 5 })
            .backgroundColor('#fff')
            Row() {
              Text('结束时间:')
                .fontSize(20)
                .width('50%');
              Text(this.holiday.end_date.toString())
                .fontSize(20)
                .width('50%');
            }.backgroundColor('#fff')
            .padding({ bottom: 5 });

            Row({space:30}){
              Column(){
                Text('审批时间:')
                  .fontSize(22)
                  .textAlign(TextAlign.Start)
              }.width('30%')
              Button(this.process.date||'年 / 月 / 日')
                .backgroundColor('#F5F5F5')
                .fontColor('#459ED4')
                .onClick(()=>{
                  DatePickerDialog.show({
                    start:new Date('1949-01-01'),
                    end:new Date('2100-12-31'),
                    selected:this.selectDate,
                    onAccept:(value:DatePickerResult)=>{
                      this.selectDate.setFullYear(value.year,value.month,value.day)
                      this.process.date=`${value.year}-${value.month+1}-${value.day}`
                    }
                  })
                })
            }
            .width('100%')
            .margin({top:10})



            Row({ space: 30 }) {
              Text('同意')
                .fontColor('#5383E0')
                .fontSize(20)
                .padding({ top: 28 })
                .onClick(() => {
                  AlertDialog.show({
                    title: '提示',
                    message: '是否确认同意该请假信息',
                    primaryButton: {
                      value: 'No',
                      action: () => {}
                    },
                    secondaryButton: {
                      value: 'Yes',
                      action: () => {
                        this.process.id=this.holiday.id
                        ADD_Process(this.process)
                          .then(response => {
                            if (response=='已处理') {
                              AlertDialog.show({
                                title: '提示',
                                message: '操作成功',
                                primaryButton: {
                                  value: '确认',
                                  action: () => {
                                    router.back();
                                  }
                                }
                              });
                              console.log('Successfully deleted');
                            } else {
                              console.log('Failed to delete');
                            }
                          });
                      }
                    }
                  });
                });

              Text('拒绝')
                .fontColor('red')
                .fontSize(20)
                .padding({ top: 28 })
                .onClick(() => {
                  AlertDialog.show({
                    title: '提示',
                    message: '是否确认拒绝该调动信息',
                    primaryButton: {
                      value: 'No',
                      action: () => {}
                    },
                    secondaryButton: {
                      value: 'Yes',
                      action: () => {
                        this.process.id=this.holiday.id
                        ADD_Reject(this.process)
                          .then(response => {
                            if (response=='已处理') {
                              AlertDialog.show({
                                title: '提示',
                                message: '操作成功',
                                primaryButton: {
                                  value: '确认',
                                  action: () => {
                                    router.back();
                                  }
                                }
                              });
                              console.log('Successfully deleted');
                            } else {
                              console.log('Failed to delete');
                            }
                          });
                      }
                    }
                  });
                });
            }
            .padding({ top: 20 });

          }
          .width('100%')
          .height('80%')
          .padding({ left: 20 })
          .alignItems(HorizontalAlign.Center)
          .shadow({ color: '#fff', radius: 15 });
        }

        .width('100%')
        .height('100%')

      }
    }  .backgroundColor('#E6E6E6')
  }
}