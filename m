Return-Path: <linux-kernel-owner+w=401wt.eu-S1758030AbYBEPlv@vger.kernel.org>
Message-Id: <20080205153913.848349672@de.ibm.com>
References: <20080205153835.337897404@de.ibm.com>
Date: Tue, 05 Feb 2008 16:38:46 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 11/18] Cleanup & optimize bitops.
Content-Disposition: inline; filename=011-cleanup-bitops.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

The bitops header is now a bit shorter and easier to understand since
it uses less inline assembly. It requires some tricks to persuade the
compiler to generate decent code. The ffz/ffs functions now use the
_zb_findmap/_sb_findmap table as well.
With this cleanup the new bitops for ext4 can be implemented with a
few lines, instead of another large inline assembly.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/asm-s390/bitops.h |  515 +++++++++++++++++++---------------------------
 1 file changed, 219 insertions(+), 296 deletions(-)

Index: quilt-2.6/include/asm-s390/bitops.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/bitops.h
+++ quilt-2.6/include/asm-s390/bitops.h
@@ -440,242 +440,256 @@ __constant_test_bit(unsigned long nr, co
  __test_bit((nr),(addr)) )
 
 /*
- * ffz = Find First Zero in word. Undefined if no zero exists,
- * so code should check against ~0UL first..
+ * Optimized find bit helper functions.
  */
-static inline unsigned long ffz(unsigned long word)
+
+/**
+ * __ffz_word_loop - find byte offset of first long != -1UL
+ * @addr: pointer to array of unsigned long
+ * @size: size of the array in bits
+ */
+static inline unsigned long __ffz_word_loop(const unsigned long *addr,
+					    unsigned long size)
+{
+	typedef struct { long _[__BITOPS_WORDS(size)]; } addrtype;
+	unsigned long bytes = 0;
+
+	asm volatile(
+#ifndef __s390x__
+		"	ahi	%1,31\n"
+		"	srl	%1,5\n"
+		"0:	c	%2,0(%0,%3)\n"
+		"	jne	1f\n"
+		"	la	%0,4(%0)\n"
+		"	brct	%1,0b\n"
+		"1:\n"
+#else
+		"	aghi	%1,63\n"
+		"	srlg	%1,%1,6\n"
+		"0:	cg	%2,0(%0,%3)\n"
+		"	jne	1f\n"
+		"	la	%0,8(%0)\n"
+		"	brct	%1,0b\n"
+		"1:\n"
+#endif
+		: "+a" (bytes), "+d" (size)
+		: "d" (-1UL), "a" (addr), "m" (*(addrtype *) addr)
+		: "cc" );
+	return bytes;
+}
+
+/**
+ * __ffs_word_loop - find byte offset of first long != 0UL
+ * @addr: pointer to array of unsigned long
+ * @size: size of the array in bits
+ */
+static inline unsigned long __ffs_word_loop(const unsigned long *addr,
+					    unsigned long size)
 {
-        unsigned long bit = 0;
+	typedef struct { long _[__BITOPS_WORDS(size)]; } addrtype;
+	unsigned long bytes = 0;
+
+	asm volatile(
+#ifndef __s390x__
+		"	ahi	%1,31\n"
+		"	srl	%1,5\n"
+		"0:	c	%2,0(%0,%3)\n"
+		"	jne	1f\n"
+		"	la	%0,4(%0)\n"
+		"	brct	%1,0b\n"
+		"1:\n"
+#else
+		"	aghi	%1,63\n"
+		"	srlg	%1,%1,6\n"
+		"0:	cg	%2,0(%0,%3)\n"
+		"	jne	1f\n"
+		"	la	%0,8(%0)\n"
+		"	brct	%1,0b\n"
+		"1:\n"
+#endif
+		: "+a" (bytes), "+a" (size)
+		: "d" (0UL), "a" (addr), "m" (*(addrtype *) addr)
+		: "cc" );
+	return bytes;
+}
 
+/**
+ * __ffz_word - add number of the first unset bit
+ * @nr: base value the bit number is added to
+ * @word: the word that is searched for unset bits
+ */
+static inline unsigned long __ffz_word(unsigned long nr, unsigned long word)
+{
 #ifdef __s390x__
 	if (likely((word & 0xffffffff) == 0xffffffff)) {
 		word >>= 32;
-		bit += 32;
+		nr += 32;
 	}
 #endif
 	if (likely((word & 0xffff) == 0xffff)) {
 		word >>= 16;
-		bit += 16;
+		nr += 16;
 	}
 	if (likely((word & 0xff) == 0xff)) {
 		word >>= 8;
-		bit += 8;
+		nr += 8;
 	}
-	return bit + _zb_findmap[word & 0xff];
+	return nr + _zb_findmap[(unsigned char) word];
 }
 
-/*
- * __ffs = find first bit in word. Undefined if no bit exists,
- * so code should check against 0UL first..
+/**
+ * __ffs_word - add number of the first set bit
+ * @nr: base value the bit number is added to
+ * @word: the word that is searched for set bits
  */
-static inline unsigned long __ffs (unsigned long word)
+static inline unsigned long __ffs_word(unsigned long nr, unsigned long word)
 {
-	unsigned long bit = 0;
-
 #ifdef __s390x__
 	if (likely((word & 0xffffffff) == 0)) {
 		word >>= 32;
-		bit += 32;
+		nr += 32;
 	}
 #endif
 	if (likely((word & 0xffff) == 0)) {
 		word >>= 16;
-		bit += 16;
+		nr += 16;
 	}
 	if (likely((word & 0xff) == 0)) {
 		word >>= 8;
-		bit += 8;
+		nr += 8;
 	}
-	return bit + _sb_findmap[word & 0xff];
+	return nr + _sb_findmap[(unsigned char) word];
 }
 
-/*
- * Find-bit routines..
- */
 
-#ifndef __s390x__
+/**
+ * __load_ulong_be - load big endian unsigned long
+ * @p: pointer to array of unsigned long
+ * @offset: byte offset of source value in the array
+ */
+static inline unsigned long __load_ulong_be(const unsigned long *p,
+					    unsigned long offset)
+{
+	p = (unsigned long *)((unsigned long) p + offset);
+	return *p;
+}
 
-static inline int
-find_first_zero_bit(const unsigned long * addr, unsigned long size)
+/**
+ * __load_ulong_le - load little endian unsigned long
+ * @p: pointer to array of unsigned long
+ * @offset: byte offset of source value in the array
+ */
+static inline unsigned long __load_ulong_le(const unsigned long *p,
+					    unsigned long offset)
 {
-	typedef struct { long _[__BITOPS_WORDS(size)]; } addrtype;
-	unsigned long cmp, count;
-        unsigned int res;
+	unsigned long word;
 
-        if (!size)
-                return 0;
+	p = (unsigned long *)((unsigned long) p + offset);
+#ifndef __s390x__
 	asm volatile(
-		"	lhi	%1,-1\n"
-		"	lr	%2,%3\n"
-		"	slr	%0,%0\n"
-		"	ahi	%2,31\n"
-		"	srl	%2,5\n"
-		"0:	c	%1,0(%0,%4)\n"
-		"	jne	1f\n"
-		"	la	%0,4(%0)\n"
-		"	brct	%2,0b\n"
-		"	lr	%0,%3\n"
-		"	j	4f\n"
-		"1:	l	%2,0(%0,%4)\n"
-		"	sll	%0,3\n"
-		"	lhi	%1,0xff\n"
-		"	tml	%2,0xffff\n"
-		"	jno	2f\n"
-		"	ahi	%0,16\n"
-		"	srl	%2,16\n"
-		"2:	tml	%2,0x00ff\n"
-		"	jno	3f\n"
-		"	ahi	%0,8\n"
-		"	srl	%2,8\n"
-		"3:	nr	%2,%1\n"
-		"	ic	%2,0(%2,%5)\n"
-		"	alr	%0,%2\n"
-		"4:"
-		: "=&a" (res), "=&d" (cmp), "=&a" (count)
-		: "a" (size), "a" (addr), "a" (&_zb_findmap),
-		  "m" (*(addrtype *) addr) : "cc");
-        return (res < size) ? res : size;
+		"	ic	%0,0(%1)\n"
+		"	icm	%0,2,1(%1)\n"
+		"	icm	%0,4,2(%1)\n"
+		"	icm	%0,8,3(%1)"
+		: "=&d" (word) : "a" (p), "m" (*p) : "cc");
+#else
+	asm volatile(
+		"	lrvg	%0,%1"
+		: "=d" (word) : "m" (*p) );
+#endif
+	return word;
 }
 
-static inline int
-find_first_bit(const unsigned long * addr, unsigned long size)
+/*
+ * The various find bit functions.
+ */
+
+/*
+ * ffz - find first zero in word.
+ * @word: The word to search
+ *
+ * Undefined if no zero exists, so code should check against ~0UL first.
+ */
+static inline unsigned long ffz(unsigned long word)
 {
-	typedef struct { long _[__BITOPS_WORDS(size)]; } addrtype;
-	unsigned long cmp, count;
-        unsigned int res;
+	return __ffz_word(0, word);
+}
 
-        if (!size)
-                return 0;
-	asm volatile(
-		"	slr	%1,%1\n"
-		"	lr	%2,%3\n"
-		"	slr	%0,%0\n"
-		"	ahi	%2,31\n"
-		"	srl	%2,5\n"
-		"0:	c	%1,0(%0,%4)\n"
-		"	jne	1f\n"
-		"	la	%0,4(%0)\n"
-		"	brct	%2,0b\n"
-		"	lr	%0,%3\n"
-		"	j	4f\n"
-		"1:	l	%2,0(%0,%4)\n"
-		"	sll	%0,3\n"
-		"	lhi	%1,0xff\n"
-		"	tml	%2,0xffff\n"
-		"	jnz	2f\n"
-		"	ahi	%0,16\n"
-		"	srl	%2,16\n"
-		"2:	tml	%2,0x00ff\n"
-		"	jnz	3f\n"
-		"	ahi	%0,8\n"
-		"	srl	%2,8\n"
-		"3:	nr	%2,%1\n"
-		"	ic	%2,0(%2,%5)\n"
-		"	alr	%0,%2\n"
-		"4:"
-		: "=&a" (res), "=&d" (cmp), "=&a" (count)
-		: "a" (size), "a" (addr), "a" (&_sb_findmap),
-		  "m" (*(addrtype *) addr) : "cc");
-        return (res < size) ? res : size;
+/**
+ * __ffs - find first bit in word.
+ * @word: The word to search
+ *
+ * Undefined if no bit exists, so code should check against 0 first.
+ */
+static inline unsigned long __ffs (unsigned long word)
+{
+	return __ffs_word(0, word);
 }
 
-#else /* __s390x__ */
+/**
+ * ffs - find first bit set
+ * @x: the word to search
+ *
+ * This is defined the same way as
+ * the libc and compiler builtin ffs routines, therefore
+ * differs in spirit from the above ffz (man ffs).
+ */
+static inline int ffs(int x)
+{
+	if (!x)
+		return 0;
+	return __ffs_word(1, x);
+}
 
-static inline unsigned long
-find_first_zero_bit(const unsigned long * addr, unsigned long size)
+/**
+ * find_first_zero_bit - find the first zero bit in a memory region
+ * @addr: The address to start the search at
+ * @size: The maximum size to search
+ *
+ * Returns the bit-number of the first zero bit, not the number of the byte
+ * containing a bit.
+ */
+static inline unsigned long find_first_zero_bit(const unsigned long *addr,
+						unsigned long size)
 {
-	typedef struct { long _[__BITOPS_WORDS(size)]; } addrtype;
-        unsigned long res, cmp, count;
+	unsigned long bytes, bits;
 
         if (!size)
                 return 0;
-	asm volatile(
-		"	lghi	%1,-1\n"
-		"	lgr	%2,%3\n"
-		"	slgr	%0,%0\n"
-		"	aghi	%2,63\n"
-		"	srlg	%2,%2,6\n"
-		"0:	cg	%1,0(%0,%4)\n"
-		"	jne	1f\n"
-		"	la	%0,8(%0)\n"
-		"	brct	%2,0b\n"
-		"	lgr	%0,%3\n"
-		"	j	5f\n"
-		"1:	lg	%2,0(%0,%4)\n"
-		"	sllg	%0,%0,3\n"
-		"	clr	%2,%1\n"
-		"	jne	2f\n"
-		"	aghi	%0,32\n"
-		"	srlg	%2,%2,32\n"
-		"2:	lghi	%1,0xff\n"
-		"	tmll	%2,0xffff\n"
-		"	jno	3f\n"
-		"	aghi	%0,16\n"
-		"	srl	%2,16\n"
-		"3:	tmll	%2,0x00ff\n"
-		"	jno	4f\n"
-		"	aghi	%0,8\n"
-		"	srl	%2,8\n"
-		"4:	ngr	%2,%1\n"
-		"	ic	%2,0(%2,%5)\n"
-		"	algr	%0,%2\n"
-		"5:"
-		: "=&a" (res), "=&d" (cmp), "=&a" (count)
-		: "a" (size), "a" (addr), "a" (&_zb_findmap),
-		  "m" (*(addrtype *) addr) : "cc");
-        return (res < size) ? res : size;
+	bytes = __ffz_word_loop(addr, size);
+	bits = __ffz_word(bytes*8, __load_ulong_be(addr, bytes));
+	return (bits < size) ? bits : size;
 }
 
-static inline unsigned long
-find_first_bit(const unsigned long * addr, unsigned long size)
+/**
+ * find_first_bit - find the first set bit in a memory region
+ * @addr: The address to start the search at
+ * @size: The maximum size to search
+ *
+ * Returns the bit-number of the first set bit, not the number of the byte
+ * containing a bit.
+ */
+static inline unsigned long find_first_bit(const unsigned long * addr,
+					   unsigned long size)
 {
-	typedef struct { long _[__BITOPS_WORDS(size)]; } addrtype;
-        unsigned long res, cmp, count;
+	unsigned long bytes, bits;
 
         if (!size)
                 return 0;
-	asm volatile(
-		"	slgr	%1,%1\n"
-		"	lgr	%2,%3\n"
-		"	slgr	%0,%0\n"
-		"	aghi	%2,63\n"
-		"	srlg	%2,%2,6\n"
-		"0:	cg	%1,0(%0,%4)\n"
-		"	jne	1f\n"
-		"	aghi	%0,8\n"
-		"	brct	%2,0b\n"
-		"	lgr	%0,%3\n"
-		"	j	5f\n"
-		"1:	lg	%2,0(%0,%4)\n"
-		"	sllg	%0,%0,3\n"
-		"	clr	%2,%1\n"
-		"	jne	2f\n"
-		"	aghi	%0,32\n"
-		"	srlg	%2,%2,32\n"
-		"2:	lghi	%1,0xff\n"
-		"	tmll	%2,0xffff\n"
-		"	jnz	3f\n"
-		"	aghi	%0,16\n"
-		"	srl	%2,16\n"
-		"3:	tmll	%2,0x00ff\n"
-		"	jnz	4f\n"
-		"	aghi	%0,8\n"
-		"	srl	%2,8\n"
-		"4:	ngr	%2,%1\n"
-		"	ic	%2,0(%2,%5)\n"
-		"	algr	%0,%2\n"
-		"5:"
-		: "=&a" (res), "=&d" (cmp), "=&a" (count)
-		: "a" (size), "a" (addr), "a" (&_sb_findmap),
-		  "m" (*(addrtype *) addr) : "cc");
-        return (res < size) ? res : size;
-}
-
-#endif /* __s390x__ */
-
-static inline int
-find_next_zero_bit (const unsigned long * addr, unsigned long size,
-		    unsigned long offset)
+	bytes = __ffs_word_loop(addr, size);
+	bits = __ffs_word(bytes*8, __load_ulong_be(addr, bytes));
+	return (bits < size) ? bits : size;
+}
+
+/**
+ * find_next_zero_bit - find the first zero bit in a memory region
+ * @addr: The address to base the search on
+ * @offset: The bitnumber to start searching at
+ * @size: The maximum size to search
+ */
+static inline int find_next_zero_bit (const unsigned long * addr,
+				      unsigned long size,
+				      unsigned long offset)
 {
         const unsigned long *p;
 	unsigned long bit, set;
@@ -688,10 +702,10 @@ find_next_zero_bit (const unsigned long 
 	p = addr + offset / __BITOPS_WORDSIZE;
 	if (bit) {
 		/*
-		 * s390 version of ffz returns __BITOPS_WORDSIZE
+		 * __ffz_word returns __BITOPS_WORDSIZE
 		 * if no zero bit is present in the word.
 		 */
-		set = ffz(*p >> bit) + bit;
+		set = __ffz_word(0, *p >> bit) + bit;
 		if (set >= size)
 			return size + offset;
 		if (set < __BITOPS_WORDSIZE)
@@ -703,9 +717,15 @@ find_next_zero_bit (const unsigned long 
 	return offset + find_first_zero_bit(p, size);
 }
 
-static inline int
-find_next_bit (const unsigned long * addr, unsigned long size,
-	       unsigned long offset)
+/**
+ * find_next_bit - find the first set bit in a memory region
+ * @addr: The address to base the search on
+ * @offset: The bitnumber to start searching at
+ * @size: The maximum size to search
+ */
+static inline int find_next_bit (const unsigned long * addr,
+				 unsigned long size,
+				 unsigned long offset)
 {
         const unsigned long *p;
 	unsigned long bit, set;
@@ -718,10 +738,10 @@ find_next_bit (const unsigned long * add
 	p = addr + offset / __BITOPS_WORDSIZE;
 	if (bit) {
 		/*
-		 * s390 version of __ffs returns __BITOPS_WORDSIZE
+		 * __ffs_word returns __BITOPS_WORDSIZE
 		 * if no one bit is present in the word.
 		 */
-		set = __ffs(*p & (~0UL << bit));
+		set = __ffs_word(0, *p & (~0UL << bit));
 		if (set >= size)
 			return size + offset;
 		if (set < __BITOPS_WORDSIZE)
@@ -744,8 +764,6 @@ static inline int sched_find_first_bit(u
 	return find_first_bit(b, 140);
 }
 
-#include <asm-generic/bitops/ffs.h>
-
 #include <asm-generic/bitops/fls.h>
 #include <asm-generic/bitops/fls64.h>
 
@@ -775,105 +793,22 @@ static inline int sched_find_first_bit(u
 #define ext2_find_next_bit(addr, size, off) \
 	generic_find_next_le_bit((unsigned long *)(addr), (size), (off))
 
-#ifndef __s390x__
-
-static inline int 
-ext2_find_first_zero_bit(void *vaddr, unsigned int size)
+static inline int ext2_find_first_zero_bit(void *vaddr, unsigned int size)
 {
-	typedef struct { long _[__BITOPS_WORDS(size)]; } addrtype;
-	unsigned long cmp, count;
-        unsigned int res;
+	unsigned long bytes, bits;
 
         if (!size)
                 return 0;
-	asm volatile(
-		"	lhi	%1,-1\n"
-		"	lr	%2,%3\n"
-		"	ahi	%2,31\n"
-		"	srl	%2,5\n"
-		"	slr	%0,%0\n"
-		"0:	cl	%1,0(%0,%4)\n"
-		"	jne	1f\n"
-		"	ahi	%0,4\n"
-		"	brct	%2,0b\n"
-		"	lr	%0,%3\n"
-		"	j	4f\n"
-		"1:	l	%2,0(%0,%4)\n"
-		"	sll	%0,3\n"
-		"	ahi	%0,24\n"
-		"	lhi	%1,0xff\n"
-		"	tmh	%2,0xffff\n"
-		"	jo	2f\n"
-		"	ahi	%0,-16\n"
-		"	srl	%2,16\n"
-		"2:	tml	%2,0xff00\n"
-		"	jo	3f\n"
-		"	ahi	%0,-8\n"
-		"	srl	%2,8\n"
-		"3:	nr	%2,%1\n"
-		"	ic	%2,0(%2,%5)\n"
-		"	alr	%0,%2\n"
-		"4:"
-		: "=&a" (res), "=&d" (cmp), "=&a" (count)
-		: "a" (size), "a" (vaddr), "a" (&_zb_findmap),
-		  "m" (*(addrtype *) vaddr) : "cc");
-        return (res < size) ? res : size;
+	bytes = __ffz_word_loop(vaddr, size);
+	bits = __ffz_word(bytes*8, __load_ulong_le(vaddr, bytes));
+	return (bits < size) ? bits : size;
 }
 
-#else /* __s390x__ */
-
-static inline unsigned long
-ext2_find_first_zero_bit(void *vaddr, unsigned long size)
-{
-	typedef struct { long _[__BITOPS_WORDS(size)]; } addrtype;
-        unsigned long res, cmp, count;
-
-        if (!size)
-                return 0;
-	asm volatile(
-		"	lghi	%1,-1\n"
-		"	lgr	%2,%3\n"
-		"	aghi	%2,63\n"
-		"	srlg	%2,%2,6\n"
-		"	slgr	%0,%0\n"
-		"0:	clg	%1,0(%0,%4)\n"
-		"	jne	1f\n"
-		"	aghi	%0,8\n"
-		"	brct	%2,0b\n"
-		"	lgr	%0,%3\n"
-		"	j	5f\n"
-		"1:	cl	%1,0(%0,%4)\n"
-		"	jne	2f\n"
-		"	aghi	%0,4\n"
-		"2:	l	%2,0(%0,%4)\n"
-		"	sllg	%0,%0,3\n"
-		"	aghi	%0,24\n"
-		"	lghi	%1,0xff\n"
-		"	tmlh	%2,0xffff\n"
-		"	jo	3f\n"
-		"	aghi	%0,-16\n"
-		"	srl	%2,16\n"
-		"3:	tmll	%2,0xff00\n"
-		"	jo	4f\n"
-		"	aghi	%0,-8\n"
-		"	srl	%2,8\n"
-		"4:	ngr	%2,%1\n"
-		"	ic	%2,0(%2,%5)\n"
-		"	algr	%0,%2\n"
-		"5:"
-		: "=&a" (res), "=&d" (cmp), "=&a" (count)
-		: "a" (size), "a" (vaddr), "a" (&_zb_findmap),
-		  "m" (*(addrtype *) vaddr) : "cc");
-        return (res < size) ? res : size;
-}
-
-#endif /* __s390x__ */
-
-static inline int
-ext2_find_next_zero_bit(void *vaddr, unsigned long size, unsigned long offset)
+static inline int ext2_find_next_zero_bit(void *vaddr, unsigned long size,
+					  unsigned long offset)
 {
         unsigned long *addr = vaddr, *p;
-	unsigned long word, bit, set;
+	unsigned long bit, set;
 
         if (offset >= size)
                 return size;
@@ -882,23 +817,11 @@ ext2_find_next_zero_bit(void *vaddr, uns
 	size -= offset;
 	p = addr + offset / __BITOPS_WORDSIZE;
         if (bit) {
-#ifndef __s390x__
-		asm volatile(
-			"	ic	%0,0(%1)\n"
-			"	icm	%0,2,1(%1)\n"
-			"	icm	%0,4,2(%1)\n"
-			"	icm	%0,8,3(%1)"
-			: "=&a" (word) : "a" (p), "m" (*p) : "cc");
-#else
-		asm volatile(
-			"	lrvg	%0,%1"
-			: "=a" (word) : "m" (*p) );
-#endif
 		/*
 		 * s390 version of ffz returns __BITOPS_WORDSIZE
 		 * if no zero bit is present in the word.
 		 */
-		set = ffz(word >> bit) + bit;
+		set = ffz(__load_ulong_le(p, 0) >> bit) + bit;
 		if (set >= size)
 			return size + offset;
 		if (set < __BITOPS_WORDSIZE)

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
