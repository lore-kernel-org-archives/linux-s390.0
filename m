Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47766 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726645AbgGCNjm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Jul 2020 09:39:42 -0400
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 7/9] s390/vmemmap: fallback to PTEs if mapping large PMD fails
Date: Fri,  3 Jul 2020 15:39:15 +0200
Message-Id: <20200703133917.39045-8-david@redhat.com>
In-Reply-To: <20200703133917.39045-1-david@redhat.com>
References: <20200703133917.39045-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org, David Hildenbrand <david@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>

Let's fallback to single pages if short on huge pages. No need to stop
memory hotplug.

Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/mm/vmem.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index 5239130770b7b..b7fdb9536707f 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -422,23 +422,23 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 		}
 
 		pm_dir = pmd_offset(pu_dir, address);
-		if (pmd_none(*pm_dir)) {
+		if (pmd_none(*pm_dir) && MACHINE_HAS_EDAT1) {
+			void *new_page;
+
 			/* Use 1MB frames for vmemmap if available. We always
 			 * use large frames even if they are only partially
 			 * used.
 			 * Otherwise we would have also page tables since
 			 * vmemmap_populate gets called for each section
 			 * separately. */
-			if (MACHINE_HAS_EDAT1) {
-				void *new_page;
-
-				new_page = vmemmap_alloc_block(PMD_SIZE, node);
-				if (!new_page)
-					goto out;
+			new_page = vmemmap_alloc_block(PMD_SIZE, node);
+			if (new_page) {
 				pmd_val(*pm_dir) = __pa(new_page) | sgt_prot;
 				address = (address + PMD_SIZE) & PMD_MASK;
 				continue;
 			}
+		}
+		if (pmd_none(*pm_dir)) {
 			pt_dir = vmem_pte_alloc();
 			if (!pt_dir)
 				goto out;
-- 
2.26.2
