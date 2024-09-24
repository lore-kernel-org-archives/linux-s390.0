Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE5018308A
	for <linux-s390@vger.kernel.org>; Tue, 24 Sep 2024 22:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727218752; cv=none; b=q+jTR4JmccO/NaabrGnpea165rnRFTJnDLVwy1HLMNPN3LNrRKQUmIw5bMpfkXWnbj7pXrRXq7L3p+esamN8GUvKgXM8Nnd8z0LRSV8uhKjBbu9OionvH4olcZTkLqJTo8GcTEgSmGU2IuYM25EjQNAUt4Ae3fftPg+k0sw2qlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727218752; c=relaxed/simple;
	bh=rDgn4gY6sOFBf2KnKyBJWLyViA6CkppFJLUhdfZeX9w=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=VkruoZlgKsDGT3qbVu0+VlERx0Isp6f3FydOPCmOMveizE6vTRBJlPEdBHD6OM82X8CKL0T3IUR9dfyqb827rtFTAxlIYu6lUx7z+awFwyFX75S/cbNz9A+Qg2EAKkgSg9wkK1ctbuxBeMfRICVmbPR8WfRES3tDRR2Z7pl9P94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nKrzlWSW; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nKrzlWSW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727218751; x=1758754751;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rDgn4gY6sOFBf2KnKyBJWLyViA6CkppFJLUhdfZeX9w=;
  b=nKrzlWSWbc8iOit7AfMnHsqMlYggGB/rVU8Dalbld5f5bMTQerRDZq6/
   JmHCosNX65DYun3i/jBI6/Zs8CyAshVWMbfYY7GakLtWrGDRXMz1M9R2e
   Mx4aszPL0aT9AsNtARFdQE2OdVzNRFv2/yDChf4ghoMShyHBLLwuc4B80
   ezFGb0rMgZrr26dZXGhnEHNQB9dQng2njpQnuOd96GZM0pDIOwtryZ6mn
   Nkq1WCzoUE608WcEyYLLNipFjyiA08OFD7xAWK809Btv3bgfpnQhDBM/Y
   7HZmJXin+FGXCFHgPddHBrHxmC6SCllLMcYsPPZ4DBOoLoaG+T/P0mYxo
   A==;
X-CSE-ConnectionGUID: NYOqu24/SNmQ9FHPYls9TA==
X-CSE-MsgGUID: yw3q07HpS92/tyZMa+rfGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="37599242"
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="37599242"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 15:59:11 -0700
X-CSE-ConnectionGUID: Oypo7GhSRcOz1k9mjLhguQ==
X-CSE-MsgGUID: 1adIioY0SCy0m4wSg98psQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="76329045"
Received: from ldmartin-desk2.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.111.21])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 15:59:10 -0700
Subject: [PATCH] dcssblk: Mark DAX broken
From: Dan Williams <dan.j.williams@intel.com>
To: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@lst.de>,
 Alistair Popple <apopple@nvidia.com>, linux-s390@vger.kernel.org,
 linux-mm@kvack.org
Date: Tue, 24 Sep 2024 15:59:08 -0700
Message-ID: <172721874675.497781.3277495908107141898.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The dcssblk driver has long needed special case supoprt to enable
limited dax operation, so called CONFIG_FS_DAX_LIMITED. This mode
works around the incomplete support for ZONE_DEVICE on s390 by forgoing
the ability of dax-mapped pages to support GUP.

Now, pending cleanups to fsdax that fix its reference counting [1] depend on
the ability of all dax drivers to supply ZONE_DEVICE pages.

To allow that work to move forward, dax support needs to be paused for
dcssblk until ZONE_DEVICE support arrives. That work has been known for
a few years [2], and the removal of "pte_devmap" requirements [3] makes the
conversion easier.

For now, place the support behind CONFIG_BROKEN, and remove PFN_SPECIAL
(dcssblk was the only user).

Link: http://lore.kernel.org/cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com [1]
Link: http://lore.kernel.org/20210820210318.187742e8@thinkpad/ [2]
Link: http://lore.kernel.org/4511465a4f8429f45e2ac70d2e65dc5e1df1eb47.1725941415.git-series.apopple@nvidia.com [3]
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Alistair Popple <apopple@nvidia.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/s390/block/Kconfig   |   12 ++++++++++--
 drivers/s390/block/dcssblk.c |   26 +++++++++++++++++---------
 fs/Kconfig                   |    9 +--------
 fs/dax.c                     |   12 ------------
 include/linux/pfn_t.h        |   15 ---------------
 mm/memory.c                  |    2 --
 mm/memremap.c                |    4 ----
 7 files changed, 28 insertions(+), 52 deletions(-)

diff --git a/drivers/s390/block/Kconfig b/drivers/s390/block/Kconfig
index e3710a762aba..4bfe469c04aa 100644
--- a/drivers/s390/block/Kconfig
+++ b/drivers/s390/block/Kconfig
@@ -4,13 +4,21 @@ comment "S/390 block device drivers"
 
 config DCSSBLK
 	def_tristate m
-	select FS_DAX_LIMITED
-	select DAX
 	prompt "DCSSBLK support"
 	depends on S390 && BLOCK
 	help
 	  Support for dcss block device
 
+config DCSSBLK_DAX
+	def_bool y
+	depends on DCSSBLK
+	# requires S390 ZONE_DEVICE support
+	depends on BROKEN
+	select DAX
+	prompt "DCSSBLK DAX support"
+	help
+	  Enable DAX operation for the dcss block device
+
 config DASD
 	def_tristate y
 	prompt "Support for DASD devices"
diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index 02a4a51da1b7..d1bc79cf56bd 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -540,6 +540,21 @@ static const struct attribute_group *dcssblk_dev_attr_groups[] = {
 	NULL,
 };
 
+static int dcssblk_setup_dax(struct dcssblk_dev_info *dev_info)
+{
+	struct dax_device *dax_dev;
+
+	if (!IS_ENABLED(CONFIG_DCSSBLK_DAX))
+		return 0;
+
+	dax_dev = alloc_dax(dev_info, &dcssblk_dax_ops);
+	if (IS_ERR(dax_dev))
+		return PTR_ERR(dax_dev);
+	set_dax_synchronous(dax_dev);
+	dev_info->dax_dev = dax_dev;
+	return dax_add_host(dev_info->dax_dev, dev_info->gd);
+}
+
 /*
  * device attribute for adding devices
  */
@@ -680,14 +695,7 @@ dcssblk_add_store(struct device *dev, struct device_attribute *attr, const char
 	if (rc)
 		goto put_dev;
 
-	dax_dev = alloc_dax(dev_info, &dcssblk_dax_ops);
-	if (IS_ERR(dax_dev)) {
-		rc = PTR_ERR(dax_dev);
-		goto put_dev;
-	}
-	set_dax_synchronous(dax_dev);
-	dev_info->dax_dev = dax_dev;
-	rc = dax_add_host(dev_info->dax_dev, dev_info->gd);
+	rc = dcssblk_setup_dax(dev_info);
 	if (rc)
 		goto out_dax;
 
@@ -923,7 +931,7 @@ __dcssblk_direct_access(struct dcssblk_dev_info *dev_info, pgoff_t pgoff,
 		*kaddr = __va(dev_info->start + offset);
 	if (pfn)
 		*pfn = __pfn_to_pfn_t(PFN_DOWN(dev_info->start + offset),
-				PFN_DEV|PFN_SPECIAL);
+				      PFN_DEV);
 
 	return (dev_sz - offset) / PAGE_SIZE;
 }
diff --git a/fs/Kconfig b/fs/Kconfig
index 0e4efec1d92e..a6f4f28fa09e 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -60,7 +60,7 @@ endif # BLOCK
 config FS_DAX
 	bool "File system based Direct Access (DAX) support"
 	depends on MMU
-	depends on ZONE_DEVICE || FS_DAX_LIMITED
+	depends on ZONE_DEVICE
 	select FS_IOMAP
 	select DAX
 	help
@@ -96,13 +96,6 @@ config FS_DAX_PMD
 	depends on ZONE_DEVICE
 	depends on TRANSPARENT_HUGEPAGE
 
-# Selected by DAX drivers that do not expect filesystem DAX to support
-# get_user_pages() of DAX mappings. I.e. "limited" indicates no support
-# for fork() of processes with MAP_SHARED mappings or support for
-# direct-I/O to a DAX mapping.
-config FS_DAX_LIMITED
-	bool
-
 # Posix ACL utility routines
 #
 # Note: Posix ACLs can be implemented without these helpers.  Never use
diff --git a/fs/dax.c b/fs/dax.c
index becb4a6920c6..6257d3fdf8f8 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -359,9 +359,6 @@ static void dax_associate_entry(void *entry, struct address_space *mapping,
 	unsigned long size = dax_entry_size(entry), pfn, index;
 	int i = 0;
 
-	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
-		return;
-
 	index = linear_page_index(vma, address & ~(size - 1));
 	for_each_mapped_pfn(entry, pfn) {
 		struct page *page = pfn_to_page(pfn);
@@ -381,9 +378,6 @@ static void dax_disassociate_entry(void *entry, struct address_space *mapping,
 {
 	unsigned long pfn;
 
-	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
-		return;
-
 	for_each_mapped_pfn(entry, pfn) {
 		struct page *page = pfn_to_page(pfn);
 
@@ -684,12 +678,6 @@ struct page *dax_layout_busy_page_range(struct address_space *mapping,
 	pgoff_t end_idx;
 	XA_STATE(xas, &mapping->i_pages, start_idx);
 
-	/*
-	 * In the 'limited' case get_user_pages() for dax is disabled.
-	 */
-	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
-		return NULL;
-
 	if (!dax_mapping(mapping) || !mapping_mapped(mapping))
 		return NULL;
 
diff --git a/include/linux/pfn_t.h b/include/linux/pfn_t.h
index 2d9148221e9a..eb8da94d1d19 100644
--- a/include/linux/pfn_t.h
+++ b/include/linux/pfn_t.h
@@ -9,18 +9,14 @@
  * PFN_SG_LAST - pfn references a page and is the last scatterlist entry
  * PFN_DEV - pfn is not covered by system memmap by default
  * PFN_MAP - pfn has a dynamic page mapping established by a device driver
- * PFN_SPECIAL - for CONFIG_FS_DAX_LIMITED builds to allow XIP, but not
- *		 get_user_pages
  */
 #define PFN_FLAGS_MASK (((u64) (~PAGE_MASK)) << (BITS_PER_LONG_LONG - PAGE_SHIFT))
 #define PFN_SG_CHAIN (1ULL << (BITS_PER_LONG_LONG - 1))
 #define PFN_SG_LAST (1ULL << (BITS_PER_LONG_LONG - 2))
 #define PFN_DEV (1ULL << (BITS_PER_LONG_LONG - 3))
 #define PFN_MAP (1ULL << (BITS_PER_LONG_LONG - 4))
-#define PFN_SPECIAL (1ULL << (BITS_PER_LONG_LONG - 5))
 
 #define PFN_FLAGS_TRACE \
-	{ PFN_SPECIAL,	"SPECIAL" }, \
 	{ PFN_SG_CHAIN,	"SG_CHAIN" }, \
 	{ PFN_SG_LAST,	"SG_LAST" }, \
 	{ PFN_DEV,	"DEV" }, \
@@ -117,15 +113,4 @@ pud_t pud_mkdevmap(pud_t pud);
 #endif
 #endif /* CONFIG_ARCH_HAS_PTE_DEVMAP */
 
-#ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
-static inline bool pfn_t_special(pfn_t pfn)
-{
-	return (pfn.val & PFN_SPECIAL) == PFN_SPECIAL;
-}
-#else
-static inline bool pfn_t_special(pfn_t pfn)
-{
-	return false;
-}
-#endif /* CONFIG_ARCH_HAS_PTE_SPECIAL */
 #endif /* _LINUX_PFN_T_H_ */
diff --git a/mm/memory.c b/mm/memory.c
index c31ea300cdf6..676f5cda992a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2462,8 +2462,6 @@ static bool vm_mixed_ok(struct vm_area_struct *vma, pfn_t pfn, bool mkwrite)
 		return true;
 	if (pfn_t_devmap(pfn))
 		return true;
-	if (pfn_t_special(pfn))
-		return true;
 	if (is_zero_pfn(pfn_t_to_pfn(pfn)))
 		return true;
 	return false;
diff --git a/mm/memremap.c b/mm/memremap.c
index 40d4547ce514..a6bbbe180eab 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -332,10 +332,6 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
 		}
 		break;
 	case MEMORY_DEVICE_FS_DAX:
-		if (IS_ENABLED(CONFIG_FS_DAX_LIMITED)) {
-			WARN(1, "File system DAX not supported\n");
-			return ERR_PTR(-EINVAL);
-		}
 		params.pgprot = pgprot_decrypted(params.pgprot);
 		break;
 	case MEMORY_DEVICE_GENERIC:

