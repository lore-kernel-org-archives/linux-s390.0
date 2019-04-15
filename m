Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 4/4] s390: fix clang -Wpointer-sign warnigns in boot code
Date: Mon, 15 Apr 2019 10:35:54 +0200
Message-Id: <20190415083605.2560074-4-arnd@arndb.de>
In-Reply-To: <20190415083605.2560074-1-arnd@arndb.de>
References: <20190415083605.2560074-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: clang-built-linux@googlegroups.com, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Collin Walling <walling@linux.ibm.com>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The arch/s390/boot directory is built with its own set of compiler
options that does not include -Wno-pointer-sign like the rest of
the kernel does, this causes a lot of harmess but correct warnings
when building with clang.

For the atomics, we can add type casts to avoid the warnings, for
everything else the easiest way is to slightly adapt the types
to be more consistent.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/s390/boot/ipl_parm.c       |  2 +-
 arch/s390/include/asm/bitops.h  | 12 ++++++------
 arch/s390/include/asm/ebcdic.h  |  2 +-
 arch/s390/include/asm/lowcore.h |  2 +-
 drivers/s390/char/sclp.h        |  4 ++--
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/s390/boot/ipl_parm.c b/arch/s390/boot/ipl_parm.c
index 36beb56de021..3f2f0a9f1dad 100644
--- a/arch/s390/boot/ipl_parm.c
+++ b/arch/s390/boot/ipl_parm.c
@@ -51,7 +51,7 @@ void store_ipl_parmblock(void)
 		early_ipl_block_valid = 1;
 }
 
-static size_t scpdata_length(const char *buf, size_t count)
+static size_t scpdata_length(const u8 *buf, size_t count)
 {
 	while (count) {
 		if (buf[count - 1] != '\0' && buf[count - 1] != ' ')
diff --git a/arch/s390/include/asm/bitops.h b/arch/s390/include/asm/bitops.h
index d1f8a4d94cca..9900d655014c 100644
--- a/arch/s390/include/asm/bitops.h
+++ b/arch/s390/include/asm/bitops.h
@@ -73,7 +73,7 @@ static inline void set_bit(unsigned long nr, volatile unsigned long *ptr)
 	}
 #endif
 	mask = 1UL << (nr & (BITS_PER_LONG - 1));
-	__atomic64_or(mask, addr);
+	__atomic64_or(mask, (long *)addr);
 }
 
 static inline void clear_bit(unsigned long nr, volatile unsigned long *ptr)
@@ -94,7 +94,7 @@ static inline void clear_bit(unsigned long nr, volatile unsigned long *ptr)
 	}
 #endif
 	mask = ~(1UL << (nr & (BITS_PER_LONG - 1)));
-	__atomic64_and(mask, addr);
+	__atomic64_and(mask, (long *)addr);
 }
 
 static inline void change_bit(unsigned long nr, volatile unsigned long *ptr)
@@ -115,7 +115,7 @@ static inline void change_bit(unsigned long nr, volatile unsigned long *ptr)
 	}
 #endif
 	mask = 1UL << (nr & (BITS_PER_LONG - 1));
-	__atomic64_xor(mask, addr);
+	__atomic64_xor(mask, (long *)addr);
 }
 
 static inline int
@@ -125,7 +125,7 @@ test_and_set_bit(unsigned long nr, volatile unsigned long *ptr)
 	unsigned long old, mask;
 
 	mask = 1UL << (nr & (BITS_PER_LONG - 1));
-	old = __atomic64_or_barrier(mask, addr);
+	old = __atomic64_or_barrier(mask, (long *)addr);
 	return (old & mask) != 0;
 }
 
@@ -136,7 +136,7 @@ test_and_clear_bit(unsigned long nr, volatile unsigned long *ptr)
 	unsigned long old, mask;
 
 	mask = ~(1UL << (nr & (BITS_PER_LONG - 1)));
-	old = __atomic64_and_barrier(mask, addr);
+	old = __atomic64_and_barrier(mask, (long *)addr);
 	return (old & ~mask) != 0;
 }
 
@@ -147,7 +147,7 @@ test_and_change_bit(unsigned long nr, volatile unsigned long *ptr)
 	unsigned long old, mask;
 
 	mask = 1UL << (nr & (BITS_PER_LONG - 1));
-	old = __atomic64_xor_barrier(mask, addr);
+	old = __atomic64_xor_barrier(mask, (long *)addr);
 	return (old & mask) != 0;
 }
 
diff --git a/arch/s390/include/asm/ebcdic.h b/arch/s390/include/asm/ebcdic.h
index 29441beb92e6..d3ce6adacb10 100644
--- a/arch/s390/include/asm/ebcdic.h
+++ b/arch/s390/include/asm/ebcdic.h
@@ -20,7 +20,7 @@ extern __u8 _ebc_tolower[256]; /* EBCDIC -> lowercase */
 extern __u8 _ebc_toupper[256]; /* EBCDIC -> uppercase */
 
 static inline void
-codepage_convert(const __u8 *codepage, volatile __u8 * addr, unsigned long nr)
+codepage_convert(const __u8 *codepage, volatile char* addr, unsigned long nr)
 {
 	if (nr-- <= 0)
 		return;
diff --git a/arch/s390/include/asm/lowcore.h b/arch/s390/include/asm/lowcore.h
index cc0947e08b6f..f3a637afd485 100644
--- a/arch/s390/include/asm/lowcore.h
+++ b/arch/s390/include/asm/lowcore.h
@@ -128,7 +128,7 @@ struct lowcore {
 	/* SMP info area */
 	__u32	cpu_nr;				/* 0x0398 */
 	__u32	softirq_pending;		/* 0x039c */
-	__u32	preempt_count;			/* 0x03a0 */
+	__s32	preempt_count;			/* 0x03a0 */
 	__u32	spinlock_lockval;		/* 0x03a4 */
 	__u32	spinlock_index;			/* 0x03a8 */
 	__u32	fpu_flags;			/* 0x03ac */
diff --git a/drivers/s390/char/sclp.h b/drivers/s390/char/sclp.h
index 367e9d384d85..5918479ffa0e 100644
--- a/drivers/s390/char/sclp.h
+++ b/drivers/s390/char/sclp.h
@@ -365,14 +365,14 @@ sclp_ascebc(unsigned char ch)
 
 /* translate string from EBCDIC to ASCII */
 static inline void
-sclp_ebcasc_str(unsigned char *str, int nr)
+sclp_ebcasc_str(char *str, int nr)
 {
 	(MACHINE_IS_VM) ? EBCASC(str, nr) : EBCASC_500(str, nr);
 }
 
 /* translate string from ASCII to EBCDIC */
 static inline void
-sclp_ascebc_str(unsigned char *str, int nr)
+sclp_ascebc_str(char *str, int nr)
 {
 	(MACHINE_IS_VM) ? ASCEBC(str, nr) : ASCEBC_500(str, nr);
 }
-- 
2.20.0
