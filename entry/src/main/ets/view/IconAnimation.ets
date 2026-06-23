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

import IconItem from '../viewmodel/IconItem';
import Common from '../common/constants/Const';
import { DeviceAdapter } from '../viewmodel/DeviceAdapter';

@Component
export struct IconAnimation {
  @Link mainFlag: boolean;
  @ObjectLink item: IconItem;
  @Link showFeature: boolean;
  @Link featureIndex: number;
  private deviceAdapter: DeviceAdapter = DeviceAdapter.getInstance();
  
  private iconTexts: string[] = ['表', '餐', '书', '件', '坛', '易'];
  private iconColors: string[] = ['#FF6B6B', '#4ECDC4', '#45B7D1', '#96CEB4', '#FFEAA7', '#DDA0DD'];

  build() {
    Column() {
      Text(this.iconTexts[this.item.index])
        .fontSize(this.deviceAdapter.getIconSize() * 0.6)
        .fontColor(Color.White)
        .fontWeight(FontWeight.Bold)
    }
    .width(this.deviceAdapter.getIconSize())
    .height(this.deviceAdapter.getIconSize())
    .backgroundColor(this.iconColors[this.item.index])
    .borderRadius(this.deviceAdapter.getIconSize() * 0.3)
    .justifyContent(FlexAlign.Center)
    .shadow({
      radius: 12,
      color: Color.Black,
      offsetX: 0,
      offsetY: 6,
      fill: true
    })
    .translate(this.mainFlag ? { x: this.item.point.x, y: this.item.point.y } : { x: 0, y: 0 })
    .rotate({
      x: 0,
      y: 1,
      z: 0,
      angle: this.item.clicked ? Common.ROTATE_ANGLE_360 : 0
    })
    .scale(this.item.clicked ? { x: Common.SCALE_RATIO, y: Common.SCALE_RATIO } : { x: 1, y: 1 })
    .opacity(this.item.clicked ? Common.OPACITY_06 : 1)
    .onClick(() => {
      if (this.mainFlag) {
        this.featureIndex = this.item.index;
        this.showFeature = true;
      } else {
        this.item.clicked = !this.item.clicked;
      }
    })
    .animation(
      {
        delay: Common.DELAY_10,
        duration: Common.DURATION_1000,
        iterations: 1,
        curve: Curve.EaseInOut,
        playMode: PlayMode.Normal
      }
    )
  }
}