Return-Path: <linux-arch-owner@vger.kernel.org>
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH v2 2/2] arm64: Create asm/initrd.h
Date: Wed, 24 Oct 2018 12:32:56 -0700
Message-ID: <20181024193256.23734-3-f.fainelli@gmail.com>
In-Reply-To: <20181024193256.23734-1-f.fainelli@gmail.com>
References: <20181024193256.23734-1-f.fainelli@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20181024193256.wumKuD7j85biFvUi1mXXHJ6G9G82WIM11bF0vfDfcHU@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marc Zyngier <marc.zyngier@arm.com>, Olof Johansson <olof@lixom.net>, "open list:ALPHA PORT" <linux-alpha@vger.kernel.org>, "open list:SYNOPSYS ARC ARCHITECTURE" <linux-snps-arc@lists.infradead.org>, "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>, "open list:C6X ARCHITECTURE" <linux-c6x-dev@linux-c6x.org>, "moderated list:H8/300
        ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>, "open list:QUALCOMM HEXAGON ARCHITECTURE" <linux-hexagon@vger.kernel.org>, "open list:IA64 Itanium PLATFORM" <linux-ia64@vger.kernel.org>, "open list:M68K ARCHITECTURE" <linux-m68k@lists.linux-m68k.org>, "open list:MIPS" <linux-mips@linux-mips.org>, "moderated list:NIOS2 ARCHITECTURE" <nios2-dev@lists.rocketboards.org>, "open list:OPENRISC ARCHITECTURE" <openrisc@lists.librecores.org>, "open list:PARISC ARCHITECTURE" <linux-parisc@vger.kernel.org>, "open list:LINUX FOR POWERPC 32-BIT AND
        64-BIT" <linuxppc-dev@lists.ozlabs.org>, "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>, "open list:S390" <linux-s390@vger.kernel.org>, "open list:SUPERH" <linux-sh@vger.kernel.org>, "open list:SPARC + UltraSPARC
        sparc/sparc64" <sparclinux@vger.kernel.org>, "open list:USER-MODE LINUX UML" <linux-um@lists.infradead.org>, "open list:TENSILICA XTENSA PORT xtensa" <linux-xtensa@linux-xtensa.org>, "open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE" <devicetree@vger.kernel.org>, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

ARM64 is the only architecture that requires a re-definition of
__early_init_dt_declare_initrd(). Now that we added the infrastructure
in asm-generic to provide an asm/initrd.h file, properly break up that
definition from asm/memory.h and make use of that header in
drivers/of/fdt.c where this is used.

This significantly cuts the number of objects that need to be rebuilt on
ARM64 due to the repercusions of including asm/memory.h in several
places.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm64/include/asm/initrd.h | 13 +++++++++++++
 arch/arm64/include/asm/memory.h |  8 --------
 drivers/of/fdt.c                |  1 +
 3 files changed, 14 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm64/include/asm/initrd.h

diff --git a/arch/arm64/include/asm/initrd.h b/arch/arm64/include/asm/initrd.h
new file mode 100644
index 000000000000..0c9572485810
--- /dev/null
+++ b/arch/arm64/include/asm/initrd.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_INITRD_H
+#define __ASM_INITRD_H
+
+#ifdef CONFIG_BLK_DEV_INITRD
+#define __early_init_dt_declare_initrd(__start, __end)			\
+	do {								\
+		initrd_start = (__start);				\
+		initrd_end = (__end);					\
+	} while (0)
+#endif
+
+#endif /* __ASM_INITRD_H */
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index b96442960aea..dc3ca21ba240 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -168,14 +168,6 @@
 #define IOREMAP_MAX_ORDER	(PMD_SHIFT)
 #endif
 
-#ifdef CONFIG_BLK_DEV_INITRD
-#define __early_init_dt_declare_initrd(__start, __end)			\
-	do {								\
-		initrd_start = (__start);				\
-		initrd_end = (__end);					\
-	} while (0)
-#endif
-
 #ifndef __ASSEMBLY__
 
 #include <linux/bitops.h>
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 800ad252cf9c..4e4711af907b 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -28,6 +28,7 @@
 
 #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
 #include <asm/page.h>
+#include <asm/initrd.h>
 
 #include "of_private.h"
 
-- 
2.17.1
