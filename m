From: Alexander Gordeev <agordeev@redhat.com>
Subject: [PATCH 0/2] Phase out pci_enable_msi_block()
Date: Mon, 14 Apr 2014 09:14:05 +0200
Message-Id: <cover.1397458024.git.agordeev@redhat.com>
Return-Path: <agordeev@redhat.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
List-Archive: <https://lore.kernel.org/linux-mips/>
List-Post: <mailto:linux-mips@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Alexander Gordeev <agordeev@redhat.com>, Frank Haverkamp <haver@linux.vnet.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, x86@kernel.org, linux-pci@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hello,

This series is against 3.15-rc1.

This update obsoletes pci_enable_msi_block() function in
favor of pci_enable_msi_range() and pci_enable_msi_exact().


Cc: Frank Haverkamp <haver@linux.vnet.ibm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-mips@linux-mips.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-s390@vger.kernel.org
Cc: x86@kernel.org
Cc: linux-pci@vger.kernel.org


Alexander Gordeev (2):
  GenWQE: Use pci_enable_msi_exact() instead of pci_enable_msi_block()
  PCI/MSI: Phase out pci_enable_msi_block()

 drivers/misc/genwqe/card_utils.c |    2 +-
 drivers/pci/msi.c                |   79 ++++++++++++++++----------------------
 include/linux/pci.h              |    5 +--
 3 files changed, 35 insertions(+), 51 deletions(-)

-- 
1.7.7.6
