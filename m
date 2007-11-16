Return-Path: <linux-kernel-owner+w=401wt.eu-S933689AbXKPOaZ@vger.kernel.org>
Message-Id: <20071116142526.604069427@de.ibm.com>
References: <20071116142441.484714036@de.ibm.com>
Date: Fri, 16 Nov 2007 15:24:45 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 04/10] cmm: remove unused binary sysctls.
Content-Disposition: inline; filename=004-cmm.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Remove binary sysctls that never worked due to missing strategy functions.

Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/mm/cmm.c     |    3 ---
 include/linux/sysctl.h |    5 -----
 kernel/sysctl_check.c  |    3 ---
 3 files changed, 11 deletions(-)

diff -urpN linux-2.6/arch/s390/mm/cmm.c linux-2.6-patched/arch/s390/mm/cmm.c
--- linux-2.6/arch/s390/mm/cmm.c	2007-11-16 14:27:30.000000000 +0100
+++ linux-2.6-patched/arch/s390/mm/cmm.c	2007-11-16 14:27:41.000000000 +0100
@@ -341,19 +341,16 @@ cmm_timeout_handler(ctl_table *ctl, int 
 
 static struct ctl_table cmm_table[] = {
 	{
-		.ctl_name	= VM_CMM_PAGES,
 		.procname	= "cmm_pages",
 		.mode		= 0644,
 		.proc_handler	= &cmm_pages_handler,
 	},
 	{
-		.ctl_name	= VM_CMM_TIMED_PAGES,
 		.procname	= "cmm_timed_pages",
 		.mode		= 0644,
 		.proc_handler	= &cmm_pages_handler,
 	},
 	{
-		.ctl_name	= VM_CMM_TIMEOUT,
 		.procname	= "cmm_timeout",
 		.mode		= 0644,
 		.proc_handler	= &cmm_timeout_handler,
diff -urpN linux-2.6/include/linux/sysctl.h linux-2.6-patched/include/linux/sysctl.h
--- linux-2.6/include/linux/sysctl.h	2007-11-16 14:27:34.000000000 +0100
+++ linux-2.6-patched/include/linux/sysctl.h	2007-11-16 14:27:41.000000000 +0100
@@ -207,11 +207,6 @@ enum
 	VM_PANIC_ON_OOM=33,	/* panic at out-of-memory */
 	VM_VDSO_ENABLED=34,	/* map VDSO into new processes? */
 	VM_MIN_SLAB=35,		 /* Percent pages ignored by zone reclaim */
-
-	/* s390 vm cmm sysctls */
-	VM_CMM_PAGES=1111,
-	VM_CMM_TIMED_PAGES=1112,
-	VM_CMM_TIMEOUT=1113,
 };
 
 
diff -urpN linux-2.6/kernel/sysctl_check.c linux-2.6-patched/kernel/sysctl_check.c
--- linux-2.6/kernel/sysctl_check.c	2007-11-16 14:27:35.000000000 +0100
+++ linux-2.6-patched/kernel/sysctl_check.c	2007-11-16 14:27:41.000000000 +0100
@@ -140,9 +140,6 @@ static struct trans_ctl_table trans_vm_t
 	{ VM_PANIC_ON_OOM,		"panic_on_oom" },
 	{ VM_VDSO_ENABLED,		"vdso_enabled" },
 	{ VM_MIN_SLAB,			"min_slab_ratio" },
-	{ VM_CMM_PAGES,			"cmm_pages" },
-	{ VM_CMM_TIMED_PAGES,		"cmm_timed_pages" },
-	{ VM_CMM_TIMEOUT,		"cmm_timeout" },
 
 	{}
 };

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
