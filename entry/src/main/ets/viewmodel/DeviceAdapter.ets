import { display } from '@kit.ArkUI';

export enum DeviceType {
  PHONE = 'phone',
  TABLET = 'tablet',
  TV = 'tv',
  WEARABLE = 'wearable',
  DEFAULT = 'default'
}

export enum BreakpointType {
  SM = 'sm',
  MD = 'md',
  LG = 'lg'
}

export interface ScreenSize {
  width: number;
  height: number;
}

export interface LayoutConfig {
  columns: number;
  gutter: number;
  margin: number;
}

export class DeviceAdapter {
  private static instance: DeviceAdapter;
  private deviceType: DeviceType = DeviceType.DEFAULT;
  private breakpointType: BreakpointType = BreakpointType.SM;
  private screenWidth: number = 0;
  private screenHeight: number = 0;
  private densityDPI: number = 0;

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
      this.densityDPI = displayInfo.densityDPI;
      
      const widthPixels = displayInfo.width;
      
      if (widthPixels < 200) {
        this.deviceType = DeviceType.WEARABLE;
        this.breakpointType = BreakpointType.SM;
      } else if (widthPixels > 600 && this.densityDPI > 240) {
        this.deviceType = DeviceType.TABLET;
        this.breakpointType = BreakpointType.LG;
      } else if (widthPixels > 1000) {
        this.deviceType = DeviceType.TV;
        this.breakpointType = BreakpointType.LG;
      } else if (widthPixels >= 600) {
        this.deviceType = DeviceType.PHONE;
        this.breakpointType = BreakpointType.MD;
      } else {
        this.deviceType = DeviceType.PHONE;
        this.breakpointType = BreakpointType.SM;
      }
    } catch (error) {
      const err = error as Error;
      console.error('DeviceAdapter init error:', err.message);
      this.deviceType = DeviceType.DEFAULT;
      this.breakpointType = BreakpointType.SM;
    }
  }

  getDeviceType(): DeviceType {
    return this.deviceType;
  }

  getBreakpointType(): BreakpointType {
    return this.breakpointType;
  }

  getScreenSize(): ScreenSize {
    const size: ScreenSize = {
      width: this.screenWidth,
      height: this.screenHeight
    };
    return size;
  }

  getDensityDPI(): number {
    return this.densityDPI;
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

  getTitleFontSize(): number {
    switch (this.breakpointType) {
      case BreakpointType.SM:
        return 16;
      case BreakpointType.MD:
        return 18;
      case BreakpointType.LG:
        return 24;
      default:
        return 16;
    }
  }

  getButtonHeight(): number {
    switch (this.breakpointType) {
      case BreakpointType.SM:
        return 40;
      case BreakpointType.MD:
        return 48;
      case BreakpointType.LG:
        return 56;
      default:
        return 40;
    }
  }

  getLayoutConfig(): LayoutConfig {
    const config: LayoutConfig = {
      columns: 4,
      gutter: 16,
      margin: 16
    };
    
    switch (this.breakpointType) {
      case BreakpointType.SM:
        config.columns = 4;
        config.gutter = 16;
        config.margin = 16;
        break;
      case BreakpointType.MD:
        config.columns = 8;
        config.gutter = 20;
        config.margin = 24;
        break;
      case BreakpointType.LG:
        config.columns = 12;
        config.gutter = 24;
        config.margin = 32;
        break;
      default:
        break;
    }
    
    return config;
  }

  isHorizontalLayout(): boolean {
    return this.deviceType === DeviceType.TV || this.screenWidth > this.screenHeight;
  }

  isLandscape(): boolean {
    return this.screenWidth > this.screenHeight;
  }

  vp2px(vp: number): number {
    return vp * (this.densityDPI / 160);
  }

  px2vp(px: number): number {
    return px / (this.densityDPI / 160);
  }
}