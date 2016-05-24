From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH 11/23] arm64:uapi: set __BITS_PER_LONG correctly for ILP32 and LP64
Date: Tue, 24 May 2016 03:04:40 +0300
Message-ID: <1464048292-30136-12-git-send-email-ynorov@caviumnetworks.com>
References: <1464048292-30136-1-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464048292-30136-1-git-send-email-ynorov@caviumnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, libc-alpha@sourceware.org
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, ynorov@caviumnetworks.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com, Andrew Pinski <apinski@cavium.com>
List-ID: <linux-s390.vger.kernel.org>

From: Andrew Pinski <apinski@cavium.com>

Define __BITS_PER_LONG depending on the ABI used (i.e. check whether
__ILP32__ or __LP64__ is defined).  This is necessary for glibc to
determine the appropriate type definitions for the system call interface.

Signed-off-by: Andrew Pinski <apinski@cavium.com>
Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Reviewed-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/arm64/include/uapi/asm/bitsperlong.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/uapi/asm/bitsperlong.h b/arch/arm64/include/uapi/asm/bitsperlong.h
index fce9c29..4265243 100644
--- a/arch/arm64/include/uapi/asm/bitsperlong.h
+++ b/arch/arm64/include/uapi/asm/bitsperlong.h
@@ -16,7 +16,14 @@
 #ifndef __ASM_BITSPERLONG_H
 #define __ASM_BITSPERLONG_H
 
-#define __BITS_PER_LONG 64
+#if defined(__LP64__)
+/* Assuming __LP64__ will be defined for native ELF64's and not for ILP32. */
+#  define __BITS_PER_LONG 64
+#elif defined(__ILP32__)
+#  define __BITS_PER_LONG 32
+#else
+#  error "Neither LP64 nor ILP32: unsupported ABI in asm/bitsperlong.h"
+#endif
 
 #include <asm-generic/bitsperlong.h>
 
-- 
2.5.0
