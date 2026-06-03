import { distributedDeviceManager } from '@kit.DistributedServiceKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import common from '@ohos.app.ability.common';

const TAG: string = 'DistributedManager';
const DOMAIN_CODE: number = 0xFF00;

export interface DeviceInfo {
  deviceId: string;
  deviceName: string;
  deviceType: string;
}

export class DistributedManager {
  private static instance: DistributedManager | null = null;
  private deviceManager: distributedDeviceManager.DeviceManager | null = null;
  private context: common.UIAbilityContext | null = null;
  private continueData: Record<string, Object> = {};

  private constructor() {}

  static getInstance(): DistributedManager {
    if (!DistributedManager.instance) {
      DistributedManager.instance = new DistributedManager();
    }
    return DistributedManager.instance;
  }

  init(context: common.UIAbilityContext): void {
    this.context = context;
    this.initDeviceManager();
  }

  private initDeviceManager(): void {
    try {
      const authInfo: distributedDeviceManager.AuthParam = {
        authType: distributedDeviceManager.AuthType.SAME_ACCOUNT,
        extraInfo: {}
      };
      
      this.deviceManager = distributedDeviceManager.createDeviceManager('com.example.animation', authInfo);
      hilog.info(DOMAIN_CODE, TAG, 'DeviceManager created successfully');
    } catch (error) {
      const err = error as Error;
      hilog.error(DOMAIN_CODE, TAG, 'Failed to create DeviceManager: %{public}s', err.message);
    }
  }

  saveContinueData(wantParam: Record<string, Object>): void {
    this.continueData = wantParam;
    hilog.info(DOMAIN_CODE, TAG, 'Continue data saved');
  }

  getContinueData(): Record<string, Object> {
    return this.continueData;
  }

  getDeviceList(): DeviceInfo[] {
    if (!this.deviceManager) {
      hilog.warn(DOMAIN_CODE, TAG, 'DeviceManager is null');
      return [];
    }
    
    try {
      const devices = this.deviceManager.getAvailableDeviceListSync();
      hilog.info(DOMAIN_CODE, TAG, 'Available devices: %{public}d', devices.length);
      
      const deviceList: DeviceInfo[] = [];
      for (let i = 0; i < devices.length; i++) {
        const device = devices[i];
        const info: DeviceInfo = {
          deviceId: device.deviceId,
          deviceName: device.deviceName,
          deviceType: this.getDeviceTypeName(device.deviceType)
        };
        deviceList.push(info);
      }
      return deviceList;
    } catch (error) {
      const err = error as Error;
      hilog.error(DOMAIN_CODE, TAG, 'Failed to get device list: %{public}s', err.message);
      return [];
    }
  }

  private getDeviceTypeName(deviceType: number): string {
    if (deviceType === 0x00) {
      return '手机';
    } else if (deviceType === 0x01) {
      return '平板';
    } else if (deviceType === 0x02) {
      return '电视';
    } else if (deviceType === 0x06) {
      return '手表';
    } else {
      return '未知设备';
    }
  }

  async continueToRemote(deviceId: string): Promise<void> {
    if (!this.context) {
      hilog.error(DOMAIN_CODE, TAG, 'Context is null');
      throw new Error('Context not initialized');
    }

    try {
      hilog.info(DOMAIN_CODE, TAG, 'Starting continue to device: %{public}s', deviceId);
      await this.context.continueAbility(deviceId);
      hilog.info(DOMAIN_CODE, TAG, 'Continue to remote device succeeded');
    } catch (error) {
      const err = error as Error;
      hilog.error(DOMAIN_CODE, TAG, 'Failed to continue: %{public}s', err.message);
      throw new Error(err.message);
    }
  }

  async startMigration(): Promise<void> {
    const devices = this.getDeviceList();
    
    if (devices.length === 0) {
      hilog.warn(DOMAIN_CODE, TAG, 'No available devices for migration');
      return;
    }

    const targetDevice = devices[0];
    hilog.info(DOMAIN_CODE, TAG, 'Migrating to device: %{public}s', targetDevice.deviceName);
    
    await this.continueToRemote(targetDevice.deviceId);
  }

  release(): void {
    if (this.deviceManager) {
      try {
        distributedDeviceManager.releaseDeviceManager(this.deviceManager);
        hilog.info(DOMAIN_CODE, TAG, 'DeviceManager released');
      } catch (error) {
        const err = error as Error;
        hilog.error(DOMAIN_CODE, TAG, 'Failed to release: %{public}s', err.message);
      }
      this.deviceManager = null;
    }
  }
}
