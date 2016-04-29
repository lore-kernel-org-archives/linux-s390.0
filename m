From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Subject: [PATCH RFC 6/8] vfio: ccw: introduce page array interfaces
Date: Fri, 29 Apr 2016 14:11:53 +0200
Message-ID: <1461931915-22397-7-git-send-email-bjsdjshi@linux.vnet.ibm.com>
References: <1461931915-22397-1-git-send-email-bjsdjshi@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1461931915-22397-1-git-send-email-bjsdjshi@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: bjsdjshi@linux.vnet.ibm.com, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com
List-ID: <linux-s390.vger.kernel.org>

CCW translation requires to pin/unpin sets of mem pages frequently.
Currently we have a lack of support to do this in an efficient way.
So we introduce page_array data structure and helper functions to
handle pin/unpin operations here.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 drivers/vfio/ccw/Makefile   |   2 +-
 drivers/vfio/ccw/ccwchain.c | 128 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 129 insertions(+), 1 deletion(-)
 create mode 100644 drivers/vfio/ccw/ccwchain.c

diff --git a/drivers/vfio/ccw/Makefile b/drivers/vfio/ccw/Makefile
index ea14ca9..ac62330 100644
--- a/drivers/vfio/ccw/Makefile
+++ b/drivers/vfio/ccw/Makefile
@@ -1,2 +1,2 @@
-vfio-ccw-y := vfio_ccw.o
+vfio-ccw-y := vfio_ccw.o ccwchain.o
 obj-$(CONFIG_VFIO_CCW) += vfio-ccw.o
diff --git a/drivers/vfio/ccw/ccwchain.c b/drivers/vfio/ccw/ccwchain.c
new file mode 100644
index 0000000..03b4e82
--- /dev/null
+++ b/drivers/vfio/ccw/ccwchain.c
@@ -0,0 +1,128 @@
+/*
+ * ccwchain interfaces
+ *
+ * Copyright IBM Corp. 2016
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License (version 2 only)
+ * as published by the Free Software Foundation.
+ *
+ * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
+ *            Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
+ */
+
+#include <linux/mm.h>
+#include <linux/slab.h>
+
+struct page_array {
+	u64			hva;
+	int			nr;
+	struct page		**items;
+};
+
+struct page_arrays {
+	struct page_array	*parray;
+	int			nr;
+};
+
+/*
+ * Helpers to operate page_array.
+ */
+/*
+ * page_array_pin() - pin user pages in memory
+ * @p: page_array on which to perform the operation
+ *
+ * Attempt to pin user pages in memory.
+ *
+ * Usage of page_array:
+ * @p->hva      starting user address. Assigned by caller.
+ * @p->nr       number of pages from @p->hva to pin. Assigned by caller.
+ *              number of pages pinned. Assigned by callee.
+ * @p->items    array that receives pointers to the pages pinned. Allocated by
+ *              caller.
+ *
+ * Returns:
+ *   Number of pages pinned on success. If @p->nr is 0 or negative, returns 0.
+ *   If no pages were pinned, returns -errno.
+ */
+static int page_array_pin(struct page_array *p)
+{
+	int i, nr;
+
+	nr = get_user_pages_fast(p->hva, p->nr, 1, p->items);
+	if (nr <= 0) {
+		p->nr = 0;
+		return nr;
+	} else if (nr != p->nr) {
+		for (i = 0; i < nr; i++)
+			put_page(p->items[i]);
+		p->nr = 0;
+		return -ENOMEM;
+	}
+
+	return nr;
+}
+
+/* Unpin the items before releasing the memory. */
+static void page_array_items_unpin_free(struct page_array *p)
+{
+	int i;
+
+	for (i = 0; i < p->nr; i++)
+		put_page(p->items[i]);
+
+	p->nr = 0;
+	kfree(p->items);
+}
+
+/* Alloc memory for items, then pin pages with them. */
+static int page_array_items_alloc_pin(u64 hva,
+				      unsigned int len,
+				      struct page_array *p)
+{
+	int ret;
+
+	if (!len || p->nr)
+		return -EINVAL;
+
+	p->hva = hva;
+
+	p->nr = ((hva & ~PAGE_MASK) + len + (PAGE_SIZE - 1)) >> PAGE_SHIFT;
+	if (!p->nr)
+		return -EINVAL;
+
+	p->items = kcalloc(p->nr, sizeof(*p->items), GFP_KERNEL);
+	if (!p->items)
+		return -ENOMEM;
+
+	ret = page_array_pin(p);
+	if (ret <= 0)
+		kfree(p->items);
+
+	return ret;
+}
+
+static int page_arrays_init(struct page_arrays *ps, int nr)
+{
+	ps->parray = kcalloc(nr, sizeof(*ps->parray), GFP_KERNEL);
+	if (!ps->parray) {
+		ps->nr = 0;
+		return -ENOMEM;
+	}
+
+	ps->nr = nr;
+	return 0;
+}
+
+static void page_arrays_unpin_free(struct page_arrays *ps)
+{
+	int i;
+
+	for (i = 0; i < ps->nr; i++)
+		page_array_items_unpin_free(ps->parray + i);
+
+	kfree(ps->parray);
+
+	ps->parray = NULL;
+	ps->nr = 0;
+}
-- 
2.6.6
