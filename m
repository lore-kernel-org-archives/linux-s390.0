Return-Path: <linux-kernel-owner+w=401wt.eu-S1757858AbYBEPlg@vger.kernel.org>
Message-Id: <20080205153914.219379693@de.ibm.com>
References: <20080205153835.337897404@de.ibm.com>
Date: Tue, 05 Feb 2008 16:38:47 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 12/18] Implement ext2_find_next_bit.
Content-Disposition: inline; filename=012-ext2-bitops.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Fixes this compile error:

fs/ext4/mballoc.c:
	In function 'ext4_mb_generate_buddy':
fs/ext4/mballoc.c:954:
	error: implicit declaration of function 'generic_find_next_le_bit'

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/asm-s390/bitops.h |   43 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

Index: quilt-2.6/include/asm-s390/bitops.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/bitops.h
+++ quilt-2.6/include/asm-s390/bitops.h
@@ -790,8 +790,6 @@ static inline int sched_find_first_bit(u
 	test_and_clear_bit((nr)^(__BITOPS_WORDSIZE - 8), (unsigned long *)addr)
 #define ext2_test_bit(nr, addr)      \
 	test_bit((nr)^(__BITOPS_WORDSIZE - 8), (unsigned long *)addr)
-#define ext2_find_next_bit(addr, size, off) \
-	generic_find_next_le_bit((unsigned long *)(addr), (size), (off))
 
 static inline int ext2_find_first_zero_bit(void *vaddr, unsigned int size)
 {
@@ -833,6 +831,47 @@ static inline int ext2_find_next_zero_bi
 	return offset + ext2_find_first_zero_bit(p, size);
 }
 
+static inline unsigned long ext2_find_first_bit(void *vaddr,
+						unsigned long size)
+{
+	unsigned long bytes, bits;
+
+	if (!size)
+		return 0;
+	bytes = __ffs_word_loop(vaddr, size);
+	bits = __ffs_word(bytes*8, __load_ulong_le(vaddr, bytes));
+	return (bits < size) ? bits : size;
+}
+
+static inline int ext2_find_next_bit(void *vaddr, unsigned long size,
+				     unsigned long offset)
+{
+	unsigned long *addr = vaddr, *p;
+	unsigned long bit, set;
+
+	if (offset >= size)
+		return size;
+	bit = offset & (__BITOPS_WORDSIZE - 1);
+	offset -= bit;
+	size -= offset;
+	p = addr + offset / __BITOPS_WORDSIZE;
+	if (bit) {
+		/*
+		 * s390 version of ffz returns __BITOPS_WORDSIZE
+		 * if no zero bit is present in the word.
+		 */
+		set = ffs(__load_ulong_le(p, 0) >> bit) + bit;
+		if (set >= size)
+			return size + offset;
+		if (set < __BITOPS_WORDSIZE)
+			return set + offset;
+		offset += __BITOPS_WORDSIZE;
+		size -= __BITOPS_WORDSIZE;
+		p++;
+	}
+	return offset + ext2_find_first_bit(p, size);
+}
+
 #include <asm-generic/bitops/minix.h>
 
 #endif /* __KERNEL__ */

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
