From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Fri, 14 Jul 2017 13:41:12 +0000
Subject: [CRIU][PATCH 1/3] s390: Replace flogr instruction with __builtin_clzl()
Message-Id: <20170714134114.36870-2-holzheu@linux.vnet.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The flogr instruction not supported by debian jessie (z900).
So replace it by the gcc built-in.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 include/common/arch/s390/asm/bitops.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/common/arch/s390/asm/bitops.h b/include/common/arch/s390/asm/bitops.h
index 13d8323..648d898 100644
--- a/include/common/arch/s390/asm/bitops.h
+++ b/include/common/arch/s390/asm/bitops.h
@@ -107,13 +107,7 @@ static inline unsigned char __flogr(unsigned long word)
 		}
 		return bit;
 	} else {
-		register unsigned long bit asm("4") = word;
-		register unsigned long out asm("5");
-
-		asm volatile(
-			"       flogr   %[bit],%[bit]\n"
-			: [bit] "+d" (bit), [out] "=d" (out) : : "cc");
-		return bit;
+		return __builtin_clzl(word);
 	}
 }
 
-- 
2.7.4
