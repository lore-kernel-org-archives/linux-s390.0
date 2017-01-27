Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 27 Jan 2017 14:03:46 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] two s390 bug fixes for 4.10-rc6
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170127140346.6e9322f9@mschwideX1>
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

Another two bug fixes:
1) The ptrace partial write information leak
2) A guest page hinting regression introduced with v4.6

Christian Borntraeger (1):
      s390/mm: Fix cmma unused transfer from pgste into pte

Martin Schwidefsky (1):
      s390/ptrace: Preserve previous registers for short regset write

 arch/s390/kernel/ptrace.c | 8 ++++++++
 arch/s390/mm/pgtable.c    | 7 ++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
index 7447ba5..12020b5 100644
--- a/arch/s390/kernel/ptrace.c
+++ b/arch/s390/kernel/ptrace.c
@@ -963,6 +963,11 @@ static int s390_fpregs_set(struct task_struct *target,
 	if (target == current)
 		save_fpu_regs();
 
+	if (MACHINE_HAS_VX)
+		convert_vx_to_fp(fprs, target->thread.fpu.vxrs);
+	else
+		memcpy(&fprs, target->thread.fpu.fprs, sizeof(fprs));
+
 	/* If setting FPC, must validate it first. */
 	if (count > 0 && pos < offsetof(s390_fp_regs, fprs)) {
 		u32 ufpc[2] = { target->thread.fpu.fpc, 0 };
@@ -1067,6 +1072,9 @@ static int s390_vxrs_low_set(struct task_struct *target,
 	if (target == current)
 		save_fpu_regs();
 
+	for (i = 0; i < __NUM_VXRS_LOW; i++)
+		vxrs[i] = *((__u64 *)(target->thread.fpu.vxrs + i) + 1);
+
 	rc = user_regset_copyin(&pos, &count, &kbuf, &ubuf, vxrs, 0, -1);
 	if (rc == 0)
 		for (i = 0; i < __NUM_VXRS_LOW; i++)
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 7a1897c..d56ef26 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -202,7 +202,7 @@ static inline pgste_t ptep_xchg_start(struct mm_struct *mm,
 	return pgste;
 }
 
-static inline void ptep_xchg_commit(struct mm_struct *mm,
+static inline pte_t ptep_xchg_commit(struct mm_struct *mm,
 				    unsigned long addr, pte_t *ptep,
 				    pgste_t pgste, pte_t old, pte_t new)
 {
@@ -220,6 +220,7 @@ static inline void ptep_xchg_commit(struct mm_struct *mm,
 	} else {
 		*ptep = new;
 	}
+	return old;
 }
 
 pte_t ptep_xchg_direct(struct mm_struct *mm, unsigned long addr,
@@ -231,7 +232,7 @@ pte_t ptep_xchg_direct(struct mm_struct *mm, unsigned long addr,
 	preempt_disable();
 	pgste = ptep_xchg_start(mm, addr, ptep);
 	old = ptep_flush_direct(mm, addr, ptep);
-	ptep_xchg_commit(mm, addr, ptep, pgste, old, new);
+	old = ptep_xchg_commit(mm, addr, ptep, pgste, old, new);
 	preempt_enable();
 	return old;
 }
@@ -246,7 +247,7 @@ pte_t ptep_xchg_lazy(struct mm_struct *mm, unsigned long addr,
 	preempt_disable();
 	pgste = ptep_xchg_start(mm, addr, ptep);
 	old = ptep_flush_lazy(mm, addr, ptep);
-	ptep_xchg_commit(mm, addr, ptep, pgste, old, new);
+	old = ptep_xchg_commit(mm, addr, ptep, pgste, old, new);
 	preempt_enable();
 	return old;
 }
