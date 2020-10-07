Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH v3 2/5] s390/pci: track whether util_str is valid in the zpci_dev
Date: Wed,  7 Oct 2020 14:56:21 -0400
Message-Id: <1602096984-13703-3-git-send-email-mjrosato@linux.ibm.com>
In-Reply-To: <1602096984-13703-1-git-send-email-mjrosato@linux.ibm.com>
References: <1602096984-13703-1-git-send-email-mjrosato@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: alex.williamson@redhat.com, cohuck@redhat.com, schnelle@linux.ibm.com
Cc: pmorel@linux.ibm.com, borntraeger@de.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org

We'll need to keep track of whether or not the byte string in util_str is
valid and thus needs to be passed to a vfio-pci passthrough device.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
Acked-by: Niklas Schnelle <schnelle@linux.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
---
 arch/s390/include/asm/pci.h | 3 ++-
 arch/s390/pci/pci_clp.c     | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 882e233..fa1fed4 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -132,7 +132,8 @@ struct zpci_dev {
 	u8		rid_available	: 1;
 	u8		has_hp_slot	: 1;
 	u8		is_physfn	: 1;
-	u8		reserved	: 5;
+	u8		util_str_avail	: 1;
+	u8		reserved	: 4;
 	unsigned int	devfn;		/* DEVFN part of the RID*/
 
 	struct mutex lock;
diff --git a/arch/s390/pci/pci_clp.c b/arch/s390/pci/pci_clp.c
index 48bf316..322689b 100644
--- a/arch/s390/pci/pci_clp.c
+++ b/arch/s390/pci/pci_clp.c
@@ -168,6 +168,7 @@ static int clp_store_query_pci_fn(struct zpci_dev *zdev,
 	if (response->util_str_avail) {
 		memcpy(zdev->util_str, response->util_str,
 		       sizeof(zdev->util_str));
+		zdev->util_str_avail = 1;
 	}
 	zdev->mio_capable = response->mio_addr_avail;
 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
-- 
1.8.3.1
