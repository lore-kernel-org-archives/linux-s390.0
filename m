Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Logan Gunthorpe <logang@deltatee.com>
Date: Mon, 29 May 2017 13:13:08 -0600
Message-Id: <20170529191308.8499-1-logang@deltatee.com>
Subject: [PATCH v2] s390: provide default ioremap and iounmap declaration
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Logan Gunthorpe <logang@deltatee.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Al Viro <viro@ZenIV.linux.org.uk>
List-ID: <linux-s390.vger.kernel.org>

Move the CONFIG_PCI device so that ioremap and iounmap are always
available. This looks safe as there's nothing PCI specific in the
implementation of these functions.

I have designs to use these functions in scatterlist.c where they'd likely
never be called without CONFIG_PCI set, but this is needed to compile
such changes.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
cc: Sebastian Ott <sebott@linux.vnet.ibm.com>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
---

v2 of this patch is changed to simply move the CONFIG_PCI #ifdef
to expose only a single set of functions as suggested by Heiko
Carstens.

 arch/s390/include/asm/io.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/io.h b/arch/s390/include/asm/io.h
index 437e9af96688..904e4b3af95d 100644
--- a/arch/s390/include/asm/io.h
+++ b/arch/s390/include/asm/io.h
@@ -25,8 +25,6 @@ void unxlate_dev_mem_ptr(phys_addr_t phys, void *addr);

 #define IO_SPACE_LIMIT 0

-#ifdef CONFIG_PCI
-
 #define ioremap_nocache(addr, size)	ioremap(addr, size)
 #define ioremap_wc			ioremap_nocache
 #define ioremap_wt			ioremap_nocache
@@ -49,6 +47,8 @@ static inline void ioport_unmap(void __iomem *p)
 {
 }

+#ifdef CONFIG_PCI
+
 /*
  * s390 needs a private implementation of pci_iomap since ioremap with its
  * offset parameter isn't sufficient. That's because BAR spaces are not
--
2.11.0
