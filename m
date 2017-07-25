Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 25 Jul 2017 07:31:05 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 fixes for 4.13-rc3
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170725073105.1da165d0@mschwideX1>
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

Three bug fixes.

Christian Borntraeger (2):
      s390/perf: fix problem state detection
      s390/mm: set change and reference bit on lazy key enablement

Dong Jia Shi (1):
      s390: chp: handle CRW_ERC_INIT for channel-path status change

 arch/s390/kernel/perf_cpum_sf.c | 2 +-
 arch/s390/mm/pgtable.c          | 6 +++---
 drivers/s390/cio/chp.c          | 1 +
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index 0c82f79..c1bf75f 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -998,7 +998,7 @@ static int perf_push_sample(struct perf_event *event, struct sf_raw_sample *sfr)
 	psw_bits(regs.psw).ia	= sfr->basic.ia;
 	psw_bits(regs.psw).dat	= sfr->basic.T;
 	psw_bits(regs.psw).wait = sfr->basic.W;
-	psw_bits(regs.psw).per	= sfr->basic.P;
+	psw_bits(regs.psw).pstate = sfr->basic.P;
 	psw_bits(regs.psw).as	= sfr->basic.AS;
 
 	/*
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index d4d409b..4a1f736 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -591,11 +591,11 @@ void ptep_zap_key(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 	unsigned long ptev;
 	pgste_t pgste;
 
-	/* Clear storage key */
+	/* Clear storage key ACC and F, but set R/C */
 	preempt_disable();
 	pgste = pgste_get_lock(ptep);
-	pgste_val(pgste) &= ~(PGSTE_ACC_BITS | PGSTE_FP_BIT |
-			      PGSTE_GR_BIT | PGSTE_GC_BIT);
+	pgste_val(pgste) &= ~(PGSTE_ACC_BITS | PGSTE_FP_BIT);
+	pgste_val(pgste) |= PGSTE_GR_BIT | PGSTE_GC_BIT;
 	ptev = pte_val(*ptep);
 	if (!(ptev & _PAGE_INVALID) && (ptev & _PAGE_WRITE))
 		page_set_storage_key(ptev & PAGE_MASK, PAGE_DEFAULT_KEY, 1);
diff --git a/drivers/s390/cio/chp.c b/drivers/s390/cio/chp.c
index 7e0d4f7..432fc40 100644
--- a/drivers/s390/cio/chp.c
+++ b/drivers/s390/cio/chp.c
@@ -559,6 +559,7 @@ static void chp_process_crw(struct crw *crw0, struct crw *crw1,
 	chpid.id = crw0->rsid;
 	switch (crw0->erc) {
 	case CRW_ERC_IPARM: /* Path has come. */
+	case CRW_ERC_INIT:
 		if (!chp_is_registered(chpid))
 			chp_new(chpid);
 		chsc_chp_online(chpid);
