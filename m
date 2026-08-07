Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785C347CC71;
	Fri,  7 Aug 2026 15:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786118106; cv=none; b=KcZmrBJwuF7z/spXuAPwxq5ShGawqnwj9XDsjRhr5lKQWHmdztC65r6suWmrbHixXEqgxKo918JAac7QNTE/QI5Z9uEQuXLfAYWFk54p90v3qWEBG028/XRGLcmQhhdfse5lZqbb4FnjDYsx58S1e31yggD0SXKYMsTQ0V2wFfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786118106; c=relaxed/simple;
	bh=M9Ltk9LTngMh32dCVU4b8xEhbozzAYHiuf2pmHVQIVA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PFG+jTmi2K/DJUZ4IITWWMU0DHg/BXsvr2aWDOeSi93hHaJtrhQ2SaQNGVk0LqlSeWfBhBbTDuMcjce/raWdW5FdwYJrVYCzDCPCeTpj1ypvBsJdcSZQmgorLs9b6wkY8pJqsTmmPzqPdO41CBKXxkB87OGL18o2SxOYY/Daylw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQ5hULQh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQ5hULQh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F351F000E9;
	Fri,  7 Aug 2026 15:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786118104;
	bh=6xfQMNbgBWP35UYA8SHpjPKFbMcGxI2450wvcek2qss=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=FQ5hULQh3JK3ZVhaPzOwSF6zU2jaopkeOpzWLE5XnZAbewoy7dNENEPeksE+EYOnP
	 F2j0A/mUOfPfsF5YRwdI1IYwYbs27h0DNoG7sv9opbUpMQ2yeJq8xbr3MDce2PSUqp
	 QbdagfNv3fNclkCiDI1TEBinzMhsbA27YFS5uSIdezbfSWfI0Q/seASm4VihsHBhA8
	 qqBx0uSC2yNkQ5zGGRFVCnzKmwjQIG88TAxm0LP5qZTSfeTnJ9PSh89pBAkOC3OuNY
	 o8wCwqpUntdtGKa9QXGYTJlknLCtHb0hl0B2ASPDIcG3cFds1T7Esu92N0tbC307a3
	 W8BqFlE/xts4g==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Fri, 07 Aug 2026 17:54:25 +0200
Subject: [PATCH v4 05/10] mm/cma: Allow dynamically creating CMA areas
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-tegra-vpr-v4-5-5510d16af89e@nvidia.com>
References: <20260807-tegra-vpr-v4-0-5510d16af89e@nvidia.com>
In-Reply-To: <20260807-tegra-vpr-v4-0-5510d16af89e@nvidia.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>, Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Russell King <linux@armlinux.org.uk>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
 Robin Murphy <robin.murphy@arm.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, 
 "T.J. Mercier" <tjmercier@google.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Chun Ng <chunn@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-mm@kvack.org, iommu@lists.linux.dev, linaro-mm-sig@lists.linaro.org, 
 linux-trace-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=15769; i=treding@nvidia.com;
 h=from:subject:message-id; bh=uYtcp1/0ht5p3sdnKJ1sz5c47iLEuBUpb3uqmQu3tyU=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqdf/GxOuhbKWOQqU1cuizYOP4sOlYM+b81Hdb7
 h8D+NuRMi+JAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCanX/xgAKCRDdI6zXfz6z
 oSGkEACYX8S9Os/+kdZSwf+RJ9Y771EcK/SPLT/+oIKE9lSICSK8SGJXkqlOZVcuXG31rnLODM7
 4+gGBCWj/CSlXRFaeofBquHyyMvcev6LYFWiJK556WJnKsGzG3aOnLNI3a1aQQGzhegEFPPA1GF
 6Zkil9dPAsGJN//botff9wTANmYDFV75rAjQeHA122jLyZ/PThsBkr9rre5ZMEcFVzQpfP8H/OD
 a5I3kusny3I2AdIW9ZfzK5QcedjXn8mvw9+OWsKJBds4T+6622mW/VVqAyQ50UpqFbjmaONKtxQ
 kIEJq9GCexBaZdrAiuzU2ee3p4KM3T28+yAGYUPmzmKv3ulQRLQWgOpI/CupTYnRLO4hAsO2+uR
 6puhznlab5PSc+FEYIxETxJD98yYAEfDbpT8DZrRkpRj5HB5uhWcOIwA94POBTF1puI6V30aZdo
 cZOHE/VywChw8lKO1S9apeeOtOFnqIEBqvWhFi5k/oDORRD+OOu3Y2m1YOt8Jd2pLvDKjt5+DbI
 HS4wGMfxNgQiIslcJLYW+lqKIZwBmSgxSAxWaXJ5g+7ntAojQ+aUrsxPzDuywXIB2ENCPkwdeAr
 qHG0Y1iDWEPx+1HjbH6iQk7YyT550JYvEJhy7PyKX23rSKns9V6MAeept71Ypjk5xxxfYvxlW6a
 oHcvPg/JXC56elQ==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1

From: Thierry Reding <treding@nvidia.com>

There is no technical reason why there should be a limited number of CMA
regions, so extract some code into helpers and use them to create extra
functions (cma_create() and cma_free()) that allow creating and freeing,
respectively, CMA regions dynamically at runtime.

The static array of CMA areas cannot be replaced by dynamically created
areas because for many of them, allocation must not fail and some cases
may need to initialize them before the slab allocator is even available.
To account for this, keep these "early" areas in a separate list and
track the dynamic areas in a separate list.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v4:
- remove __init annotations to allow cma_create() after early boot
- make sure CMA area names are unique

Changes in v3:
- rebase on top of recent linux-next, update kernel/dma/contiguous.c
- use kzalloc_obj() instead of kzalloc() with sizeof()

Changes in v2:
- rename fixed number of CMA areas to reflect their main use
- account for pages in dynamically allocated regions
---
 arch/arm/mm/dma-mapping.c |   2 +-
 arch/s390/mm/init.c       |   2 +-
 include/linux/cma.h       |   8 +-
 kernel/dma/contiguous.c   |   2 +-
 mm/cma.c                  | 221 +++++++++++++++++++++++++++++++++++++---------
 mm/cma.h                  |   5 +-
 mm/cma_debug.c            |   6 +-
 mm/cma_sysfs.c            |   6 +-
 mm/mm_init.c              |   4 +-
 9 files changed, 201 insertions(+), 55 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 7761099dde9e..99bd7655e673 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -254,7 +254,7 @@ struct dma_contig_early_reserve {
 	unsigned long size;
 };
 
-static struct dma_contig_early_reserve dma_mmu_remap[MAX_CMA_AREAS] __initdata;
+static struct dma_contig_early_reserve dma_mmu_remap[MAX_EARLY_CMA_AREAS] __initdata;
 
 static int dma_mmu_remap_num __initdata;
 
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index be7e009e7b59..ccd48d611129 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -256,7 +256,7 @@ static int s390_cma_mem_notifier(struct notifier_block *nb,
 	mem_data.start = arg->start_pfn << PAGE_SHIFT;
 	mem_data.end = mem_data.start + (arg->nr_pages << PAGE_SHIFT);
 	if (action == MEM_GOING_OFFLINE)
-		rc = cma_for_each_area(s390_cma_check_range, &mem_data);
+		rc = cma_for_each_early_area(s390_cma_check_range, &mem_data);
 	return notifier_from_errno(rc);
 }
 
diff --git a/include/linux/cma.h b/include/linux/cma.h
index 8555d38a97b1..fb7a4923c3ba 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -7,7 +7,7 @@
 #include <linux/numa.h>
 
 #ifdef CONFIG_CMA_AREAS
-#define MAX_CMA_AREAS	CONFIG_CMA_AREAS
+#define MAX_EARLY_CMA_AREAS	CONFIG_CMA_AREAS
 #endif
 
 #define CMA_MAX_NAME 64
@@ -57,8 +57,14 @@ struct page *cma_alloc_frozen_compound(struct cma *cma, unsigned int order);
 bool cma_release_frozen(struct cma *cma, const struct page *pages,
 		unsigned long count);
 
+extern int cma_for_each_early_area(int (*it)(struct cma *cma, void *data), void *data);
 extern int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data);
 extern bool cma_intersects(struct cma *cma, unsigned long start, unsigned long end);
 
 extern void cma_reserve_pages_on_error(struct cma *cma);
+
+extern struct cma *cma_create(phys_addr_t base, phys_addr_t size,
+			      unsigned int order_per_bit, const char *name);
+extern void cma_free(struct cma *cma);
+
 #endif
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index f754079a287d..7975551f69b3 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -52,7 +52,7 @@
 #define CMA_SIZE_MBYTES 0
 #endif
 
-static struct cma *dma_contiguous_areas[MAX_CMA_AREAS];
+static struct cma *dma_contiguous_areas[MAX_EARLY_CMA_AREAS];
 static unsigned int dma_contiguous_areas_num;
 
 static int dma_contiguous_insert_area(struct cma *cma)
diff --git a/mm/cma.c b/mm/cma.c
index a7929c758df1..8d8fe7c82ae5 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -35,7 +35,12 @@
 #include "cma.h"
 #include "mm_init.h"
 
-struct cma cma_areas[MAX_CMA_AREAS];
+static DEFINE_MUTEX(cma_lock);
+
+struct cma cma_early_areas[MAX_EARLY_CMA_AREAS];
+unsigned int cma_early_area_count;
+
+static LIST_HEAD(cma_areas);
 unsigned int cma_area_count;
 
 phys_addr_t cma_get_base(const struct cma *cma)
@@ -138,10 +143,10 @@ bool cma_validate_zones(struct cma *cma)
 	return true;
 }
 
-static void __init cma_activate_area(struct cma *cma)
+static int cma_activate_area(struct cma *cma)
 {
 	unsigned long pfn, end_pfn, early_pfn[CMA_MAX_RANGES];
-	int allocrange, r;
+	int allocrange, r, err;
 	struct cma_memrange *cmr;
 	unsigned long bitmap_count, count;
 
@@ -150,12 +155,16 @@ static void __init cma_activate_area(struct cma *cma)
 		early_pfn[allocrange] = cmr->early_pfn;
 		cmr->bitmap = bitmap_zalloc(cma_bitmap_maxno(cma, cmr),
 					    GFP_KERNEL);
-		if (!cmr->bitmap)
+		if (!cmr->bitmap) {
+			err = -ENOMEM;
 			goto cleanup;
+		}
 	}
 
-	if (!cma_validate_zones(cma))
+	if (!cma_validate_zones(cma)) {
+		err = -EINVAL;
 		goto cleanup;
+	}
 
 	for (r = 0; r < cma->nranges; r++) {
 		cmr = &cma->ranges[r];
@@ -182,7 +191,7 @@ static void __init cma_activate_area(struct cma *cma)
 #endif
 	set_bit(CMA_ACTIVATED, &cma->flags);
 
-	return;
+	return 0;
 
 cleanup:
 	for (r = 0; r < allocrange; r++)
@@ -198,19 +207,24 @@ static void __init cma_activate_area(struct cma *cma)
 			end_pfn = cmr->base_pfn + cmr->count;
 			for (pfn = start_pfn; pfn < end_pfn; pfn++)
 				free_reserved_page(pfn_to_page(pfn));
+
+			/* reset these so we don't later confuse cma_free() */
+			cmr->bitmap = NULL;
+			cmr->count = 0;
 		}
 	}
-	totalcma_pages -= cma->count;
 	cma->available_count = cma->count = 0;
 	pr_err("CMA area %s could not be activated\n", cma->name);
+
+	return err;
 }
 
 static int __init cma_init_reserved_areas(void)
 {
 	int i;
 
-	for (i = 0; i < cma_area_count; i++)
-		cma_activate_area(&cma_areas[i]);
+	for (i = 0; i < cma_early_area_count; i++)
+		cma_activate_area(&cma_early_areas[i]);
 
 	return 0;
 }
@@ -221,41 +235,85 @@ void __init cma_reserve_pages_on_error(struct cma *cma)
 	set_bit(CMA_RESERVE_PAGES_ON_ERROR, &cma->flags);
 }
 
+static void cma_init_area(struct cma *cma, const char *name,
+			  phys_addr_t size, unsigned int order_per_bit,
+			  bool dynamic)
+{
+	unsigned int index;
+
+	if (dynamic)
+		index = MAX_EARLY_CMA_AREAS + cma_area_count;
+	else
+		index = cma_early_area_count;
+
+	if (name)
+		strscpy(cma->name, name);
+	else
+		snprintf(cma->name, CMA_MAX_NAME,  "cma%d\n", index);
+
+	cma->count = size >> PAGE_SHIFT;
+	cma->available_count = cma->count;
+	cma->order_per_bit = order_per_bit;
+
+	INIT_LIST_HEAD(&cma->node);
+}
+
 static int __init cma_new_area(const char *name, phys_addr_t size,
 			       unsigned int order_per_bit,
 			       struct cma **res_cma)
 {
 	struct cma *cma;
 
-	if (cma_area_count == ARRAY_SIZE(cma_areas)) {
+	if (cma_early_area_count == ARRAY_SIZE(cma_early_areas)) {
 		pr_err("Not enough slots for CMA reserved regions!\n");
 		return -ENOSPC;
 	}
 
+	mutex_lock(&cma_lock);
+
 	/*
 	 * Each reserved area must be initialised later, when more kernel
 	 * subsystems (like slab allocator) are available.
 	 */
-	cma = &cma_areas[cma_area_count];
-	cma_area_count++;
+	cma = &cma_early_areas[cma_early_area_count];
+	cma_init_area(cma, name, size, order_per_bit, false);
 
-	if (name)
-		strscpy(cma->name, name);
-	else
-		snprintf(cma->name, CMA_MAX_NAME,  "cma%d\n", cma_area_count);
-
-	cma->available_count = cma->count = size >> PAGE_SHIFT;
-	cma->order_per_bit = order_per_bit;
-	*res_cma = cma;
 	totalcma_pages += cma->count;
+	cma_early_area_count++;
+	*res_cma = cma;
+
+	mutex_unlock(&cma_lock);
 
 	return 0;
 }
 
 static void __init cma_drop_area(struct cma *cma)
 {
+	mutex_lock(&cma_lock);
 	totalcma_pages -= cma->count;
-	cma_area_count--;
+	cma_early_area_count--;
+	mutex_unlock(&cma_lock);
+}
+
+static int cma_check_memory(phys_addr_t base, phys_addr_t size)
+{
+	if (!size || !memblock_is_region_reserved(base, size))
+		return -EINVAL;
+
+	/*
+	 * CMA uses CMA_MIN_ALIGNMENT_BYTES as alignment requirement which
+	 * needs pageblock_order to be initialized. Let's enforce it.
+	 */
+	if (!pageblock_order) {
+		pr_err("pageblock_order not yet initialized. Called during early boot?\n");
+		return -EINVAL;
+	}
+
+	/* ensure minimal alignment required by mm core */
+	if (!IS_ALIGNED(base | size, CMA_MIN_ALIGNMENT_BYTES))
+		return -EINVAL;
+
+	return 0;
 }
 
 /**
@@ -278,22 +336,9 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
 	struct cma *cma;
 	int ret;
 
-	/* Sanity checks */
-	if (!size || !memblock_is_region_reserved(base, size))
-		return -EINVAL;
-
-	/*
-	 * CMA uses CMA_MIN_ALIGNMENT_BYTES as alignment requirement which
-	 * needs pageblock_order to be initialized. Let's enforce it.
-	 */
-	if (!pageblock_order) {
-		pr_err("pageblock_order not yet initialized. Called during early boot?\n");
-		return -EINVAL;
-	}
-
-	/* ensure minimal alignment required by mm core */
-	if (!IS_ALIGNED(base | size, CMA_MIN_ALIGNMENT_BYTES))
-		return -EINVAL;
+	ret = cma_check_memory(base, size);
+	if (ret < 0)
+		return ret;
 
 	ret = cma_new_area(name, size, order_per_bit, &cma);
 	if (ret != 0)
@@ -446,7 +491,7 @@ static int __init __cma_declare_contiguous_nid(phys_addr_t *basep,
 	pr_debug("%s(size %pa, base %pa, limit %pa alignment %pa)\n",
 		__func__, &size, &base, &limit, &alignment);
 
-	if (cma_area_count == ARRAY_SIZE(cma_areas)) {
+	if (cma_early_area_count == ARRAY_SIZE(cma_early_areas)) {
 		pr_err("Not enough slots for CMA reserved regions!\n");
 		return -ENOSPC;
 	}
@@ -1053,12 +1098,12 @@ bool cma_release_frozen(struct cma *cma, const struct page *pages,
 	return true;
 }
 
-int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data)
+int cma_for_each_early_area(int (*it)(struct cma *cma, void *data), void *data)
 {
 	int i;
 
-	for (i = 0; i < cma_area_count; i++) {
-		int ret = it(&cma_areas[i], data);
+	for (i = 0; i < cma_early_area_count; i++) {
+		int ret = it(&cma_early_areas[i], data);
 
 		if (ret)
 			return ret;
@@ -1067,6 +1112,25 @@ int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data)
 	return 0;
 }
 
+int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data)
+{
+	struct cma *cma;
+
+	mutex_lock(&cma_lock);
+
+	list_for_each_entry(cma, &cma_areas, node) {
+		int ret = it(cma, data);
+
+		if (ret) {
+			mutex_unlock(&cma_lock);
+			return ret;
+		}
+	}
+
+	mutex_unlock(&cma_lock);
+	return 0;
+}
+
 bool cma_intersects(struct cma *cma, unsigned long start, unsigned long end)
 {
 	int r;
@@ -1149,3 +1213,78 @@ void __init *cma_reserve_early(struct cma *cma, unsigned long size)
 
 	return ret;
 }
+
+struct cma *cma_create(phys_addr_t base, phys_addr_t size,
+		       unsigned int order_per_bit, const char *name)
+{
+	struct cma *cma;
+	int ret;
+
+	ret = cma_check_memory(base, size);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	cma = kzalloc_obj(*cma, GFP_KERNEL);
+	if (!cma)
+		return ERR_PTR(-ENOMEM);
+
+	mutex_lock(&cma_lock);
+
+	cma_init_area(cma, name, size, order_per_bit, true);
+	cma->ranges[0].base_pfn = PFN_DOWN(base);
+	cma->ranges[0].early_pfn = PFN_DOWN(base);
+	cma->ranges[0].count = cma->count;
+	cma->nranges = 1;
+
+	cma_activate_area(cma);
+
+	list_add_tail(&cma->node, &cma_areas);
+	totalcma_pages += cma->count;
+	cma_area_count++;
+
+	mutex_unlock(&cma_lock);
+
+	return cma;
+}
+
+void cma_free(struct cma *cma)
+{
+	unsigned int i;
+
+	/*
+	 * Safety check to prevent a CMA with active allocations from being
+	 * released.
+	 */
+	for (i = 0; i < cma->nranges; i++) {
+		unsigned long nbits = cma_bitmap_maxno(cma, &cma->ranges[i]);
+
+		if (nbits && !bitmap_empty(cma->ranges[i].bitmap, nbits)) {
+			WARN(1, "%s: range %u not empty\n", cma->name, i);
+			return;
+		}
+	}
+
+	mutex_lock(&cma_lock);
+
+	/* free reserved pages and the bitmap */
+	for (i = 0; i < cma->nranges; i++) {
+		struct cma_memrange *cmr = &cma->ranges[i];
+		unsigned long end_pfn, pfn;
+
+		end_pfn = cmr->base_pfn + cmr->count;
+		for (pfn = cmr->base_pfn; pfn < end_pfn; pfn++)
+			free_reserved_page(pfn_to_page(pfn));
+
+		bitmap_free(cmr->bitmap);
+	}
+
+	mutex_destroy(&cma->alloc_mutex);
+
+	totalcma_pages -= cma->count;
+	list_del(&cma->node);
+	cma_area_count--;
+
+	mutex_unlock(&cma_lock);
+
+	kfree(cma);
+}
diff --git a/mm/cma.h b/mm/cma.h
index c70180c36559..ae4db9819e38 100644
--- a/mm/cma.h
+++ b/mm/cma.h
@@ -41,6 +41,7 @@ struct cma {
 	unsigned long	available_count;
 	unsigned int order_per_bit; /* Order of pages represented by one bit */
 	spinlock_t	lock;
+	struct list_head node;
 	struct mutex alloc_mutex;
 #ifdef CONFIG_CMA_DEBUGFS
 	struct hlist_head mem_head;
@@ -71,8 +72,8 @@ enum cma_flags {
 	CMA_ACTIVATED,
 };
 
-extern struct cma cma_areas[MAX_CMA_AREAS];
-extern unsigned int cma_area_count;
+extern struct cma cma_early_areas[MAX_EARLY_CMA_AREAS];
+extern unsigned int cma_early_area_count;
 
 static inline unsigned long cma_bitmap_maxno(struct cma *cma,
 		struct cma_memrange *cmr)
diff --git a/mm/cma_debug.c b/mm/cma_debug.c
index 523ba4a0f9f7..548b0157e7b5 100644
--- a/mm/cma_debug.c
+++ b/mm/cma_debug.c
@@ -204,9 +204,9 @@ static int __init cma_debugfs_init(void)
 
 	cma_debugfs_root = debugfs_create_dir("cma", NULL);
 
-	for (i = 0; i < cma_area_count; i++)
-		if (test_bit(CMA_ACTIVATED, &cma_areas[i].flags))
-			cma_debugfs_add_one(&cma_areas[i], cma_debugfs_root);
+	for (i = 0; i < cma_early_area_count; i++)
+		if (test_bit(CMA_ACTIVATED, &cma_early_areas[i].flags))
+			cma_debugfs_add_one(&cma_early_areas[i], cma_debugfs_root);
 
 	return 0;
 }
diff --git a/mm/cma_sysfs.c b/mm/cma_sysfs.c
index d5bf792c6245..15319c7b8227 100644
--- a/mm/cma_sysfs.c
+++ b/mm/cma_sysfs.c
@@ -116,8 +116,8 @@ static int __init cma_sysfs_init(void)
 	if (!cma_kobj_root)
 		return -ENOMEM;
 
-	for (i = 0; i < cma_area_count; i++) {
-		cma = &cma_areas[i];
+	for (i = 0; i < cma_early_area_count; i++) {
+		cma = &cma_early_areas[i];
 		if (!test_bit(CMA_ACTIVATED, &cma->flags))
 			continue;
 
@@ -140,7 +140,7 @@ static int __init cma_sysfs_init(void)
 	return 0;
 out:
 	while (--i >= 0) {
-		cma = &cma_areas[i];
+		cma = &cma_early_areas[i];
 		if (cma->cma_kobj)
 			kobject_put(&cma->cma_kobj->kobj);
 	}
diff --git a/mm/mm_init.c b/mm/mm_init.c
index e5aa20a9b898..796eafb57752 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2156,7 +2156,7 @@ bool __init deferred_grow_zone(struct zone *zone, unsigned int order)
 #endif /* CONFIG_DEFERRED_STRUCT_PAGE_INIT */
 
 #ifdef CONFIG_CMA
-void __init init_cma_reserved_pageblock(struct page *page)
+void init_cma_reserved_pageblock(struct page *page)
 {
 	unsigned i = pageblock_nr_pages;
 	struct page *p = page;
@@ -2178,7 +2178,7 @@ void __init init_cma_reserved_pageblock(struct page *page)
 /*
  * Similar to above, but only set the migrate type and stats.
  */
-void __init init_cma_pageblock(struct page *page)
+void init_cma_pageblock(struct page *page)
 {
 	init_pageblock_migratetype(page, MIGRATE_CMA, false);
 	adjust_managed_page_count(page, pageblock_nr_pages);

-- 
2.54.0

