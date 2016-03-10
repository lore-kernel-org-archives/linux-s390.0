Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 10 Mar 2016 09:41:46 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.5-rc7
Message-ID: <20160310094146.26382ed8@mschwide>
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

Three bug fixes:
 - The fix for the page table corruption (CVE-2016-2143)
 - The diagnose statistics introduced a regression for the dasd diag driver
 - Boot crash on systems without the set-program-parameters facility

Christian Borntraeger (1):
      s390/cpumf: Fix lpp detection

Heiko Carstens (1):
      s390/dasd: fix diag 0x250 inline assembly

Martin Schwidefsky (1):
      s390/mm: four page table levels vs. fork

 arch/s390/include/asm/mmu_context.h | 16 +++++++++++-----
 arch/s390/include/asm/pgalloc.h     | 24 +++++++++++++++++++-----
 arch/s390/kernel/head64.S           |  2 +-
 drivers/s390/block/dasd_diag.c      |  9 +++++++--
 4 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/arch/s390/include/asm/mmu_context.h b/arch/s390/include/asm/mmu_context.h
index fb1b93e..e485817 100644
--- a/arch/s390/include/asm/mmu_context.h
+++ b/arch/s390/include/asm/mmu_context.h
@@ -15,17 +15,25 @@
 static inline int init_new_context(struct task_struct *tsk,
 				   struct mm_struct *mm)
 {
+	spin_lock_init(&mm->context.list_lock);
+	INIT_LIST_HEAD(&mm->context.pgtable_list);
+	INIT_LIST_HEAD(&mm->context.gmap_list);
 	cpumask_clear(&mm->context.cpu_attach_mask);
 	atomic_set(&mm->context.attach_count, 0);
 	mm->context.flush_mm = 0;
-	mm->context.asce_bits = _ASCE_TABLE_LENGTH | _ASCE_USER_BITS;
-	mm->context.asce_bits |= _ASCE_TYPE_REGION3;
 #ifdef CONFIG_PGSTE
 	mm->context.alloc_pgste = page_table_allocate_pgste;
 	mm->context.has_pgste = 0;
 	mm->context.use_skey = 0;
 #endif
-	mm->context.asce_limit = STACK_TOP_MAX;
+	if (mm->context.asce_limit == 0) {
+		/* context created by exec, set asce limit to 4TB */
+		mm->context.asce_bits = _ASCE_TABLE_LENGTH |
+			_ASCE_USER_BITS | _ASCE_TYPE_REGION3;
+		mm->context.asce_limit = STACK_TOP_MAX;
+	} else if (mm->context.asce_limit == (1UL << 31)) {
+		mm_inc_nr_pmds(mm);
+	}
 	crst_table_init((unsigned long *) mm->pgd, pgd_entry_type(mm));
 	return 0;
 }
@@ -111,8 +119,6 @@ static inline void activate_mm(struct mm_struct *prev,
 static inline void arch_dup_mmap(struct mm_struct *oldmm,
 				 struct mm_struct *mm)
 {
-	if (oldmm->context.asce_limit < mm->context.asce_limit)
-		crst_table_downgrade(mm, oldmm->context.asce_limit);
 }
 
 static inline void arch_exit_mmap(struct mm_struct *mm)
diff --git a/arch/s390/include/asm/pgalloc.h b/arch/s390/include/asm/pgalloc.h
index 7b7858f..d7cc79f 100644
--- a/arch/s390/include/asm/pgalloc.h
+++ b/arch/s390/include/asm/pgalloc.h
@@ -100,12 +100,26 @@ static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
-	spin_lock_init(&mm->context.list_lock);
-	INIT_LIST_HEAD(&mm->context.pgtable_list);
-	INIT_LIST_HEAD(&mm->context.gmap_list);
-	return (pgd_t *) crst_table_alloc(mm);
+	unsigned long *table = crst_table_alloc(mm);
+
+	if (!table)
+		return NULL;
+	if (mm->context.asce_limit == (1UL << 31)) {
+		/* Forking a compat process with 2 page table levels */
+		if (!pgtable_pmd_page_ctor(virt_to_page(table))) {
+			crst_table_free(mm, table);
+			return NULL;
+		}
+	}
+	return (pgd_t *) table;
+}
+
+static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
+{
+	if (mm->context.asce_limit == (1UL << 31))
+		pgtable_pmd_page_dtor(virt_to_page(pgd));
+	crst_table_free(mm, (unsigned long *) pgd);
 }
-#define pgd_free(mm, pgd) crst_table_free(mm, (unsigned long *) pgd)
 
 static inline void pmd_populate(struct mm_struct *mm,
 				pmd_t *pmd, pgtable_t pte)
diff --git a/arch/s390/kernel/head64.S b/arch/s390/kernel/head64.S
index c5febe8..03c2b46 100644
--- a/arch/s390/kernel/head64.S
+++ b/arch/s390/kernel/head64.S
@@ -16,7 +16,7 @@
 
 __HEAD
 ENTRY(startup_continue)
-	tm	__LC_STFLE_FAC_LIST+6,0x80	# LPP available ?
+	tm	__LC_STFLE_FAC_LIST+5,0x80	# LPP available ?
 	jz	0f
 	xc	__LC_LPP+1(7,0),__LC_LPP+1	# clear lpp and current_pid
 	mvi	__LC_LPP,0x80			#   and set LPP_MAGIC
diff --git a/drivers/s390/block/dasd_diag.c b/drivers/s390/block/dasd_diag.c
index cb61f30..277b5c8 100644
--- a/drivers/s390/block/dasd_diag.c
+++ b/drivers/s390/block/dasd_diag.c
@@ -67,7 +67,7 @@ static const u8 DASD_DIAG_CMS1[] = { 0xc3, 0xd4, 0xe2, 0xf1 };/* EBCDIC CMS1 */
  * and function code cmd.
  * In case of an exception return 3. Otherwise return result of bitwise OR of
  * resulting condition code and DIAG return code. */
-static inline int dia250(void *iob, int cmd)
+static inline int __dia250(void *iob, int cmd)
 {
 	register unsigned long reg2 asm ("2") = (unsigned long) iob;
 	typedef union {
@@ -77,7 +77,6 @@ static inline int dia250(void *iob, int cmd)
 	int rc;
 
 	rc = 3;
-	diag_stat_inc(DIAG_STAT_X250);
 	asm volatile(
 		"	diag	2,%2,0x250\n"
 		"0:	ipm	%0\n"
@@ -91,6 +90,12 @@ static inline int dia250(void *iob, int cmd)
 	return rc;
 }
 
+static inline int dia250(void *iob, int cmd)
+{
+	diag_stat_inc(DIAG_STAT_X250);
+	return __dia250(iob, cmd);
+}
+
 /* Initialize block I/O to DIAG device using the specified blocksize and
  * block offset. On success, return zero and set end_block to contain the
  * number of blocks on the device minus the specified offset. Return non-zero
