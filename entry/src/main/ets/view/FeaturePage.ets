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
  schedule?: ScheduleItem[];
  menu?: MenuItem[];
  librarySeats?: LibrarySeatItem[];
  expresses?: ExpressItem[];
  posts?: PostItem[];
  products?: ProductItem[];
}

interface HomeworkItem {
  title: string;
  deadline: string;
  daysLeft: number;
}

interface ScheduleItem {
  time: string;
  course: string;
  location: string;
}

interface MenuItem {
  name: string;
  price: string;
  canteen: string;
}

interface LibrarySeatItem {
  area: string;
  total: number;
  available: number;
}

interface ExpressItem {
  company: string;
  code: string;
  location: string;
}

interface PostItem {
  title: string;
  author: string;
  time: string;
}

interface ProductItem {
  name: string;
  price: string;
  seller: string;
}

@Component
export struct FeaturePage {
  @Prop featureIndex: number = 0;
  @Link showFeature: boolean;
  private deviceAdapter: DeviceAdapter = DeviceAdapter.getInstance();
  @State expandedFeature: number = -1; // -1表示没有展开任何功能
  
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
        { title: '物理实验报告', deadline: '2026-06-18', daysLeft: 2 },
        { title: '数据结构实验', deadline: '2026-06-19', daysLeft: 3 },
        { title: '英语作文', deadline: '2026-06-20', daysLeft: 4 },
        { title: '操作系统项目', deadline: '2026-06-23', daysLeft: 7 }
      ],
      schedule: [
        { time: '08:00-09:35', course: '高等数学', location: '教学楼A301' },
        { time: '10:00-11:35', course: '数据结构', location: '计算机楼B202' },
        { time: '14:00-15:35', course: '大学英语', location: '外语楼C105' },
        { time: '16:00-17:35', course: '操作系统', location: '计算机楼B301' }
      ]
    },
    { 
      title: '校园食堂', 
      description: '查看食堂菜单和价格', 
      iconText: '餐',
      color: '#4ECDC4',
      features: ['实时更新每日菜单', '显示菜品价格'],
      menu: [
        { name: '红烧肉', price: '￥12', canteen: '一食堂' },
        { name: '糖醋排骨', price: '￥15', canteen: '一食堂' },
        { name: '宫保鸡丁', price: '￥10', canteen: '二食堂' },
        { name: '清蒸鲈鱼', price: '￥18', canteen: '二食堂' }
      ]
    },
    { 
      title: '图书馆', 
      description: '座位预约和图书查询', 
      iconText: '书',
      color: '#45B7D1',
      features: ['座位剩余查询', '图书检索预约', '自习室查询'],
      librarySeats: [
        { area: '一楼阅览区', total: 200, available: 45 },
        { area: '二楼自习室', total: 150, available: 23 },
        { area: '三楼电子区', total: 100, available: 67 }
      ]
    },
    { 
      title: '快递查询', 
      description: '查询快递取件信息', 
      iconText: '件',
      color: '#96CEB4',
      features: ['快递到件通知', '取件码查询'],
      expresses: [
        { company: '顺丰快递', code: 'SF123456', location: '东门快递点' },
        { company: '中通快递', code: 'ZT789012', location: '西门快递点' },
        { company: '韵达快递', code: 'YD345678', location: '南门快递点' }
      ]
    },
    { 
      title: '校园论坛', 
      description: '查看校园动态和话题', 
      iconText: '坛',
      color: '#FFEAA7',
      features: ['校园热点话题', '失物招领信息'],
      posts: [
        { title: '【求助】有没有人捡到一张校园卡？', author: '张同学', time: '2小时前' },
        { title: '【分享】期末复习资料整理', author: '李同学', time: '5小时前' },
        { title: '【活动】周末社团招新', author: '学生会', time: '1天前' }
      ]
    },
    { 
      title: '二手市场', 
      description: '校园二手物品交易', 
      iconText: '易',
      color: '#DDA0DD',
      features: ['发布闲置物品', '分类浏览搜索'],
      products: [
        { name: '二手教材《高等数学》', price: '￥25', seller: '王同学' },
        { name: '九成新台灯', price: '￥35', seller: '赵同学' },
        { name: '自行车一辆', price: '￥150', seller: '刘同学' }
      ]
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
            Column() {
              Row() {
                Text(this.expandedFeature === index ? '▼' : '▶')
                  .fontSize(12)
                  .fontColor(this.featureConfigs[this.featureIndex].color)
                  .margin({ right: 10 })

                Text(feature)
                  .fontSize(16)
                  .fontColor('#333333')
                  .layoutWeight(1)
              }
              .width('100%')
              .padding({ top: 12, bottom: 12 })
              .onClick(() => {
                if (this.expandedFeature === index) {
                  this.expandedFeature = -1;
                } else {
                  this.expandedFeature = index;
                }
              })

              if (this.expandedFeature === index) {
                Column() {
                  this.FeatureContentBuilder(index)
                }
                .width('100%')
                .padding({ left: 20, top: 10, bottom: 10 })
                .backgroundColor('#FFFFFF')
                .borderRadius(8)
                .margin({ top: 5 })
              }
            }
            .width('100%')
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
                    .fontColor(homework.daysLeft <= 1 ? '#FF0000' : (homework.daysLeft <= 3 ? '#FF9800' : '#666666'))
                    .margin({ top: 5 })
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)

                Column() {
                  Text(`${homework.daysLeft}天`)
                    .fontSize(16)
                    .fontColor(homework.daysLeft <= 1 ? '#FF0000' : (homework.daysLeft <= 3 ? '#FF9800' : '#4CAF50'))
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

          Column() {
            Row() {
              Text('●')
                .fontSize(12)
                .fontColor('#FF0000')
              
              Text(' ≤1天（紧急）')
                .fontSize(12)
                .fontColor('#666666')
            }
            
            Row() {
              Text('●')
                .fontSize(12)
                .fontColor('#FF9800')
              
              Text(' 2-3天（警告）')
                .fontSize(12)
                .fontColor('#666666')
            }
            
            Row() {
              Text('●')
                .fontSize(12)
                .fontColor('#4CAF50')
              
              Text(' >3天（正常）')
                .fontSize(12)
                .fontColor('#666666')
            }
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .margin({ top: 10 })
        }
        .width('85%')
        .padding(15)
        .backgroundColor('#F8F8F8')
        .borderRadius(12)
        .margin({ bottom: 15 })
      }

      if (this.featureConfigs[this.featureIndex].schedule && this.featureConfigs[this.featureIndex].schedule!.length > 0) {
        Column() {
          Text('今日课程安排')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#333333')
            .margin({ bottom: 15 })

          Column() {
            ForEach(this.featureConfigs[this.featureIndex].schedule, (item: ScheduleItem, index: number) => {
              Row() {
                Column() {
                  Text(item.time)
                    .fontSize(14)
                    .fontColor('#666666')
                  
                  Text(item.course)
                    .fontSize(16)
                    .fontColor('#333333')
                    .fontWeight(FontWeight.Medium)
                    .margin({ top: 5 })
                  
                  Text(item.location)
                    .fontSize(13)
                    .fontColor('#999999')
                    .margin({ top: 3 })
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)
              }
              .width('100%')
              .padding({ top: 12, bottom: 12 })
              .border({
                width: { bottom: index < this.featureConfigs[this.featureIndex].schedule!.length - 1 ? 1 : 0 },
                color: '#E0E0E0'
              })
            }, (item: ScheduleItem, index: number) => index.toString())
          }
          .width('100%')
        }
        .width('85%')
        .padding(15)
        .backgroundColor('#F8F8F8')
        .borderRadius(12)
        .margin({ bottom: 15 })
      }

      if (this.featureConfigs[this.featureIndex].menu && this.featureConfigs[this.featureIndex].menu!.length > 0) {
        Column() {
          Text('今日推荐菜品')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#333333')
            .margin({ bottom: 15 })

          Column() {
            ForEach(this.featureConfigs[this.featureIndex].menu, (item: MenuItem, index: number) => {
              Row() {
                Column() {
                  Text(item.name)
                    .fontSize(16)
                    .fontColor('#333333')
                    .fontWeight(FontWeight.Medium)
                  
                  Text(item.canteen)
                    .fontSize(13)
                    .fontColor('#999999')
                    .margin({ top: 3 })
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)

                Text(item.price)
                  .fontSize(16)
                  .fontColor('#FF6B6B')
                  .fontWeight(FontWeight.Bold)
              }
              .width('100%')
              .padding({ top: 12, bottom: 12 })
              .border({
                width: { bottom: index < this.featureConfigs[this.featureIndex].menu!.length - 1 ? 1 : 0 },
                color: '#E0E0E0'
              })
            }, (item: MenuItem, index: number) => index.toString())
          }
          .width('100%')
        }
        .width('85%')
        .padding(15)
        .backgroundColor('#F8F8F8')
        .borderRadius(12)
        .margin({ bottom: 15 })
      }

      if (this.featureConfigs[this.featureIndex].librarySeats && this.featureConfigs[this.featureIndex].librarySeats!.length > 0) {
        Column() {
          Text('座位使用情况')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#333333')
            .margin({ bottom: 15 })

          Column() {
            ForEach(this.featureConfigs[this.featureIndex].librarySeats, (item: LibrarySeatItem, index: number) => {
              Row() {
                Text(item.area)
                  .fontSize(15)
                  .fontColor('#333333')
                  .layoutWeight(1)

                Text(`${item.available}/${item.total}`)
                  .fontSize(15)
                  .fontColor(item.available < 30 ? '#FF6B6B' : '#4CAF50')
                  .fontWeight(FontWeight.Bold)
              }
              .width('100%')
              .padding({ top: 12, bottom: 12 })
              .border({
                width: { bottom: index < this.featureConfigs[this.featureIndex].librarySeats!.length - 1 ? 1 : 0 },
                color: '#E0E0E0'
              })
            }, (item: LibrarySeatItem, index: number) => index.toString())
          }
          .width('100%')
        }
        .width('85%')
        .padding(15)
        .backgroundColor('#F8F8F8')
        .borderRadius(12)
        .margin({ bottom: 15 })
      }

      if (this.featureConfigs[this.featureIndex].expresses && this.featureConfigs[this.featureIndex].expresses!.length > 0) {
        Column() {
          Text('待取快递')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#333333')
            .margin({ bottom: 15 })

          Column() {
            ForEach(this.featureConfigs[this.featureIndex].expresses, (item: ExpressItem, index: number) => {
              Row() {
                Column() {
                  Text(item.company)
                    .fontSize(15)
                    .fontColor('#333333')
                    .fontWeight(FontWeight.Medium)
                  
                  Text(`取件码：${item.code}`)
                    .fontSize(13)
                    .fontColor('#666666')
                    .margin({ top: 3 })
                  
                  Text(item.location)
                    .fontSize(13)
                    .fontColor('#999999')
                    .margin({ top: 3 })
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)
              }
              .width('100%')
              .padding({ top: 12, bottom: 12 })
              .border({
                width: { bottom: index < this.featureConfigs[this.featureIndex].expresses!.length - 1 ? 1 : 0 },
                color: '#E0E0E0'
              })
            }, (item: ExpressItem, index: number) => index.toString())
          }
          .width('100%')
        }
        .width('85%')
        .padding(15)
        .backgroundColor('#F8F8F8')
        .borderRadius(12)
        .margin({ bottom: 15 })
      }

      if (this.featureConfigs[this.featureIndex].posts && this.featureConfigs[this.featureIndex].posts!.length > 0) {
        Column() {
          Text('热门帖子')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#333333')
            .margin({ bottom: 15 })

          Column() {
            ForEach(this.featureConfigs[this.featureIndex].posts, (item: PostItem, index: number) => {
              Row() {
                Column() {
                  Text(item.title)
                    .fontSize(15)
                    .fontColor('#333333')
                    .fontWeight(FontWeight.Medium)
                  
                  Row() {
                    Text(item.author)
                      .fontSize(12)
                      .fontColor('#999999')
                    
                    Text(' · ')
                      .fontSize(12)
                      .fontColor('#999999')
                    
                    Text(item.time)
                      .fontSize(12)
                      .fontColor('#999999')
                  }
                  .margin({ top: 5 })
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)
              }
              .width('100%')
              .padding({ top: 12, bottom: 12 })
              .border({
                width: { bottom: index < this.featureConfigs[this.featureIndex].posts!.length - 1 ? 1 : 0 },
                color: '#E0E0E0'
              })
            }, (item: PostItem, index: number) => index.toString())
          }
          .width('100%')
        }
        .width('85%')
        .padding(15)
        .backgroundColor('#F8F8F8')
        .borderRadius(12)
        .margin({ bottom: 15 })
      }

      if (this.featureConfigs[this.featureIndex].products && this.featureConfigs[this.featureIndex].products!.length > 0) {
        Column() {
          Text('热门商品')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#333333')
            .margin({ bottom: 15 })

          Column() {
            ForEach(this.featureConfigs[this.featureIndex].products, (item: ProductItem, index: number) => {
              Row() {
                Column() {
                  Text(item.name)
                    .fontSize(15)
                    .fontColor('#333333')
                    .fontWeight(FontWeight.Medium)
                  
                  Text(`卖家：${item.seller}`)
                    .fontSize(13)
                    .fontColor('#999999')
                    .margin({ top: 3 })
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)

                Text(item.price)
                  .fontSize(16)
                  .fontColor('#FF6B6B')
                  .fontWeight(FontWeight.Bold)
              }
              .width('100%')
              .padding({ top: 12, bottom: 12 })
              .border({
                width: { bottom: index < this.featureConfigs[this.featureIndex].products!.length - 1 ? 1 : 0 },
                color: '#E0E0E0'
              })
            }, (item: ProductItem, index: number) => index.toString())
          }
          .width('100%')
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

  @Builder
  FeatureContentBuilder(featureIdx: number) {
    if (this.featureIndex === 0) { // 课程表
      if (featureIdx === 0 && this.featureConfigs[this.featureIndex].schedule) {
        ForEach(this.featureConfigs[this.featureIndex].schedule, (item: ScheduleItem) => {
          Row() {
            Column() {
              Text(item.time)
                .fontSize(13)
                .fontColor('#666666')
              
              Text(item.course)
                .fontSize(15)
                .fontColor('#333333')
                .fontWeight(FontWeight.Medium)
                .margin({ top: 3 })
              
              Text(item.location)
                .fontSize(12)
                .fontColor('#999999')
                .margin({ top: 2 })
            }
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
          .padding({ top: 8, bottom: 8 })
        }, (item: ScheduleItem) => item.time)
      }
      
      if (featureIdx === 2 && this.featureConfigs[this.featureIndex].leaveTypes) {
        Column() {
          Text('选择请假类型：')
            .fontSize(14)
            .fontColor('#666666')
            .margin({ bottom: 10 })
          
          Row() {
            ForEach(this.featureConfigs[this.featureIndex].leaveTypes, (type: string) => {
              Column() {
                Text(type)
                  .fontSize(15)
                  .fontColor('#333333')
                  .fontWeight(FontWeight.Medium)
              }
              .padding({ left: 16, right: 16, top: 10, bottom: 10 })
              .backgroundColor('#FFFFFF')
              .borderRadius(8)
              .border({ width: 1, color: '#E0E0E0' })
              .margin({ right: 10 })
            }, (type: string) => type)
          }
          .width('100%')
          .justifyContent(FlexAlign.Start)
          
          Text('点击类型可提交请假申请')
            .fontSize(12)
            .fontColor('#999999')
            .margin({ top: 10 })
        }
        .width('100%')
      }
      
      if (featureIdx === 3 && this.featureConfigs[this.featureIndex].homeworks) {
        Column() {
          ForEach(this.featureConfigs[this.featureIndex].homeworks, (homework: HomeworkItem) => {
            Row() {
              Column() {
                Text(homework.title)
                  .fontSize(14)
                  .fontColor('#333333')
                  .fontWeight(FontWeight.Medium)
                
                Text(`截止：${homework.deadline}`)
                  .fontSize(12)
                  .fontColor(homework.daysLeft <= 1 ? '#FF0000' : (homework.daysLeft <= 3 ? '#FF9800' : '#666666'))
                  .margin({ top: 3 })
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)

              Text(`${homework.daysLeft}天`)
                .fontSize(15)
                .fontColor(homework.daysLeft <= 1 ? '#FF0000' : (homework.daysLeft <= 3 ? '#FF9800' : '#4CAF50'))
                .fontWeight(FontWeight.Bold)
            }
            .width('100%')
            .padding({ top: 8, bottom: 8 })
          }, (homework: HomeworkItem) => homework.title)
        }
      }
    }
    
    if (this.featureIndex === 1 && featureIdx === 0 && this.featureConfigs[this.featureIndex].menu) {
      ForEach(this.featureConfigs[this.featureIndex].menu, (item: MenuItem) => {
        Row() {
          Column() {
            Text(item.name)
              .fontSize(15)
              .fontColor('#333333')
              .fontWeight(FontWeight.Medium)
            
            Text(item.canteen)
              .fontSize(12)
              .fontColor('#999999')
              .margin({ top: 2 })
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)

          Text(item.price)
            .fontSize(15)
            .fontColor('#FF6B6B')
            .fontWeight(FontWeight.Bold)
        }
        .width('100%')
        .padding({ top: 8, bottom: 8 })
      }, (item: MenuItem) => item.name)
    }
    
    if (this.featureIndex === 2 && featureIdx === 0 && this.featureConfigs[this.featureIndex].librarySeats) {
      ForEach(this.featureConfigs[this.featureIndex].librarySeats, (item: LibrarySeatItem) => {
        Row() {
          Text(item.area)
            .fontSize(14)
            .fontColor('#333333')
            .layoutWeight(1)

          Text(`${item.available}/${item.total}`)
            .fontSize(14)
            .fontColor(item.available < 30 ? '#FF6B6B' : '#4CAF50')
            .fontWeight(FontWeight.Bold)
        }
        .width('100%')
        .padding({ top: 8, bottom: 8 })
      }, (item: LibrarySeatItem) => item.area)
    }
    
    if (this.featureIndex === 3 && featureIdx === 0 && this.featureConfigs[this.featureIndex].expresses) {
      ForEach(this.featureConfigs[this.featureIndex].expresses, (item: ExpressItem) => {
        Column() {
          Text(item.company)
            .fontSize(14)
            .fontColor('#333333')
            .fontWeight(FontWeight.Medium)
          
          Text(`取件码：${item.code}`)
            .fontSize(12)
            .fontColor('#666666')
            .margin({ top: 2 })
          
          Text(item.location)
            .fontSize(12)
            .fontColor('#999999')
            .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Start)
        .width('100%')
        .padding({ top: 8, bottom: 8 })
      }, (item: ExpressItem) => item.code)
    }
    
    if (this.featureIndex === 4 && featureIdx === 0 && this.featureConfigs[this.featureIndex].posts) {
      ForEach(this.featureConfigs[this.featureIndex].posts, (item: PostItem) => {
        Column() {
          Text(item.title)
            .fontSize(14)
            .fontColor('#333333')
            .fontWeight(FontWeight.Medium)
          
          Row() {
            Text(item.author)
              .fontSize(11)
              .fontColor('#999999')
            
            Text(' · ')
              .fontSize(11)
              .fontColor('#999999')
            
            Text(item.time)
              .fontSize(11)
              .fontColor('#999999')
          }
          .margin({ top: 3 })
        }
        .alignItems(HorizontalAlign.Start)
        .width('100%')
        .padding({ top: 8, bottom: 8 })
      }, (item: PostItem) => item.title)
    }
    
    if (this.featureIndex === 5 && featureIdx === 0 && this.featureConfigs[this.featureIndex].products) {
      ForEach(this.featureConfigs[this.featureIndex].products, (item: ProductItem) => {
        Row() {
          Column() {
            Text(item.name)
              .fontSize(14)
              .fontColor('#333333')
              .fontWeight(FontWeight.Medium)
            
            Text(`卖家：${item.seller}`)
              .fontSize(12)
              .fontColor('#999999')
              .margin({ top: 2 })
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)

          Text(item.price)
            .fontSize(15)
            .fontColor('#FF6B6B')
            .fontWeight(FontWeight.Bold)
        }
        .width('100%')
        .padding({ top: 8, bottom: 8 })
      }, (item: ProductItem) => item.name)
    }
  }
}
