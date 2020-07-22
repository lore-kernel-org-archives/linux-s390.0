Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53350 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731684AbgGVJqW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 22 Jul 2020 05:46:22 -0400
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 4/9] s390/vmemmap: cleanup when vmemmap_populate() fails
Date: Wed, 22 Jul 2020 11:45:53 +0200
Message-Id: <20200722094558.9828-5-david@redhat.com>
In-Reply-To: <20200722094558.9828-1-david@redhat.com>
References: <20200722094558.9828-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org, David Hildenbrand <david@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>

Cleanup what we partially added in case vmemmap_populate() fails. For
vmem, this is already handled by vmem_add_mapping().

Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/mm/vmem.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index 43fe1e2eb90ea..be32a38bb91fd 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -332,8 +332,13 @@ static void vmem_remove_range(unsigned long start, unsigned long size)
 int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 		struct vmem_altmap *altmap)
 {
+	int ret;
+
 	/* We don't care about the node, just use NUMA_NO_NODE on allocations */
-	return add_pagetable(start, end, false);
+	ret = add_pagetable(start, end, false);
+	if (ret)
+		remove_pagetable(start, end, false);
+	return ret;
 }
 
 void vmemmap_free(unsigned long start, unsigned long end,
-- 
2.26.2
