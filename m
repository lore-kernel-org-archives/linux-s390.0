Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33909 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731673AbgGVJqX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 22 Jul 2020 05:46:23 -0400
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 5/9] s390/vmemmap: take the vmem_mutex when populating/freeing
Date: Wed, 22 Jul 2020 11:45:54 +0200
Message-Id: <20200722094558.9828-6-david@redhat.com>
In-Reply-To: <20200722094558.9828-1-david@redhat.com>
References: <20200722094558.9828-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org, David Hildenbrand <david@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>

Let's synchronize all accesses to the 1:1 and vmemmap mappings. This will
be especially relevant when wanting to cleanup empty page tables that could
be shared by both. Avoid races when removing tables that might be just
about to get reused.

Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/mm/vmem.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index be32a38bb91fd..a2b79681df69d 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -334,17 +334,21 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 {
 	int ret;
 
+	mutex_lock(&vmem_mutex);
 	/* We don't care about the node, just use NUMA_NO_NODE on allocations */
 	ret = add_pagetable(start, end, false);
 	if (ret)
 		remove_pagetable(start, end, false);
+	mutex_unlock(&vmem_mutex);
 	return ret;
 }
 
 void vmemmap_free(unsigned long start, unsigned long end,
 		struct vmem_altmap *altmap)
 {
+	mutex_lock(&vmem_mutex);
 	remove_pagetable(start, end, false);
+	mutex_unlock(&vmem_mutex);
 }
 
 void vmem_remove_mapping(unsigned long start, unsigned long size)
-- 
2.26.2
