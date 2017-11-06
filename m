From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: [RFC/PATCH 20/22] s390/mm: Enable gmap huge pmd support
Date: Mon,  6 Nov 2017 23:29:58 +0100
Message-ID: <1510007400-42493-21-git-send-email-frankja@linux.vnet.ibm.com>
References: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Now that we have everything in place, let's allow huge pmds for gmap
linking, effectively allowing huge pages guests.

Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 arch/s390/mm/gmap.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 430dcd9..3cc2765 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -1,8 +1,10 @@
 /*
  *  KVM guest address space mapping code
  *
- *    Copyright IBM Corp. 2007, 2016
+ *    Copyright IBM Corp. 2007, 2016, 2017
  *    Author(s): Martin Schwidefsky <schwidefsky@de.ibm.com>
+ *		 David Hildenbrand <david@redhat.com>
+ *		 Janosch Frank <frankja@linux.vnet.ibm.com>
  */
 
 #include <linux/kernel.h>
@@ -596,9 +598,6 @@ int __gmap_link(struct gmap *gmap, unsigned long gaddr, unsigned long vmaddr)
 		return -EFAULT;
 	pmd = pmd_offset(pud, vmaddr);
 	VM_BUG_ON(pmd_none(*pmd));
-	/* large pmds cannot yet be handled */
-	if (pmd_large(*pmd))
-		return -EFAULT;
 	/* Link gmap segment table entry location to page table. */
 	rc = radix_tree_preload(GFP_KERNEL);
 	if (rc)
-- 
2.7.4
