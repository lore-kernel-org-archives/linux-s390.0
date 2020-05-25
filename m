Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-ej1-f66.google.com ([209.85.218.66]:37236 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387644AbgEYS0N (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 25 May 2020 14:26:13 -0400
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Subject: [PATCH 0/8] Add helper for accessing Power Management callbacs
Date: Mon, 25 May 2020 18:26:00 +0000
Message-Id: <20200525182608.1823735-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Felipe Balbi <balbi@kernel.org>, Julian Wiedmann <jwi@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Jakub Kicinski <kuba@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, John Stultz <john.stultz@linaro.org>, "David S. Miller" <davem@davemloft.net>, greybus-dev@lists.linaro.org, netdev@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org

This series aims to add a new driver_to_pm() helper allowing for
accessing the Power Management callbacs for a particular device.

Access to the callbacs (struct dev_pm_ops) is normally done through
using the pm pointer that is embedded within the device_driver struct.

This new helper allows for the code required to reference the pm pointer
and access Power Management callbas to be simplified.  Changing the
following:

  struct device_driver *drv = dev->driver;
  if (dev->driver && dev->driver->pm && dev->driver->pm->prepare) {
      int ret = dev->driver->pm->prepare(dev);

To:

  const struct dev_pm_ops *pm = driver_to_pm(dev->driver);
  if (pm && pm->prepare) {
      int ret = pm->prepare(dev);

Or, changing the following:

     const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;

To:
     const struct dev_pm_ops *pm = driver_to_pm(dev->driver);

This series builds on top of the previous commit 6da2f2ccfd2d ("PCI/PM:
Make power management op coding style consistent") that had an aim to
make accessing the Power Managemnet callbacs more consistent.

No functional change intended.

Links:
  https://lore.kernel.org/driverdev-devel/20191014230016.240912-6-helgaas@kernel.org/
  https://lore.kernel.org/driverdev-devel/8592302.r4xC6RIy69@kreacher/
  https://lore.kernel.org/driverdev-devel/20191016135002.GA24678@kadam/

Krzysztof Wilczyński (8):
  driver core: Add helper for accessing Power Management callbacs
  ACPI: PM: Use the new device_to_pm() helper to access struct
    dev_pm_ops
  greybus: Use the new device_to_pm() helper to access struct dev_pm_ops
  scsi: pm: Use the new device_to_pm() helper to access struct
    dev_pm_ops
  usb: phy: fsl: Use the new device_to_pm() helper to access struct
    dev_pm_ops
  PCI/PM: Use the new device_to_pm() helper to access struct dev_pm_ops
  PM: Use the new device_to_pm() helper to access struct dev_pm_ops
  net/iucv: Use the new device_to_pm() helper to access struct
    dev_pm_ops

 drivers/acpi/device_pm.c         |  5 ++-
 drivers/base/power/domain.c      | 12 ++++--
 drivers/base/power/generic_ops.c | 65 ++++++++++++++------------------
 drivers/base/power/main.c        | 48 +++++++++++++++--------
 drivers/base/power/runtime.c     |  7 ++--
 drivers/greybus/bundle.c         |  4 +-
 drivers/pci/pci-driver.c         | 32 ++++++++--------
 drivers/scsi/scsi_pm.c           |  8 ++--
 drivers/usb/phy/phy-fsl-usb.c    | 11 ++++--
 include/linux/device/driver.h    | 15 ++++++++
 net/iucv/iucv.c                  | 30 +++++++++------
 11 files changed, 138 insertions(+), 99 deletions(-)

-- 
2.26.2
