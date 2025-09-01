Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A3D34AB0A
	for <linux-s390@vger.kernel.org>; Mon,  1 Sep 2025 12:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729860; cv=none; b=FKOGN9aj4A/5iEMPwLL982Dyt/heNWj6vd3s3n6nTWncJmzjvSODfDThct2qiCaCD4pLFcvU/tV9fekgKHYhl7hMjMu/4GD+TwIevFUopGwsxUL3coo7psCQIit1RpLqJ4DPjf3jvKBBedRwRYOy7hoImEprRHtVgmWiVA0NhA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729860; c=relaxed/simple;
	bh=k1s6/3+1LZLo5UUwx6YnV4ZFL9KBD5D/EJISKBZ+akI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WfLOGpl8UbS3gDgbS2RVx2Zv02TyS70p96SF5IWHouHzzh/6pA+gZgcSd1SIeWIkP075EE8HktmizPZW292cdbKki+hk8i/u4Y7ucTz7vhOKQ1lUU5MxwrrPecKp7o1yXiGuzEVFCxEWINPUG2TiQYpr9USL7vGO9qIDWjLe79k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Mewagtta; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Mewagtta"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-61ce4c32a36so6732796a12.3
        for <linux-s390@vger.kernel.org>; Mon, 01 Sep 2025 05:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756729856; x=1757334656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W7iVmeI4QbKEqLSgMzs/KBDF5kQHVdSmVc3arqRn58E=;
        b=Mewagtta50Wt5d65PR3YI2NmvBlBexQYpZaVUZMTvrwIDFmbnna16Qo9bjaWVluq6/
         nGfT2R53GcyS/AEBjpLMX07bL6brRVhurBYyukGqaQbMY9eX/EXb0+ZWo4ff8KW8+8nd
         qV7y1lt16HVcyXf3ulcnAhi7JSvGbQOlaCLK/B/kaLzOmCdsfMIfedd+vz7zVxlXH6Vw
         2KsYvGkU4n3WRA6QnsiDS9CU0ZxEIXkqVNDBhZTN/CHB59Afm8QkPtHPBxxZnI4kFL0f
         1fJM+NqkoAtbwkoG8xQhOYK48NP9kBAefLS9E7TgssvbYW9mAuSm/fxzrQqoQ2nys7We
         jHCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756729856; x=1757334656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W7iVmeI4QbKEqLSgMzs/KBDF5kQHVdSmVc3arqRn58E=;
        b=JJ/77pZIPW6iL00BBfyy9OcbevkVSZWpD/yyhZXGCVYIGWmMTC2GULQ79YuKUBSmEu
         n+I8i+cnBUdgtHzteEPLMUaN+wrC4eAdcUGKYxdBByJTxID3AHBIMSG3uvMMQj3FFALC
         9ZQ3CtukRoD9guUpb1rjKtXavF/Bq0+WNL+eqFFsuuV2c7hT4Gj/M9evl+I2z0fwtBVt
         JtFdfNRo3IxkZ8CAbbtQQHegkrC6xhJah6j6NszDB9UBdIPvQBLZV0mbp+8fgJz5ScPw
         SKNbJbsO2+pCuNp27PYlPhwyJYK2yLXfOEq8fpRRmwcaeIG+k6NVOHYfIKbWHTbi2L7i
         nMog==
X-Forwarded-Encrypted: i=1; AJvYcCUCS2koPei3OHZF9ujoPG5UrLP2hsja+vnjlYFMHQWgrKutZmTjwWwSS6ZxiX699nKCqc9SBs9Ry2NA@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl1/vwVs0G6vfq1gEfuPb/zTIfVNsDW+cmMjdrR5+vHZPwMsvf
	5gl1vhsaPIDWD8teE/vVImc0GsUJQv8kVOLPSd8cpD3jdBxHsCIJ5KBQ3NANYQEoHG0=
X-Gm-Gg: ASbGnctz0hX1SfSIHFtwH9QPTpcThTKuJy9z4R3EOWhaJhaoLnmOunMM03GMVXec1gG
	l4PNcNJMzRcs452khQp8vvF1UpV0feGc+BUeKwcEheLBZySpa/eMrErVaW0VlqLMgQffnjALync
	bDwMEZRPZ0Ba8j9nFVmyBlAuEp8b/k9luHq3/xDtTXTxHfNOgSrXb30ubQa9L5UFU5DVhgozJPZ
	/SXiu4tP1EPRZ8yHGLEv+zp+DreJ86uzDkm/yKjf72X+9aE/JPywSoy2mmXatMKghKzz9uHrlgg
	wL7MB/h28RWq9Kcpq4OjOdgW/cci9RiJ6fXvLj0MkZOQd89T1+xN8VN10DjfLUqexhXxS0LEg9x
	7f/oFwMjkNebQsWFIdClexESF2vBfCGOuXelcn0mBbOM6BnbPG4FFpXyW2BgWXrgHwFcRqbdXA+
	qyuZS1ANApCbPuAeOu9Opgs70QAYrvwUVZ
X-Google-Smtp-Source: AGHT+IFoXjkT5AKVagAxNg7F2t10e+aOutMVefuJzQmttAG6qfcyBYcXqTaEs2cFD41mn40EFxW2tQ==
X-Received: by 2002:a05:6402:354f:b0:61d:2d2b:76ad with SMTP id 4fb4d7f45d1cf-61d2d2b78fdmr6247075a12.14.1756729856194;
        Mon, 01 Sep 2025 05:30:56 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61eaf5883b6sm255566a12.20.2025.09.01.05.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 05:30:55 -0700 (PDT)
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
Subject: [PATCH v5 11/12] mm: constify assert/test functions in mm.h
Date: Mon,  1 Sep 2025 14:30:27 +0200
Message-ID: <20250901123028.3383461-12-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901123028.3383461-1-max.kellermann@ionos.com>
References: <20250901123028.3383461-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For improved const-correctness.

We select certain assert and test functions which either invoke each
other, functions that are already const-ified, or no further
functions.

It is therefore relatively trivial to const-ify them, which
provides a basis for further const-ification further up the call
stack.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/mm.h | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 23864c3519d6..4cca66ba8839 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -703,7 +703,7 @@ static inline void release_fault_lock(struct vm_fault *vmf)
 		mmap_read_unlock(vmf->vma->vm_mm);
 }
 
-static inline void assert_fault_locked(struct vm_fault *vmf)
+static inline void assert_fault_locked(struct vm_fault *const vmf)
 {
 	if (vmf->flags & FAULT_FLAG_VMA_LOCK)
 		vma_assert_locked(vmf->vma);
@@ -716,7 +716,7 @@ static inline void release_fault_lock(struct vm_fault *vmf)
 	mmap_read_unlock(vmf->vma->vm_mm);
 }
 
-static inline void assert_fault_locked(struct vm_fault *vmf)
+static inline void assert_fault_locked(const struct vm_fault *vmf)
 {
 	mmap_assert_locked(vmf->vma->vm_mm);
 }
@@ -859,7 +859,7 @@ static inline bool vma_is_initial_stack(const struct vm_area_struct *vma)
 		vma->vm_end >= vma->vm_mm->start_stack;
 }
 
-static inline bool vma_is_temporary_stack(struct vm_area_struct *vma)
+static inline bool vma_is_temporary_stack(const struct vm_area_struct *const vma)
 {
 	int maybe_stack = vma->vm_flags & (VM_GROWSDOWN | VM_GROWSUP);
 
@@ -873,7 +873,7 @@ static inline bool vma_is_temporary_stack(struct vm_area_struct *vma)
 	return false;
 }
 
-static inline bool vma_is_foreign(struct vm_area_struct *vma)
+static inline bool vma_is_foreign(const struct vm_area_struct *const vma)
 {
 	if (!current->mm)
 		return true;
@@ -884,7 +884,7 @@ static inline bool vma_is_foreign(struct vm_area_struct *vma)
 	return false;
 }
 
-static inline bool vma_is_accessible(struct vm_area_struct *vma)
+static inline bool vma_is_accessible(const struct vm_area_struct *const vma)
 {
 	return vma->vm_flags & VM_ACCESS_FLAGS;
 }
@@ -895,7 +895,7 @@ static inline bool is_shared_maywrite(vm_flags_t vm_flags)
 		(VM_SHARED | VM_MAYWRITE);
 }
 
-static inline bool vma_is_shared_maywrite(struct vm_area_struct *vma)
+static inline bool vma_is_shared_maywrite(const struct vm_area_struct *const vma)
 {
 	return is_shared_maywrite(vma->vm_flags);
 }
@@ -1839,7 +1839,7 @@ static inline struct folio *pfn_folio(unsigned long pfn)
 }
 
 #ifdef CONFIG_MMU
-static inline pte_t mk_pte(struct page *page, pgprot_t pgprot)
+static inline pte_t mk_pte(const struct page *page, pgprot_t pgprot)
 {
 	return pfn_pte(page_to_pfn(page), pgprot);
 }
@@ -1854,7 +1854,7 @@ static inline pte_t mk_pte(struct page *page, pgprot_t pgprot)
  *
  * Return: A page table entry suitable for mapping this folio.
  */
-static inline pte_t folio_mk_pte(struct folio *folio, pgprot_t pgprot)
+static inline pte_t folio_mk_pte(const struct folio *folio, pgprot_t pgprot)
 {
 	return pfn_pte(folio_pfn(folio), pgprot);
 }
@@ -1870,7 +1870,7 @@ static inline pte_t folio_mk_pte(struct folio *folio, pgprot_t pgprot)
  *
  * Return: A page table entry suitable for mapping this folio.
  */
-static inline pmd_t folio_mk_pmd(struct folio *folio, pgprot_t pgprot)
+static inline pmd_t folio_mk_pmd(const struct folio *folio, pgprot_t pgprot)
 {
 	return pmd_mkhuge(pfn_pmd(folio_pfn(folio), pgprot));
 }
@@ -1886,7 +1886,7 @@ static inline pmd_t folio_mk_pmd(struct folio *folio, pgprot_t pgprot)
  *
  * Return: A page table entry suitable for mapping this folio.
  */
-static inline pud_t folio_mk_pud(struct folio *folio, pgprot_t pgprot)
+static inline pud_t folio_mk_pud(const struct folio *folio, pgprot_t pgprot)
 {
 	return pud_mkhuge(pfn_pud(folio_pfn(folio), pgprot));
 }
@@ -3488,7 +3488,7 @@ struct vm_area_struct *vma_lookup(struct mm_struct *mm, unsigned long addr)
 	return mtree_load(&mm->mm_mt, addr);
 }
 
-static inline unsigned long stack_guard_start_gap(struct vm_area_struct *vma)
+static inline unsigned long stack_guard_start_gap(const struct vm_area_struct *const vma)
 {
 	if (vma->vm_flags & VM_GROWSDOWN)
 		return stack_guard_gap;
@@ -3500,7 +3500,7 @@ static inline unsigned long stack_guard_start_gap(struct vm_area_struct *vma)
 	return 0;
 }
 
-static inline unsigned long vm_start_gap(struct vm_area_struct *vma)
+static inline unsigned long vm_start_gap(const struct vm_area_struct *const vma)
 {
 	unsigned long gap = stack_guard_start_gap(vma);
 	unsigned long vm_start = vma->vm_start;
@@ -3511,7 +3511,7 @@ static inline unsigned long vm_start_gap(struct vm_area_struct *vma)
 	return vm_start;
 }
 
-static inline unsigned long vm_end_gap(struct vm_area_struct *vma)
+static inline unsigned long vm_end_gap(const struct vm_area_struct *const vma)
 {
 	unsigned long vm_end = vma->vm_end;
 
@@ -3523,7 +3523,7 @@ static inline unsigned long vm_end_gap(struct vm_area_struct *vma)
 	return vm_end;
 }
 
-static inline unsigned long vma_pages(struct vm_area_struct *vma)
+static inline unsigned long vma_pages(const struct vm_area_struct *const vma)
 {
 	return (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
 }
@@ -3540,7 +3540,7 @@ static inline struct vm_area_struct *find_exact_vma(struct mm_struct *mm,
 	return vma;
 }
 
-static inline bool range_in_vma(struct vm_area_struct *vma,
+static inline bool range_in_vma(const struct vm_area_struct *const vma,
 				unsigned long start, unsigned long end)
 {
 	return (vma && vma->vm_start <= start && end <= vma->vm_end);
@@ -3656,7 +3656,7 @@ static inline int vm_fault_to_errno(vm_fault_t vm_fault, int foll_flags)
  * Indicates whether GUP can follow a PROT_NONE mapped page, or whether
  * a (NUMA hinting) fault is required.
  */
-static inline bool gup_can_follow_protnone(struct vm_area_struct *vma,
+static inline bool gup_can_follow_protnone(const struct vm_area_struct *const vma,
 					   unsigned int flags)
 {
 	/*
@@ -3786,7 +3786,7 @@ static inline bool debug_guardpage_enabled(void)
 	return static_branch_unlikely(&_debug_guardpage_enabled);
 }
 
-static inline bool page_is_guard(struct page *page)
+static inline bool page_is_guard(const struct page *const page)
 {
 	if (!debug_guardpage_enabled())
 		return false;
@@ -3817,7 +3817,7 @@ static inline void debug_pagealloc_map_pages(struct page *page, int numpages) {}
 static inline void debug_pagealloc_unmap_pages(struct page *page, int numpages) {}
 static inline unsigned int debug_guardpage_minorder(void) { return 0; }
 static inline bool debug_guardpage_enabled(void) { return false; }
-static inline bool page_is_guard(struct page *page) { return false; }
+static inline bool page_is_guard(const struct page *const page) { return false; }
 static inline bool set_page_guard(struct zone *zone, struct page *page,
 			unsigned int order) { return false; }
 static inline void clear_page_guard(struct zone *zone, struct page *page,
@@ -3899,7 +3899,7 @@ void vmemmap_free(unsigned long start, unsigned long end,
 #endif
 
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
-static inline unsigned long vmem_altmap_offset(struct vmem_altmap *altmap)
+static inline unsigned long vmem_altmap_offset(const struct vmem_altmap *altmap)
 {
 	/* number of pfns from base where pfn_to_page() is valid */
 	if (altmap)
@@ -3913,7 +3913,7 @@ static inline void vmem_altmap_free(struct vmem_altmap *altmap,
 	altmap->alloc -= nr_pfns;
 }
 #else
-static inline unsigned long vmem_altmap_offset(struct vmem_altmap *altmap)
+static inline unsigned long vmem_altmap_offset(const struct vmem_altmap *altmap)
 {
 	return 0;
 }
-- 
2.47.2

