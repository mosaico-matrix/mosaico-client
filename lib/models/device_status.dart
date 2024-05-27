enum DeviceStatusEnum { CONNECTED, DISCONNECTED, ERROR }

class DeviceStatus {
  DeviceStatusEnum status;

  DeviceStatus({required this.status});

  bool isConnected() {
    return status == DeviceStatusEnum.CONNECTED;
  }

  String getStatusString() {
    switch (status) {
      case DeviceStatusEnum.CONNECTED:
        return "Connected";
      case DeviceStatusEnum.DISCONNECTED:
        return "Disconnected";
      default:
        return "Error";
    }
  }

  String getStatusMessage() {
    switch (status) {
      case DeviceStatusEnum.CONNECTED:
        return "Connected to device";
      case DeviceStatusEnum.DISCONNECTED:
        return "Disconnected from device";
      default:
        return "Error";
    }
  }
}
