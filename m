Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B324D30BF6C
	for <linux-s390@vger.kernel.org>; Mon,  1 Sep 2025 09:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756718371; cv=none; b=igirKQailuygOOR65IdSWhxet2ofb+7vWUx5jONDGGO+xtQwtgANFczlEqdGWDtLPHc3dHmEDCXvQhBh/EemRnI4+Gmmy6r9LSWVErwPZP8m3rnzwsAhkJEIuLzzYQw09vyz4jyeJ7v4Pn1+Rb0+jI2cEGkWYklCxWjCEeeMmaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756718371; c=relaxed/simple;
	bh=FhyUK7QsvNq/SF0r5wXC/+v53sPppKo0XIJG59J83m0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qh2qgKTc9o96DOX30rk0nhXNIUhK/7bXL5+056u6mG4TFM9f7J7XGXw3WhtQEZvFi/HqKX/JE9iGoRsaByf55ONFYvLutZRPPyoOhFYSVl0ibGpxsLNrOJ4tCnzoOXG6wTxfzkxqfuCZIFLmesBJQPZiYV6CD3jWI8Wo+/Fy/vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=foPXI06h; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="foPXI06h"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b00a9989633so335076166b.0
        for <linux-s390@vger.kernel.org>; Mon, 01 Sep 2025 02:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756718368; x=1757323168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l7WepIwVsrDIqGjged5DTLMeHd34+rtR8uy9Koi3lTw=;
        b=foPXI06hEx3s9angwkek6CCQGLQArJrnbXNyZrtc5lxlV+FJ3W+DnpY7TZ38NB3qXz
         vHSxV96Tu09OJU0o6RQwuggNx7g9f8pell4hIeKxlEpJT6QoZiixpHAbHtKtm6sbxHOd
         HBaLhUV2pXIp+tPV+eTiViaQ7Yhz+sueuCsJ5YHAbT490mfEkGHgfosaN5ctD/GaDotR
         QovCj5erg0ebNRYLdOxfPxUrfJy3UsarwgRBf9rk/zQjR5n2SgTdWlMJtFhepTd20NDm
         u0ClVwKSDOFUT69il8k1+95798Ju3Ia5Qd+/1SUtmW0Xb5zxZ/lE4SO3+UctDeb29Y4L
         gKYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756718368; x=1757323168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l7WepIwVsrDIqGjged5DTLMeHd34+rtR8uy9Koi3lTw=;
        b=ks7yv5Ge32I5WqNM1IRLbXoZpwObZoi+YKbNq2vBnhjNAhqJMcWr0MX8+Y9tEambZE
         AYp8ox7C2XZMcc/KH4SZMn2OC8sE5xSvzY7CYJTt/C8+wX9j5aM+H8QHPseTeR4cy26u
         bLW4AIRBeqpiFlcbqlhEMdrBYWqu0lb9FPUP23wVJ4FeXE1cZtTpQdk5iQdxOTUDRlFY
         ZeabHR8cLGEccEgCDwsDCVp+xWxx3GfkziH9TpduRNmiOJb0JRAGb1PQUeWLFcmISGqC
         oJGycZSwMzjU5Nw/gAqH2SuYBmdolpxSBUg7e1cZUfFnXk7bKraV5ysT/5tlYWDBKWzL
         OeQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxWcdxJNlvjKhwKaZrzN4AwHJeRPN2rNUhUDMVQMe+cP0vBtcy7alLFGwoSv5X+B3dbXD7DShoO9q6@vger.kernel.org
X-Gm-Message-State: AOJu0YxKL89RoYegwwbqxPNqBsyAISFQ7btUFdYOoW5nj9h3IdbkxO4G
	GHoJ7dTxqk5V96ML6J6Djh5cVAkzny5DPO+y5VeEuPaYjn+q8hdLBxR6hDAbLOtanC8=
X-Gm-Gg: ASbGncvEDa2NdpsE6rlPHDHmarA7ydD2bAp8C5U5B9gZzJl6LFpOSSSbp/RvhKqWCwl
	TLdJSvao+JM0wtk/NYFugm6rZHMovzb7MsScb3ctzWyIHI5UyHDcF/k8yOOTlXJBD5JNbMRLGlv
	vWslEei5yYPZu+QNDd2LBb1Ea1voUqLXIk2zTKXcfvM9ctFm3KmIMUCCwbBv1pyMtXY146VknCs
	lb84BEJc66mrzs7fRhYGEnWUUK+/apusxswZNpzwjQS4/RcgPEdfIk/GZASdDKobwKWvxFQMZ2V
	FlN9OX/mnOfhmkc215BH84vr1lsadzKqR3zQVYzGk63A87p4AJ88jA8wxqUqlObBRpkoKN9hKhv
	afLLjlzQeBSFuv7h0HQ1d+gzwy5PJhODtXXWuEklHRyW5l4rX/Y2/C8q8JT+UHcv8rxoU7sSNtA
	xuFByALtNd7PCPQm5nlL4iPTE/lqfJj191
X-Google-Smtp-Source: AGHT+IHN/TqbysKK0s5Zu0KlpyXlJ7CQoaS7LuJ5q1gjVHxfVF3yXVZtull4SVbEI/dReygUbTQsRw==
X-Received: by 2002:a17:907:3d92:b0:afe:ee36:2eb8 with SMTP id a640c23a62f3a-b01081807a8mr707309966b.8.1756718367712;
        Mon, 01 Sep 2025 02:19:27 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b01902d0e99sm541005766b.12.2025.09.01.02.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 02:19:27 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	willy@infradead.org,
	hughd@google.com,
	mhocko@suse.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	vishal.moola@gmail.com,
	linux@armlinux.org.uk,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	davem@davemloft.net,
	andreas@gaisler.com,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	weixugc@google.com,
	baolin.wang@linux.alibaba.com,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	max.kellermann@ionos.com,
	thuth@redhat.com,
	broonie@kernel.org,
	osalvador@suse.de,
	jfalempe@redhat.com,
	mpe@ellerman.id.au,
	nysal@linux.ibm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-parisc@vger.kernel.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 02/12] mm/pagemap: add `const` to pointer parameters for improved const-correctness
Date: Mon,  1 Sep 2025 11:19:05 +0200
Message-ID: <20250901091916.3002082-3-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901091916.3002082-1-max.kellermann@ionos.com>
References: <20250901091916.3002082-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory management (mm) subsystem is a fundamental low-level component
of the Linux kernel. Establishing const-correctness at this foundational
level enables higher-level subsystems, such as filesystems and drivers,
to also adopt const-correctness in their interfaces. This patch lays
the groundwork for broader const-correctness throughout the kernel
by starting with the core mm subsystem.

This patch adds const qualifiers to address_space, folio, vm_area_struct,
readahead_control, and inode pointer parameters in pagemap.h functions
that do not modify the referenced memory, improving type safety and
enabling compiler optimizations.

Functions improved:
- mapping_empty()
- mapping_shrinkable()
- mapping_unevictable()
- mapping_exiting()
- mapping_use_writeback_tags()
- mapping_inaccessible()
- mapping_writeback_may_deadlock_on_reclaim()
- mapping_gfp_mask()
- mapping_gfp_constraint()
- mapping_min_folio_nrpages()
- mapping_min_folio_nrbytes()
- mapping_align_index()
- mapping_large_folio_support()
- filemap_nr_thps()
- folio_next_index()
- folio_contains()
- folio_pgoff()
- linear_page_index()
- readahead_pos()
- readahead_length()
- readahead_index()
- readahead_count()
- readahead_batch_length()
- dir_pages()
- folio_mkwrite_check_truncate()

Constify pagemap related test functions for improved
const-correctness.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/pagemap.h | 57 +++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 28 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index a3e16d74792f..1d35f9e1416e 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -140,7 +140,7 @@ static inline int inode_drain_writes(struct inode *inode)
 	return filemap_write_and_wait(inode->i_mapping);
 }
 
-static inline bool mapping_empty(struct address_space *mapping)
+static inline bool mapping_empty(const struct address_space *const mapping)
 {
 	return xa_empty(&mapping->i_pages);
 }
@@ -166,7 +166,7 @@ static inline bool mapping_empty(struct address_space *mapping)
  * refcount and the referenced bit, which will be elevated or set in
  * the process of adding new cache pages to an inode.
  */
-static inline bool mapping_shrinkable(struct address_space *mapping)
+static inline bool mapping_shrinkable(const struct address_space *const mapping)
 {
 	void *head;
 
@@ -267,7 +267,7 @@ static inline void mapping_clear_unevictable(struct address_space *mapping)
 	clear_bit(AS_UNEVICTABLE, &mapping->flags);
 }
 
-static inline bool mapping_unevictable(struct address_space *mapping)
+static inline bool mapping_unevictable(const struct address_space *const mapping)
 {
 	return mapping && test_bit(AS_UNEVICTABLE, &mapping->flags);
 }
@@ -277,7 +277,7 @@ static inline void mapping_set_exiting(struct address_space *mapping)
 	set_bit(AS_EXITING, &mapping->flags);
 }
 
-static inline int mapping_exiting(struct address_space *mapping)
+static inline int mapping_exiting(const struct address_space *const mapping)
 {
 	return test_bit(AS_EXITING, &mapping->flags);
 }
@@ -287,7 +287,7 @@ static inline void mapping_set_no_writeback_tags(struct address_space *mapping)
 	set_bit(AS_NO_WRITEBACK_TAGS, &mapping->flags);
 }
 
-static inline int mapping_use_writeback_tags(struct address_space *mapping)
+static inline int mapping_use_writeback_tags(const struct address_space *const mapping)
 {
 	return !test_bit(AS_NO_WRITEBACK_TAGS, &mapping->flags);
 }
@@ -333,7 +333,7 @@ static inline void mapping_set_inaccessible(struct address_space *mapping)
 	set_bit(AS_INACCESSIBLE, &mapping->flags);
 }
 
-static inline bool mapping_inaccessible(struct address_space *mapping)
+static inline bool mapping_inaccessible(const struct address_space *const mapping)
 {
 	return test_bit(AS_INACCESSIBLE, &mapping->flags);
 }
@@ -343,18 +343,18 @@ static inline void mapping_set_writeback_may_deadlock_on_reclaim(struct address_
 	set_bit(AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM, &mapping->flags);
 }
 
-static inline bool mapping_writeback_may_deadlock_on_reclaim(struct address_space *mapping)
+static inline bool mapping_writeback_may_deadlock_on_reclaim(const struct address_space *const mapping)
 {
 	return test_bit(AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM, &mapping->flags);
 }
 
-static inline gfp_t mapping_gfp_mask(struct address_space * mapping)
+static inline gfp_t mapping_gfp_mask(const struct address_space *const mapping)
 {
 	return mapping->gfp_mask;
 }
 
 /* Restricts the given gfp_mask to what the mapping allows. */
-static inline gfp_t mapping_gfp_constraint(struct address_space *mapping,
+static inline gfp_t mapping_gfp_constraint(const struct address_space *mapping,
 		gfp_t gfp_mask)
 {
 	return mapping_gfp_mask(mapping) & gfp_mask;
@@ -477,13 +477,13 @@ mapping_min_folio_order(const struct address_space *mapping)
 }
 
 static inline unsigned long
-mapping_min_folio_nrpages(struct address_space *mapping)
+mapping_min_folio_nrpages(const struct address_space *const mapping)
 {
 	return 1UL << mapping_min_folio_order(mapping);
 }
 
 static inline unsigned long
-mapping_min_folio_nrbytes(struct address_space *mapping)
+mapping_min_folio_nrbytes(const struct address_space *const mapping)
 {
 	return mapping_min_folio_nrpages(mapping) << PAGE_SHIFT;
 }
@@ -497,7 +497,7 @@ mapping_min_folio_nrbytes(struct address_space *mapping)
  * new folio to the page cache and need to know what index to give it,
  * call this function.
  */
-static inline pgoff_t mapping_align_index(struct address_space *mapping,
+static inline pgoff_t mapping_align_index(const struct address_space *const mapping,
 					  pgoff_t index)
 {
 	return round_down(index, mapping_min_folio_nrpages(mapping));
@@ -507,7 +507,7 @@ static inline pgoff_t mapping_align_index(struct address_space *mapping,
  * Large folio support currently depends on THP.  These dependencies are
  * being worked on but are not yet fixed.
  */
-static inline bool mapping_large_folio_support(struct address_space *mapping)
+static inline bool mapping_large_folio_support(const struct address_space *mapping)
 {
 	/* AS_FOLIO_ORDER is only reasonable for pagecache folios */
 	VM_WARN_ONCE((unsigned long)mapping & FOLIO_MAPPING_ANON,
@@ -522,7 +522,7 @@ static inline size_t mapping_max_folio_size(const struct address_space *mapping)
 	return PAGE_SIZE << mapping_max_folio_order(mapping);
 }
 
-static inline int filemap_nr_thps(struct address_space *mapping)
+static inline int filemap_nr_thps(const struct address_space *const mapping)
 {
 #ifdef CONFIG_READ_ONLY_THP_FOR_FS
 	return atomic_read(&mapping->nr_thps);
@@ -936,7 +936,7 @@ static inline struct page *grab_cache_page_nowait(struct address_space *mapping,
  *
  * Return: The index of the folio which follows this folio in the file.
  */
-static inline pgoff_t folio_next_index(struct folio *folio)
+static inline pgoff_t folio_next_index(const struct folio *const folio)
 {
 	return folio->index + folio_nr_pages(folio);
 }
@@ -965,7 +965,7 @@ static inline struct page *folio_file_page(struct folio *folio, pgoff_t index)
  * e.g., shmem did not move this folio to the swap cache.
  * Return: true or false.
  */
-static inline bool folio_contains(struct folio *folio, pgoff_t index)
+static inline bool folio_contains(const struct folio *const folio, pgoff_t index)
 {
 	VM_WARN_ON_ONCE_FOLIO(folio_test_swapcache(folio), folio);
 	return index - folio->index < folio_nr_pages(folio);
@@ -1042,13 +1042,13 @@ static inline loff_t page_offset(struct page *page)
 /*
  * Get the offset in PAGE_SIZE (even for hugetlb folios).
  */
-static inline pgoff_t folio_pgoff(struct folio *folio)
+static inline pgoff_t folio_pgoff(const struct folio *const folio)
 {
 	return folio->index;
 }
 
-static inline pgoff_t linear_page_index(struct vm_area_struct *vma,
-					unsigned long address)
+static inline pgoff_t linear_page_index(const struct vm_area_struct *const vma,
+					const unsigned long address)
 {
 	pgoff_t pgoff;
 	pgoff = (address - vma->vm_start) >> PAGE_SHIFT;
@@ -1468,7 +1468,7 @@ static inline unsigned int __readahead_batch(struct readahead_control *rac,
  * readahead_pos - The byte offset into the file of this readahead request.
  * @rac: The readahead request.
  */
-static inline loff_t readahead_pos(struct readahead_control *rac)
+static inline loff_t readahead_pos(const struct readahead_control *const rac)
 {
 	return (loff_t)rac->_index * PAGE_SIZE;
 }
@@ -1477,7 +1477,7 @@ static inline loff_t readahead_pos(struct readahead_control *rac)
  * readahead_length - The number of bytes in this readahead request.
  * @rac: The readahead request.
  */
-static inline size_t readahead_length(struct readahead_control *rac)
+static inline size_t readahead_length(const struct readahead_control *const rac)
 {
 	return rac->_nr_pages * PAGE_SIZE;
 }
@@ -1486,7 +1486,7 @@ static inline size_t readahead_length(struct readahead_control *rac)
  * readahead_index - The index of the first page in this readahead request.
  * @rac: The readahead request.
  */
-static inline pgoff_t readahead_index(struct readahead_control *rac)
+static inline pgoff_t readahead_index(const struct readahead_control *const rac)
 {
 	return rac->_index;
 }
@@ -1495,7 +1495,7 @@ static inline pgoff_t readahead_index(struct readahead_control *rac)
  * readahead_count - The number of pages in this readahead request.
  * @rac: The readahead request.
  */
-static inline unsigned int readahead_count(struct readahead_control *rac)
+static inline unsigned int readahead_count(const struct readahead_control *const rac)
 {
 	return rac->_nr_pages;
 }
@@ -1504,12 +1504,12 @@ static inline unsigned int readahead_count(struct readahead_control *rac)
  * readahead_batch_length - The number of bytes in the current batch.
  * @rac: The readahead request.
  */
-static inline size_t readahead_batch_length(struct readahead_control *rac)
+static inline size_t readahead_batch_length(const struct readahead_control *const rac)
 {
 	return rac->_batch_count * PAGE_SIZE;
 }
 
-static inline unsigned long dir_pages(struct inode *inode)
+static inline unsigned long dir_pages(const struct inode *const inode)
 {
 	return (unsigned long)(inode->i_size + PAGE_SIZE - 1) >>
 			       PAGE_SHIFT;
@@ -1523,8 +1523,8 @@ static inline unsigned long dir_pages(struct inode *inode)
  * Return: the number of bytes in the folio up to EOF,
  * or -EFAULT if the folio was truncated.
  */
-static inline ssize_t folio_mkwrite_check_truncate(struct folio *folio,
-					      struct inode *inode)
+static inline ssize_t folio_mkwrite_check_truncate(const struct folio *const folio,
+						   const struct inode *const inode)
 {
 	loff_t size = i_size_read(inode);
 	pgoff_t index = size >> PAGE_SHIFT;
@@ -1555,7 +1555,8 @@ static inline ssize_t folio_mkwrite_check_truncate(struct folio *folio,
  * Return: The number of filesystem blocks covered by this folio.
  */
 static inline
-unsigned int i_blocks_per_folio(struct inode *inode, struct folio *folio)
+unsigned int i_blocks_per_folio(const struct inode *const inode,
+				const struct folio *const folio)
 {
 	return folio_size(folio) >> inode->i_blkbits;
 }
-- 
2.47.2

