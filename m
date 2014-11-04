Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Frank Blaschka <blaschka@linux.vnet.ibm.com>
Subject: [PATCH linux-next] s390/io: add ioport_map stubs
Date: Tue,  4 Nov 2014 13:09:13 +0100
Message-Id: <1415102953-49643-1-git-send-email-blaschka@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com
Cc: alex.williamson@redhat.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Frank Blaschka <frank.blaschka@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Frank Blaschka <frank.blaschka@de.ibm.com>

add ioport_map stubs to make vfio build on s390.

Signed-off-by: Frank Blaschka <frank.blaschka@de.ibm.com>
---
 arch/s390/include/asm/io.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/s390/include/asm/io.h b/arch/s390/include/asm/io.h
index cd6b9ee..ba516f8 100644
--- a/arch/s390/include/asm/io.h
+++ b/arch/s390/include/asm/io.h
@@ -38,6 +38,15 @@ static inline void iounmap(volatile void __iomem *addr)
 {
 }
 
+static inline void __iomem *ioport_map(unsigned long port, unsigned int nr)
+{
+	return NULL;
+}
+
+static inline void ioport_unmap(void __iomem *p)
+{
+}
+
 /*
  * s390 needs a private implementation of pci_iomap since ioremap with its
  * offset parameter isn't sufficient. That's because BAR spaces are not
-- 
1.8.5.5
