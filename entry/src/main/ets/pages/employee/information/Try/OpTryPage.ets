import router from '@ohos.router'
import { employee } from '../../../../entity/employee'
import { tryChangeRequest } from '../../../../httpRequest/employee/information/tryChangeRequest'
import { Process } from '../../../../entity/Process'
import { ADD_Process } from '../../../../httpRequest/employee/information/ADD_Try'
import { ADD_Reject } from '../../../../httpRequest/employee/information/ADD_Try'
import { filterEmptyFields } from '../../../../httpRequest/employee/information/ADD_Try'

@Entry
@Component
struct OpTryPage {
  @State message: string = '试用期管理操作'
  @State emp: employee = new employee(0, '', '', 0, 0, '', '', '', '', '', '','', 0, 0)
  private selectedDate: Date = new Date()
  @State process: Process = new Process(0, '')

  onPageShow() {
    console.log('onInit called'); // 确认 onInit 被调用
    const params = router.getParams() as { employee: string }
    console.log('Params:', params); // 打印整个 params 对象
    if (params /*&& params.item*/) {
      const employeeJson = params.employee
      console.log('employeeJson:', employeeJson)
      try {
        const employeeData = JSON.parse(employeeJson)
        this.emp = employeeData
        this.process.id = this.emp.emp_ID
      } catch (error) {
        console.error('Failed to parse employee data', error);
      }
    } else {
      console.log('not found')
    }
  }

  build() {
    Column() {
      Row() {
        Image($r('app.media.back'))
          .width(30)
          .onClick(() => {
            router.back()
          })
        Text(this.message)
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .margin({ left: 30 })
      }
      .width('90%')
      .margin({ top: 10 })

      Divider()
        .strokeWidth(5)
        .margin({ top: 5 })

      Row({ space: 25 }) {
        if (this.emp.gender == '女') {
          Image($r("app.media.girl"))
            .width(100)
            .margin(10)
        }
        else {
          Image($r("app.media.boy"))
            .width(100)
            .margin(10)
        }

        Column({ space: 10 }) {
          Text(this.emp.emp_name)
            .fontSize(30)
            .margin({ bottom: 5 })
          Row() {
            Text('员工ID:').fontColor('#C9C9C9').fontSize('20')
            Text(this.emp.emp_ID.toString())
              .fontSize('20')
              .fontColor('#C9C9C9')
          }
        }
      }
      .width('100%')
      .margin(10)
      Row() {
        Column() {
          Text('部门ID(名称):')
            .fontSize(22)
            .textAlign(TextAlign.Start)
        }.width('41%')

        Text(`${this.emp.dep_ID} (${this.emp.dep_name})`)
          .fontSize(22)
      }.width('100%')
      Row() {
        Column() {
          Text('岗位ID(名称):')
            .fontSize(22)
            .textAlign(TextAlign.Start)
        }.width('41%')

        Text(`${this.emp.pos_ID} (${this.emp.pos_name})`)
          .fontSize(22)
      }.width('100%')
      .padding({ top: 10 })

      Row({ space: 40 }) {
        Column() {
          Text('入职时间:')
            .fontSize(22)
            .textAlign(TextAlign.Start)
        }.width('30%')

        Text(`${this.emp.date} `)
          .fontSize(22)
      }.width('100%')
      .padding({ top: 10 })

      Row({ space: 40 }) {
        Column() {
          Text('实习状态:')
            .fontSize(22)
            .textAlign(TextAlign.Start)
        }.width('30%')

        Text(`${this.emp.intern_situation} `)
          .fontSize(22)
      }
      .width('100%')
      .margin({ top: 10 })

      Row({ space: 30 }) {
        Column() {
          Text('转正时间:')
            .fontSize(22)
            .textAlign(TextAlign.Start)
        }.width('30%')


        Button(this.process.date || '年 / 月 / 日')
          .backgroundColor('#F5F5F5')
          .fontColor('#459ED4')
          .onClick(() => {
            // 打印调试信息
            console.log('Selected Date:', this.selectedDate);
            DatePickerDialog.show({
              start: new Date('1949-01-01'),
              end: new Date('2100-12-31'),
              selected: this.selectedDate,
              onAccept: (value) => {
                // 更新 selectDate 对象
                this.selectedDate.setFullYear(value.year, value.month, value.day);
                // 格式化并更新 process.date
                this.process.date = `${value.year}-${value.month + 1}-${value.day}`;
              }
            });
          })
      }.width('100%')
      .margin({ top: 10 })

      Row({ space: 30 }) {
        Text('同意')
          .fontColor('#5383E0')
          .fontSize(20)
          .padding({ top: 28 })
          .onClick(() => {
            AlertDialog.show({
              title: '提示',
              message: '是否确认同意该转正信息',
              primaryButton: {
                value: 'No',
                action: () => { }
              },
              secondaryButton: {
                value: 'Yes',
                action: () => {
                  ADD_Process(this.process)
                    .then(response => {
                      if (response == '已处理') {
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
              message: '是否确认拒绝该转正信息',
              primaryButton: {
                value: 'No',
                action: () => { }
              },
              secondaryButton: {
                value: 'Yes',
                action: () => {
                  const process = filterEmptyFields(this.process)
                  ADD_Reject(process)
                    .then(response => {
                      if (response == '已处理') {
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
    }
    .width('100%')
    .height('100%')
  }
}
