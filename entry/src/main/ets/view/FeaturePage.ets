import Common from '../common/constants/Const';
import { DeviceAdapter } from '../viewmodel/DeviceAdapter';

export enum FeatureType {
  SCHEDULE = 0,
  CAFETERIA = 1,
  LIBRARY = 2,
  EXPRESS = 3,
  FORUM = 4,
  MARKET = 5
}

interface FeatureConfig {
  title: string;
  description: string;
  iconText: string;
  color: string;
  features: string[];
  leaveTypes?: string[];
  homeworks?: HomeworkItem[];
}

interface HomeworkItem {
  title: string;
  deadline: string;
  daysLeft: number;
}

@Component
export struct FeaturePage {
  @Prop featureIndex: number = 0;
  @Link showFeature: boolean;
  private deviceAdapter: DeviceAdapter = DeviceAdapter.getInstance();
  
  private featureConfigs: FeatureConfig[] = [
    { 
      title: '课程表', 
      description: '查看每日课程安排', 
      iconText: '表',
      color: '#FF6B6B',
      features: ['今日课程一目了然', '课前提醒通知', '请假申请', '作业到期提醒'],
      leaveTypes: ['病假', '事假', '公假', '其他'],
      homeworks: [
        { title: '高等数学作业', deadline: '2026-06-17', daysLeft: 1 },
        { title: '数据结构实验', deadline: '2026-06-18', daysLeft: 2 },
        { title: '英语作文', deadline: '2026-06-20', daysLeft: 4 }
      ]
    },
    { 
      title: '校园食堂', 
      description: '查看食堂菜单和价格', 
      iconText: '餐',
      color: '#4ECDC4',
      features: ['实时更新每日菜单', '显示菜品价格']
    },
    { 
      title: '图书馆', 
      description: '座位预约和图书查询', 
      iconText: '书',
      color: '#45B7D1',
      features: ['座位剩余查询', '图书检索预约', '自习室查询']
    },
    { 
      title: '快递查询', 
      description: '查询快递取件信息', 
      iconText: '件',
      color: '#96CEB4',
      features: ['快递到件通知', '取件码查询']
    },
    { 
      title: '校园论坛', 
      description: '查看校园动态和话题', 
      iconText: '坛',
      color: '#FFEAA7',
      features: ['校园热点话题', '失物招领信息']
    },
    { 
      title: '二手市场', 
      description: '校园二手物品交易', 
      iconText: '易',
      color: '#DDA0DD',
      features: ['发布闲置物品', '分类浏览搜索']
    }
  ];

  build() {
    Column() {
      Row() {
        Text('←')
          .fontSize(this.deviceAdapter.getFontSize())
          .fontColor('#333333')
        
        Text('返回')
          .fontSize(this.deviceAdapter.getFontSize())
          .fontColor('#333333')
          .margin({ left: 5 })
      }
      .padding({ left: 20, right: 20, top: 15, bottom: 15 })
      .onClick(() => {
        this.showFeature = false;
      })

      Column() {
        Row() {
          Text(this.featureConfigs[this.featureIndex].iconText)
            .fontSize(50)
            .fontColor(Color.White)
            .fontWeight(FontWeight.Bold)
        }
        .width(90)
        .height(90)
        .backgroundColor(this.featureConfigs[this.featureIndex].color)
        .borderRadius(45)
        .justifyContent(FlexAlign.Center)
        .margin({ top: 30, bottom: 20 })

        Text(this.featureConfigs[this.featureIndex].title)
          .fontSize(this.deviceAdapter.getTitleFontSize())
          .fontWeight(FontWeight.Bold)
          .fontColor(this.featureConfigs[this.featureIndex].color)
          .margin({ bottom: 10 })

        Text(this.featureConfigs[this.featureIndex].description)
          .fontSize(this.deviceAdapter.getFontSize())
          .fontColor('#666666')
          .margin({ bottom: 30 })
      }
      .width('100%')

      Column() {
        Text('核心功能')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#333333')
          .margin({ bottom: 15 })

        Column() {
          ForEach(this.featureConfigs[this.featureIndex].features, (feature: string, index: number) => {
            Row() {
              Text('●')
                .fontSize(14)
                .fontColor(this.featureConfigs[this.featureIndex].color)
                .margin({ right: 10 })

              Text(feature)
                .fontSize(16)
                .fontColor('#333333')
            }
            .width('100%')
            .padding({ top: 12, bottom: 12 })
            .border({
              width: { bottom: index < this.featureConfigs[this.featureIndex].features.length - 1 ? 1 : 0 },
              color: '#E0E0E0'
            })
          }, (feature: string, index: number) => index.toString())
        }
        .width('100%')
        .padding(20)
        .backgroundColor('#F8F8F8')
        .borderRadius(12)
      }
      .width('85%')
      .margin({ bottom: 15 })

      if (this.featureConfigs[this.featureIndex].leaveTypes && this.featureConfigs[this.featureIndex].leaveTypes!.length > 0) {
        Column() {
          Text('请假类型')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#333333')
            .margin({ bottom: 15 })

          Row() {
            ForEach(this.featureConfigs[this.featureIndex].leaveTypes, (type: string) => {
              Column() {
                Text(type)
                  .fontSize(14)
                  .fontColor('#333333')
              }
              .padding({ left: 12, right: 12, top: 8, bottom: 8 })
              .backgroundColor('#F0F0F0')
              .borderRadius(15)
            }, (type: string) => type)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceAround)
        }
        .width('85%')
        .padding(15)
        .backgroundColor('#F8F8F8')
        .borderRadius(12)
        .margin({ bottom: 15 })
      }

      if (this.featureConfigs[this.featureIndex].homeworks && this.featureConfigs[this.featureIndex].homeworks!.length > 0) {
        Column() {
          Text('作业到期提醒')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#333333')
            .margin({ bottom: 15 })

          Column() {
            ForEach(this.featureConfigs[this.featureIndex].homeworks, (homework: HomeworkItem, index: number) => {
              Row() {
                Column() {
                  Text(homework.title)
                    .fontSize(15)
                    .fontColor('#333333')
                    .fontWeight(FontWeight.Medium)
                  
                  Text(`截止：${homework.deadline}`)
                    .fontSize(13)
                    .fontColor(homework.daysLeft <= 1 ? '#FF0000' : '#666666')
                    .margin({ top: 5 })
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)

                Column() {
                  Text(`${homework.daysLeft}天`)
                    .fontSize(16)
                    .fontColor(homework.daysLeft <= 1 ? '#FF0000' : '#4CAF50')
                    .fontWeight(FontWeight.Bold)
                }
              }
              .width('100%')
              .padding({ top: 10, bottom: 10 })
              .border({
                width: { bottom: index < this.featureConfigs[this.featureIndex].homeworks!.length - 1 ? 1 : 0 },
                color: '#E0E0E0'
              })
            }, (homework: HomeworkItem, index: number) => index.toString())
          }
          .width('100%')

          Row() {
            Text('⚠️')
              .fontSize(14)
            
            Text('红色标注表示即将到期（≤1天）')
              .fontSize(12)
              .fontColor('#FF0000')
              .margin({ left: 5 })
          }
          .margin({ top: 10 })
        }
        .width('85%')
        .padding(15)
        .backgroundColor('#F8F8F8')
        .borderRadius(12)
        .margin({ bottom: 15 })
      }

      Column() {
        Text('温馨提示')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FF9800')
          .margin({ bottom: 10 })

        Text('本功能需要连接校园网络使用')
          .fontSize(14)
          .fontColor('#666666')
      }
      .width('85%')
      .padding(15)
      .backgroundColor('#FFF3E0')
      .borderRadius(12)
      .margin({ bottom: 25 })

      Row() {
        Column() {
          Text('立即使用')
            .fontSize(this.deviceAdapter.getFontSize())
            .fontColor(Color.White)
        }
        .width('45%')
        .height(this.deviceAdapter.getButtonHeight())
        .backgroundColor(this.featureConfigs[this.featureIndex].color)
        .borderRadius(8)
        .justifyContent(FlexAlign.Center)

        Column() {
          Text('返回首页')
            .fontSize(this.deviceAdapter.getFontSize())
            .fontColor('#333333')
        }
        .width('45%')
        .height(this.deviceAdapter.getButtonHeight())
        .backgroundColor('#F0F0F0')
        .borderRadius(8)
        .justifyContent(FlexAlign.Center)
        .onClick(() => {
          this.showFeature = false;
        })
      }
      .width('85%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}
