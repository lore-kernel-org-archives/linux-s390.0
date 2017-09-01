Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 1 Sep 2017 12:42:35 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 fixes for 4.13-rc8/final
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170901124235.6c6fb461@mschwideX1>
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

"Three more bug fixes for v4.13.

The two memory management related fixes are quite new, they fix kernel
crashes that can be triggered by user space.

The third commit fixes a bug in the vfio ccw translation code."

Jason J. Herne (1):
      vfio: ccw: fix bad ptr math for TIC cda translation

Martin Schwidefsky (2):
      s390/mm: fork vs. 5 level page tabel
      s390/mm: fix BUG_ON in crst_table_upgrade

 arch/s390/include/asm/mmu_context.h | 5 +++++
 arch/s390/mm/mmap.c                 | 6 ++++--
 drivers/s390/cio/vfio_ccw_cp.c      | 2 +-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/mmu_context.h b/arch/s390/include/asm/mmu_context.h
index 4541ac4..24bc416 100644
--- a/arch/s390/include/asm/mmu_context.h
+++ b/arch/s390/include/asm/mmu_context.h
@@ -44,6 +44,11 @@ static inline int init_new_context(struct task_struct *tsk,
 		mm->context.asce = __pa(mm->pgd) | _ASCE_TABLE_LENGTH |
 				   _ASCE_USER_BITS | _ASCE_TYPE_REGION3;
 		break;
+	case -PAGE_SIZE:
+		/* forked 5-level task, set new asce with new_mm->pgd */
+		mm->context.asce = __pa(mm->pgd) | _ASCE_TABLE_LENGTH |
+			_ASCE_USER_BITS | _ASCE_TYPE_REGION1;
+		break;
 	case 1UL << 53:
 		/* forked 4-level task, set new asce with new mm->pgd */
 		mm->context.asce = __pa(mm->pgd) | _ASCE_TABLE_LENGTH |
diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index 2e10d2b..5bea139 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -119,7 +119,8 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 		return addr;
 
 check_asce_limit:
-	if (addr + len > current->mm->context.asce_limit) {
+	if (addr + len > current->mm->context.asce_limit &&
+	    addr + len <= TASK_SIZE) {
 		rc = crst_table_upgrade(mm, addr + len);
 		if (rc)
 			return (unsigned long) rc;
@@ -183,7 +184,8 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	}
 
 check_asce_limit:
-	if (addr + len > current->mm->context.asce_limit) {
+	if (addr + len > current->mm->context.asce_limit &&
+	    addr + len <= TASK_SIZE) {
 		rc = crst_table_upgrade(mm, addr + len);
 		if (rc)
 			return (unsigned long) rc;
diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index ba6ac83..5ccfdc8 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -481,7 +481,7 @@ static int ccwchain_fetch_tic(struct ccwchain *chain,
 		ccw_tail = ccw_head + (iter->ch_len - 1) * sizeof(struct ccw1);
 
 		if ((ccw_head <= ccw->cda) && (ccw->cda <= ccw_tail)) {
-			ccw->cda = (__u32) (addr_t) (iter->ch_ccw +
+			ccw->cda = (__u32) (addr_t) (((char *)iter->ch_ccw) +
 						     (ccw->cda - ccw_head));
 			return 0;
 		}
