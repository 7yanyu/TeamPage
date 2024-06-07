import router from '@ohos.router';
import { EmployeeMov } from '../../../entity/EmployeeMov';
import { Delete_Mov } from '../../../httpRequest/move/Delete_Mov';
import {ADD_Process} from '../../../httpRequest/move/Add_Move'
import {ADD_Reject} from '../../../httpRequest/move/Add_Move'
import  {Process} from  '../../../entity/Process'
import {employee} from '../../../entity/employee'
import {queryRequest_1} from '../../../httpRequest/employee/information/queryRequest_1'
@Entry
@Component
struct moveDetailsPage {
  @State message: string = '调动详情';
  @State empmov: EmployeeMov | null = null;
  @State process :Process =new Process(0,'')
  @State emp:employee=new employee(0,'','',0,0,'','','','','','','',0,0)
  onPageShow() {
    console.log('onInit called');
    const params = router.getParams() as { empmov: string };
    console.log('Params:', params);
    if (params && params.empmov) {
      const empmovJson = params.empmov;
      console.log('Employee Move JSON:', empmovJson);
      try {
        const empmovData = JSON.parse(empmovJson);
        this.empmov = empmovData;
        queryRequest_1(this.empmov.emp_ID).then(response=>{
          if(response){
            this.emp=response
          }
        })
      } catch (e) {
        console.error('Failed to parse empmov data', e);
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
      if (this.empmov) {
        Column() {
          // Employee Info
          Row({ space: 25 }) {
            if(this.emp.gender=='女'){
              Image($r("app.media.girl"))
                .width(60);
            }
            else {
              Image($r("app.media.boy"))
                .width(60);
            }

            Column() {
              Text(`姓名: ${this.empmov.emp_name}`)
                .fontSize(20)
                .textAlign(TextAlign.Start);
              Text(`员工ID: ${this.empmov.emp_ID}`)
                .fontSize(16)
                .padding({ top: 5 })
                .textAlign(TextAlign.Start);
            }
          }
          .width('100%')
          .padding({ top: 10, left: 60 });

          // Move details table
          Column({space:8}) {
            Row() {
              Text('调动单号:')
                .fontSize(20)
                .width('50%');
              Text(this.empmov.mov_ID.toString())
                .fontSize(20)
                .width('50%');
            }    .border({ color: '#D1D1D1', width: 1 })
            .padding({ bottom: 5 });
            Row() {
              Text('调动类型:')
                .fontSize(20)
                .width('50%');
              Text(this.empmov.movtype.toString())
                .fontSize(20)
                .width('50%');
            } .border({ color: '#D1D1D1', width: 1 })
            .padding({ bottom: 5 });
            Row() {
              Text('调动时间:')
                .fontSize(20)
                .width('50%');
              Text(this.empmov.mov_date.toString())
                .fontSize(20)
                .width('50%');
            } .border({ color: '#D1D1D1', width: 1 })
            .padding({ bottom: 5 });
            Row() {
              Text('原部门ID(名称):')
                .fontSize(20)
                .width('50%');
              Text(`${this.empmov.before_dep} (${this.empmov.before_depname})`)
                .fontSize(20)
                .width('50%');
            } .border({ color: '#D1D1D1', width: 1 })
            .padding({ bottom: 5 });
            Row() {
              Text('现部门ID(名称):')
                .fontSize(20)
                .width('50%');
              Text(`${this.empmov.after_dep} (${this.empmov.after_depname})`)
                .fontSize(20)
                .width('50%');
            } .border({ color: '#D1D1D1', width: 1 })
            .padding({ bottom: 5 });
            Row() {
              Text('原岗位ID(名称):')
                .fontSize(20)
                .width('50%');
              Text(`${this.empmov.before_pos} (${this.empmov.before_posname})`)
                .fontSize(20)
                .width('50%');
            } .border({ color: '#D1D1D1', width: 1 })
            .padding({ bottom: 5 });
            Row() {
              Text('现岗位ID(名称):')
                .fontSize(20)
                .width('50%');
              Text(`${this.empmov.after_pos} (${this.empmov.after_posname})`)
                .fontSize(20)
                .width('50%');
            } .border({ color: '#D1D1D1', width: 1 })
            .padding({ bottom: 5 });
            Row() {
              Text('调动原因:')
                .fontSize(20)
                .width('50%');
              Text(this.empmov.reason)
                .fontSize(20)
                .width('50%');
            } .border({ color: '#D1D1D1', width: 1 })
            .padding({ bottom: 30 });
          }
          .padding({ left: 20, right: 20, top: 20, bottom: 20 })
          .border({ color: 'black', width: 1 });

          // Actions
          Row({ space: 30 }) {
            Text('同意')
              .fontColor('#5383E0')
              .fontSize(20)
              .padding({ top: 28 })
              .onClick(() => {
                AlertDialog.show({
                  title: '提示',
                  message: '是否确认同意该调动信息',
                  primaryButton: {
                    value: 'No',
                    action: () => {}
                  },
                  secondaryButton: {
                    value: 'Yes',
                    action: () => {
                      this.process.id=this.empmov.mov_ID
                      this.process.date=this.empmov.mov_date
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
                      this.process.id=this.empmov.mov_ID
                      this.process.date=this.empmov.mov_date
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
        .shadow({ color: 'gray', radius: 15 });
      }
    }
    .width('100%')
    .height('100%')
    .backgroundImageSize({ width: '100%', height: '100%' });
  }
}
