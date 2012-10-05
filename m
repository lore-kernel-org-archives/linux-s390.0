From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Subject: [PATCH 5/10] memory-hotplug : memory-hotplug: check page type in
 get_page_bootmem
Date: Fri, 5 Oct 2012 11:32:22 +0900
Message-ID: <506E46B6.3060502@jp.fujitsu.com>
References: <506E43E0.70507@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <506E43E0.70507@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-acpi/>
List-Post: <mailto:linux-acpi@vger.kernel.org>
To: x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-ia64@vger.kernel.org, cmetcalf@tilera.com, sparclinux@vger.kernel.org
Cc: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, rientjes@google.com, liuj97@gmail.com, len.brown@intel.com, cl@linux.com, minchan.kim@gmail.com, akpm@linux-foundation.org, kosaki.motohiro@jp.fujitsu.com, wency@cn.fujitsu.com
List-ID: <linux-s390.vger.kernel.org>

The function get_page_bootmem() may be called more than one time to the same
page. There is no need to set page's type, private if the function is not
the first time called to the page.

Note: the patch is just optimization and does not fix any problem.

CC: David Rientjes <rientjes@google.com>
CC: Jiang Liu <liuj97@gmail.com>
CC: Len Brown <len.brown@intel.com>
CC: Christoph Lameter <cl@linux.com>
Cc: Minchan Kim <minchan.kim@gmail.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
CC: Wen Congyang <wency@cn.fujitsu.com>
Signed-off-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
---
 mm/memory_hotplug.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

Index: linux-3.6/mm/memory_hotplug.c
===================================================================
--- linux-3.6.orig/mm/memory_hotplug.c	2012-10-04 18:29:58.284676075 +0900
+++ linux-3.6/mm/memory_hotplug.c	2012-10-04 18:30:03.454680542 +0900
@@ -95,10 +95,17 @@ static void release_memory_resource(stru
 static void get_page_bootmem(unsigned long info,  struct page *page,
 			     unsigned long type)
 {
-	page->lru.next = (struct list_head *) type;
-	SetPagePrivate(page);
-	set_page_private(page, info);
-	atomic_inc(&page->_count);
+	unsigned long page_type;
+
+	page_type = (unsigned long)page->lru.next;
+	if (page_type < MEMORY_HOTPLUG_MIN_BOOTMEM_TYPE ||
+	    page_type > MEMORY_HOTPLUG_MAX_BOOTMEM_TYPE){
+		page->lru.next = (struct list_head *)type;
+		SetPagePrivate(page);
+		set_page_private(page, info);
+		atomic_inc(&page->_count);
+	} else
+		atomic_inc(&page->_count);
 }
 
 /* reference to __meminit __free_pages_bootmem is valid
