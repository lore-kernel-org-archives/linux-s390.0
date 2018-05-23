Return-Path: <owner-linux-mm@kvack.org>
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH RFCv2 2/4] s390: mm: support removal of memory
Date: Wed, 23 May 2018 20:24:02 +0200
Message-Id: <20180523182404.11433-3-david@redhat.com>
In-Reply-To: <20180523182404.11433-1-david@redhat.com>
References: <20180523182404.11433-1-david@redhat.com>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

With virtio-mem, we actually want to remove memory again.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-s390@vger.kernel.org
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/mm/init.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 3fa3e5323612..7202344d0eae 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -242,12 +242,18 @@ int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
 #ifdef CONFIG_MEMORY_HOTREMOVE
 int arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
 {
-	/*
-	 * There is no hardware or firmware interface which could trigger a
-	 * hot memory remove on s390. So there is nothing that needs to be
-	 * implemented.
-	 */
-	return -EBUSY;
+	const unsigned long start_pfn = start >> PAGE_SHIFT;
+	const unsigned long nr_pages = size >> PAGE_SHIFT;
+	struct page *page = pfn_to_page(start_pfn);
+	struct zone *zone;
+	int ret;
+
+	zone = page_zone(page);
+	ret = __remove_pages(zone, start_pfn, nr_pages, altmap);
+	WARN_ON_ONCE(ret);
+	vmem_remove_mapping(start, size);
+
+	return ret;
 }
 #endif
 #endif /* CONFIG_MEMORY_HOTPLUG */
-- 
2.17.0
