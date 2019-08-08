Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39185 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfHHHSX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 8 Aug 2019 03:18:23 -0400
From: Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH 1/2] s390/extmem: Use refcount_t for refcount
Date: Thu,  8 Aug 2019 15:18:17 +0800
Message-Id: <20190808071817.6595-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>

Reference counters are preferred to use refcount_t instead of
atomic_t.
This is because the implementation of refcount_t can prevent
overflows and detect possible use-after-free.
So convert atomic_t ref counters to refcount_t.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 arch/s390/mm/extmem.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/s390/mm/extmem.c b/arch/s390/mm/extmem.c
index 0b5622714c12..78e801287c72 100644
--- a/arch/s390/mm/extmem.c
+++ b/arch/s390/mm/extmem.c
@@ -19,6 +19,7 @@
 #include <linux/memblock.h>
 #include <linux/ctype.h>
 #include <linux/ioport.h>
+#include <linux/refcount.h>
 #include <asm/diag.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
@@ -64,7 +65,7 @@ struct dcss_segment {
 	char res_name[16];
 	unsigned long start_addr;
 	unsigned long end;
-	atomic_t ref_count;
+	refcount_t ref_count;
 	int do_nonshared;
 	unsigned int vm_segtype;
 	struct qrange range[6];
@@ -362,7 +363,7 @@ __segment_load (char *name, int do_nonshared, unsigned long *addr, unsigned long
 	seg->start_addr = start_addr;
 	seg->end = end_addr;
 	seg->do_nonshared = do_nonshared;
-	atomic_set(&seg->ref_count, 1);
+	refcount_set(&seg->ref_count, 1);
 	list_add(&seg->list, &dcss_list);
 	*addr = seg->start_addr;
 	*end  = seg->end;
@@ -422,7 +423,7 @@ segment_load (char *name, int do_nonshared, unsigned long *addr,
 		rc = __segment_load (name, do_nonshared, addr, end);
 	else {
 		if (do_nonshared == seg->do_nonshared) {
-			atomic_inc(&seg->ref_count);
+			refcount_inc(&seg->ref_count);
 			*addr = seg->start_addr;
 			*end  = seg->end;
 			rc    = seg->vm_segtype;
@@ -468,7 +469,7 @@ segment_modify_shared (char *name, int do_nonshared)
 		rc = 0;
 		goto out_unlock;
 	}
-	if (atomic_read (&seg->ref_count) != 1) {
+	if (refcount_read(&seg->ref_count) != 1) {
 		pr_warn("DCSS %s is in use and cannot be reloaded\n", name);
 		rc = -EAGAIN;
 		goto out_unlock;
@@ -544,7 +545,7 @@ segment_unload(char *name)
 		pr_err("Unloading unknown DCSS %s failed\n", name);
 		goto out_unlock;
 	}
-	if (atomic_dec_return(&seg->ref_count) != 0)
+	if (!refcount_dec_and_test(&seg->ref_count))
 		goto out_unlock;
 	release_resource(seg->res);
 	kfree(seg->res);
-- 
2.20.1
