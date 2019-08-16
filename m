Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41642 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbfHPJY5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 16 Aug 2019 05:24:57 -0400
From: Denis Efremov <efremov@linux.com>
Subject: [PATCH v2 00/10] Add definition for the number of standard PCI BARs
Date: Fri, 16 Aug 2019 12:24:27 +0300
Message-Id: <20190816092437.31846-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, Sebastian Ott <sebott@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, Alexandre Torgue <alexandre.torgue@st.com>, Matt Porter <mporter@kernel.crashing.org>, Alexandre Bounine <alex.bou9@gmail.com>, Peter Jones <pjones@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Cornelia Huck <cohuck@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Andrew Murray <andrew.murray@arm.com>, Jose Abreu <Jose.Abreu@synopsys.com>, kvm@vger.kernel.org, linux-fbdev@vger.kernel.org, netdev@vger.kernel.org, x86@kernel.org, linux-s390@vger.kernel.org

Code that iterates over all standard PCI BARs typically uses
PCI_STD_RESOURCE_END, but this is error-prone because it requires
"i <= PCI_STD_RESOURCE_END" rather than something like
"i < PCI_STD_NUM_BARS". We could add such a definition and use it the same
way PCI_SRIOV_NUM_BARS is used. There is already the definition
PCI_BAR_COUNT for s390 only. Thus, this patchset introduces it globally.

Changes in v2:
  - Reverse checks in pci_iomap_range,pci_iomap_wc_range.
  - Refactor loops in vfio_pci to keep PCI_STD_RESOURCES.
  - Add 2 new patches to replace the magic constant with new define.
  - Split net patch in v1 to separate stmmac and dwc-xlgmac patches.

Denis Efremov (10):
  PCI: Add define for the number of standard PCI BARs
  s390/pci: Loop using PCI_STD_NUM_BARS
  x86/PCI: Loop using PCI_STD_NUM_BARS
  stmmac: pci: Loop using PCI_STD_NUM_BARS
  net: dwc-xlgmac: Loop using PCI_STD_NUM_BARS
  rapidio/tsi721: Loop using PCI_STD_NUM_BARS
  efifb: Loop using PCI_STD_NUM_BARS
  vfio_pci: Loop using PCI_STD_NUM_BARS
  PCI: hv: Use PCI_STD_NUM_BARS
  PCI: Use PCI_STD_NUM_BARS

 arch/s390/include/asm/pci.h                      |  5 +----
 arch/s390/include/asm/pci_clp.h                  |  6 +++---
 arch/s390/pci/pci.c                              | 16 ++++++++--------
 arch/s390/pci/pci_clp.c                          |  6 +++---
 arch/x86/pci/common.c                            |  2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c |  4 ++--
 drivers/net/ethernet/synopsys/dwc-xlgmac-pci.c   |  2 +-
 drivers/pci/controller/pci-hyperv.c              | 10 +++++-----
 drivers/pci/pci.c                                | 11 ++++++-----
 drivers/pci/quirks.c                             |  4 ++--
 drivers/rapidio/devices/tsi721.c                 |  2 +-
 drivers/vfio/pci/vfio_pci.c                      | 11 +++++++----
 drivers/vfio/pci/vfio_pci_config.c               | 10 ++++++----
 drivers/vfio/pci/vfio_pci_private.h              |  4 ++--
 drivers/video/fbdev/efifb.c                      |  2 +-
 include/linux/pci.h                              |  2 +-
 include/uapi/linux/pci_regs.h                    |  1 +
 17 files changed, 51 insertions(+), 47 deletions(-)

-- 
2.21.0
