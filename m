From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v3] mm: do not drop unused pages when userfaultd is running
Date: Tue,  3 Jul 2018 19:18:54 +0200
Message-ID: <20180703171854.63981-1-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-mm@kvack.org, linux-s390@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: kvm@vger.kernel.org, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

KVM guests on s390 can notify the host of unused pages. This can result
in pte_unused callbacks to be true for KVM guest memory.

If a page is unused (checked with pte_unused) we might drop this page
instead of paging it. This can have side-effects on userfaultd, when the
page in question was already migrated:

The next access of that page will trigger a fault and a user fault
instead of faulting in a new and empty zero page. As QEMU does not
expect a userfault on an already migrated page this migration will fail.

The most straightforward solution is to ignore the pte_unused hint if a
userfault context is active for this VMA.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
v2->v3 : improve comment
RFC->v2: user userfaultfd_active
 mm/rmap.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 6db729dc4c50..eb477809a5c0 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -64,6 +64,7 @@
 #include <linux/backing-dev.h>
 #include <linux/page_idle.h>
 #include <linux/memremap.h>
+#include <linux/userfaultfd_k.h>
 
 #include <asm/tlbflush.h>
 
@@ -1481,11 +1482,16 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 				set_pte_at(mm, address, pvmw.pte, pteval);
 			}
 
-		} else if (pte_unused(pteval)) {
+		} else if (pte_unused(pteval) && !userfaultfd_armed(vma)) {
 			/*
 			 * The guest indicated that the page content is of no
 			 * interest anymore. Simply discard the pte, vmscan
 			 * will take care of the rest.
+			 * A future reference will then fault in a new zero
+			 * page. When userfaultfd is active, we must not drop
+			 * this page though, as its main user (postcopy
+			 * migration) will not expect userfaults on already
+			 * copied pages.
 			 */
 			dec_mm_counter(mm, mm_counter(page));
 			/* We have to invalidate as we cleared the pte */
-- 
2.17.0
