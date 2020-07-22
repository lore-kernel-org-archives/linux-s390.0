Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33454 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731802AbgGVJq3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 22 Jul 2020 05:46:29 -0400
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 7/9] s390/vmemmap: fallback to PTEs if mapping large PMD fails
Date: Wed, 22 Jul 2020 11:45:56 +0200
Message-Id: <20200722094558.9828-8-david@redhat.com>
In-Reply-To: <20200722094558.9828-1-david@redhat.com>
References: <20200722094558.9828-1-david@redhat.com>
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
 arch/s390/mm/vmem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index b831f9f9130aa..e82a63de19db2 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -180,10 +180,10 @@ static int __ref modify_pmd_table(pud_t *pud, unsigned long addr,
 				 */
 				new_page = vmemmap_alloc_block(PMD_SIZE,
 							       NUMA_NO_NODE);
-				if (!new_page)
-					goto out;
-				pmd_val(*pmd) = __pa(new_page) | prot;
-				continue;
+				if (new_page) {
+					pmd_val(*pmd) = __pa(new_page) | prot;
+					continue;
+				}
 			}
 			pte = vmem_pte_alloc();
 			if (!pte)
-- 
2.26.2
