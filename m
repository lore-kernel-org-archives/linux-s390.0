Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 20 Jun 2016 08:10:41 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.7-rc5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20160620081041.7fc20c21@mschwide>
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

Two more bugs fixes for 4.7:
- A KVM regression introduced with the pgtable.c code split
- A perf issue with two hardware PMUs using a shared event context

Christian Borntraeger (1):
      KVM: s390/mm: Fix CMMA reset during reboot

Hendrik Brueckner (1):
      s390/cpum_cf: use perf software context for hardware counters

 arch/s390/kernel/perf_cpum_cf.c | 8 ++------
 arch/s390/mm/pgtable.c          | 2 +-
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index 59215c5..7ec63b1 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -649,6 +649,8 @@ static int cpumf_pmu_commit_txn(struct pmu *pmu)
 
 /* Performance monitoring unit for s390x */
 static struct pmu cpumf_pmu = {
+	.task_ctx_nr  = perf_sw_context,
+	.capabilities = PERF_PMU_CAP_NO_INTERRUPT,
 	.pmu_enable   = cpumf_pmu_enable,
 	.pmu_disable  = cpumf_pmu_disable,
 	.event_init   = cpumf_pmu_event_init,
@@ -708,12 +710,6 @@ static int __init cpumf_pmu_init(void)
 		goto out;
 	}
 
-	/* The CPU measurement counter facility does not have overflow
-	 * interrupts to do sampling.  Sampling must be provided by
-	 * external means, for example, by timers.
-	 */
-	cpumf_pmu.capabilities |= PERF_PMU_CAP_NO_INTERRUPT;
-
 	cpumf_pmu.attr_groups = cpumf_cf_event_group();
 	rc = perf_pmu_register(&cpumf_pmu, "cpum_cf", PERF_TYPE_RAW);
 	if (rc) {
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 4324b87..9f0ce0e 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -437,7 +437,7 @@ void ptep_zap_unused(struct mm_struct *mm, unsigned long addr,
 	pgste = pgste_get_lock(ptep);
 	pgstev = pgste_val(pgste);
 	pte = *ptep;
-	if (pte_swap(pte) &&
+	if (!reset && pte_swap(pte) &&
 	    ((pgstev & _PGSTE_GPS_USAGE_MASK) == _PGSTE_GPS_USAGE_UNUSED ||
 	     (pgstev & _PGSTE_GPS_ZERO))) {
 		ptep_zap_swap_entry(mm, pte_to_swp_entry(pte));
