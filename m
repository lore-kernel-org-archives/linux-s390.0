Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27746 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731072AbgIHUKr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Sep 2020 16:10:47 -0400
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 1/7] kernel/resource: make release_mem_region_adjustable() never fail
Date: Tue,  8 Sep 2020 22:10:06 +0200
Message-Id: <20200908201012.44168-2-david@redhat.com>
In-Reply-To: <20200908201012.44168-1-david@redhat.com>
References: <20200908201012.44168-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org, linux-mm@kvack.org, linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, linux-s390@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>, Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kees Cook <keescook@chromium.org>, Ard Biesheuvel <ardb@kernel.org>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Baoquan He <bhe@redhat.com>, Wei Yang <richardw.yang@linux.intel.com>

Let's make sure splitting a resource on memory hotunplug will never fail.
This will become more relevant once we merge selected System RAM
resources - then, we'll trigger that case more often on memory hotunplug.

In general, this function is already unlikely to fail. When we remove
memory, we free up quite a lot of metadata (memmap, page tables, memory
block device, etc.). The only reason it could really fail would be when
injecting allocation errors.

All other error cases inside release_mem_region_adjustable() seem to be
sanity checks if the function would be abused in different context -
let's add WARN_ON_ONCE() in these cases so we can catch them.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Kees Cook <keescook@chromium.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/ioport.h |  4 ++--
 kernel/resource.c      | 49 ++++++++++++++++++++++++------------------
 mm/memory_hotplug.c    | 22 +------------------
 3 files changed, 31 insertions(+), 44 deletions(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 6c2b06fe8beb7..52a91f5fa1a36 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -248,8 +248,8 @@ extern struct resource * __request_region(struct resource *,
 extern void __release_region(struct resource *, resource_size_t,
 				resource_size_t);
 #ifdef CONFIG_MEMORY_HOTREMOVE
-extern int release_mem_region_adjustable(struct resource *, resource_size_t,
-				resource_size_t);
+extern void release_mem_region_adjustable(struct resource *, resource_size_t,
+					  resource_size_t);
 #endif
 
 /* Wrappers for managed devices */
diff --git a/kernel/resource.c b/kernel/resource.c
index f1175ce93a1d5..36b3552210120 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1258,21 +1258,28 @@ EXPORT_SYMBOL(__release_region);
  *   assumes that all children remain in the lower address entry for
  *   simplicity.  Enhance this logic when necessary.
  */
-int release_mem_region_adjustable(struct resource *parent,
-				  resource_size_t start, resource_size_t size)
+void release_mem_region_adjustable(struct resource *parent,
+				   resource_size_t start, resource_size_t size)
 {
+	struct resource *new_res = NULL;
+	bool alloc_nofail = false;
 	struct resource **p;
 	struct resource *res;
-	struct resource *new_res;
 	resource_size_t end;
-	int ret = -EINVAL;
 
 	end = start + size - 1;
-	if ((start < parent->start) || (end > parent->end))
-		return ret;
+	if (WARN_ON_ONCE((start < parent->start) || (end > parent->end)))
+		return;
 
-	/* The alloc_resource() result gets checked later */
-	new_res = alloc_resource(GFP_KERNEL);
+	/*
+	 * We free up quite a lot of memory on memory hotunplug (esp., memap),
+	 * just before releasing the region. This is highly unlikely to
+	 * fail - let's play save and make it never fail as the caller cannot
+	 * perform any error handling (e.g., trying to re-add memory will fail
+	 * similarly).
+	 */
+retry:
+	new_res = alloc_resource(GFP_KERNEL | alloc_nofail ? __GFP_NOFAIL : 0);
 
 	p = &parent->child;
 	write_lock(&resource_lock);
@@ -1298,7 +1305,6 @@ int release_mem_region_adjustable(struct resource *parent,
 		 * so if we are dealing with them, let us just back off here.
 		 */
 		if (!(res->flags & IORESOURCE_SYSRAM)) {
-			ret = 0;
 			break;
 		}
 
@@ -1315,20 +1321,23 @@ int release_mem_region_adjustable(struct resource *parent,
 			/* free the whole entry */
 			*p = res->sibling;
 			free_resource(res);
-			ret = 0;
 		} else if (res->start == start && res->end != end) {
 			/* adjust the start */
-			ret = __adjust_resource(res, end + 1,
-						res->end - end);
+			WARN_ON_ONCE(__adjust_resource(res, end + 1,
+						       res->end - end));
 		} else if (res->start != start && res->end == end) {
 			/* adjust the end */
-			ret = __adjust_resource(res, res->start,
-						start - res->start);
+			WARN_ON_ONCE(__adjust_resource(res, res->start,
+						       start - res->start));
 		} else {
-			/* split into two entries */
+			/* split into two entries - we need a new resource */
 			if (!new_res) {
-				ret = -ENOMEM;
-				break;
+				new_res = alloc_resource(GFP_ATOMIC);
+				if (!new_res) {
+					alloc_nofail = true;
+					write_unlock(&resource_lock);
+					goto retry;
+				}
 			}
 			new_res->name = res->name;
 			new_res->start = end + 1;
@@ -1339,9 +1348,8 @@ int release_mem_region_adjustable(struct resource *parent,
 			new_res->sibling = res->sibling;
 			new_res->child = NULL;
 
-			ret = __adjust_resource(res, res->start,
-						start - res->start);
-			if (ret)
+			if (WARN_ON_ONCE(__adjust_resource(res, res->start,
+							   start - res->start)))
 				break;
 			res->sibling = new_res;
 			new_res = NULL;
@@ -1352,7 +1360,6 @@ int release_mem_region_adjustable(struct resource *parent,
 
 	write_unlock(&resource_lock);
 	free_resource(new_res);
-	return ret;
 }
 #endif	/* CONFIG_MEMORY_HOTREMOVE */
 
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index baded53b9ff92..4c47b68a9f4b5 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1724,26 +1724,6 @@ void try_offline_node(int nid)
 }
 EXPORT_SYMBOL(try_offline_node);
 
-static void __release_memory_resource(resource_size_t start,
-				      resource_size_t size)
-{
-	int ret;
-
-	/*
-	 * When removing memory in the same granularity as it was added,
-	 * this function never fails. It might only fail if resources
-	 * have to be adjusted or split. We'll ignore the error, as
-	 * removing of memory cannot fail.
-	 */
-	ret = release_mem_region_adjustable(&iomem_resource, start, size);
-	if (ret) {
-		resource_size_t endres = start + size - 1;
-
-		pr_warn("Unable to release resource <%pa-%pa> (%d)\n",
-			&start, &endres, ret);
-	}
-}
-
 static int __ref try_remove_memory(int nid, u64 start, u64 size)
 {
 	int rc = 0;
@@ -1777,7 +1757,7 @@ static int __ref try_remove_memory(int nid, u64 start, u64 size)
 		memblock_remove(start, size);
 	}
 
-	__release_memory_resource(start, size);
+	release_mem_region_adjustable(&iomem_resource, start, size);
 
 	try_offline_node(nid);
 
-- 
2.26.2
