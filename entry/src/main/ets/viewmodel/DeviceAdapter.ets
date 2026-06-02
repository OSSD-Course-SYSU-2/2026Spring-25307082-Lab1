import { display } from '@kit.ArkUI';

export enum DeviceType {
  PHONE = 'phone',
  TABLET = 'tablet',
  TV = 'tv',
  WEARABLE = 'wearable',
  DEFAULT = 'default'
}

export class DeviceAdapter {
  private static instance: DeviceAdapter;
  private deviceType: DeviceType = DeviceType.DEFAULT;
  private screenWidth: number = 0;
  private screenHeight: number = 0;

  private constructor() {}

  static getInstance(): DeviceAdapter {
    if (!DeviceAdapter.instance) {
      DeviceAdapter.instance = new DeviceAdapter();
    }
    return DeviceAdapter.instance;
  }

  async init(): Promise<void> {
    try {
      const displayInfo = display.getDefaultDisplaySync();
      this.screenWidth = displayInfo.width;
      this.screenHeight = displayInfo.height;
      
      const densityDpi = displayInfo.densityDpi;
      const widthPixels = displayInfo.width;
      
      if (widthPixels < 200) {
        this.deviceType = DeviceType.WEARABLE;
      } else if (widthPixels > 600 && densityDpi > 240) {
        this.deviceType = DeviceType.TABLET;
      } else if (widthPixels > 1000) {
        this.deviceType = DeviceType.TV;
      } else {
        this.deviceType = DeviceType.PHONE;
      }
    } catch (error) {
      this.deviceType = DeviceType.DEFAULT;
    }
  }

  getDeviceType(): DeviceType {
    return this.deviceType;
  }

  getScreenSize(): { width: number; height: number } {
    return { width: this.screenWidth, height: this.screenHeight };
  }

  getIconSize(): number {
    switch (this.deviceType) {
      case DeviceType.WEARABLE:
        return 32;
      case DeviceType.TABLET:
        return 80;
      case DeviceType.TV:
        return 96;
      default:
        return 58;
    }
  }

  getOffsetRadius(): number {
    switch (this.deviceType) {
      case DeviceType.WEARABLE:
        return 80;
      case DeviceType.TABLET:
        return 200;
      case DeviceType.TV:
        return 250;
      default:
        return 145;
    }
  }

  getControllerHeight(): string {
    switch (this.deviceType) {
      case DeviceType.WEARABLE:
        return '200vp';
      case DeviceType.TABLET:
        return '400vp';
      case DeviceType.TV:
        return '500vp';
      default:
        return '336vp';
    }
  }

  getFontSize(): number {
    switch (this.deviceType) {
      case DeviceType.WEARABLE:
        return 12;
      case DeviceType.TABLET:
        return 18;
      case DeviceType.TV:
        return 20;
      default:
        return 16;
    }
  }

  isHorizontalLayout(): boolean {
    return this.deviceType === DeviceType.TV || this.screenWidth > this.screenHeight;
  }
}