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

interface ClassroomSeat {
  classroom: string;
  time: string;
  total: number;
  available: number;
  status: string;
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
  @State searchArea: string = '';
  @State searchTime: string = '';
  @State showSearchResult: boolean = false;
  @State searchResults: ClassroomSeat[] = [];
  
  private featureTitles: string[] = ['课程表', '校园食堂', '图书馆', '快递查询', '校园论坛', '二手市场'];
  private featureDescs: string[] = ['查看每日课程安排', '查看食堂菜单和价格', '座位预约和图书查询', '查询快递取件信息', '查看校园动态和话题', '校园二手物品交易'];
  private featureIcons: string[] = ['表', '餐', '书', '件', '坛', '易'];
  private featureColors: string[] = ['#FF6B6B', '#4ECDC4', '#45B7D1', '#96CEB4', '#FFEAA7', '#DDA0DD'];
  private featureLists: string[][] = [
    ['今日课程一目了然', '课前提醒通知', '作业到期提醒'],
    ['实时更新每日菜单', '显示菜品价格'],
    ['座位剩余查询', '图书检索预约', '自习室查询'],
    ['快递到件通知', '取件码查询'],
    ['校园热点话题', '失物招领信息'],
    ['发布闲置物品', '分类浏览搜索']
  ];
  
  private homeworks: HomeworkItem[] = [
    { title: '高等数学作业', deadline: '2026-06-17', daysLeft: 1 },
    { title: '物理实验报告', deadline: '2026-06-18', daysLeft: 2 },
    { title: '数据结构实验', deadline: '2026-06-19', daysLeft: 3 },
    { title: '英语作文', deadline: '2026-06-20', daysLeft: 4 },
    { title: '操作系统项目', deadline: '2026-06-23', daysLeft: 7 }
  ];
  
  private schedules: ScheduleItem[] = [
    { time: '08:00-09:35', course: '高等数学', location: '教学楼A301' },
    { time: '10:00-11:35', course: '数据结构', location: '计算机楼B202' },
    { time: '14:00-15:35', course: '大学英语', location: '外语楼C105' },
    { time: '16:00-17:35', course: '操作系统', location: '计算机楼B301' }
  ];
  
  private menus: MenuItem[] = [
    { name: '红烧肉', price: '￥12', canteen: '一食堂' },
    { name: '糖醋排骨', price: '￥15', canteen: '一食堂' },
    { name: '宫保鸡丁', price: '￥10', canteen: '二食堂' },
    { name: '清蒸鲈鱼', price: '￥18', canteen: '二食堂' }
  ];
  
  private librarySeats: LibrarySeatItem[] = [
    { area: '一楼阅览区', total: 200, available: 45 },
    { area: '二楼自习室', total: 150, available: 23 },
    { area: '三楼电子区', total: 100, available: 67 }
  ];
  
  private classroomSeats: ClassroomSeat[] = [
    { classroom: '一楼阅览区', time: '08:00-10:00', total: 200, available: 45, status: '空闲' },
    { classroom: '一楼阅览区', time: '10:00-12:00', total: 200, available: 32, status: '紧张' },
    { classroom: '一楼阅览区', time: '14:00-16:00', total: 200, available: 78, status: '空闲' },
    { classroom: '一楼阅览区', time: '16:00-18:00', total: 200, available: 15, status: '紧张' },
    { classroom: '二楼自习室', time: '08:00-10:00', total: 150, available: 23, status: '紧张' },
    { classroom: '二楼自习室', time: '10:00-12:00', total: 150, available: 56, status: '空闲' },
    { classroom: '二楼自习室', time: '14:00-16:00', total: 150, available: 12, status: '紧张' },
    { classroom: '二楼自习室', time: '16:00-18:00', total: 150, available: 89, status: '空闲' },
    { classroom: '三楼电子区', time: '08:00-10:00', total: 100, available: 67, status: '空闲' },
    { classroom: '三楼电子区', time: '10:00-12:00', total: 100, available: 45, status: '空闲' },
    { classroom: '三楼电子区', time: '14:00-16:00', total: 100, available: 8, status: '紧张' },
    { classroom: '三楼电子区', time: '16:00-18:00', total: 100, available: 34, status: '空闲' }
  ];
  

  searchSeats() {
    this.searchResults = [];
    
    for (let i = 0; i < this.classroomSeats.length; i++) {
      const item = this.classroomSeats[i];
      let matchArea = true;
      let matchTime = true;
      
      if (this.searchArea.length > 0) {
        matchArea = item.classroom.indexOf(this.searchArea) >= 0;
      }
      
      if (this.searchTime.length > 0) {
        matchTime = item.time.indexOf(this.searchTime) >= 0;
      }
      
      if (matchArea && matchTime) {
        this.searchResults.push(item);
      }
    }
    
    this.showSearchResult = true;
  }
  
  private expresses: ExpressItem[] = [
    { company: '顺丰快递', code: 'SF123456', location: '东门快递点' },
    { company: '中通快递', code: 'ZT789012', location: '西门快递点' },
    { company: '韵达快递', code: 'YD345678', location: '南门快递点' }
  ];
  
  private posts: PostItem[] = [
    { title: '【求助】有没有人捡到一张校园卡？', author: '张同学', time: '2小时前' },
    { title: '【分享】期末复习资料整理', author: '李同学', time: '5小时前' },
    { title: '【活动】周末社团招新', author: '学生会', time: '1天前' }
  ];
  
  private products: ProductItem[] = [
    { name: '二手教材《高等数学》', price: '￥25', seller: '王同学' },
    { name: '九成新台灯', price: '￥35', seller: '赵同学' },
    { name: '自行车一辆', price: '￥150', seller: '刘同学' }
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
          Text(this.featureIcons[this.featureIndex])
            .fontSize(50)
            .fontColor(Color.White)
            .fontWeight(FontWeight.Bold)
        }
        .width(90)
        .height(90)
        .backgroundColor(this.featureColors[this.featureIndex])
        .borderRadius(45)
        .justifyContent(FlexAlign.Center)
        .margin({ top: 30, bottom: 20 })

        Text(this.featureTitles[this.featureIndex])
          .fontSize(this.deviceAdapter.getTitleFontSize())
          .fontWeight(FontWeight.Bold)
          .fontColor(this.featureColors[this.featureIndex])
          .margin({ bottom: 10 })

        Text(this.featureDescs[this.featureIndex])
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
          ForEach(this.featureLists[this.featureIndex], (feature: string, index: number) => {
            Row() {
              Text('●')
                .fontSize(12)
                .fontColor(this.featureColors[this.featureIndex])
                .margin({ right: 10 })

              Text(feature)
                .fontSize(16)
                .fontColor('#333333')
            }
            .width('100%')
            .padding({ top: 12, bottom: 12 })
          }, (feature: string, index: number) => index.toString())
        }
        .width('100%')
        .padding(20)
        .backgroundColor('#F8F8F8')
        .borderRadius(12)
      }
      .width('85%')
      .margin({ bottom: 15 })

      if (this.featureIndex === 0) {
        Column() {
          Text('作业到期提醒')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#333333')
            .margin({ bottom: 15 })

          Column() {
            ForEach(this.homeworks, (homework: HomeworkItem, index: number) => {
              Row() {
                Column() {
                  Text(homework.title)
                    .fontSize(15)
                    .fontColor('#333333')
                    .fontWeight(FontWeight.Medium)
                  
                  Text('截止：' + homework.deadline)
                    .fontSize(13)
                    .fontColor(homework.daysLeft <= 1 ? '#FF0000' : (homework.daysLeft <= 3 ? '#FF9800' : '#666666'))
                    .margin({ top: 5 })
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)

                Column() {
                  Text(homework.daysLeft + '天')
                    .fontSize(16)
                    .fontColor(homework.daysLeft <= 1 ? '#FF0000' : (homework.daysLeft <= 3 ? '#FF9800' : '#4CAF50'))
                    .fontWeight(FontWeight.Bold)
                }
              }
              .width('100%')
              .padding({ top: 10, bottom: 10 })
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

        Column() {
          Text('今日课程安排')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#333333')
            .margin({ bottom: 15 })

          Column() {
            ForEach(this.schedules, (item: ScheduleItem, index: number) => {
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

      if (this.featureIndex === 1) {
        Column() {
          Text('今日推荐菜品')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#333333')
            .margin({ bottom: 15 })

          Column() {
            ForEach(this.menus, (item: MenuItem, index: number) => {
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

      if (this.featureIndex === 2) {
        Column() {
          Text('座位查询')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#333333')
            .margin({ bottom: 15 })

          Column() {
            Row() {
              Text('教室：')
                .fontSize(14)
                .fontColor('#666666')
                .width(50)
              
              TextInput({ placeholder: '输入教室名称' })
                .fontSize(14)
                .layoutWeight(1)
                .height(40)
                .backgroundColor('#FFFFFF')
                .borderRadius(6)
                .border({ width: 1, color: '#E0E0E0' })
                .onChange((value: string) => {
                  this.searchArea = value;
                })
            }
            .width('100%')
            .margin({ bottom: 10 })

            Row() {
              Text('时间：')
                .fontSize(14)
                .fontColor('#666666')
                .width(50)
              
              TextInput({ placeholder: '输入时间段（如08:00）' })
                .fontSize(14)
                .layoutWeight(1)
                .height(40)
                .backgroundColor('#FFFFFF')
                .borderRadius(6)
                .border({ width: 1, color: '#E0E0E0' })
                .onChange((value: string) => {
                  this.searchTime = value;
                })
            }
            .width('100%')
            .margin({ bottom: 15 })

            Button('查询空闲座位')
              .width('100%')
              .height(45)
              .fontSize(16)
              .backgroundColor('#45B7D1')
              .onClick(() => {
                this.searchSeats();
              })
          }
          .width('100%')
          .padding(15)
          .backgroundColor('#F8F8F8')
          .borderRadius(8)
        }
        .width('85%')
        .padding(15)
        .backgroundColor('#F8F8F8')
        .borderRadius(12)
        .margin({ bottom: 15 })

        if (this.showSearchResult) {
          Column() {
            Text('查询结果')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#333333')
              .margin({ bottom: 15 })

            if (this.searchResults.length === 0) {
              Column() {
                Text('未找到符合条件的座位')
                  .fontSize(14)
                  .fontColor('#999999')
                  .margin({ top: 20, bottom: 20 })
              }
            } else {
              Column() {
                ForEach(this.searchResults, (item: ClassroomSeat, index: number) => {
                  Row() {
                    Column() {
                      Text(item.classroom)
                        .fontSize(15)
                        .fontColor('#333333')
                        .fontWeight(FontWeight.Medium)
                      
                      Text(item.time)
                        .fontSize(13)
                        .fontColor('#666666')
                        .margin({ top: 3 })
                    }
                    .alignItems(HorizontalAlign.Start)
                    .layoutWeight(1)

                    Column() {
                      Text(item.available + '/' + item.total)
                        .fontSize(15)
                        .fontColor(item.status === '紧张' ? '#FF6B6B' : '#4CAF50')
                        .fontWeight(FontWeight.Bold)
                      
                      Text(item.status)
                        .fontSize(12)
                        .fontColor(item.status === '紧张' ? '#FF6B6B' : '#4CAF50')
                        .margin({ top: 2 })
                    }
                    .alignItems(HorizontalAlign.End)
                  }
                  .width('100%')
                  .padding({ top: 12, bottom: 12 })
                  .backgroundColor(index % 2 === 0 ? '#FFFFFF' : '#FAFAFA')
                  .borderRadius(6)
                  .margin({ bottom: 8 })
                }, (item: ClassroomSeat, index: number) => index.toString())
              }
              .width('100%')
            }
          }
          .width('85%')
          .padding(15)
          .backgroundColor('#F8F8F8')
          .borderRadius(12)
          .margin({ bottom: 15 })
        }

        Column() {
          Text('座位总览')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#333333')
            .margin({ bottom: 15 })

          Column() {
            ForEach(this.librarySeats, (item: LibrarySeatItem, index: number) => {
              Row() {
                Text(item.area)
                  .fontSize(15)
                  .fontColor('#333333')
                  .layoutWeight(1)

                Text(item.available + '/' + item.total)
                  .fontSize(15)
                  .fontColor(item.available < 30 ? '#FF6B6B' : '#4CAF50')
                  .fontWeight(FontWeight.Bold)
              }
              .width('100%')
              .padding({ top: 12, bottom: 12 })
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

      if (this.featureIndex === 3) {
        Column() {
          Text('待取快递')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#333333')
            .margin({ bottom: 15 })

          Column() {
            ForEach(this.expresses, (item: ExpressItem, index: number) => {
              Row() {
                Column() {
                  Text(item.company)
                    .fontSize(15)
                    .fontColor('#333333')
                    .fontWeight(FontWeight.Medium)
                  
                  Text('取件码：' + item.code)
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

      if (this.featureIndex === 4) {
        Column() {
          Text('热门帖子')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#333333')
            .margin({ bottom: 15 })

          Column() {
            ForEach(this.posts, (item: PostItem, index: number) => {
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

      if (this.featureIndex === 5) {
        Column() {
          Text('热门商品')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#333333')
            .margin({ bottom: 15 })

          Column() {
            ForEach(this.products, (item: ProductItem, index: number) => {
              Row() {
                Column() {
                  Text(item.name)
                    .fontSize(15)
                    .fontColor('#333333')
                    .fontWeight(FontWeight.Medium)
                  
                  Text('卖家：' + item.seller)
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
        .backgroundColor(this.featureColors[this.featureIndex])
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
