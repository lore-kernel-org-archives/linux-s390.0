Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195C830BB8A
	for <linux-s390@vger.kernel.org>; Mon,  1 Sep 2025 09:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756718388; cv=none; b=JHvOsgReWVPfSXZ1nBVyA24MfNNOAqdlvhLfav00S20Odu7xDlLqNHvtR/6yxj/lVhG79G3hMwvOGJLyFuEpnq5NZ5Y1Av9n7xrP4SWcDdc2d4qdXWfrDZpkcM54xtxKne7+GHPr//B9aSWiUYPHWPvAzQzPSwT1o2UzmIcUj60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756718388; c=relaxed/simple;
	bh=Pn49jH4PG3C/8QXwFhtbB4oaruklGtMdnkS4pKxEcwk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D5YfozmL25R7v5S21HYZvuruMH86UUmJiojMk6PwCJtVYKRm4Yx0N/JOK/knCK77RGLP9N5pwg7Xc4/aTlVlxo5ydF7eHVD388z9cNZufg8LmZWNEe2r6pccc9G4jiVpIesHNDEpgg/bzNSudmI8bDFYd3myK0+lzLg9ZVyHMHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=MMDFQDKY; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="MMDFQDKY"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b043a33b060so48125066b.1
        for <linux-s390@vger.kernel.org>; Mon, 01 Sep 2025 02:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756718384; x=1757323184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZWR7oxTxdlLJJjGEzgnWnG58Pm+0fE4rR05OeDaJbk0=;
        b=MMDFQDKY98LRy0ducF1oknt2/Ci7puoeG19apThwFntZPpI7tuXpWmd8xb+WjSXuvk
         6uZMzzxCKvIMc1YPLxEmMSYPRv5weI4GYlezIsnjhXMNpm3p8T+hi22h5D5ekbu1+OO5
         WaPWa1W15BaEJwnWWx0iYjWnYF8PJElEcv+ZJpn5ZvBOgt5uFUleI43wBIe70nLU2zmF
         bRMP5tOxhYwhTp+Ah0cHfWFBLyNf98BY3KsrY8SCnk+LfUCIpAkDjlRrjn45InVgpIxG
         EeRpuLzmM55M6C7N3qrv7MSuXD0Q0T7GvdwpLs64aLlMOfHTflOn9QCnVkKAhwzKLmBi
         2D2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756718384; x=1757323184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWR7oxTxdlLJJjGEzgnWnG58Pm+0fE4rR05OeDaJbk0=;
        b=HYhFfFwqd2iUt/R+mGeh6c9fjrW+DrFXJqhzawPOYfvhiexIabwPcMZSoBNQOSIOSw
         dbyDdwtVtyM486Tc7FVSyEpVQmJnOh0iBc/PWcvef5pFD5XDhdtIOSnF4PHZK47PGj1q
         401AMJ6uNLC58fzIj8VXqnC11TX+xlqNgrwJpadof9MeoRgbGdCo7Jyi5EIoeQZGBeSI
         G7o81tB1X7L3VB6depBbVdGpgQGozeHHcZpPbqf7cNiK8lp6xMKU504TmVbPenmAFUtP
         eDWsBhIJtB8fJ+JlAd7SU2c2W9FzlEp7MZk04fyOPH/xwlXZjK4+90w8GIdDeirvq7AO
         VADw==
X-Forwarded-Encrypted: i=1; AJvYcCXd4tc0/wc2arzL+4t5My7kSbWnzzts+k/gh6CweVjpm9Yuz4OaUqFMUm8Mm8YWVWx+if7rQLZSXqjl@vger.kernel.org
X-Gm-Message-State: AOJu0YyCOiPkULojaPWu/hFglOalQ9ZRz4+/Az4h2u+wSNCBSCSEUsPn
	bbY0ks62F7DoRDhdrl2Zxg/5o2ZYh+S9agfoFU5Ji9QgxCgyjoaL8/BSDO55q0XMMbA=
X-Gm-Gg: ASbGnctO4Vtnq+XXlWxfY4k4x6CMG2Hxt9doLYJMsNx8R8fR++dQbmLOVM0pmp/Rhqg
	NjEO1v8TBzPorGQC5CH+3pfC+/IZI/H9AiRM8WWTXzPHBtRwz41Y18ocExAU3fvJdIJ/H957/6/
	rqWYVcUbj3SYw5bzfYJEwxZFWGv1EZJNr6plG9jLmFCDlVXj3Z3Oi/fA09SsH0QDrHyskCn6Jbl
	feMYwaacHgJYvQIdBNAucafzvX0DkhvARBX3jUhLCNMzBfl7oif/+tBoTjwqI4teBDrAvl2sT7y
	q6Ocs7HVw8D8Cf5sZmnjVbJggg1rrXwbeE1wCZsfkNQ/o4wC4CA2kOC5+/mFkjq5efYnIWZdAr2
	w2cilkTnBTI1yQKL0hT3uxdTY0aER6CpRSoxmrh5Z/xhrjqi8rj7DaU4csC18uDf9FUdUS6Hjhp
	MHsmN1HOODIX5WmfPg+PUo/JukfvO/SDIvRSPHKN8jSQE=
X-Google-Smtp-Source: AGHT+IHaglaKkw7QyMbGEsEV4gTcSx4b/Ps7GCifY+uWygIU+PJPwrgvRO0dRVpnqktVCBoBvNUDww==
X-Received: by 2002:a17:906:eecd:b0:afd:d94b:830d with SMTP id a640c23a62f3a-b01e52b79camr796896166b.62.1756718384210;
        Mon, 01 Sep 2025 02:19:44 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b01902d0e99sm541005766b.12.2025.09.01.02.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 02:19:44 -0700 (PDT)
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
Subject: [PATCH v4 11/12] mm: add const to pointer parameters for improved const-correctness
Date: Mon,  1 Sep 2025 11:19:14 +0200
Message-ID: <20250901091916.3002082-12-max.kellermann@ionos.com>
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

This patch adds const qualifiers to vm_area_struct, vm_fault, page, and
vmem_altmap pointer parameters in core mm functions that do not modify
the referenced memory, improving type safety and enabling compiler
optimizations.

Functions improved:
- assert_fault_locked()
- vma_is_temporary_stack()
- vma_is_foreign()
- vma_is_accessible()
- vma_is_shared_maywrite()
- stack_guard_start_gap()
- vm_start_gap()
- vm_end_gap()
- vma_pages()
- range_in_vma()
- gup_can_follow_protnone()
- page_is_guard()
- vmem_altmap_offset()

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/mm.h | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 23864c3519d6..08ea6e7c0329 100644
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

