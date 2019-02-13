Return-Path: <linux-kbuild-owner@vger.kernel.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 01/11] powerpc: remove dead ifdefs in <asm/checksum.h>
Date: Wed, 13 Feb 2019 18:39:55 +0100
Message-Id: <20190213174005.28785-2-hch@lst.de>
In-Reply-To: <20190213174005.28785-1-hch@lst.de>
References: <20190213174005.28785-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

__KERNEL__ is never not defined for non-uapi headers, and GENERIC_CSUM
isn't ever set for powerpc either.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/include/asm/checksum.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/checksum.h b/arch/powerpc/include/asm/checksum.h
index a78a57e5058d..37c309500260 100644
--- a/arch/powerpc/include/asm/checksum.h
+++ b/arch/powerpc/include/asm/checksum.h
@@ -1,6 +1,5 @@
 #ifndef _ASM_POWERPC_CHECKSUM_H
 #define _ASM_POWERPC_CHECKSUM_H
-#ifdef __KERNEL__
 
 /*
  * This program is free software; you can redistribute it and/or
@@ -9,9 +8,6 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-#ifdef CONFIG_GENERIC_CSUM
-#include <asm-generic/checksum.h>
-#else
 #include <linux/bitops.h>
 #include <linux/in6.h>
 /*
@@ -217,6 +213,4 @@ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 			const struct in6_addr *daddr,
 			__u32 len, __u8 proto, __wsum sum);
 
-#endif
-#endif /* __KERNEL__ */
-#endif
+#endif /* _ASM_POWERPC_CHECKSUM_H */
-- 
2.20.1
