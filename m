Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36388 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfHSG2Z (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 19 Aug 2019 02:28:25 -0400
Received: by mail-pg1-f195.google.com with SMTP id l21so590564pgm.3
        for <linux-s390@vger.kernel.org>; Sun, 18 Aug 2019 23:28:25 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
Subject: [PATCH 2/2] powerpc: support KASAN instrumentation of bitops
Date: Mon, 19 Aug 2019 16:28:14 +1000
Message-Id: <20190819062814.5315-2-dja@axtens.net>
In-Reply-To: <20190819062814.5315-1-dja@axtens.net>
References: <20190819062814.5315-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: christophe.leroy@c-s.fr, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: kasan-dev@googlegroups.com, Daniel Axtens <dja@axtens.net>, Nicholas Piggin <npiggin@gmail.com>

In KASAN development I noticed that the powerpc-specific bitops
were not being picked up by the KASAN test suite.

Instrumentation is done via the bitops/instrumented-{atomic,lock}.h
headers. They require that arch-specific versions of bitop functions
are renamed to arch_*. Do this renaming.

For clear_bit_unlock_is_negative_byte, the current implementation
uses the PG_waiters constant. This works because it's a preprocessor
macro - so it's only actually evaluated in contexts where PG_waiters
is defined. With instrumentation however, it becomes a static inline
function, and all of a sudden we need the actual value of PG_waiters.
Because of the order of header includes, it's not available and we
fail to compile. Instead, manually specify that we care about bit 7.
This is still correct: bit 7 is the bit that would mark a negative
byte.

Cc: Nicholas Piggin <npiggin@gmail.com> # clear_bit_unlock_negative_byte
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/include/asm/bitops.h | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/asm/bitops.h
index 603aed229af7..8615b2bc35fe 100644
--- a/arch/powerpc/include/asm/bitops.h
+++ b/arch/powerpc/include/asm/bitops.h
@@ -86,22 +86,22 @@ DEFINE_BITOP(clear_bits, andc, "")
 DEFINE_BITOP(clear_bits_unlock, andc, PPC_RELEASE_BARRIER)
 DEFINE_BITOP(change_bits, xor, "")
 
-static __inline__ void set_bit(int nr, volatile unsigned long *addr)
+static __inline__ void arch_set_bit(int nr, volatile unsigned long *addr)
 {
 	set_bits(BIT_MASK(nr), addr + BIT_WORD(nr));
 }
 
-static __inline__ void clear_bit(int nr, volatile unsigned long *addr)
+static __inline__ void arch_clear_bit(int nr, volatile unsigned long *addr)
 {
 	clear_bits(BIT_MASK(nr), addr + BIT_WORD(nr));
 }
 
-static __inline__ void clear_bit_unlock(int nr, volatile unsigned long *addr)
+static __inline__ void arch_clear_bit_unlock(int nr, volatile unsigned long *addr)
 {
 	clear_bits_unlock(BIT_MASK(nr), addr + BIT_WORD(nr));
 }
 
-static __inline__ void change_bit(int nr, volatile unsigned long *addr)
+static __inline__ void arch_change_bit(int nr, volatile unsigned long *addr)
 {
 	change_bits(BIT_MASK(nr), addr + BIT_WORD(nr));
 }
@@ -138,26 +138,26 @@ DEFINE_TESTOP(test_and_clear_bits, andc, PPC_ATOMIC_ENTRY_BARRIER,
 DEFINE_TESTOP(test_and_change_bits, xor, PPC_ATOMIC_ENTRY_BARRIER,
 	      PPC_ATOMIC_EXIT_BARRIER, 0)
 
-static __inline__ int test_and_set_bit(unsigned long nr,
+static __inline__ int arch_test_and_set_bit(unsigned long nr,
 				       volatile unsigned long *addr)
 {
 	return test_and_set_bits(BIT_MASK(nr), addr + BIT_WORD(nr)) != 0;
 }
 
-static __inline__ int test_and_set_bit_lock(unsigned long nr,
+static __inline__ int arch_test_and_set_bit_lock(unsigned long nr,
 				       volatile unsigned long *addr)
 {
 	return test_and_set_bits_lock(BIT_MASK(nr),
 				addr + BIT_WORD(nr)) != 0;
 }
 
-static __inline__ int test_and_clear_bit(unsigned long nr,
+static __inline__ int arch_test_and_clear_bit(unsigned long nr,
 					 volatile unsigned long *addr)
 {
 	return test_and_clear_bits(BIT_MASK(nr), addr + BIT_WORD(nr)) != 0;
 }
 
-static __inline__ int test_and_change_bit(unsigned long nr,
+static __inline__ int arch_test_and_change_bit(unsigned long nr,
 					  volatile unsigned long *addr)
 {
 	return test_and_change_bits(BIT_MASK(nr), addr + BIT_WORD(nr)) != 0;
@@ -185,15 +185,18 @@ static __inline__ unsigned long clear_bit_unlock_return_word(int nr,
 	return old;
 }
 
-/* This is a special function for mm/filemap.c */
-#define clear_bit_unlock_is_negative_byte(nr, addr)			\
-	(clear_bit_unlock_return_word(nr, addr) & BIT_MASK(PG_waiters))
+/*
+ * This is a special function for mm/filemap.c
+ * Bit 7 corresponds to PG_waiters.
+ */
+#define arch_clear_bit_unlock_is_negative_byte(nr, addr)		\
+	(clear_bit_unlock_return_word(nr, addr) & BIT_MASK(7))
 
 #endif /* CONFIG_PPC64 */
 
 #include <asm-generic/bitops/non-atomic.h>
 
-static __inline__ void __clear_bit_unlock(int nr, volatile unsigned long *addr)
+static __inline__ void arch___clear_bit_unlock(int nr, volatile unsigned long *addr)
 {
 	__asm__ __volatile__(PPC_RELEASE_BARRIER "" ::: "memory");
 	__clear_bit(nr, addr);
@@ -239,6 +242,10 @@ unsigned long __arch_hweight64(__u64 w);
 
 #include <asm-generic/bitops/find.h>
 
+/* wrappers that deal with KASAN instrumentation */
+#include <asm-generic/bitops/instrumented-atomic.h>
+#include <asm-generic/bitops/instrumented-lock.h>
+
 /* Little-endian versions */
 #include <asm-generic/bitops/le.h>
 
-- 
2.20.1
