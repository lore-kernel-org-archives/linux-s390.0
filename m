Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55599 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729710AbgGGWu5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 7 Jul 2020 18:50:57 -0400
Received: by mail-qv1-f69.google.com with SMTP id t12so17827308qvw.5
        for <linux-s390@vger.kernel.org>; Tue, 07 Jul 2020 15:50:54 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
Subject: [PATCH v5 18/25] mm/s390: Use general page fault accounting
Date: Tue,  7 Jul 2020 18:50:14 -0400
Message-Id: <20200707225021.200906-19-peterx@redhat.com>
In-Reply-To: <20200707225021.200906-1-peterx@redhat.com>
References: <20200707225021.200906-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, peterx@redhat.com, Andrew Morton <akpm@linux-foundation.org>, Will Deacon <will@kernel.org>, Andrea Arcangeli <aarcange@redhat.com>, David Rientjes <rientjes@google.com>, John Hubbard <jhubbard@nvidia.com>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org

Use the general page fault accounting by passing regs into handle_mm_fault().
It naturally solve the issue of multiple page fault accounting when page fault
retry happened.

CC: Heiko Carstens <heiko.carstens@de.ibm.com>
CC: Vasily Gorbik <gor@linux.ibm.com>
CC: Christian Borntraeger <borntraeger@de.ibm.com>
CC: linux-s390@vger.kernel.org
Reviewed-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Acked-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/s390/mm/fault.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index fc14df0b4d6e..9aa201df2e94 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -478,7 +478,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 	if (fault_signal_pending(fault, regs)) {
 		fault = VM_FAULT_SIGNAL;
 		if (flags & FAULT_FLAG_RETRY_NOWAIT)
@@ -488,21 +488,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
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
