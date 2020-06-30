Return-Path: <linux-kernel-owner@vger.kernel.org>
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v1] s390/extmem: remove stale -ENOSPC comment and handling
Date: Tue, 30 Jun 2020 10:42:40 +0200
Message-Id: <20200630084240.8283-1-david@redhat.com>
In-Reply-To: <20200625150029.45019-1-david@redhat.com>
References: <20200625150029.45019-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org, David Hildenbrand <david@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Gerald Schaefer <gerald.schaefer@de.ibm.com>

segment_load() will no longer return -ENOSPC. If a segment overlaps with
storage, we now also return -EBUSY. Remove the stale comment from
__segment_load() and the stale handling from segment_warning().

Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/mm/extmem.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/s390/mm/extmem.c b/arch/s390/mm/extmem.c
index 105c09282f8c5..5060956b8e7d6 100644
--- a/arch/s390/mm/extmem.c
+++ b/arch/s390/mm/extmem.c
@@ -401,8 +401,7 @@ __segment_load (char *name, int do_nonshared, unsigned long *addr, unsigned long
  * -EIO     : could not perform query or load diagnose
  * -ENOENT  : no such segment
  * -EOPNOTSUPP: multi-part segment cannot be used with linux
- * -ENOSPC  : segment cannot be used (overlaps with storage)
- * -EBUSY   : segment can temporarily not be used (overlaps with dcss)
+ * -EBUSY   : segment cannot be used (overlaps with dcss or storage)
  * -ERANGE  : segment cannot be used (exceeds kernel mapping range)
  * -EPERM   : segment is currently loaded with incompatible permissions
  * -ENOMEM  : out of memory
@@ -627,10 +626,6 @@ void segment_warning(int rc, char *seg_name)
 		pr_err("DCSS %s has multiple page ranges and cannot be "
 		       "loaded or queried\n", seg_name);
 		break;
-	case -ENOSPC:
-		pr_err("DCSS %s overlaps with used storage and cannot "
-		       "be loaded\n", seg_name);
-		break;
 	case -EBUSY:
 		pr_err("%s needs used memory resources and cannot be "
 		       "loaded or queried\n", seg_name);
-- 
2.26.2
