From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 10 Jan 2019 15:41:51 +0000
Subject: [kvm-unit-tests PATCH v5 11/11] s390x: Initialize the physical allocator on mem init
Message-Id: <20190110154151.24233-12-frankja@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The physical and virtual allocators can coexist, so we can initialize
the former and allocate pages without breaking VM alloc.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 lib/s390x/sclp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/s390x/sclp.c b/lib/s390x/sclp.c
index e14f25d..0e76787 100644
--- a/lib/s390x/sclp.c
+++ b/lib/s390x/sclp.c
@@ -18,6 +18,7 @@
 #include <asm/spinlock.h>
 #include "sclp.h"
 #include <alloc_phys.h>
+#include <alloc_page.h>
 
 extern unsigned long stacktop;
 
@@ -32,8 +33,16 @@ static struct spinlock sclp_lock;
 static void mem_init(phys_addr_t mem_end)
 {
 	phys_addr_t freemem_start = (phys_addr_t)&stacktop;
+	phys_addr_t base, top;
 
 	phys_alloc_init(freemem_start, mem_end - freemem_start);
+	phys_alloc_get_unused(&base, &top);
+	base = (base + PAGE_SIZE - 1) & -PAGE_SIZE;
+	top = top & -PAGE_SIZE;
+
+	/* Make the pages available to the physical allocator */
+	free_pages((void *)(unsigned long)base, top - base);
+	page_alloc_ops_enable();
 }
 
 static void sclp_setup_int(void)
-- 
2.14.3
