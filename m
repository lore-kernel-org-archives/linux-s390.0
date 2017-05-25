Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Logan Gunthorpe <logang@deltatee.com>
Date: Thu, 25 May 2017 09:43:48 -0600
Message-Id: <1495727028-27656-1-git-send-email-logang@deltatee.com>
Subject: [PATCH] s390: provide default ioremap and iounmap declaration
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Logan Gunthorpe <logang@deltatee.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Al Viro <viro@ZenIV.linux.org.uk>
List-ID: <linux-s390.vger.kernel.org>

Add a default ioremap function which was not provided in all
circumstances. (Only when CONFIG_PCI was set).

I have designs to use them in scatterlist.c where they'd likely never
be called without CONFIG_PCI set, but it is needed to compile. Thus,
if the function is ever hit it returns NULL.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
---

Thanks to Al Viro for pointing out this corner case in s390.

 arch/s390/include/asm/io.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/s390/include/asm/io.h b/arch/s390/include/asm/io.h
index 437e9af..f4140d4 100644
--- a/arch/s390/include/asm/io.h
+++ b/arch/s390/include/asm/io.h
@@ -73,6 +73,17 @@ static inline void ioport_unmap(void __iomem *p)
 #define __raw_writel	zpci_write_u32
 #define __raw_writeq	zpci_write_u64

+#else
+
+static inline void __iomem *ioremap(unsigned long offset, unsigned long size)
+{
+	return NULL;
+}
+
+static inline void iounmap(void __iomem *addr)
+{
+}
+
 #endif /* CONFIG_PCI */

 #include <asm-generic/io.h>
--
2.1.4
