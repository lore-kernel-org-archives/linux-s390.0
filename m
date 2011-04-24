From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH 5/6] s390: use asm-generic/bitops/le.h
Date: Sun, 24 Apr 2011 18:51:16 +0900
Message-ID: <1303638677-11211-6-git-send-email-akinobu.mita@gmail.com>
References: <1303638677-11211-1-git-send-email-akinobu.mita@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1303638677-11211-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, arnd@arndb.de
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The previous style change enables to use asm-generic/bitops/le.h
on s390.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux390@de.ibm.com
Cc: linux-s390@vger.kernel.org
---
 arch/s390/include/asm/bitops.h |   37 ++-----------------------------------
 1 files changed, 2 insertions(+), 35 deletions(-)

diff --git a/arch/s390/include/asm/bitops.h b/arch/s390/include/asm/bitops.h
index fc298b2..deb1c56 100644
--- a/arch/s390/include/asm/bitops.h
+++ b/arch/s390/include/asm/bitops.h
@@ -746,41 +746,6 @@ static inline int sched_find_first_bit(unsigned long *b)
  *    23 22 21 20 19 18 17 16 31 30 29 28 27 26 25 24
  */
 
-static inline void __set_bit_le(unsigned long nr, void *addr)
-{
-	__set_bit(nr ^ (__BITOPS_WORDSIZE - 8), addr);
-}
-
-static inline void __clear_bit_le(unsigned long nr, void *addr)
-{
-	__clear_bit(nr ^ (__BITOPS_WORDSIZE - 8), addr);
-}
-
-static inline int __test_and_set_bit_le(unsigned long nr, void *addr)
-{
-	return __test_and_set_bit(nr ^ (__BITOPS_WORDSIZE - 8), addr);
-}
-
-static inline int test_and_set_bit_le(unsigned long nr, void *addr)
-{
-	return test_and_set_bit(nr ^ (__BITOPS_WORDSIZE - 8), addr);
-}
-
-static inline int __test_and_clear_bit_le(unsigned long nr, void *addr)
-{
-	return __test_and_clear_bit(nr ^ (__BITOPS_WORDSIZE - 8), addr);
-}
-
-static inline int test_and_clear_bit_le(unsigned long nr, void *addr)
-{
-	return test_and_clear_bit(nr ^ (__BITOPS_WORDSIZE - 8), addr);
-}
-
-static inline int test_bit_le(unsigned long nr, const void *addr)
-{
-	return test_bit(nr ^ (__BITOPS_WORDSIZE - 8), addr);
-}
-
 static inline int find_first_zero_bit_le(void *vaddr, unsigned int size)
 {
 	unsigned long bytes, bits;
@@ -865,6 +830,8 @@ static inline int find_next_bit_le(void *vaddr, unsigned long size,
 }
 #define find_next_bit_le find_next_bit_le
 
+#include <asm-generic/bitops/le.h>
+
 #include <asm-generic/bitops/ext2-atomic-test.h>
 
 #endif /* __KERNEL__ */
-- 
1.7.4.4
