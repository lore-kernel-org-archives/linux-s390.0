Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36348 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726408AbgFOWXK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 15 Jun 2020 18:23:10 -0400
Received: by mail-qt1-f200.google.com with SMTP id t24so15185763qtj.15
        for <linux-s390@vger.kernel.org>; Mon, 15 Jun 2020 15:23:05 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
Subject: [PATCH 19/25] mm/s390: Use mm_fault_accounting()
Date: Mon, 15 Jun 2020 18:23:02 -0400
Message-Id: <20200615222302.8452-1-peterx@redhat.com>
In-Reply-To: <20200615221607.7764-1-peterx@redhat.com>
References: <20200615221607.7764-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Peter Xu <peterx@redhat.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrea Arcangeli <aarcange@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org

Use the new mm_fault_accounting() helper for page fault accounting.

Avoid doing page fault accounting multiple times if the page fault is retried.

CC: Heiko Carstens <heiko.carstens@de.ibm.com>
CC: Vasily Gorbik <gor@linux.ibm.com>
CC: Christian Borntraeger <borntraeger@de.ibm.com>
CC: linux-s390@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/s390/mm/fault.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index dedc28be27ab..8ca207635b59 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -392,7 +392,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 	unsigned long trans_exc_code;
 	unsigned long address;
 	unsigned int flags;
-	vm_fault_t fault;
+	vm_fault_t fault, major = 0;
 
 	tsk = current;
 	/*
@@ -428,7 +428,6 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 	}
 
 	address = trans_exc_code & __FAIL_ADDR_MASK;
-	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 	flags = FAULT_FLAG_DEFAULT;
 	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
@@ -480,6 +479,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 	 * the fault.
 	 */
 	fault = handle_mm_fault(vma, address, flags);
+	major |= fault & VM_FAULT_MAJOR;
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
@@ -519,6 +505,9 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 			goto retry;
 		}
 	}
+
+	mm_fault_accounting(tsk, regs, address, major);
+
 	if (IS_ENABLED(CONFIG_PGSTE) && gmap) {
 		address =  __gmap_link(gmap, current->thread.gmap_addr,
 				       address);
-- 
2.26.2
