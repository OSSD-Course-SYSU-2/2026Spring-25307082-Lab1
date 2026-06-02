import distributedDeviceManager from '@ohos.distributedDeviceManager';
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
  private deviceManager: distributedDeviceManager.DeviceManager | null = null;
  private context: common.UIAbilityContext;
  private deviceList: DeviceInfo[] = [];

  constructor(context: common.UIAbilityContext) {
    this.context = context;
    this.initDeviceManager();
  }

  private initDeviceManager(): void {
    try {
      const deviceInfo: distributedDeviceManager.DeviceInfo = {
        deviceId: 'local',
        deviceName: 'local',
        deviceType: distributedDeviceManager.DeviceType.UNKNOWN,
        networkId: 'local'
      };
      
      this.deviceManager = distributedDeviceManager.createDeviceManager('com.example.animation', deviceInfo);
      hilog.info(DOMAIN_CODE, TAG, 'DeviceManager created');
    } catch (error) {
      hilog.error(DOMAIN_CODE, TAG, 'Failed to create DeviceManager: %{public}s', JSON.stringify(error));
    }
  }

  getDeviceList(): DeviceInfo[] {
    if (!this.deviceManager) {
      return [];
    }
    
    try {
      const devices = this.deviceManager.getAvailableDeviceListSync();
      return devices.map((device: distributedDeviceManager.DeviceInfo) => ({
        deviceId: device.deviceId,
        deviceName: device.deviceName,
        deviceType: this.getDeviceTypeName(device.deviceType)
      }));
    } catch (error) {
      hilog.error(DOMAIN_CODE, TAG, 'Failed to get device list: %{public}s', JSON.stringify(error));
      return [];
    }
  }

  private getDeviceTypeName(deviceType: number): string {
    switch (deviceType) {
      case distributedDeviceManager.DeviceType.PHONE:
        return '手机';
      case distributedDeviceManager.DeviceType.TABLET:
        return '平板';
      case distributedDeviceManager.DeviceType.TV:
        return '电视';
      case distributedDeviceManager.DeviceType.WEARABLE:
        return '手表';
      default:
        return '未知设备';
    }
  }

  async continueToRemote(deviceId: string): Promise<void> {
    try {
      await this.context.continueAbility(deviceId);
      hilog.info(DOMAIN_CODE, TAG, 'Continue to remote device: %{public}s', deviceId);
    } catch (error) {
      hilog.error(DOMAIN_CODE, TAG, 'Failed to continue: %{public}s', JSON.stringify(error));
      throw error;
    }
  }

  release(): void {
    if (this.deviceManager) {
      try {
        distributedDeviceManager.releaseDeviceManager(this.deviceManager);
        hilog.info(DOMAIN_CODE, TAG, 'DeviceManager released');
      } catch (error) {
        hilog.error(DOMAIN_CODE, TAG, 'Failed to release: %{public}s', JSON.stringify(error));
      }
      this.deviceManager = null;
    }
  }
}