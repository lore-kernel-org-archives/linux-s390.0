Return-Path: <linux-pci-owner@vger.kernel.org>
From: Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH 5/5] s390/MSI: Fix msi mask issue
Date: Thu, 19 Jun 2014 16:31:14 +0800
Message-ID: <1403166674-6836-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-pci/>
List-Post: <mailto:linux-pci@vger.kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Sebastian Ott <sebott@linux.vnet.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-pci@vger.kernel.org, Wuyun <wuyun.wu@huawei.com>, Xinwei Hu <huxinwei@huawei.com>, Yijing Wang <wangyijing@huawei.com>
List-ID: <linux-s390.vger.kernel.org>

Maskbit in msi_attrib indicates MSI whether
support mask-pending bit. It is read only,
should save mask state in masked.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 arch/s390/pci/pci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index bdf0257..4651d6b 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -263,7 +263,7 @@ static int zpci_msi_set_mask_bits(struct msi_desc *msi, u32 mask, u32 flag)
 	} else
 		return 0;
 
-	msi->msi_attrib.maskbit = !!flag;
+	msi->masked = !!flag;
 	return 1;
 }
 
-- 
1.7.1
