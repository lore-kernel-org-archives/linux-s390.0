Return-Path: <SRS0=qZKM=S2=kvack.org=owner-linux-mm@kernel.org>
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 2/7] s390x/mm: Implement arch_remove_memory()
Date: Wed, 24 Apr 2019 12:25:06 +0200
Message-Id: <20190424102511.29318-3-david@redhat.com>
In-Reply-To: <20190424102511.29318-1-david@redhat.com>
References: <20190424102511.29318-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, akpm@linux-foundation.org, Dan Williams <dan.j.williams@intel.com>, David Hildenbrand <david@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Oscar Salvador <osalvador@suse.com>
List-ID: <linux-s390.vger.kernel.org>

Will come in handy when wanting to handle errors after
arch_add_memory().

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Oscar Salvador <osalvador@suse.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/mm/init.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 31b1071315d7..2636d62df04e 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -237,12 +237,13 @@ int arch_add_memory(int nid, u64 start, u64 size,
 void arch_remove_memory(int nid, u64 start, u64 size,
 			struct vmem_altmap *altmap)
 {
-	/*
-	 * There is no hardware or firmware interface which could trigger a
-	 * hot memory remove on s390. So there is nothing that needs to be
-	 * implemented.
-	 */
-	BUG();
+	unsigned long start_pfn = start >> PAGE_SHIFT;
+	unsigned long nr_pages = size >> PAGE_SHIFT;
+	struct zone *zone;
+
+	vmem_remove_mapping(start, size);
+	zone = page_zone(pfn_to_page(start_pfn));
+	__remove_pages(zone, start_pfn, nr_pages, altmap);
 }
 #endif
 #endif /* CONFIG_MEMORY_HOTPLUG */
-- 
2.20.1
