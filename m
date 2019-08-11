Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40989 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbfHKPIY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 11 Aug 2019 11:08:24 -0400
From: Denis Efremov <efremov@linux.com>
Subject: [PATCH 0/7] Add definition for the number of standard PCI BARs
Date: Sun, 11 Aug 2019 18:07:55 +0300
Message-Id: <20190811150802.2418-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Denis Efremov <efremov@linux.com>, Sebastian Ott <sebott@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, Alexandre Torgue <alexandre.torgue@st.com>, Matt Porter <mporter@kernel.crashing.org>, Alexandre Bounine <alex.bou9@gmail.com>, Peter Jones <pjones@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Cornelia Huck <cohuck@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org, linux-fbdev@vger.kernel.org, netdev@vger.kernel.org, x86@kernel.org, linux-s390@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org

Code that iterates over all standard PCI BARs typically uses
PCI_STD_RESOURCE_END, but this is error-prone because it requires
"i <= PCI_STD_RESOURCE_END" rather than something like
"i < PCI_STD_NUM_BARS". We could add such a definition and use it the same
way PCI_SRIOV_NUM_BARS is used. There is already the definition
PCI_BAR_COUNT for s390 only. Thus, this patchset introduces it globally.

The patch is splitted into 7 parts for different drivers/subsystems for
easy readability.

Denis Efremov (7):
  PCI: Add define for the number of standard PCI BARs
  s390/pci: Replace PCI_BAR_COUNT with PCI_STD_NUM_BARS
  x86/PCI: Use PCI_STD_NUM_BARS in loops instead of PCI_STD_RESOURCE_END
  PCI/net: Use PCI_STD_NUM_BARS in loops instead of PCI_STD_RESOURCE_END
  rapidio/tsi721: use PCI_STD_NUM_BARS in loops instead of
    PCI_STD_RESOURCE_END
  efifb: Use PCI_STD_NUM_BARS in loops instead of PCI_STD_RESOURCE_END
  vfio_pci: Use PCI_STD_NUM_BARS in loops instead of
    PCI_STD_RESOURCE_END

 arch/s390/include/asm/pci.h                      |  5 +----
 arch/s390/include/asm/pci_clp.h                  |  6 +++---
 arch/s390/pci/pci.c                              | 16 ++++++++--------
 arch/s390/pci/pci_clp.c                          |  6 +++---
 arch/x86/pci/common.c                            |  2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c |  4 ++--
 drivers/net/ethernet/synopsys/dwc-xlgmac-pci.c   |  2 +-
 drivers/pci/quirks.c                             |  2 +-
 drivers/rapidio/devices/tsi721.c                 |  2 +-
 drivers/vfio/pci/vfio_pci.c                      |  4 ++--
 drivers/vfio/pci/vfio_pci_config.c               |  2 +-
 drivers/vfio/pci/vfio_pci_private.h              |  4 ++--
 drivers/video/fbdev/efifb.c                      |  2 +-
 include/linux/pci.h                              |  2 +-
 include/uapi/linux/pci_regs.h                    |  1 +
 15 files changed, 29 insertions(+), 31 deletions(-)

-- 
2.21.0
