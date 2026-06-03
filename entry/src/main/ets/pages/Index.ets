/*
 * Copyright (c) 2022 Huawei Device Co., Ltd.
 * Licensed under the Apache License,Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { AnimationWidgets } from '../view/AnimationWidgets';
import { CountController } from '../view/CountController';
import Common from '../common/constants/Const';
import {IconsModel} from '../viewmodel/IconsModel';
import { DistributedManager, DeviceInfo } from '../viewmodel/DistributedManager';
import { DeviceAdapter, DeviceType } from '../viewmodel/DeviceAdapter';
import { promptAction } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State quantity: number = Common.IMAGES_MIN;
  @Provide iconModel: IconsModel = new IconsModel(this.quantity, Common.OFFSET_RADIUS);
  private distributedManager: DistributedManager = DistributedManager.getInstance();
  private deviceAdapter: DeviceAdapter = DeviceAdapter.getInstance();
  @State deviceInfo: string = '';
  @State deviceList: DeviceInfo[] = [];
  @State showDeviceList: boolean = false;
  @State isMigrating: boolean = false;

  aboutToAppear() {
    this.deviceAdapter.init().then(() => {
      this.deviceInfo = `设备: ${this.deviceAdapter.getDeviceType()}`;
    });
  }

  refreshDeviceList() {
    this.deviceList = this.distributedManager.getDeviceList();
    if (this.deviceList.length === 0) {
      try {
        promptAction.showToast({
          message: '未发现可流转设备',
          duration: 2000
        });
      } catch (error) {
        console.error('showToast error:', error);
      }
    }
  }

  async migrateToDevice(deviceId: string, deviceName: string) {
    this.isMigrating = true;
    this.showDeviceList = false;
    
    try {
      try {
        promptAction.showToast({
          message: `正在流转到 ${deviceName}...`,
          duration: 2000
        });
      } catch (err) {
        console.error('showToast error:', err);
      }
      await this.distributedManager.continueToRemote(deviceId);
    } catch (error) {
      try {
        promptAction.showToast({
          message: '流转失败',
          duration: 2000
        });
      } catch (err) {
        console.error('showToast error:', err);
      }
    } finally {
      this.isMigrating = false;
    }
  }

  build() {
    Stack() {
      Column() {
        Row() {
          Text(this.deviceInfo)
            .fontSize(12)
            .fontColor('#999999')
          
          Blank()
          
          Button(this.isMigrating ? '流转中...' : '流转')
            .fontSize(14)
            .enabled(!this.isMigrating)
            .onClick(() => {
              this.refreshDeviceList();
              this.showDeviceList = true;
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .padding({ left: 20, right: 20, top: 10 })

        AnimationWidgets({
          quantity: $quantity
        })

        CountController({
          quantity: $quantity
        })
      }
      .width(Common.DEFAULT_FULL_WIDTH)
      .height(Common.DEFAULT_FULL_HEIGHT)
      .backgroundColor($r('app.color.bgColor'))

      if (this.showDeviceList) {
        Column() {
          Column() {
            Text('选择目标设备')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .margin({ bottom: 15 })

            if (this.deviceList.length === 0) {
              Text('暂无可用设备')
                .fontSize(14)
                .fontColor('#999999')
                .margin({ top: 20, bottom: 20 })
            } else {
              ForEach(this.deviceList, (device: DeviceInfo) => {
                Row() {
                  Column() {
                    Text(device.deviceName)
                      .fontSize(16)
                      .fontWeight(FontWeight.Medium)
                    
                    Text(device.deviceType)
                      .fontSize(12)
                      .fontColor('#999999')
                      .margin({ top: 4 })
                  }
                  .alignItems(HorizontalAlign.Start)
                  .layoutWeight(1)

                  Button('迁移')
                    .fontSize(14)
                    .height(36)
                    .onClick(() => {
                      this.migrateToDevice(device.deviceId, device.deviceName);
                    })
                }
                .width('100%')
                .padding({ top: 12, bottom: 12 })
                .border({ width: { bottom: 1 }, color: '#E0E0E0' })
              }, (device: DeviceInfo) => device.deviceId)
            }

            Button('关闭')
              .width('100%')
              .margin({ top: 20 })
              .backgroundColor('#F0F0F0')
              .fontColor('#333333')
              .onClick(() => {
                this.showDeviceList = false;
              })
          }
          .width('80%')
          .padding(20)
          .backgroundColor(Color.White)
          .borderRadius(12)
          .shadow({ radius: 20, color: '#00000020', offsetX: 0, offsetY: 5 })
        }
        .width('100%')
        .height('100%')
        .backgroundColor('rgba(0, 0, 0, 0.3)')
        .justifyContent(FlexAlign.Center)
        .onClick(() => {
          this.showDeviceList = false;
        })
      }
    }
    .width('100%')
    .height('100%')
  }
}