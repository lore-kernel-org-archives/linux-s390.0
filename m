Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Peter Xu <peterx@redhat.com>
Subject: [PATCH 18/26] mm/s390: Use general page fault accounting
Date: Fri, 26 Jun 2020 18:36:27 -0400
Message-Id: <20200626223627.199861-1-peterx@redhat.com>
In-Reply-To: <20200626223130.199227-1-peterx@redhat.com>
References: <20200626223130.199227-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Peter Xu <peterx@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, Will Deacon <will@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org

Use the general page fault accounting by passing regs into handle_mm_fault().
It naturally solve the issue of multiple page fault accounting when page fault
retry happened.

CC: Heiko Carstens <heiko.carstens@de.ibm.com>
CC: Vasily Gorbik <gor@linux.ibm.com>
CC: Christian Borntraeger <borntraeger@de.ibm.com>
CC: linux-s390@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/s390/mm/fault.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index ab6d7eedcfab..4d62ca7d3e09 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -479,7 +479,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 	if (fault_signal_pending(fault, regs)) {
 		fault = VM_FAULT_SIGNAL;
 		if (flags & FAULT_FLAG_RETRY_NOWAIT)
@@ -489,21 +489,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 	if (unlikely(fault & VM_FAULT_ERROR))
 		goto out_up;
 
-	/*
-	 * Major/minor page fault accounting is only done on the
-	 * initial attempt. If we go through a retry, it is extremely
-	 * likely that the page will be found in page cache at that point.
-	 */
 	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_MAJOR) {
-			tsk->maj_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1,
-				      regs, address);
-		} else {
-			tsk->min_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1,
-				      regs, address);
-		}
 		if (fault & VM_FAULT_RETRY) {
 			if (IS_ENABLED(CONFIG_PGSTE) && gmap &&
 			    (flags & FAULT_FLAG_RETRY_NOWAIT)) {
-- 
2.26.2
