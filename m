Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 28 Apr 2015 09:07:10 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.1-rc2
Message-ID: <20150428090710.29afe68e@mschwide>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull from the 'for-linus' branch of

	git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git for-linus

to receive the following updates:

One additional new feature for 4.1, a new PRNG based on SHA-512 for the
zcrypt driver. Two memory management related changes, the page table
reallocation for KVM is removed, and with file ptes gone the encoding
of page table entries is improved. And three bug fixes.

Christophe Jaillet (1):
      s390/3215: free memory in error path

Harald Freudenberger (1):
      s390/zcrypt: Introduce new SHA-512 based Pseudo Random Generator.

Heiko Carstens (1):
      s390/bpf: add dependency to z196 features

Martin Schwidefsky (3):
      s390/kvm: remove delayed reallocation of page tables for KVM
      s390/mm: correct transfer of dirty & young bits in __pmd_to_pte
      s390/mm: change swap pte encoding and pgtable cleanup

 arch/s390/Kconfig                   |   2 +-
 arch/s390/crypto/crypt_s390.h       | 122 ++++--
 arch/s390/crypto/prng.c             | 850 +++++++++++++++++++++++++++++++++---
 arch/s390/include/asm/mmu.h         |   4 +-
 arch/s390/include/asm/mmu_context.h |   3 +
 arch/s390/include/asm/pgalloc.h     |   1 +
 arch/s390/include/asm/pgtable.h     | 167 +++----
 arch/s390/mm/hugetlbpage.c          |  66 +--
 arch/s390/mm/pgtable.c              | 142 ++----
 drivers/s390/char/con3215.c         |   2 +
 10 files changed, 1031 insertions(+), 328 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 8e58c61..b06dc38 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -115,7 +115,7 @@ config S390
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
-	select HAVE_BPF_JIT if PACK_STACK && HAVE_MARCH_Z9_109_FEATURES
+	select HAVE_BPF_JIT if PACK_STACK && HAVE_MARCH_Z196_FEATURES
 	select HAVE_CMPXCHG_DOUBLE
 	select HAVE_CMPXCHG_LOCAL
 	select HAVE_DEBUG_KMEMLEAK
diff --git a/arch/s390/crypto/crypt_s390.h b/arch/s390/crypto/crypt_s390.h
index ba3b2ae..d9c4c31 100644
--- a/arch/s390/crypto/crypt_s390.h
+++ b/arch/s390/crypto/crypt_s390.h
@@ -3,9 +3,10 @@
  *
  * Support for s390 cryptographic instructions.
  *
- *   Copyright IBM Corp. 2003, 2007
+ *   Copyright IBM Corp. 2003, 2015
  *   Author(s): Thomas Spatzier
  *		Jan Glauber (jan.glauber@de.ibm.com)
+ *		Harald Freudenberger (freude@de.ibm.com)
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the Free
@@ -28,15 +29,17 @@
 #define CRYPT_S390_MSA	0x1
 #define CRYPT_S390_MSA3	0x2
 #define CRYPT_S390_MSA4	0x4
+#define CRYPT_S390_MSA5	0x8
 
 /* s390 cryptographic operations */
 enum crypt_s390_operations {
-	CRYPT_S390_KM   = 0x0100,
-	CRYPT_S390_KMC  = 0x0200,
-	CRYPT_S390_KIMD = 0x0300,
-	CRYPT_S390_KLMD = 0x0400,
-	CRYPT_S390_KMAC = 0x0500,
-	CRYPT_S390_KMCTR = 0x0600
+	CRYPT_S390_KM	 = 0x0100,
+	CRYPT_S390_KMC	 = 0x0200,
+	CRYPT_S390_KIMD  = 0x0300,
+	CRYPT_S390_KLMD  = 0x0400,
+	CRYPT_S390_KMAC  = 0x0500,
+	CRYPT_S390_KMCTR = 0x0600,
+	CRYPT_S390_PPNO  = 0x0700
 };
 
 /*
@@ -138,6 +141,16 @@ enum crypt_s390_kmac_func {
 	KMAC_TDEA_192 = CRYPT_S390_KMAC | 3
 };
 
+/*
+ * function codes for PPNO (PERFORM PSEUDORANDOM NUMBER
+ * OPERATION) instruction
+ */
+enum crypt_s390_ppno_func {
+	PPNO_QUERY	      = CRYPT_S390_PPNO | 0,
+	PPNO_SHA512_DRNG_GEN  = CRYPT_S390_PPNO | 3,
+	PPNO_SHA512_DRNG_SEED = CRYPT_S390_PPNO | 0x83
+};
+
 /**
  * crypt_s390_km:
  * @func: the function code passed to KM; see crypt_s390_km_func
@@ -162,11 +175,11 @@ static inline int crypt_s390_km(long func, void *param,
 	int ret;
 
 	asm volatile(
-		"0:	.insn	rre,0xb92e0000,%3,%1 \n" /* KM opcode */
-		"1:	brc	1,0b \n" /* handle partial completion */
+		"0:	.insn	rre,0xb92e0000,%3,%1\n" /* KM opcode */
+		"1:	brc	1,0b\n" /* handle partial completion */
 		"	la	%0,0\n"
 		"2:\n"
-		EX_TABLE(0b,2b) EX_TABLE(1b,2b)
+		EX_TABLE(0b, 2b) EX_TABLE(1b, 2b)
 		: "=d" (ret), "+a" (__src), "+d" (__src_len), "+a" (__dest)
 		: "d" (__func), "a" (__param), "0" (-1) : "cc", "memory");
 	if (ret < 0)
@@ -198,11 +211,11 @@ static inline int crypt_s390_kmc(long func, void *param,
 	int ret;
 
 	asm volatile(
-		"0:	.insn	rre,0xb92f0000,%3,%1 \n" /* KMC opcode */
-		"1:	brc	1,0b \n" /* handle partial completion */
+		"0:	.insn	rre,0xb92f0000,%3,%1\n" /* KMC opcode */
+		"1:	brc	1,0b\n" /* handle partial completion */
 		"	la	%0,0\n"
 		"2:\n"
-		EX_TABLE(0b,2b) EX_TABLE(1b,2b)
+		EX_TABLE(0b, 2b) EX_TABLE(1b, 2b)
 		: "=d" (ret), "+a" (__src), "+d" (__src_len), "+a" (__dest)
 		: "d" (__func), "a" (__param), "0" (-1) : "cc", "memory");
 	if (ret < 0)
@@ -233,11 +246,11 @@ static inline int crypt_s390_kimd(long func, void *param,
 	int ret;
 
 	asm volatile(
-		"0:	.insn	rre,0xb93e0000,%1,%1 \n" /* KIMD opcode */
-		"1:	brc	1,0b \n" /* handle partial completion */
+		"0:	.insn	rre,0xb93e0000,%1,%1\n" /* KIMD opcode */
+		"1:	brc	1,0b\n" /* handle partial completion */
 		"	la	%0,0\n"
 		"2:\n"
-		EX_TABLE(0b,2b) EX_TABLE(1b,2b)
+		EX_TABLE(0b, 2b) EX_TABLE(1b, 2b)
 		: "=d" (ret), "+a" (__src), "+d" (__src_len)
 		: "d" (__func), "a" (__param), "0" (-1) : "cc", "memory");
 	if (ret < 0)
@@ -267,11 +280,11 @@ static inline int crypt_s390_klmd(long func, void *param,
 	int ret;
 
 	asm volatile(
-		"0:	.insn	rre,0xb93f0000,%1,%1 \n" /* KLMD opcode */
-		"1:	brc	1,0b \n" /* handle partial completion */
+		"0:	.insn	rre,0xb93f0000,%1,%1\n" /* KLMD opcode */
+		"1:	brc	1,0b\n" /* handle partial completion */
 		"	la	%0,0\n"
 		"2:\n"
-		EX_TABLE(0b,2b) EX_TABLE(1b,2b)
+		EX_TABLE(0b, 2b) EX_TABLE(1b, 2b)
 		: "=d" (ret), "+a" (__src), "+d" (__src_len)
 		: "d" (__func), "a" (__param), "0" (-1) : "cc", "memory");
 	if (ret < 0)
@@ -302,11 +315,11 @@ static inline int crypt_s390_kmac(long func, void *param,
 	int ret;
 
 	asm volatile(
-		"0:	.insn	rre,0xb91e0000,%1,%1 \n" /* KLAC opcode */
-		"1:	brc	1,0b \n" /* handle partial completion */
+		"0:	.insn	rre,0xb91e0000,%1,%1\n" /* KLAC opcode */
+		"1:	brc	1,0b\n" /* handle partial completion */
 		"	la	%0,0\n"
 		"2:\n"
-		EX_TABLE(0b,2b) EX_TABLE(1b,2b)
+		EX_TABLE(0b, 2b) EX_TABLE(1b, 2b)
 		: "=d" (ret), "+a" (__src), "+d" (__src_len)
 		: "d" (__func), "a" (__param), "0" (-1) : "cc", "memory");
 	if (ret < 0)
@@ -340,11 +353,11 @@ static inline int crypt_s390_kmctr(long func, void *param, u8 *dest,
 	int ret = -1;
 
 	asm volatile(
-		"0:	.insn	rrf,0xb92d0000,%3,%1,%4,0 \n" /* KMCTR opcode */
-		"1:	brc	1,0b \n" /* handle partial completion */
+		"0:	.insn	rrf,0xb92d0000,%3,%1,%4,0\n" /* KMCTR opcode */
+		"1:	brc	1,0b\n" /* handle partial completion */
 		"	la	%0,0\n"
 		"2:\n"
-		EX_TABLE(0b,2b) EX_TABLE(1b,2b)
+		EX_TABLE(0b, 2b) EX_TABLE(1b, 2b)
 		: "+d" (ret), "+a" (__src), "+d" (__src_len), "+a" (__dest),
 		  "+a" (__ctr)
 		: "d" (__func), "a" (__param) : "cc", "memory");
@@ -354,6 +367,47 @@ static inline int crypt_s390_kmctr(long func, void *param, u8 *dest,
 }
 
 /**
+ * crypt_s390_ppno:
+ * @func: the function code passed to PPNO; see crypt_s390_ppno_func
+ * @param: address of parameter block; see POP for details on each func
+ * @dest: address of destination memory area
+ * @dest_len: size of destination memory area in bytes
+ * @seed: address of seed data
+ * @seed_len: size of seed data in bytes
+ *
+ * Executes the PPNO (PERFORM PSEUDORANDOM NUMBER OPERATION)
+ * operation of the CPU.
+ *
+ * Returns -1 for failure, 0 for the query func, number of random
+ * bytes stored in dest buffer for generate function
+ */
+static inline int crypt_s390_ppno(long func, void *param,
+				  u8 *dest, long dest_len,
+				  const u8 *seed, long seed_len)
+{
+	register long  __func	  asm("0") = func & CRYPT_S390_FUNC_MASK;
+	register void *__param	  asm("1") = param;    /* param block (240 bytes) */
+	register u8   *__dest	  asm("2") = dest;     /* buf for recv random bytes */
+	register long  __dest_len asm("3") = dest_len; /* requested random bytes */
+	register const u8 *__seed asm("4") = seed;     /* buf with seed data */
+	register long  __seed_len asm("5") = seed_len; /* bytes in seed buf */
+	int ret = -1;
+
+	asm volatile (
+		"0:	.insn	rre,0xb93c0000,%1,%5\n"	/* PPNO opcode */
+		"1:	brc	1,0b\n"	  /* handle partial completion */
+		"	la	%0,0\n"
+		"2:\n"
+		EX_TABLE(0b, 2b) EX_TABLE(1b, 2b)
+		: "+d" (ret), "+a"(__dest), "+d"(__dest_len)
+		: "d"(__func), "a"(__param), "a"(__seed), "d"(__seed_len)
+		: "cc", "memory");
+	if (ret < 0)
+		return ret;
+	return (func & CRYPT_S390_FUNC_MASK) ? dest_len - __dest_len : 0;
+}
+
+/**
  * crypt_s390_func_available:
  * @func: the function code of the specific function; 0 if op in general
  *
@@ -373,6 +427,9 @@ static inline int crypt_s390_func_available(int func,
 		return 0;
 	if (facility_mask & CRYPT_S390_MSA4 && !test_facility(77))
 		return 0;
+	if (facility_mask & CRYPT_S390_MSA5 && !test_facility(57))
+		return 0;
+
 	switch (func & CRYPT_S390_OP_MASK) {
 	case CRYPT_S390_KM:
 		ret = crypt_s390_km(KM_QUERY, &status, NULL, NULL, 0);
@@ -390,8 +447,12 @@ static inline int crypt_s390_func_available(int func,
 		ret = crypt_s390_kmac(KMAC_QUERY, &status, NULL, 0);
 		break;
 	case CRYPT_S390_KMCTR:
-		ret = crypt_s390_kmctr(KMCTR_QUERY, &status, NULL, NULL, 0,
-				       NULL);
+		ret = crypt_s390_kmctr(KMCTR_QUERY, &status,
+				       NULL, NULL, 0, NULL);
+		break;
+	case CRYPT_S390_PPNO:
+		ret = crypt_s390_ppno(PPNO_QUERY, &status,
+				      NULL, 0, NULL, 0);
 		break;
 	default:
 		return 0;
@@ -419,15 +480,14 @@ static inline int crypt_s390_pcc(long func, void *param)
 	int ret = -1;
 
 	asm volatile(
-		"0:	.insn	rre,0xb92c0000,0,0 \n" /* PCC opcode */
-		"1:	brc	1,0b \n" /* handle partial completion */
+		"0:	.insn	rre,0xb92c0000,0,0\n" /* PCC opcode */
+		"1:	brc	1,0b\n" /* handle partial completion */
 		"	la	%0,0\n"
 		"2:\n"
-		EX_TABLE(0b,2b) EX_TABLE(1b,2b)
+		EX_TABLE(0b, 2b) EX_TABLE(1b, 2b)
 		: "+d" (ret)
 		: "d" (__func), "a" (__param) : "cc", "memory");
 	return ret;
 }
 
-
 #endif	/* _CRYPTO_ARCH_S390_CRYPT_S390_H */
diff --git a/arch/s390/crypto/prng.c b/arch/s390/crypto/prng.c
index 94a35a4..1f374b3 100644
--- a/arch/s390/crypto/prng.c
+++ b/arch/s390/crypto/prng.c
@@ -1,106 +1,529 @@
 /*
- * Copyright IBM Corp. 2006, 2007
+ * Copyright IBM Corp. 2006, 2015
  * Author(s): Jan Glauber <jan.glauber@de.ibm.com>
+ *	      Harald Freudenberger <freude@de.ibm.com>
  * Driver for the s390 pseudo random number generator
  */
+
+#define KMSG_COMPONENT "prng"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include <linux/fs.h>
+#include <linux/fips.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/device.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/mutex.h>
 #include <linux/random.h>
 #include <linux/slab.h>
 #include <asm/debug.h>
 #include <asm/uaccess.h>
+#include <asm/timex.h>
 
 #include "crypt_s390.h"
 
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Jan Glauber <jan.glauber@de.ibm.com>");
+MODULE_AUTHOR("IBM Corporation");
 MODULE_DESCRIPTION("s390 PRNG interface");
 
-static int prng_chunk_size = 256;
-module_param(prng_chunk_size, int, S_IRUSR | S_IRGRP | S_IROTH);
+
+#define PRNG_MODE_AUTO	  0
+#define PRNG_MODE_TDES	  1
+#define PRNG_MODE_SHA512  2
+
+static unsigned int prng_mode = PRNG_MODE_AUTO;
+module_param_named(mode, prng_mode, int, 0);
+MODULE_PARM_DESC(prng_mode, "PRNG mode: 0 - auto, 1 - TDES, 2 - SHA512");
+
+
+#define PRNG_CHUNKSIZE_TDES_MIN   8
+#define PRNG_CHUNKSIZE_TDES_MAX   (64*1024)
+#define PRNG_CHUNKSIZE_SHA512_MIN 64
+#define PRNG_CHUNKSIZE_SHA512_MAX (64*1024)
+
+static unsigned int prng_chunk_size = 256;
+module_param_named(chunksize, prng_chunk_size, int, 0);
 MODULE_PARM_DESC(prng_chunk_size, "PRNG read chunk size in bytes");
 
-static int prng_entropy_limit = 4096;
-module_param(prng_entropy_limit, int, S_IRUSR | S_IRGRP | S_IROTH | S_IWUSR);
-MODULE_PARM_DESC(prng_entropy_limit,
-	"PRNG add entropy after that much bytes were produced");
+
+#define PRNG_RESEED_LIMIT_TDES		 4096
+#define PRNG_RESEED_LIMIT_TDES_LOWER	 4096
+#define PRNG_RESEED_LIMIT_SHA512       100000
+#define PRNG_RESEED_LIMIT_SHA512_LOWER	10000
+
+static unsigned int prng_reseed_limit;
+module_param_named(reseed_limit, prng_reseed_limit, int, 0);
+MODULE_PARM_DESC(prng_reseed_limit, "PRNG reseed limit");
+
 
 /*
  * Any one who considers arithmetical methods of producing random digits is,
  * of course, in a state of sin. -- John von Neumann
  */
 
-struct s390_prng_data {
-	unsigned long count; /* how many bytes were produced */
-	char *buf;
+static int prng_errorflag;
+
+#define PRNG_GEN_ENTROPY_FAILED  1
+#define PRNG_SELFTEST_FAILED	 2
+#define PRNG_INSTANTIATE_FAILED  3
+#define PRNG_SEED_FAILED	 4
+#define PRNG_RESEED_FAILED	 5
+#define PRNG_GEN_FAILED		 6
+
+struct prng_ws_s {
+	u8  parm_block[32];
+	u32 reseed_counter;
+	u64 byte_counter;
 };
 
-static struct s390_prng_data *p;
+struct ppno_ws_s {
+	u32 res;
+	u32 reseed_counter;
+	u64 stream_bytes;
+	u8  V[112];
+	u8  C[112];
+};
 
-/* copied from libica, use a non-zero initial parameter block */
-static unsigned char parm_block[32] = {
-0x0F,0x2B,0x8E,0x63,0x8C,0x8E,0xD2,0x52,0x64,0xB7,0xA0,0x7B,0x75,0x28,0xB8,0xF4,
-0x75,0x5F,0xD2,0xA6,0x8D,0x97,0x11,0xFF,0x49,0xD8,0x23,0xF3,0x7E,0x21,0xEC,0xA0,
+struct prng_data_s {
+	struct mutex mutex;
+	union {
+		struct prng_ws_s prngws;
+		struct ppno_ws_s ppnows;
+	};
+	u8 *buf;
+	u32 rest;
+	u8 *prev;
 };
 
-static int prng_open(struct inode *inode, struct file *file)
+static struct prng_data_s *prng_data;
+
+/* initial parameter block for tdes mode, copied from libica */
+static const u8 initial_parm_block[32] __initconst = {
+	0x0F, 0x2B, 0x8E, 0x63, 0x8C, 0x8E, 0xD2, 0x52,
+	0x64, 0xB7, 0xA0, 0x7B, 0x75, 0x28, 0xB8, 0xF4,
+	0x75, 0x5F, 0xD2, 0xA6, 0x8D, 0x97, 0x11, 0xFF,
+	0x49, 0xD8, 0x23, 0xF3, 0x7E, 0x21, 0xEC, 0xA0 };
+
+
+/*** helper functions ***/
+
+static int generate_entropy(u8 *ebuf, size_t nbytes)
 {
-	return nonseekable_open(inode, file);
+	int n, ret = 0;
+	u8 *pg, *h, hash[32];
+
+	pg = (u8 *) __get_free_page(GFP_KERNEL);
+	if (!pg) {
+		prng_errorflag = PRNG_GEN_ENTROPY_FAILED;
+		return -ENOMEM;
+	}
+
+	while (nbytes) {
+		/* fill page with urandom bytes */
+		get_random_bytes(pg, PAGE_SIZE);
+		/* exor page with stckf values */
+		for (n = 0; n < sizeof(PAGE_SIZE/sizeof(u64)); n++) {
+			u64 *p = ((u64 *)pg) + n;
+			*p ^= get_tod_clock_fast();
+		}
+		n = (nbytes < sizeof(hash)) ? nbytes : sizeof(hash);
+		if (n < sizeof(hash))
+			h = hash;
+		else
+			h = ebuf;
+		/* generate sha256 from this page */
+		if (crypt_s390_kimd(KIMD_SHA_256, h,
+				    pg, PAGE_SIZE) != PAGE_SIZE) {
+			prng_errorflag = PRNG_GEN_ENTROPY_FAILED;
+			ret = -EIO;
+			goto out;
+		}
+		if (n < sizeof(hash))
+			memcpy(ebuf, hash, n);
+		ret += n;
+		ebuf += n;
+		nbytes -= n;
+	}
+
+out:
+	free_page((unsigned long)pg);
+	return ret;
 }
 
-static void prng_add_entropy(void)
+
+/*** tdes functions ***/
+
+static void prng_tdes_add_entropy(void)
 {
 	__u64 entropy[4];
 	unsigned int i;
 	int ret;
 
 	for (i = 0; i < 16; i++) {
-		ret = crypt_s390_kmc(KMC_PRNG, parm_block, (char *)entropy,
-				     (char *)entropy, sizeof(entropy));
+		ret = crypt_s390_kmc(KMC_PRNG, prng_data->prngws.parm_block,
+				     (char *)entropy, (char *)entropy,
+				     sizeof(entropy));
 		BUG_ON(ret < 0 || ret != sizeof(entropy));
-		memcpy(parm_block, entropy, sizeof(entropy));
+		memcpy(prng_data->prngws.parm_block, entropy, sizeof(entropy));
 	}
 }
 
-static void prng_seed(int nbytes)
+
+static void prng_tdes_seed(int nbytes)
 {
 	char buf[16];
 	int i = 0;
 
-	BUG_ON(nbytes > 16);
+	BUG_ON(nbytes > sizeof(buf));
+
 	get_random_bytes(buf, nbytes);
 
 	/* Add the entropy */
 	while (nbytes >= 8) {
-		*((__u64 *)parm_block) ^= *((__u64 *)(buf+i));
-		prng_add_entropy();
+		*((__u64 *)prng_data->prngws.parm_block) ^= *((__u64 *)(buf+i));
+		prng_tdes_add_entropy();
 		i += 8;
 		nbytes -= 8;
 	}
-	prng_add_entropy();
+	prng_tdes_add_entropy();
+	prng_data->prngws.reseed_counter = 0;
+}
+
+
+static int __init prng_tdes_instantiate(void)
+{
+	int datalen;
+
+	pr_debug("prng runs in TDES mode with "
+		 "chunksize=%d and reseed_limit=%u\n",
+		 prng_chunk_size, prng_reseed_limit);
+
+	/* memory allocation, prng_data struct init, mutex init */
+	datalen = sizeof(struct prng_data_s) + prng_chunk_size;
+	prng_data = kzalloc(datalen, GFP_KERNEL);
+	if (!prng_data) {
+		prng_errorflag = PRNG_INSTANTIATE_FAILED;
+		return -ENOMEM;
+	}
+	mutex_init(&prng_data->mutex);
+	prng_data->buf = ((u8 *)prng_data) + sizeof(struct prng_data_s);
+	memcpy(prng_data->prngws.parm_block, initial_parm_block, 32);
+
+	/* initialize the PRNG, add 128 bits of entropy */
+	prng_tdes_seed(16);
+
+	return 0;
 }
 
-static ssize_t prng_read(struct file *file, char __user *ubuf, size_t nbytes,
-			 loff_t *ppos)
+
+static void prng_tdes_deinstantiate(void)
+{
+	pr_debug("The prng module stopped "
+		 "after running in triple DES mode\n");
+	kzfree(prng_data);
+}
+
+
+/*** sha512 functions ***/
+
+static int __init prng_sha512_selftest(void)
 {
-	int chunk, n;
+	/* NIST DRBG testvector for Hash Drbg, Sha-512, Count #0 */
+	static const u8 seed[] __initconst = {
+		0x6b, 0x50, 0xa7, 0xd8, 0xf8, 0xa5, 0x5d, 0x7a,
+		0x3d, 0xf8, 0xbb, 0x40, 0xbc, 0xc3, 0xb7, 0x22,
+		0xd8, 0x70, 0x8d, 0xe6, 0x7f, 0xda, 0x01, 0x0b,
+		0x03, 0xc4, 0xc8, 0x4d, 0x72, 0x09, 0x6f, 0x8c,
+		0x3e, 0xc6, 0x49, 0xcc, 0x62, 0x56, 0xd9, 0xfa,
+		0x31, 0xdb, 0x7a, 0x29, 0x04, 0xaa, 0xf0, 0x25 };
+	static const u8 V0[] __initconst = {
+		0x00, 0xad, 0xe3, 0x6f, 0x9a, 0x01, 0xc7, 0x76,
+		0x61, 0x34, 0x35, 0xf5, 0x4e, 0x24, 0x74, 0x22,
+		0x21, 0x9a, 0x29, 0x89, 0xc7, 0x93, 0x2e, 0x60,
+		0x1e, 0xe8, 0x14, 0x24, 0x8d, 0xd5, 0x03, 0xf1,
+		0x65, 0x5d, 0x08, 0x22, 0x72, 0xd5, 0xad, 0x95,
+		0xe1, 0x23, 0x1e, 0x8a, 0xa7, 0x13, 0xd9, 0x2b,
+		0x5e, 0xbc, 0xbb, 0x80, 0xab, 0x8d, 0xe5, 0x79,
+		0xab, 0x5b, 0x47, 0x4e, 0xdd, 0xee, 0x6b, 0x03,
+		0x8f, 0x0f, 0x5c, 0x5e, 0xa9, 0x1a, 0x83, 0xdd,
+		0xd3, 0x88, 0xb2, 0x75, 0x4b, 0xce, 0x83, 0x36,
+		0x57, 0x4b, 0xf1, 0x5c, 0xca, 0x7e, 0x09, 0xc0,
+		0xd3, 0x89, 0xc6, 0xe0, 0xda, 0xc4, 0x81, 0x7e,
+		0x5b, 0xf9, 0xe1, 0x01, 0xc1, 0x92, 0x05, 0xea,
+		0xf5, 0x2f, 0xc6, 0xc6, 0xc7, 0x8f, 0xbc, 0xf4 };
+	static const u8 C0[] __initconst = {
+		0x00, 0xf4, 0xa3, 0xe5, 0xa0, 0x72, 0x63, 0x95,
+		0xc6, 0x4f, 0x48, 0xd0, 0x8b, 0x5b, 0x5f, 0x8e,
+		0x6b, 0x96, 0x1f, 0x16, 0xed, 0xbc, 0x66, 0x94,
+		0x45, 0x31, 0xd7, 0x47, 0x73, 0x22, 0xa5, 0x86,
+		0xce, 0xc0, 0x4c, 0xac, 0x63, 0xb8, 0x39, 0x50,
+		0xbf, 0xe6, 0x59, 0x6c, 0x38, 0x58, 0x99, 0x1f,
+		0x27, 0xa7, 0x9d, 0x71, 0x2a, 0xb3, 0x7b, 0xf9,
+		0xfb, 0x17, 0x86, 0xaa, 0x99, 0x81, 0xaa, 0x43,
+		0xe4, 0x37, 0xd3, 0x1e, 0x6e, 0xe5, 0xe6, 0xee,
+		0xc2, 0xed, 0x95, 0x4f, 0x53, 0x0e, 0x46, 0x8a,
+		0xcc, 0x45, 0xa5, 0xdb, 0x69, 0x0d, 0x81, 0xc9,
+		0x32, 0x92, 0xbc, 0x8f, 0x33, 0xe6, 0xf6, 0x09,
+		0x7c, 0x8e, 0x05, 0x19, 0x0d, 0xf1, 0xb6, 0xcc,
+		0xf3, 0x02, 0x21, 0x90, 0x25, 0xec, 0xed, 0x0e };
+	static const u8 random[] __initconst = {
+		0x95, 0xb7, 0xf1, 0x7e, 0x98, 0x02, 0xd3, 0x57,
+		0x73, 0x92, 0xc6, 0xa9, 0xc0, 0x80, 0x83, 0xb6,
+		0x7d, 0xd1, 0x29, 0x22, 0x65, 0xb5, 0xf4, 0x2d,
+		0x23, 0x7f, 0x1c, 0x55, 0xbb, 0x9b, 0x10, 0xbf,
+		0xcf, 0xd8, 0x2c, 0x77, 0xa3, 0x78, 0xb8, 0x26,
+		0x6a, 0x00, 0x99, 0x14, 0x3b, 0x3c, 0x2d, 0x64,
+		0x61, 0x1e, 0xee, 0xb6, 0x9a, 0xcd, 0xc0, 0x55,
+		0x95, 0x7c, 0x13, 0x9e, 0x8b, 0x19, 0x0c, 0x7a,
+		0x06, 0x95, 0x5f, 0x2c, 0x79, 0x7c, 0x27, 0x78,
+		0xde, 0x94, 0x03, 0x96, 0xa5, 0x01, 0xf4, 0x0e,
+		0x91, 0x39, 0x6a, 0xcf, 0x8d, 0x7e, 0x45, 0xeb,
+		0xdb, 0xb5, 0x3b, 0xbf, 0x8c, 0x97, 0x52, 0x30,
+		0xd2, 0xf0, 0xff, 0x91, 0x06, 0xc7, 0x61, 0x19,
+		0xae, 0x49, 0x8e, 0x7f, 0xbc, 0x03, 0xd9, 0x0f,
+		0x8e, 0x4c, 0x51, 0x62, 0x7a, 0xed, 0x5c, 0x8d,
+		0x42, 0x63, 0xd5, 0xd2, 0xb9, 0x78, 0x87, 0x3a,
+		0x0d, 0xe5, 0x96, 0xee, 0x6d, 0xc7, 0xf7, 0xc2,
+		0x9e, 0x37, 0xee, 0xe8, 0xb3, 0x4c, 0x90, 0xdd,
+		0x1c, 0xf6, 0xa9, 0xdd, 0xb2, 0x2b, 0x4c, 0xbd,
+		0x08, 0x6b, 0x14, 0xb3, 0x5d, 0xe9, 0x3d, 0xa2,
+		0xd5, 0xcb, 0x18, 0x06, 0x69, 0x8c, 0xbd, 0x7b,
+		0xbb, 0x67, 0xbf, 0xe3, 0xd3, 0x1f, 0xd2, 0xd1,
+		0xdb, 0xd2, 0xa1, 0xe0, 0x58, 0xa3, 0xeb, 0x99,
+		0xd7, 0xe5, 0x1f, 0x1a, 0x93, 0x8e, 0xed, 0x5e,
+		0x1c, 0x1d, 0xe2, 0x3a, 0x6b, 0x43, 0x45, 0xd3,
+		0x19, 0x14, 0x09, 0xf9, 0x2f, 0x39, 0xb3, 0x67,
+		0x0d, 0x8d, 0xbf, 0xb6, 0x35, 0xd8, 0xe6, 0xa3,
+		0x69, 0x32, 0xd8, 0x10, 0x33, 0xd1, 0x44, 0x8d,
+		0x63, 0xb4, 0x03, 0xdd, 0xf8, 0x8e, 0x12, 0x1b,
+		0x6e, 0x81, 0x9a, 0xc3, 0x81, 0x22, 0x6c, 0x13,
+		0x21, 0xe4, 0xb0, 0x86, 0x44, 0xf6, 0x72, 0x7c,
+		0x36, 0x8c, 0x5a, 0x9f, 0x7a, 0x4b, 0x3e, 0xe2 };
+
 	int ret = 0;
-	int tmp;
+	u8 buf[sizeof(random)];
+	struct ppno_ws_s ws;
+
+	memset(&ws, 0, sizeof(ws));
+
+	/* initial seed */
+	ret = crypt_s390_ppno(PPNO_SHA512_DRNG_SEED,
+			      &ws, NULL, 0,
+			      seed, sizeof(seed));
+	if (ret < 0) {
+		pr_err("The prng self test seed operation for the "
+		       "SHA-512 mode failed with rc=%d\n", ret);
+		prng_errorflag = PRNG_SELFTEST_FAILED;
+		return -EIO;
+	}
+
+	/* check working states V and C */
+	if (memcmp(ws.V, V0, sizeof(V0)) != 0
+	    || memcmp(ws.C, C0, sizeof(C0)) != 0) {
+		pr_err("The prng self test state test "
+		       "for the SHA-512 mode failed\n");
+		prng_errorflag = PRNG_SELFTEST_FAILED;
+		return -EIO;
+	}
+
+	/* generate random bytes */
+	ret = crypt_s390_ppno(PPNO_SHA512_DRNG_GEN,
+			      &ws, buf, sizeof(buf),
+			      NULL, 0);
+	if (ret < 0) {
+		pr_err("The prng self test generate operation for "
+		       "the SHA-512 mode failed with rc=%d\n", ret);
+		prng_errorflag = PRNG_SELFTEST_FAILED;
+		return -EIO;
+	}
+	ret = crypt_s390_ppno(PPNO_SHA512_DRNG_GEN,
+			      &ws, buf, sizeof(buf),
+			      NULL, 0);
+	if (ret < 0) {
+		pr_err("The prng self test generate operation for "
+		       "the SHA-512 mode failed with rc=%d\n", ret);
+		prng_errorflag = PRNG_SELFTEST_FAILED;
+		return -EIO;
+	}
+
+	/* check against expected data */
+	if (memcmp(buf, random, sizeof(random)) != 0) {
+		pr_err("The prng self test data test "
+		       "for the SHA-512 mode failed\n");
+		prng_errorflag = PRNG_SELFTEST_FAILED;
+		return -EIO;
+	}
+
+	return 0;
+}
+
+
+static int __init prng_sha512_instantiate(void)
+{
+	int ret, datalen;
+	u8 seed[64];
+
+	pr_debug("prng runs in SHA-512 mode "
+		 "with chunksize=%d and reseed_limit=%u\n",
+		 prng_chunk_size, prng_reseed_limit);
+
+	/* memory allocation, prng_data struct init, mutex init */
+	datalen = sizeof(struct prng_data_s) + prng_chunk_size;
+	if (fips_enabled)
+		datalen += prng_chunk_size;
+	prng_data = kzalloc(datalen, GFP_KERNEL);
+	if (!prng_data) {
+		prng_errorflag = PRNG_INSTANTIATE_FAILED;
+		return -ENOMEM;
+	}
+	mutex_init(&prng_data->mutex);
+	prng_data->buf = ((u8 *)prng_data) + sizeof(struct prng_data_s);
+
+	/* selftest */
+	ret = prng_sha512_selftest();
+	if (ret)
+		goto outfree;
+
+	/* generate initial seed bytestring, first 48 bytes of entropy */
+	ret = generate_entropy(seed, 48);
+	if (ret != 48)
+		goto outfree;
+	/* followed by 16 bytes of unique nonce */
+	get_tod_clock_ext(seed + 48);
+
+	/* initial seed of the ppno drng */
+	ret = crypt_s390_ppno(PPNO_SHA512_DRNG_SEED,
+			      &prng_data->ppnows, NULL, 0,
+			      seed, sizeof(seed));
+	if (ret < 0) {
+		prng_errorflag = PRNG_SEED_FAILED;
+		ret = -EIO;
+		goto outfree;
+	}
+
+	/* if fips mode is enabled, generate a first block of random
+	   bytes for the FIPS 140-2 Conditional Self Test */
+	if (fips_enabled) {
+		prng_data->prev = prng_data->buf + prng_chunk_size;
+		ret = crypt_s390_ppno(PPNO_SHA512_DRNG_GEN,
+				      &prng_data->ppnows,
+				      prng_data->prev,
+				      prng_chunk_size,
+				      NULL, 0);
+		if (ret < 0 || ret != prng_chunk_size) {
+			prng_errorflag = PRNG_GEN_FAILED;
+			ret = -EIO;
+			goto outfree;
+		}
+	}
+
+	return 0;
+
+outfree:
+	kfree(prng_data);
+	return ret;
+}
+
+
+static void prng_sha512_deinstantiate(void)
+{
+	pr_debug("The prng module stopped after running in SHA-512 mode\n");
+	kzfree(prng_data);
+}
+
+
+static int prng_sha512_reseed(void)
+{
+	int ret;
+	u8 seed[32];
+
+	/* generate 32 bytes of fresh entropy */
+	ret = generate_entropy(seed, sizeof(seed));
+	if (ret != sizeof(seed))
+		return ret;
+
+	/* do a reseed of the ppno drng with this bytestring */
+	ret = crypt_s390_ppno(PPNO_SHA512_DRNG_SEED,
+			      &prng_data->ppnows, NULL, 0,
+			      seed, sizeof(seed));
+	if (ret) {
+		prng_errorflag = PRNG_RESEED_FAILED;
+		return -EIO;
+	}
+
+	return 0;
+}
+
+
+static int prng_sha512_generate(u8 *buf, size_t nbytes)
+{
+	int ret;
+
+	/* reseed needed ? */
+	if (prng_data->ppnows.reseed_counter > prng_reseed_limit) {
+		ret = prng_sha512_reseed();
+		if (ret)
+			return ret;
+	}
+
+	/* PPNO generate */
+	ret = crypt_s390_ppno(PPNO_SHA512_DRNG_GEN,
+			      &prng_data->ppnows, buf, nbytes,
+			      NULL, 0);
+	if (ret < 0 || ret != nbytes) {
+		prng_errorflag = PRNG_GEN_FAILED;
+		return -EIO;
+	}
+
+	/* FIPS 140-2 Conditional Self Test */
+	if (fips_enabled) {
+		if (!memcmp(prng_data->prev, buf, nbytes)) {
+			prng_errorflag = PRNG_GEN_FAILED;
+			return -EILSEQ;
+		}
+		memcpy(prng_data->prev, buf, nbytes);
+	}
+
+	return ret;
+}
+
+
+/*** file io functions ***/
+
+static int prng_open(struct inode *inode, struct file *file)
+{
+	return nonseekable_open(inode, file);
+}
+
+
+static ssize_t prng_tdes_read(struct file *file, char __user *ubuf,
+			      size_t nbytes, loff_t *ppos)
+{
+	int chunk, n, tmp, ret = 0;
+
+	/* lock prng_data struct */
+	if (mutex_lock_interruptible(&prng_data->mutex))
+		return -ERESTARTSYS;
 
-	/* nbytes can be arbitrary length, we split it into chunks */
 	while (nbytes) {
-		/* same as in extract_entropy_user in random.c */
 		if (need_resched()) {
 			if (signal_pending(current)) {
 				if (ret == 0)
 					ret = -ERESTARTSYS;
 				break;
 			}
+			/* give mutex free before calling schedule() */
+			mutex_unlock(&prng_data->mutex);
 			schedule();
+			/* occopy mutex again */
+			if (mutex_lock_interruptible(&prng_data->mutex)) {
+				if (ret == 0)
+					ret = -ERESTARTSYS;
+				return ret;
+			}
 		}
 
 		/*
@@ -112,12 +535,11 @@ static ssize_t prng_read(struct file *file, char __user *ubuf, size_t nbytes,
 		/* PRNG only likes multiples of 8 bytes */
 		n = (chunk + 7) & -8;
 
-		if (p->count > prng_entropy_limit)
-			prng_seed(8);
+		if (prng_data->prngws.reseed_counter > prng_reseed_limit)
+			prng_tdes_seed(8);
 
 		/* if the CPU supports PRNG stckf is present too */
-		asm volatile(".insn     s,0xb27c0000,%0"
-			     : "=m" (*((unsigned long long *)p->buf)) : : "cc");
+		*((unsigned long long *)prng_data->buf) = get_tod_clock_fast();
 
 		/*
 		 * Beside the STCKF the input for the TDES-EDE is the output
@@ -132,35 +554,259 @@ static ssize_t prng_read(struct file *file, char __user *ubuf, size_t nbytes,
 		 * Note: you can still get strict X9.17 conformity by setting
 		 * prng_chunk_size to 8 bytes.
 		*/
-		tmp = crypt_s390_kmc(KMC_PRNG, parm_block, p->buf, p->buf, n);
-		BUG_ON((tmp < 0) || (tmp != n));
+		tmp = crypt_s390_kmc(KMC_PRNG, prng_data->prngws.parm_block,
+				     prng_data->buf, prng_data->buf, n);
+		if (tmp < 0 || tmp != n) {
+			ret = -EIO;
+			break;
+		}
 
-		p->count += n;
+		prng_data->prngws.byte_counter += n;
+		prng_data->prngws.reseed_counter += n;
 
-		if (copy_to_user(ubuf, p->buf, chunk))
+		if (copy_to_user(ubuf, prng_data->buf, chunk))
 			return -EFAULT;
 
 		nbytes -= chunk;
 		ret += chunk;
 		ubuf += chunk;
 	}
+
+	/* unlock prng_data struct */
+	mutex_unlock(&prng_data->mutex);
+
 	return ret;
 }
 
-static const struct file_operations prng_fops = {
+
+static ssize_t prng_sha512_read(struct file *file, char __user *ubuf,
+				size_t nbytes, loff_t *ppos)
+{
+	int n, ret = 0;
+	u8 *p;
+
+	/* if errorflag is set do nothing and return 'broken pipe' */
+	if (prng_errorflag)
+		return -EPIPE;
+
+	/* lock prng_data struct */
+	if (mutex_lock_interruptible(&prng_data->mutex))
+		return -ERESTARTSYS;
+
+	while (nbytes) {
+		if (need_resched()) {
+			if (signal_pending(current)) {
+				if (ret == 0)
+					ret = -ERESTARTSYS;
+				break;
+			}
+			/* give mutex free before calling schedule() */
+			mutex_unlock(&prng_data->mutex);
+			schedule();
+			/* occopy mutex again */
+			if (mutex_lock_interruptible(&prng_data->mutex)) {
+				if (ret == 0)
+					ret = -ERESTARTSYS;
+				return ret;
+			}
+		}
+		if (prng_data->rest) {
+			/* push left over random bytes from the previous read */
+			p = prng_data->buf + prng_chunk_size - prng_data->rest;
+			n = (nbytes < prng_data->rest) ?
+				nbytes : prng_data->rest;
+			prng_data->rest -= n;
+		} else {
+			/* generate one chunk of random bytes into read buf */
+			p = prng_data->buf;
+			n = prng_sha512_generate(p, prng_chunk_size);
+			if (n < 0) {
+				ret = n;
+				break;
+			}
+			if (nbytes < prng_chunk_size) {
+				n = nbytes;
+				prng_data->rest = prng_chunk_size - n;
+			} else {
+				n = prng_chunk_size;
+				prng_data->rest = 0;
+			}
+		}
+		if (copy_to_user(ubuf, p, n)) {
+			ret = -EFAULT;
+			break;
+		}
+		ubuf += n;
+		nbytes -= n;
+		ret += n;
+	}
+
+	/* unlock prng_data struct */
+	mutex_unlock(&prng_data->mutex);
+
+	return ret;
+}
+
+
+/*** sysfs stuff ***/
+
+static const struct file_operations prng_sha512_fops = {
+	.owner		= THIS_MODULE,
+	.open		= &prng_open,
+	.release	= NULL,
+	.read		= &prng_sha512_read,
+	.llseek		= noop_llseek,
+};
+static const struct file_operations prng_tdes_fops = {
 	.owner		= THIS_MODULE,
 	.open		= &prng_open,
 	.release	= NULL,
-	.read		= &prng_read,
+	.read		= &prng_tdes_read,
 	.llseek		= noop_llseek,
 };
 
-static struct miscdevice prng_dev = {
+static struct miscdevice prng_sha512_dev = {
+	.name	= "prandom",
+	.minor	= MISC_DYNAMIC_MINOR,
+	.fops	= &prng_sha512_fops,
+};
+static struct miscdevice prng_tdes_dev = {
 	.name	= "prandom",
 	.minor	= MISC_DYNAMIC_MINOR,
-	.fops	= &prng_fops,
+	.fops	= &prng_tdes_fops,
 };
 
+
+/* chunksize attribute (ro) */
+static ssize_t prng_chunksize_show(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%u\n", prng_chunk_size);
+}
+static DEVICE_ATTR(chunksize, 0444, prng_chunksize_show, NULL);
+
+/* counter attribute (ro) */
+static ssize_t prng_counter_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	u64 counter;
+
+	if (mutex_lock_interruptible(&prng_data->mutex))
+		return -ERESTARTSYS;
+	if (prng_mode == PRNG_MODE_SHA512)
+		counter = prng_data->ppnows.stream_bytes;
+	else
+		counter = prng_data->prngws.byte_counter;
+	mutex_unlock(&prng_data->mutex);
+
+	return snprintf(buf, PAGE_SIZE, "%llu\n", counter);
+}
+static DEVICE_ATTR(byte_counter, 0444, prng_counter_show, NULL);
+
+/* errorflag attribute (ro) */
+static ssize_t prng_errorflag_show(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n", prng_errorflag);
+}
+static DEVICE_ATTR(errorflag, 0444, prng_errorflag_show, NULL);
+
+/* mode attribute (ro) */
+static ssize_t prng_mode_show(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	if (prng_mode == PRNG_MODE_TDES)
+		return snprintf(buf, PAGE_SIZE, "TDES\n");
+	else
+		return snprintf(buf, PAGE_SIZE, "SHA512\n");
+}
+static DEVICE_ATTR(mode, 0444, prng_mode_show, NULL);
+
+/* reseed attribute (w) */
+static ssize_t prng_reseed_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	if (mutex_lock_interruptible(&prng_data->mutex))
+		return -ERESTARTSYS;
+	prng_sha512_reseed();
+	mutex_unlock(&prng_data->mutex);
+
+	return count;
+}
+static DEVICE_ATTR(reseed, 0200, NULL, prng_reseed_store);
+
+/* reseed limit attribute (rw) */
+static ssize_t prng_reseed_limit_show(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%u\n", prng_reseed_limit);
+}
+static ssize_t prng_reseed_limit_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t count)
+{
+	unsigned limit;
+
+	if (sscanf(buf, "%u\n", &limit) != 1)
+		return -EINVAL;
+
+	if (prng_mode == PRNG_MODE_SHA512) {
+		if (limit < PRNG_RESEED_LIMIT_SHA512_LOWER)
+			return -EINVAL;
+	} else {
+		if (limit < PRNG_RESEED_LIMIT_TDES_LOWER)
+			return -EINVAL;
+	}
+
+	prng_reseed_limit = limit;
+
+	return count;
+}
+static DEVICE_ATTR(reseed_limit, 0644,
+		   prng_reseed_limit_show, prng_reseed_limit_store);
+
+/* strength attribute (ro) */
+static ssize_t prng_strength_show(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "256\n");
+}
+static DEVICE_ATTR(strength, 0444, prng_strength_show, NULL);
+
+static struct attribute *prng_sha512_dev_attrs[] = {
+	&dev_attr_errorflag.attr,
+	&dev_attr_chunksize.attr,
+	&dev_attr_byte_counter.attr,
+	&dev_attr_mode.attr,
+	&dev_attr_reseed.attr,
+	&dev_attr_reseed_limit.attr,
+	&dev_attr_strength.attr,
+	NULL
+};
+static struct attribute *prng_tdes_dev_attrs[] = {
+	&dev_attr_chunksize.attr,
+	&dev_attr_byte_counter.attr,
+	&dev_attr_mode.attr,
+	NULL
+};
+
+static struct attribute_group prng_sha512_dev_attr_group = {
+	.attrs = prng_sha512_dev_attrs
+};
+static struct attribute_group prng_tdes_dev_attr_group = {
+	.attrs = prng_tdes_dev_attrs
+};
+
+
+/*** module init and exit ***/
+
 static int __init prng_init(void)
 {
 	int ret;
@@ -169,43 +815,105 @@ static int __init prng_init(void)
 	if (!crypt_s390_func_available(KMC_PRNG, CRYPT_S390_MSA))
 		return -EOPNOTSUPP;
 
-	if (prng_chunk_size < 8)
-		return -EINVAL;
+	/* choose prng mode */
+	if (prng_mode != PRNG_MODE_TDES) {
+		/* check for MSA5 support for PPNO operations */
+		if (!crypt_s390_func_available(PPNO_SHA512_DRNG_GEN,
+					       CRYPT_S390_MSA5)) {
+			if (prng_mode == PRNG_MODE_SHA512) {
+				pr_err("The prng module cannot "
+				       "start in SHA-512 mode\n");
+				return -EOPNOTSUPP;
+			}
+			prng_mode = PRNG_MODE_TDES;
+		} else
+			prng_mode = PRNG_MODE_SHA512;
+	}
 
-	p = kmalloc(sizeof(struct s390_prng_data), GFP_KERNEL);
-	if (!p)
-		return -ENOMEM;
-	p->count = 0;
+	if (prng_mode == PRNG_MODE_SHA512) {
 
-	p->buf = kmalloc(prng_chunk_size, GFP_KERNEL);
-	if (!p->buf) {
-		ret = -ENOMEM;
-		goto out_free;
-	}
+		/* SHA512 mode */
 
-	/* initialize the PRNG, add 128 bits of entropy */
-	prng_seed(16);
+		if (prng_chunk_size < PRNG_CHUNKSIZE_SHA512_MIN
+		    || prng_chunk_size > PRNG_CHUNKSIZE_SHA512_MAX)
+			return -EINVAL;
+		prng_chunk_size = (prng_chunk_size + 0x3f) & ~0x3f;
 
-	ret = misc_register(&prng_dev);
-	if (ret)
-		goto out_buf;
-	return 0;
+		if (prng_reseed_limit == 0)
+			prng_reseed_limit = PRNG_RESEED_LIMIT_SHA512;
+		else if (prng_reseed_limit < PRNG_RESEED_LIMIT_SHA512_LOWER)
+			return -EINVAL;
+
+		ret = prng_sha512_instantiate();
+		if (ret)
+			goto out;
+
+		ret = misc_register(&prng_sha512_dev);
+		if (ret) {
+			prng_sha512_deinstantiate();
+			goto out;
+		}
+		ret = sysfs_create_group(&prng_sha512_dev.this_device->kobj,
+					 &prng_sha512_dev_attr_group);
+		if (ret) {
+			misc_deregister(&prng_sha512_dev);
+			prng_sha512_deinstantiate();
+			goto out;
+		}
 
-out_buf:
-	kfree(p->buf);
-out_free:
-	kfree(p);
+	} else {
+
+		/* TDES mode */
+
+		if (prng_chunk_size < PRNG_CHUNKSIZE_TDES_MIN
+		    || prng_chunk_size > PRNG_CHUNKSIZE_TDES_MAX)
+			return -EINVAL;
+		prng_chunk_size = (prng_chunk_size + 0x07) & ~0x07;
+
+		if (prng_reseed_limit == 0)
+			prng_reseed_limit = PRNG_RESEED_LIMIT_TDES;
+		else if (prng_reseed_limit < PRNG_RESEED_LIMIT_TDES_LOWER)
+			return -EINVAL;
+
+		ret = prng_tdes_instantiate();
+		if (ret)
+			goto out;
+
+		ret = misc_register(&prng_tdes_dev);
+		if (ret) {
+			prng_tdes_deinstantiate();
+			goto out;
+		}
+		ret = sysfs_create_group(&prng_tdes_dev.this_device->kobj,
+					 &prng_tdes_dev_attr_group);
+		if (ret) {
+			misc_deregister(&prng_tdes_dev);
+			prng_tdes_deinstantiate();
+			goto out;
+		}
+
+	}
+
+out:
 	return ret;
 }
 
+
 static void __exit prng_exit(void)
 {
-	/* wipe me */
-	kzfree(p->buf);
-	kfree(p);
-
-	misc_deregister(&prng_dev);
+	if (prng_mode == PRNG_MODE_SHA512) {
+		sysfs_remove_group(&prng_sha512_dev.this_device->kobj,
+				   &prng_sha512_dev_attr_group);
+		misc_deregister(&prng_sha512_dev);
+		prng_sha512_deinstantiate();
+	} else {
+		sysfs_remove_group(&prng_tdes_dev.this_device->kobj,
+				   &prng_tdes_dev_attr_group);
+		misc_deregister(&prng_tdes_dev);
+		prng_tdes_deinstantiate();
+	}
 }
 
+
 module_init(prng_init);
 module_exit(prng_exit);
diff --git a/arch/s390/include/asm/mmu.h b/arch/s390/include/asm/mmu.h
index a5e6562..d29ad95 100644
--- a/arch/s390/include/asm/mmu.h
+++ b/arch/s390/include/asm/mmu.h
@@ -14,7 +14,9 @@ typedef struct {
 	unsigned long asce_bits;
 	unsigned long asce_limit;
 	unsigned long vdso_base;
-	/* The mmu context has extended page tables. */
+	/* The mmu context allocates 4K page tables. */
+	unsigned int alloc_pgste:1;
+	/* The mmu context uses extended page tables. */
 	unsigned int has_pgste:1;
 	/* The mmu context uses storage keys. */
 	unsigned int use_skey:1;
diff --git a/arch/s390/include/asm/mmu_context.h b/arch/s390/include/asm/mmu_context.h
index d25d9ff..fb1b93e 100644
--- a/arch/s390/include/asm/mmu_context.h
+++ b/arch/s390/include/asm/mmu_context.h
@@ -20,8 +20,11 @@ static inline int init_new_context(struct task_struct *tsk,
 	mm->context.flush_mm = 0;
 	mm->context.asce_bits = _ASCE_TABLE_LENGTH | _ASCE_USER_BITS;
 	mm->context.asce_bits |= _ASCE_TYPE_REGION3;
+#ifdef CONFIG_PGSTE
+	mm->context.alloc_pgste = page_table_allocate_pgste;
 	mm->context.has_pgste = 0;
 	mm->context.use_skey = 0;
+#endif
 	mm->context.asce_limit = STACK_TOP_MAX;
 	crst_table_init((unsigned long *) mm->pgd, pgd_entry_type(mm));
 	return 0;
diff --git a/arch/s390/include/asm/pgalloc.h b/arch/s390/include/asm/pgalloc.h
index 51e7fb6..7b7858f 100644
--- a/arch/s390/include/asm/pgalloc.h
+++ b/arch/s390/include/asm/pgalloc.h
@@ -21,6 +21,7 @@ void crst_table_free(struct mm_struct *, unsigned long *);
 unsigned long *page_table_alloc(struct mm_struct *);
 void page_table_free(struct mm_struct *, unsigned long *);
 void page_table_free_rcu(struct mmu_gather *, unsigned long *, unsigned long);
+extern int page_table_allocate_pgste;
 
 int set_guest_storage_key(struct mm_struct *mm, unsigned long addr,
 			  unsigned long key, bool nq);
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 989cfae..fc64239 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -12,12 +12,9 @@
 #define _ASM_S390_PGTABLE_H
 
 /*
- * The Linux memory management assumes a three-level page table setup. For
- * s390 31 bit we "fold" the mid level into the top-level page table, so
- * that we physically have the same two-level page table as the s390 mmu
- * expects in 31 bit mode. For s390 64 bit we use three of the five levels
- * the hardware provides (region first and region second tables are not
- * used).
+ * The Linux memory management assumes a three-level page table setup.
+ * For s390 64 bit we use up to four of the five levels the hardware
+ * provides (region first tables are not used).
  *
  * The "pgd_xxx()" functions are trivial for a folded two-level
  * setup: the pgd is never bad, and a pmd always exists (as it's folded
@@ -101,8 +98,8 @@ extern unsigned long zero_page_mask;
 
 #ifndef __ASSEMBLY__
 /*
- * The vmalloc and module area will always be on the topmost area of the kernel
- * mapping. We reserve 96MB (31bit) / 128GB (64bit) for vmalloc and modules.
+ * The vmalloc and module area will always be on the topmost area of the
+ * kernel mapping. We reserve 128GB (64bit) for vmalloc and modules.
  * On 64 bit kernels we have a 2GB area at the top of the vmalloc area where
  * modules will reside. That makes sure that inter module branches always
  * happen without trampolines and in addition the placement within a 2GB frame
@@ -131,38 +128,6 @@ static inline int is_module_addr(void *addr)
 }
 
 /*
- * A 31 bit pagetable entry of S390 has following format:
- *  |   PFRA          |    |  OS  |
- * 0                   0IP0
- * 00000000001111111111222222222233
- * 01234567890123456789012345678901
- *
- * I Page-Invalid Bit:    Page is not available for address-translation
- * P Page-Protection Bit: Store access not possible for page
- *
- * A 31 bit segmenttable entry of S390 has following format:
- *  |   P-table origin      |  |PTL
- * 0                         IC
- * 00000000001111111111222222222233
- * 01234567890123456789012345678901
- *
- * I Segment-Invalid Bit:    Segment is not available for address-translation
- * C Common-Segment Bit:     Segment is not private (PoP 3-30)
- * PTL Page-Table-Length:    Page-table length (PTL+1*16 entries -> up to 256)
- *
- * The 31 bit segmenttable origin of S390 has following format:
- *
- *  |S-table origin   |     | STL |
- * X                   **GPS
- * 00000000001111111111222222222233
- * 01234567890123456789012345678901
- *
- * X Space-Switch event:
- * G Segment-Invalid Bit:     *
- * P Private-Space Bit:       Segment is not private (PoP 3-30)
- * S Storage-Alteration:
- * STL Segment-Table-Length:  Segment-table length (STL+1*16 entries -> up to 2048)
- *
  * A 64 bit pagetable entry of S390 has following format:
  * |			 PFRA			      |0IPC|  OS  |
  * 0000000000111111111122222222223333333333444444444455555555556666
@@ -220,7 +185,6 @@ static inline int is_module_addr(void *addr)
 
 /* Software bits in the page table entry */
 #define _PAGE_PRESENT	0x001		/* SW pte present bit */
-#define _PAGE_TYPE	0x002		/* SW pte type bit */
 #define _PAGE_YOUNG	0x004		/* SW pte young bit */
 #define _PAGE_DIRTY	0x008		/* SW pte dirty bit */
 #define _PAGE_READ	0x010		/* SW pte read bit */
@@ -240,31 +204,34 @@ static inline int is_module_addr(void *addr)
  * table lock held.
  *
  * The following table gives the different possible bit combinations for
- * the pte hardware and software bits in the last 12 bits of a pte:
+ * the pte hardware and software bits in the last 12 bits of a pte
+ * (. unassigned bit, x don't care, t swap type):
  *
  *				842100000000
  *				000084210000
  *				000000008421
- *				.IR...wrdytp
- * empty			.10...000000
- * swap				.10...xxxx10
- * file				.11...xxxxx0
- * prot-none, clean, old	.11...000001
- * prot-none, clean, young	.11...000101
- * prot-none, dirty, old	.10...001001
- * prot-none, dirty, young	.10...001101
- * read-only, clean, old	.11...010001
- * read-only, clean, young	.01...010101
- * read-only, dirty, old	.11...011001
- * read-only, dirty, young	.01...011101
- * read-write, clean, old	.11...110001
- * read-write, clean, young	.01...110101
- * read-write, dirty, old	.10...111001
- * read-write, dirty, young	.00...111101
+ *				.IR.uswrdy.p
+ * empty			.10.00000000
+ * swap				.11..ttttt.0
+ * prot-none, clean, old	.11.xx0000.1
+ * prot-none, clean, young	.11.xx0001.1
+ * prot-none, dirty, old	.10.xx0010.1
+ * prot-none, dirty, young	.10.xx0011.1
+ * read-only, clean, old	.11.xx0100.1
+ * read-only, clean, young	.01.xx0101.1
+ * read-only, dirty, old	.11.xx0110.1
+ * read-only, dirty, young	.01.xx0111.1
+ * read-write, clean, old	.11.xx1100.1
+ * read-write, clean, young	.01.xx1101.1
+ * read-write, dirty, old	.10.xx1110.1
+ * read-write, dirty, young	.00.xx1111.1
+ * HW-bits: R read-only, I invalid
+ * SW-bits: p present, y young, d dirty, r read, w write, s special,
+ *	    u unused, l large
  *
- * pte_present is true for the bit pattern .xx...xxxxx1, (pte & 0x001) == 0x001
- * pte_none    is true for the bit pattern .10...xxxx00, (pte & 0x603) == 0x400
- * pte_swap    is true for the bit pattern .10...xxxx10, (pte & 0x603) == 0x402
+ * pte_none    is true for the bit pattern .10.00000000, pte == 0x400
+ * pte_swap    is true for the bit pattern .11..ooooo.0, (pte & 0x201) == 0x200
+ * pte_present is true for the bit pattern .xx.xxxxxx.1, (pte & 0x001) == 0x001
  */
 
 /* Bits in the segment/region table address-space-control-element */
@@ -335,6 +302,8 @@ static inline int is_module_addr(void *addr)
  * read-write, dirty, young	11..0...0...11
  * The segment table origin is used to distinguish empty (origin==0) from
  * read-write, old segment table entries (origin!=0)
+ * HW-bits: R read-only, I invalid
+ * SW-bits: y young, d dirty, r read, w write
  */
 
 #define _SEGMENT_ENTRY_SPLIT_BIT 11	/* THP splitting bit number */
@@ -423,6 +392,15 @@ static inline int mm_has_pgste(struct mm_struct *mm)
 	return 0;
 }
 
+static inline int mm_alloc_pgste(struct mm_struct *mm)
+{
+#ifdef CONFIG_PGSTE
+	if (unlikely(mm->context.alloc_pgste))
+		return 1;
+#endif
+	return 0;
+}
+
 /*
  * In the case that a guest uses storage keys
  * faults should no longer be backed by zero pages
@@ -582,10 +560,9 @@ static inline int pte_none(pte_t pte)
 
 static inline int pte_swap(pte_t pte)
 {
-	/* Bit pattern: (pte & 0x603) == 0x402 */
-	return (pte_val(pte) & (_PAGE_INVALID | _PAGE_PROTECT |
-				_PAGE_TYPE | _PAGE_PRESENT))
-		== (_PAGE_INVALID | _PAGE_TYPE);
+	/* Bit pattern: (pte & 0x201) == 0x200 */
+	return (pte_val(pte) & (_PAGE_PROTECT | _PAGE_PRESENT))
+		== _PAGE_PROTECT;
 }
 
 static inline int pte_special(pte_t pte)
@@ -1586,51 +1563,51 @@ static inline int has_transparent_hugepage(void)
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 /*
- * 31 bit swap entry format:
- * A page-table entry has some bits we have to treat in a special way.
- * Bits 0, 20 and bit 23 have to be zero, otherwise an specification
- * exception will occur instead of a page translation exception. The
- * specifiation exception has the bad habit not to store necessary
- * information in the lowcore.
- * Bits 21, 22, 30 and 31 are used to indicate the page type.
- * A swap pte is indicated by bit pattern (pte & 0x603) == 0x402
- * This leaves the bits 1-19 and bits 24-29 to store type and offset.
- * We use the 5 bits from 25-29 for the type and the 20 bits from 1-19
- * plus 24 for the offset.
- * 0|     offset        |0110|o|type |00|
- * 0 0000000001111111111 2222 2 22222 33
- * 0 1234567890123456789 0123 4 56789 01
- *
  * 64 bit swap entry format:
  * A page-table entry has some bits we have to treat in a special way.
  * Bits 52 and bit 55 have to be zero, otherwise an specification
  * exception will occur instead of a page translation exception. The
  * specifiation exception has the bad habit not to store necessary
  * information in the lowcore.
- * Bits 53, 54, 62 and 63 are used to indicate the page type.
- * A swap pte is indicated by bit pattern (pte & 0x603) == 0x402
- * This leaves the bits 0-51 and bits 56-61 to store type and offset.
- * We use the 5 bits from 57-61 for the type and the 53 bits from 0-51
- * plus 56 for the offset.
- * |                      offset                        |0110|o|type |00|
- *  0000000000111111111122222222223333333333444444444455 5555 5 55566 66
- *  0123456789012345678901234567890123456789012345678901 2345 6 78901 23
+ * Bits 54 and 63 are used to indicate the page type.
+ * A swap pte is indicated by bit pattern (pte & 0x201) == 0x200
+ * This leaves the bits 0-51 and bits 56-62 to store type and offset.
+ * We use the 5 bits from 57-61 for the type and the 52 bits from 0-51
+ * for the offset.
+ * |			  offset			|01100|type |00|
+ * |0000000000111111111122222222223333333333444444444455|55555|55566|66|
+ * |0123456789012345678901234567890123456789012345678901|23456|78901|23|
  */
 
-#define __SWP_OFFSET_MASK (~0UL >> 11)
+#define __SWP_OFFSET_MASK	((1UL << 52) - 1)
+#define __SWP_OFFSET_SHIFT	12
+#define __SWP_TYPE_MASK		((1UL << 5) - 1)
+#define __SWP_TYPE_SHIFT	2
 
 static inline pte_t mk_swap_pte(unsigned long type, unsigned long offset)
 {
 	pte_t pte;
-	offset &= __SWP_OFFSET_MASK;
-	pte_val(pte) = _PAGE_INVALID | _PAGE_TYPE | ((type & 0x1f) << 2) |
-		((offset & 1UL) << 7) | ((offset & ~1UL) << 11);
+
+	pte_val(pte) = _PAGE_INVALID | _PAGE_PROTECT;
+	pte_val(pte) |= (offset & __SWP_OFFSET_MASK) << __SWP_OFFSET_SHIFT;
+	pte_val(pte) |= (type & __SWP_TYPE_MASK) << __SWP_TYPE_SHIFT;
 	return pte;
 }
 
-#define __swp_type(entry)	(((entry).val >> 2) & 0x1f)
-#define __swp_offset(entry)	(((entry).val >> 11) | (((entry).val >> 7) & 1))
-#define __swp_entry(type,offset) ((swp_entry_t) { pte_val(mk_swap_pte((type),(offset))) })
+static inline unsigned long __swp_type(swp_entry_t entry)
+{
+	return (entry.val >> __SWP_TYPE_SHIFT) & __SWP_TYPE_MASK;
+}
+
+static inline unsigned long __swp_offset(swp_entry_t entry)
+{
+	return (entry.val >> __SWP_OFFSET_SHIFT) & __SWP_OFFSET_MASK;
+}
+
+static inline swp_entry_t __swp_entry(unsigned long type, unsigned long offset)
+{
+	return (swp_entry_t) { pte_val(mk_swap_pte(type, offset)) };
+}
 
 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)	((pte_t) { (x).val })
diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
index 210ffed..e617e74 100644
--- a/arch/s390/mm/hugetlbpage.c
+++ b/arch/s390/mm/hugetlbpage.c
@@ -14,20 +14,23 @@ static inline pmd_t __pte_to_pmd(pte_t pte)
 
 	/*
 	 * Convert encoding		  pte bits	   pmd bits
-	 *				.IR...wrdytp	dy..R...I...wr
-	 * empty			.10...000000 -> 00..0...1...00
-	 * prot-none, clean, old	.11...000001 -> 00..1...1...00
-	 * prot-none, clean, young	.11...000101 -> 01..1...1...00
-	 * prot-none, dirty, old	.10...001001 -> 10..1...1...00
-	 * prot-none, dirty, young	.10...001101 -> 11..1...1...00
-	 * read-only, clean, old	.11...010001 -> 00..1...1...01
-	 * read-only, clean, young	.01...010101 -> 01..1...0...01
-	 * read-only, dirty, old	.11...011001 -> 10..1...1...01
-	 * read-only, dirty, young	.01...011101 -> 11..1...0...01
-	 * read-write, clean, old	.11...110001 -> 00..0...1...11
-	 * read-write, clean, young	.01...110101 -> 01..0...0...11
-	 * read-write, dirty, old	.10...111001 -> 10..0...1...11
-	 * read-write, dirty, young	.00...111101 -> 11..0...0...11
+	 *				lIR.uswrdy.p	dy..R...I...wr
+	 * empty			010.000000.0 -> 00..0...1...00
+	 * prot-none, clean, old	111.000000.1 -> 00..1...1...00
+	 * prot-none, clean, young	111.000001.1 -> 01..1...1...00
+	 * prot-none, dirty, old	111.000010.1 -> 10..1...1...00
+	 * prot-none, dirty, young	111.000011.1 -> 11..1...1...00
+	 * read-only, clean, old	111.000100.1 -> 00..1...1...01
+	 * read-only, clean, young	101.000101.1 -> 01..1...0...01
+	 * read-only, dirty, old	111.000110.1 -> 10..1...1...01
+	 * read-only, dirty, young	101.000111.1 -> 11..1...0...01
+	 * read-write, clean, old	111.001100.1 -> 00..1...1...11
+	 * read-write, clean, young	101.001101.1 -> 01..1...0...11
+	 * read-write, dirty, old	110.001110.1 -> 10..0...1...11
+	 * read-write, dirty, young	100.001111.1 -> 11..0...0...11
+	 * HW-bits: R read-only, I invalid
+	 * SW-bits: p present, y young, d dirty, r read, w write, s special,
+	 *	    u unused, l large
 	 */
 	if (pte_present(pte)) {
 		pmd_val(pmd) = pte_val(pte) & PAGE_MASK;
@@ -48,20 +51,23 @@ static inline pte_t __pmd_to_pte(pmd_t pmd)
 
 	/*
 	 * Convert encoding		   pmd bits	    pte bits
-	 *				dy..R...I...wr	  .IR...wrdytp
-	 * empty			00..0...1...00 -> .10...001100
-	 * prot-none, clean, old	00..0...1...00 -> .10...000001
-	 * prot-none, clean, young	01..0...1...00 -> .10...000101
-	 * prot-none, dirty, old	10..0...1...00 -> .10...001001
-	 * prot-none, dirty, young	11..0...1...00 -> .10...001101
-	 * read-only, clean, old	00..1...1...01 -> .11...010001
-	 * read-only, clean, young	01..1...1...01 -> .11...010101
-	 * read-only, dirty, old	10..1...1...01 -> .11...011001
-	 * read-only, dirty, young	11..1...1...01 -> .11...011101
-	 * read-write, clean, old	00..0...1...11 -> .10...110001
-	 * read-write, clean, young	01..0...1...11 -> .10...110101
-	 * read-write, dirty, old	10..0...1...11 -> .10...111001
-	 * read-write, dirty, young	11..0...1...11 -> .10...111101
+	 *				dy..R...I...wr	  lIR.uswrdy.p
+	 * empty			00..0...1...00 -> 010.000000.0
+	 * prot-none, clean, old	00..1...1...00 -> 111.000000.1
+	 * prot-none, clean, young	01..1...1...00 -> 111.000001.1
+	 * prot-none, dirty, old	10..1...1...00 -> 111.000010.1
+	 * prot-none, dirty, young	11..1...1...00 -> 111.000011.1
+	 * read-only, clean, old	00..1...1...01 -> 111.000100.1
+	 * read-only, clean, young	01..1...0...01 -> 101.000101.1
+	 * read-only, dirty, old	10..1...1...01 -> 111.000110.1
+	 * read-only, dirty, young	11..1...0...01 -> 101.000111.1
+	 * read-write, clean, old	00..1...1...11 -> 111.001100.1
+	 * read-write, clean, young	01..1...0...11 -> 101.001101.1
+	 * read-write, dirty, old	10..0...1...11 -> 110.001110.1
+	 * read-write, dirty, young	11..0...0...11 -> 100.001111.1
+	 * HW-bits: R read-only, I invalid
+	 * SW-bits: p present, y young, d dirty, r read, w write, s special,
+	 *	    u unused, l large
 	 */
 	if (pmd_present(pmd)) {
 		pte_val(pte) = pmd_val(pmd) & _SEGMENT_ENTRY_ORIGIN_LARGE;
@@ -70,8 +76,8 @@ static inline pte_t __pmd_to_pte(pmd_t pmd)
 		pte_val(pte) |= (pmd_val(pmd) & _SEGMENT_ENTRY_WRITE) << 4;
 		pte_val(pte) |= (pmd_val(pmd) & _SEGMENT_ENTRY_INVALID) << 5;
 		pte_val(pte) |= (pmd_val(pmd) & _SEGMENT_ENTRY_PROTECT);
-		pmd_val(pmd) |= (pte_val(pte) & _PAGE_DIRTY) << 10;
-		pmd_val(pmd) |= (pte_val(pte) & _PAGE_YOUNG) << 10;
+		pte_val(pte) |= (pmd_val(pmd) & _SEGMENT_ENTRY_DIRTY) >> 10;
+		pte_val(pte) |= (pmd_val(pmd) & _SEGMENT_ENTRY_YOUNG) >> 10;
 	} else
 		pte_val(pte) = _PAGE_INVALID;
 	return pte;
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 33f5894..b33f661 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -18,6 +18,7 @@
 #include <linux/rcupdate.h>
 #include <linux/slab.h>
 #include <linux/swapops.h>
+#include <linux/sysctl.h>
 #include <linux/ksm.h>
 #include <linux/mman.h>
 
@@ -920,6 +921,40 @@ unsigned long get_guest_storage_key(struct mm_struct *mm, unsigned long addr)
 }
 EXPORT_SYMBOL(get_guest_storage_key);
 
+static int page_table_allocate_pgste_min = 0;
+static int page_table_allocate_pgste_max = 1;
+int page_table_allocate_pgste = 0;
+EXPORT_SYMBOL(page_table_allocate_pgste);
+
+static struct ctl_table page_table_sysctl[] = {
+	{
+		.procname	= "allocate_pgste",
+		.data		= &page_table_allocate_pgste,
+		.maxlen		= sizeof(int),
+		.mode		= S_IRUGO | S_IWUSR,
+		.proc_handler	= proc_dointvec,
+		.extra1		= &page_table_allocate_pgste_min,
+		.extra2		= &page_table_allocate_pgste_max,
+	},
+	{ }
+};
+
+static struct ctl_table page_table_sysctl_dir[] = {
+	{
+		.procname	= "vm",
+		.maxlen		= 0,
+		.mode		= 0555,
+		.child		= page_table_sysctl,
+	},
+	{ }
+};
+
+static int __init page_table_register_sysctl(void)
+{
+	return register_sysctl_table(page_table_sysctl_dir) ? 0 : -ENOMEM;
+}
+__initcall(page_table_register_sysctl);
+
 #else /* CONFIG_PGSTE */
 
 static inline int page_table_with_pgste(struct page *page)
@@ -963,7 +998,7 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
 	struct page *uninitialized_var(page);
 	unsigned int mask, bit;
 
-	if (mm_has_pgste(mm))
+	if (mm_alloc_pgste(mm))
 		return page_table_alloc_pgste(mm);
 	/* Allocate fragments of a 4K page as 1K/2K page table */
 	spin_lock_bh(&mm->context.list_lock);
@@ -1165,116 +1200,25 @@ static inline void thp_split_mm(struct mm_struct *mm)
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
-static unsigned long page_table_realloc_pmd(struct mmu_gather *tlb,
-				struct mm_struct *mm, pud_t *pud,
-				unsigned long addr, unsigned long end)
-{
-	unsigned long next, *table, *new;
-	struct page *page;
-	spinlock_t *ptl;
-	pmd_t *pmd;
-
-	pmd = pmd_offset(pud, addr);
-	do {
-		next = pmd_addr_end(addr, end);
-again:
-		if (pmd_none_or_clear_bad(pmd))
-			continue;
-		table = (unsigned long *) pmd_deref(*pmd);
-		page = pfn_to_page(__pa(table) >> PAGE_SHIFT);
-		if (page_table_with_pgste(page))
-			continue;
-		/* Allocate new page table with pgstes */
-		new = page_table_alloc_pgste(mm);
-		if (!new)
-			return -ENOMEM;
-
-		ptl = pmd_lock(mm, pmd);
-		if (likely((unsigned long *) pmd_deref(*pmd) == table)) {
-			/* Nuke pmd entry pointing to the "short" page table */
-			pmdp_flush_lazy(mm, addr, pmd);
-			pmd_clear(pmd);
-			/* Copy ptes from old table to new table */
-			memcpy(new, table, PAGE_SIZE/2);
-			clear_table(table, _PAGE_INVALID, PAGE_SIZE/2);
-			/* Establish new table */
-			pmd_populate(mm, pmd, (pte_t *) new);
-			/* Free old table with rcu, there might be a walker! */
-			page_table_free_rcu(tlb, table, addr);
-			new = NULL;
-		}
-		spin_unlock(ptl);
-		if (new) {
-			page_table_free_pgste(new);
-			goto again;
-		}
-	} while (pmd++, addr = next, addr != end);
-
-	return addr;
-}
-
-static unsigned long page_table_realloc_pud(struct mmu_gather *tlb,
-				   struct mm_struct *mm, pgd_t *pgd,
-				   unsigned long addr, unsigned long end)
-{
-	unsigned long next;
-	pud_t *pud;
-
-	pud = pud_offset(pgd, addr);
-	do {
-		next = pud_addr_end(addr, end);
-		if (pud_none_or_clear_bad(pud))
-			continue;
-		next = page_table_realloc_pmd(tlb, mm, pud, addr, next);
-		if (unlikely(IS_ERR_VALUE(next)))
-			return next;
-	} while (pud++, addr = next, addr != end);
-
-	return addr;
-}
-
-static unsigned long page_table_realloc(struct mmu_gather *tlb, struct mm_struct *mm,
-					unsigned long addr, unsigned long end)
-{
-	unsigned long next;
-	pgd_t *pgd;
-
-	pgd = pgd_offset(mm, addr);
-	do {
-		next = pgd_addr_end(addr, end);
-		if (pgd_none_or_clear_bad(pgd))
-			continue;
-		next = page_table_realloc_pud(tlb, mm, pgd, addr, next);
-		if (unlikely(IS_ERR_VALUE(next)))
-			return next;
-	} while (pgd++, addr = next, addr != end);
-
-	return 0;
-}
-
 /*
  * switch on pgstes for its userspace process (for kvm)
  */
 int s390_enable_sie(void)
 {
-	struct task_struct *tsk = current;
-	struct mm_struct *mm = tsk->mm;
-	struct mmu_gather tlb;
+	struct mm_struct *mm = current->mm;
 
 	/* Do we have pgstes? if yes, we are done */
-	if (mm_has_pgste(tsk->mm))
+	if (mm_has_pgste(mm))
 		return 0;
-
+	/* Fail if the page tables are 2K */
+	if (!mm_alloc_pgste(mm))
+		return -EINVAL;
 	down_write(&mm->mmap_sem);
+	mm->context.has_pgste = 1;
 	/* split thp mappings and disable thp for future mappings */
 	thp_split_mm(mm);
-	/* Reallocate the page tables with pgstes */
-	tlb_gather_mmu(&tlb, mm, 0, TASK_SIZE);
-	if (!page_table_realloc(&tlb, mm, 0, TASK_SIZE))
-		mm->context.has_pgste = 1;
-	tlb_finish_mmu(&tlb, 0, TASK_SIZE);
 	up_write(&mm->mmap_sem);
-	return mm->context.has_pgste ? 0 : -ENOMEM;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(s390_enable_sie);
 
diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
index c43aca6..0fc3fe5 100644
--- a/drivers/s390/char/con3215.c
+++ b/drivers/s390/char/con3215.c
@@ -667,6 +667,8 @@ static struct raw3215_info *raw3215_alloc_info(void)
 	info->buffer = kzalloc(RAW3215_BUFFER_SIZE, GFP_KERNEL | GFP_DMA);
 	info->inbuf = kzalloc(RAW3215_INBUF_SIZE, GFP_KERNEL | GFP_DMA);
 	if (!info->buffer || !info->inbuf) {
+		kfree(info->inbuf);
+		kfree(info->buffer);
 		kfree(info);
 		return NULL;
 	}
