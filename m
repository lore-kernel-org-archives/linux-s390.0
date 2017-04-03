Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 3 Apr 2017 13:05:45 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.11-rc6
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170403130545.5be6fb53@mschwideX1>
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

Four bug fixes, two of them for stable:

 - Avoid initrd corruptions in the kernel decompressor

 - Prevent inconsistent dumps if the boot CPU does not have address zero

 - Fix the new pkey interface added with the merge window for 4.11

 - A fix for a fix, another issue with user copy zero padding

Harald Freudenberger (1):
      s390/pkey: Fix wrong handling of secure key with old MKVP

Heiko Carstens (2):
      s390/smp: fix ipl from cpu with non-zero address
      s390/uaccess: get_user() should zero on failure (again)

Marcelo Henrique Cerri (1):
      s390/decompressor: fix initrd corruption caused by bss clear

 arch/s390/boot/compressed/misc.c | 35 ++++++++++++++------------
 arch/s390/include/asm/uaccess.h  |  2 +-
 arch/s390/kernel/smp.c           |  5 ++--
 drivers/s390/crypto/pkey_api.c   | 53 ++++++++++++++++++++++++++--------------
 4 files changed, 56 insertions(+), 39 deletions(-)

diff --git a/arch/s390/boot/compressed/misc.c b/arch/s390/boot/compressed/misc.c
index fa95041..33ca293 100644
--- a/arch/s390/boot/compressed/misc.c
+++ b/arch/s390/boot/compressed/misc.c
@@ -141,31 +141,34 @@ static void check_ipl_parmblock(void *start, unsigned long size)
 
 unsigned long decompress_kernel(void)
 {
-	unsigned long output_addr;
-	unsigned char *output;
+	void *output, *kernel_end;
 
-	output_addr = ((unsigned long) &_end + HEAP_SIZE + 4095UL) & -4096UL;
-	check_ipl_parmblock((void *) 0, output_addr + SZ__bss_start);
-	memset(&_bss, 0, &_ebss - &_bss);
-	free_mem_ptr = (unsigned long)&_end;
-	free_mem_end_ptr = free_mem_ptr + HEAP_SIZE;
-	output = (unsigned char *) output_addr;
+	output = (void *) ALIGN((unsigned long) &_end + HEAP_SIZE, PAGE_SIZE);
+	kernel_end = output + SZ__bss_start;
+	check_ipl_parmblock((void *) 0, (unsigned long) kernel_end);
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	/*
 	 * Move the initrd right behind the end of the decompressed
-	 * kernel image.
+	 * kernel image. This also prevents initrd corruption caused by
+	 * bss clearing since kernel_end will always be located behind the
+	 * current bss section..
 	 */
-	if (INITRD_START && INITRD_SIZE &&
-	    INITRD_START < (unsigned long) output + SZ__bss_start) {
-		check_ipl_parmblock(output + SZ__bss_start,
-				    INITRD_START + INITRD_SIZE);
-		memmove(output + SZ__bss_start,
-			(void *) INITRD_START, INITRD_SIZE);
-		INITRD_START = (unsigned long) output + SZ__bss_start;
+	if (INITRD_START && INITRD_SIZE && kernel_end > (void *) INITRD_START) {
+		check_ipl_parmblock(kernel_end, INITRD_SIZE);
+		memmove(kernel_end, (void *) INITRD_START, INITRD_SIZE);
+		INITRD_START = (unsigned long) kernel_end;
 	}
 #endif
 
+	/*
+	 * Clear bss section. free_mem_ptr and free_mem_end_ptr need to be
+	 * initialized afterwards since they reside in bss.
+	 */
+	memset(&_bss, 0, &_ebss - &_bss);
+	free_mem_ptr = (unsigned long) &_end;
+	free_mem_end_ptr = free_mem_ptr + HEAP_SIZE;
+
 	puts("Uncompressing Linux... ");
 	__decompress(input_data, input_len, NULL, NULL, output, 0, NULL, error);
 	puts("Ok, booting the kernel.\n");
diff --git a/arch/s390/include/asm/uaccess.h b/arch/s390/include/asm/uaccess.h
index 136932f..3ea1554 100644
--- a/arch/s390/include/asm/uaccess.h
+++ b/arch/s390/include/asm/uaccess.h
@@ -147,7 +147,7 @@ unsigned long __must_check __copy_to_user(void __user *to, const void *from,
 		"	jg	2b\n"				\
 		".popsection\n"					\
 		EX_TABLE(0b,3b) EX_TABLE(1b,3b)			\
-		: "=d" (__rc), "=Q" (*(to))			\
+		: "=d" (__rc), "+Q" (*(to))			\
 		: "d" (size), "Q" (*(from)),			\
 		  "d" (__reg0), "K" (-EFAULT)			\
 		: "cc");					\
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 47a973b..5dab859 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -909,13 +909,11 @@ void __init smp_prepare_boot_cpu(void)
 {
 	struct pcpu *pcpu = pcpu_devices;
 
+	WARN_ON(!cpu_present(0) || !cpu_online(0));
 	pcpu->state = CPU_STATE_CONFIGURED;
-	pcpu->address = stap();
 	pcpu->lowcore = (struct lowcore *)(unsigned long) store_prefix();
 	S390_lowcore.percpu_offset = __per_cpu_offset[0];
 	smp_cpu_set_polarization(0, POLARIZATION_UNKNOWN);
-	set_cpu_present(0, true);
-	set_cpu_online(0, true);
 }
 
 void __init smp_cpus_done(unsigned int max_cpus)
@@ -924,6 +922,7 @@ void __init smp_cpus_done(unsigned int max_cpus)
 
 void __init smp_setup_processor_id(void)
 {
+	pcpu_devices[0].address = stap();
 	S390_lowcore.cpu_nr = 0;
 	S390_lowcore.spinlock_lockval = arch_spin_lockval(0);
 }
diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
index 40f1136..058db72 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -572,6 +572,12 @@ int pkey_sec2protkey(u16 cardnr, u16 domain,
 		rc = -EIO;
 		goto out;
 	}
+	if (prepcblk->ccp_rscode != 0) {
+		DEBUG_WARN(
+			"pkey_sec2protkey unwrap secure key warning, card response %d/%d\n",
+			(int) prepcblk->ccp_rtcode,
+			(int) prepcblk->ccp_rscode);
+	}
 
 	/* process response cprb param block */
 	prepcblk->rpl_parmb = ((u8 *) prepcblk) + sizeof(struct CPRBX);
@@ -761,9 +767,10 @@ static int query_crypto_facility(u16 cardnr, u16 domain,
 }
 
 /*
- * Fetch just the mkvp value via query_crypto_facility from adapter.
+ * Fetch the current and old mkvp values via
+ * query_crypto_facility from adapter.
  */
-static int fetch_mkvp(u16 cardnr, u16 domain, u64 *mkvp)
+static int fetch_mkvp(u16 cardnr, u16 domain, u64 mkvp[2])
 {
 	int rc, found = 0;
 	size_t rlen, vlen;
@@ -779,9 +786,10 @@ static int fetch_mkvp(u16 cardnr, u16 domain, u64 *mkvp)
 	rc = query_crypto_facility(cardnr, domain, "STATICSA",
 				   rarray, &rlen, varray, &vlen);
 	if (rc == 0 && rlen > 8*8 && vlen > 184+8) {
-		if (rarray[64] == '2') {
+		if (rarray[8*8] == '2') {
 			/* current master key state is valid */
-			*mkvp = *((u64 *)(varray + 184));
+			mkvp[0] = *((u64 *)(varray + 184));
+			mkvp[1] = *((u64 *)(varray + 172));
 			found = 1;
 		}
 	}
@@ -796,14 +804,14 @@ struct mkvp_info {
 	struct list_head list;
 	u16 cardnr;
 	u16 domain;
-	u64 mkvp;
+	u64 mkvp[2];
 };
 
 /* a list with mkvp_info entries */
 static LIST_HEAD(mkvp_list);
 static DEFINE_SPINLOCK(mkvp_list_lock);
 
-static int mkvp_cache_fetch(u16 cardnr, u16 domain, u64 *mkvp)
+static int mkvp_cache_fetch(u16 cardnr, u16 domain, u64 mkvp[2])
 {
 	int rc = -ENOENT;
 	struct mkvp_info *ptr;
@@ -812,7 +820,7 @@ static int mkvp_cache_fetch(u16 cardnr, u16 domain, u64 *mkvp)
 	list_for_each_entry(ptr, &mkvp_list, list) {
 		if (ptr->cardnr == cardnr &&
 		    ptr->domain == domain) {
-			*mkvp = ptr->mkvp;
+			memcpy(mkvp, ptr->mkvp, 2 * sizeof(u64));
 			rc = 0;
 			break;
 		}
@@ -822,7 +830,7 @@ static int mkvp_cache_fetch(u16 cardnr, u16 domain, u64 *mkvp)
 	return rc;
 }
 
-static void mkvp_cache_update(u16 cardnr, u16 domain, u64 mkvp)
+static void mkvp_cache_update(u16 cardnr, u16 domain, u64 mkvp[2])
 {
 	int found = 0;
 	struct mkvp_info *ptr;
@@ -831,7 +839,7 @@ static void mkvp_cache_update(u16 cardnr, u16 domain, u64 mkvp)
 	list_for_each_entry(ptr, &mkvp_list, list) {
 		if (ptr->cardnr == cardnr &&
 		    ptr->domain == domain) {
-			ptr->mkvp = mkvp;
+			memcpy(ptr->mkvp, mkvp, 2 * sizeof(u64));
 			found = 1;
 			break;
 		}
@@ -844,7 +852,7 @@ static void mkvp_cache_update(u16 cardnr, u16 domain, u64 mkvp)
 		}
 		ptr->cardnr = cardnr;
 		ptr->domain = domain;
-		ptr->mkvp = mkvp;
+		memcpy(ptr->mkvp, mkvp, 2 * sizeof(u64));
 		list_add(&ptr->list, &mkvp_list);
 	}
 	spin_unlock_bh(&mkvp_list_lock);
@@ -888,8 +896,8 @@ int pkey_findcard(const struct pkey_seckey *seckey,
 	struct secaeskeytoken *t = (struct secaeskeytoken *) seckey;
 	struct zcrypt_device_matrix *device_matrix;
 	u16 card, dom;
-	u64 mkvp;
-	int i, rc;
+	u64 mkvp[2];
+	int i, rc, oi = -1;
 
 	/* mkvp must not be zero */
 	if (t->mkvp == 0)
@@ -910,14 +918,14 @@ int pkey_findcard(const struct pkey_seckey *seckey,
 		    device_matrix->device[i].functions & 0x04) {
 			/* an enabled CCA Coprocessor card */
 			/* try cached mkvp */
-			if (mkvp_cache_fetch(card, dom, &mkvp) == 0 &&
-			    t->mkvp == mkvp) {
+			if (mkvp_cache_fetch(card, dom, mkvp) == 0 &&
+			    t->mkvp == mkvp[0]) {
 				if (!verify)
 					break;
 				/* verify: fetch mkvp from adapter */
-				if (fetch_mkvp(card, dom, &mkvp) == 0) {
+				if (fetch_mkvp(card, dom, mkvp) == 0) {
 					mkvp_cache_update(card, dom, mkvp);
-					if (t->mkvp == mkvp)
+					if (t->mkvp == mkvp[0])
 						break;
 				}
 			}
@@ -936,14 +944,21 @@ int pkey_findcard(const struct pkey_seckey *seckey,
 			card = AP_QID_CARD(device_matrix->device[i].qid);
 			dom = AP_QID_QUEUE(device_matrix->device[i].qid);
 			/* fresh fetch mkvp from adapter */
-			if (fetch_mkvp(card, dom, &mkvp) == 0) {
+			if (fetch_mkvp(card, dom, mkvp) == 0) {
 				mkvp_cache_update(card, dom, mkvp);
-				if (t->mkvp == mkvp)
+				if (t->mkvp == mkvp[0])
 					break;
+				if (t->mkvp == mkvp[1] && oi < 0)
+					oi = i;
 			}
 		}
+		if (i >= MAX_ZDEV_ENTRIES && oi >= 0) {
+			/* old mkvp matched, use this card then */
+			card = AP_QID_CARD(device_matrix->device[oi].qid);
+			dom = AP_QID_QUEUE(device_matrix->device[oi].qid);
+		}
 	}
-	if (i < MAX_ZDEV_ENTRIES) {
+	if (i < MAX_ZDEV_ENTRIES || oi >= 0) {
 		if (pcardnr)
 			*pcardnr = card;
 		if (pdomain)
