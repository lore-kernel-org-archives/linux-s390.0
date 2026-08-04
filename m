Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDD13A9DAB
	for <linux-s390@vger.kernel.org>; Tue,  4 Aug 2026 12:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785845156; cv=none; b=qpnST4wZAsaNMx4ksVN7eNQnORvdQqNrc6tiR17U7WDV3qOgLHSHHROiHLyC9CAmp6ILZ69hQcqFwbl7eWjpyxkcPhusRzIkZMB/kiDgDTmue4m9QY+zd0uFbhSSEN1FIUrm69X7SK+xyAVEZIO1wk1k0809QUB0Xnd6T1uxpmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785845156; c=relaxed/simple;
	bh=pfZ9447zK/9Z8PR/ugAEc+1h5xI66Sw/HNM5zHbRVZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rx66ueqdM0Gn+6TMV1oKcXeJ3a+LCU0jMkuXgfdpdrfid7UammH3nUwvUHn9hgcMjVA3tjQ0r4zWA9lAsc2inHNsaBx36cUt/ZwMiS9y8/h3IySHWuh9Pstra+5RTqMaGGpN79rLcWpWSblffkOi/D5cpGazNjpvI8DAYaNHnw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JYBkdgj7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=E6C/yKqM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYBkdgj7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="E6C/yKqM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785845152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j37JFINyTYCydy6a1WRFKL3cyTkOscZBfjMnbKqhj70=;
	b=JYBkdgj7vraKX8U+OPef0+NWCLXHZCI7AcWG8eWcPDPhNaqrjsi+oZm30/XkrsDzDMgIBU
	tFjd9ixMJa4ZKikka47Qm9WOUycMz5HH1r+vop2s431um7o8Up7EQRBOR/nfE3rfWPa2Sx
	TqlTMAnyQyQBu/XDQEbVOdbjGtwZ11s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-x3B-H-akPZW3zdmPXwcZ5A-1; Tue, 04 Aug 2026 08:05:50 -0400
X-MC-Unique: x3B-H-akPZW3zdmPXwcZ5A-1
X-Mimecast-MFC-AGG-ID: x3B-H-akPZW3zdmPXwcZ5A_1785845150
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f6db77430so3331657f8f.0
        for <linux-s390@vger.kernel.org>; Tue, 04 Aug 2026 05:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785845149; x=1786449949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j37JFINyTYCydy6a1WRFKL3cyTkOscZBfjMnbKqhj70=;
        b=E6C/yKqMRyFadcJC6fKjGVc9ZurbscECGfuXwXa5veKYxO3wgWpV1hfVxJE3y0jUpV
         ugyjpClLjCphtzH/JVprAl5b504ncEXNhLkFOqouMcmwnG7a1G4XiUjpGJQKfzLqCT1g
         F6avX0ZWzs2DfGnzUW3DgRS5Zc3jk/kXPf2ygWIBUJ9cdmjvRdsHUCPA0jcYOX2NI1gQ
         J7Rrx9t9y9RCOyECw4ICAphTMOPxbaU3qDz6cYKFi8WBHPoLXOO3qU1loSVj4JNRb+5M
         iQrli2L7qbh9e9uVNAxTlnZH9HnxMlSsEmsM88LBCF6O1bWNMk/Mn6G5j1j/+O5GwkX1
         RVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785845149; x=1786449949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j37JFINyTYCydy6a1WRFKL3cyTkOscZBfjMnbKqhj70=;
        b=LF90Ei0t0r/vObdKwfH/B0m5tTjX/8hABOX/qY0g6RLbCSWesVjuSDk88+FP+rgRK0
         DxPLRMn4rWxwoDyA4dK/Kw3a/aAlLLghxs2aYheWqESdjYQebqz9vfV4EQZl7Fmwm20a
         10n2rv7AClOB7T9uRJI8R3lj2b+66uCWUTTfotvP6nnamRHoGIVPGyg761/Da+DuhwEX
         oXGACcd8BXwT8CPp9m5/uXgdH/g4qZG5dAZuwQLvLlHDO0Rnowte+lYsHoonZK+tHOu6
         Uf1/+iktHMBZgZEF7iGDYlIfCZInkQ2BLt59M4wNOAoTMEUuSjSJabd6Lntqyx8Pw0sW
         bNkA==
X-Forwarded-Encrypted: i=1; AHgh+Rrhp69mZaAC2tDFnDMImLCvMOIzPY+ZphYcaNyMsMVUYqqaOYwlYFlbWsMZqLZ6KN+nw4e8KpHEkdn8@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/+nOcw+rAy9bCaUs50upDJzP1Km+YEPTgy020rzAuVeGNROMa
	qLsFUqkFGUVlzgxKE8YE+ZJHN67FvJaFeIKa4U8J2TncHjU0S7DHmXbuhBlszkf4JYm9yU2bfa+
	jF7le+nRBlH+JKw4zQRBfqy+0fbWkni6wuRji9fJxw1kPKiO3tHOZKpFMrUw/p6A=
X-Gm-Gg: AR+sD13aRrnYXxA9kbAgBqZLLkV8/TYvoabPu9MBQyBxzt4pC3RPWWKQig9TNWELbFB
	MwGaejBrQYfNWBgL2px2bp36GJGCjkCLc9pwuwFE2FTZspuFgmLWLzPUxxhEUGM+HVsIkWwlqfP
	6X6QoxUW/VI+Jju8q1aJ682cEtKSfA1OFYFawWiCKPH1+lJHzr2E+T7D2HdaYMLEjWWQt1FzYEV
	aMWkkjJ76Nv1uBzNgC15yXnlk+HJ2DWzqutkUCQE/IYVdpkAmCMbGsJ6Nu2nm5wSeB0uNfP9oNF
	kphCkGGBWyeWxLs4D20E7kb5P4yAHjFksNDr/r/4aASz6GJApbgECEsTMye4CO9KbOokf8JE+vx
	zKXuSSpfpsUnUELedEc/IuWs0h7Ea+X6kBqKB9/S772kGyY/6cig7NDrc2a3HZZ/wblUR+3Eh2J
	/QZOc=
X-Received: by 2002:adf:eb8f:0:b0:47f:97f6:d39a with SMTP id ffacd0b85a97d-47fd72c7121mr27900808f8f.17.1785845149400;
        Tue, 04 Aug 2026 05:05:49 -0700 (PDT)
X-Received: by 2002:adf:eb8f:0:b0:47f:97f6:d39a with SMTP id ffacd0b85a97d-47fd72c7121mr27900691f8f.17.1785845148854;
        Tue, 04 Aug 2026 05:05:48 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41d1756sm41086159f8f.4.2026.08.04.05.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 05:05:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Alex Williamson <alex@shazbot.org>,
	bcm-kernel-feedback-list@broadcom.com,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Christian Koenig <christian.koenig@amd.com>,
	David Hildenbrand <david@kernel.org>,
	dri-devel@lists.freedesktop.org,
	Fei Li <fei1.li@intel.com>,
	Huang Rui <ray.huang@amd.com>,
	linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	Michal Hocko <mhocko@suse.com>,
	Peter Xu <peterx@redhat.com>,
	Sergio Lopez <slp@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	stable@vger.kernel.org
Subject: [PATCH v2 5/6] mm: pull writability check to follow_pfnmap_start()
Date: Tue,  4 Aug 2026 14:05:27 +0200
Message-ID: <20260804120529.1730187-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804120529.1730187-1-pbonzini@redhat.com>
References: <20260804120529.1730187-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All callers of follow_pfnmap_start() except s390_pci_mmio_write()
are following it, if they are doing a write, with a check that
args.writable is true; for s390_pci_mmio_write() that's a bug.
Also, most of them return -EFAULT if it is not.  Pull the check
directly into follow_pfnmap_start() through another input parameter
args.write_fault, to eliminate the need to do it in the caller.

This also fixes an issue where follow_pfnmap_start() would return
0 for a PFN that is mapped read-only, and the caller would not
attempt to call fixup_user_fault() on it; this can happen with
vm_ops that set .pfn_mkwrite(), for example.  Instead, now the
caller (for example hva_to_pfn_remapped()) sees an error,
does attempt to fix it, and only returns -EFAULT if the
fixup was fruitless.

Reported-by: Sergio Lopez <slp@redhat.com>
Fixes: 28e3918179aa ("drm/gem-shmem: Track folio accessed/dirty status in mmap")
Link: https://lore.kernel.org/kvm/CAAiTLFU1ALsDoJoKW3d9bUvv990AozAoX=bEHmfnG54qyBAHFg@mail.gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/s390/pci/pci_mmio.c        |  2 ++
 drivers/vfio/vfio_iommu_type1.c | 17 +++++----
 drivers/virt/acrn/mm.c          | 10 +-----
 include/linux/mm.h              |  3 ++
 mm/memory.c                     | 62 ++++++++++++++++++++-------------
 virt/kvm/kvm_main.c             | 15 ++++----
 6 files changed, 58 insertions(+), 51 deletions(-)

diff --git a/arch/s390/pci/pci_mmio.c b/arch/s390/pci/pci_mmio.c
index 51e7a28af899..d9d5b3318cbc 100644
--- a/arch/s390/pci/pci_mmio.c
+++ b/arch/s390/pci/pci_mmio.c
@@ -180,6 +180,7 @@ SYSCALL_DEFINE3(s390_pci_mmio_write, unsigned long, mmio_addr,
 
 	args.address = mmio_addr;
 	args.vma = vma;
+	args.write = true;
 	ret = follow_pfnmap_start(&args);
 	if (ret) {
 		fixup_user_fault(current->mm, mmio_addr, FAULT_FLAG_WRITE, NULL);
@@ -332,6 +333,7 @@ SYSCALL_DEFINE3(s390_pci_mmio_read, unsigned long, mmio_addr,
 
 	args.vma = vma;
 	args.address = mmio_addr;
+	args.write = false;
 	ret = follow_pfnmap_start(&args);
 	if (ret) {
 		fixup_user_fault(current->mm, mmio_addr, 0, NULL);
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index c8151ba54de3..e6d3a2311a99 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -541,7 +541,11 @@ static int follow_fault_pfn(struct vm_area_struct *vma, struct mm_struct *mm,
 			    unsigned long vaddr, unsigned long *pfn,
 			    unsigned long *addr_mask, bool write_fault)
 {
-	struct follow_pfnmap_args args = { .vma = vma, .address = vaddr };
+	struct follow_pfnmap_args args = {
+		.vma = vma,
+		.address = vaddr,
+		.write = write_fault,
+	};
 	int ret;
 
 	ret = follow_pfnmap_start(&args);
@@ -563,15 +567,10 @@ static int follow_fault_pfn(struct vm_area_struct *vma, struct mm_struct *mm,
 			return ret;
 	}
 
-	if (write_fault && !args.writable) {
-		ret = -EFAULT;
-	} else {
-		*pfn = args.pfn;
-		*addr_mask = args.addr_mask;
-	}
-
+	*pfn = args.pfn;
+	*addr_mask = args.addr_mask;
 	follow_pfnmap_end(&args);
-	return ret;
+	return 0;
 }
 
 /*
diff --git a/drivers/virt/acrn/mm.c b/drivers/virt/acrn/mm.c
index 5bca500a83e0..2f9808399f19 100644
--- a/drivers/virt/acrn/mm.c
+++ b/drivers/virt/acrn/mm.c
@@ -177,7 +177,6 @@ int acrn_vm_ram_map(struct acrn_vm *vm, struct acrn_vm_memmap *memmap)
 	vma = vma_lookup(current->mm, memmap->vma_base);
 	if (vma && ((vma->vm_flags & VM_PFNMAP) != 0)) {
 		unsigned long start_pfn, cur_pfn;
-		bool writable;
 
 		if ((memmap->vma_base + memmap->len) > vma->vm_end) {
 			mmap_read_unlock(current->mm);
@@ -188,6 +187,7 @@ int acrn_vm_ram_map(struct acrn_vm *vm, struct acrn_vm_memmap *memmap)
 			struct follow_pfnmap_args args = {
 				.vma = vma,
 				.address = memmap->vma_base + i * PAGE_SIZE,
+				.write = !!(memmap->attr & ACRN_MEM_ACCESS_WRITE),
 			};
 
 			ret = follow_pfnmap_start(&args);
@@ -197,16 +197,8 @@ int acrn_vm_ram_map(struct acrn_vm *vm, struct acrn_vm_memmap *memmap)
 			cur_pfn = args.pfn;
 			if (i == 0)
 				start_pfn = cur_pfn;
-			writable = args.writable;
 			follow_pfnmap_end(&args);
 
-			/* Disallow write access if the PTE is not writable. */
-			if (!writable &&
-			    (memmap->attr & ACRN_MEM_ACCESS_WRITE)) {
-				ret = -EFAULT;
-				break;
-			}
-
 			/* Disallow refcounted pages. */
 			if (pfn_valid(cur_pfn) &&
 			    !PageReserved(pfn_to_page(cur_pfn))) {
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 01184a4bdd6f..1659cb8f42fd 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3136,9 +3136,12 @@ struct follow_pfnmap_args {
 	 * Inputs:
 	 * @vma: Pointer to @vm_area_struct struct
 	 * @address: the virtual address to walk
+	 * @write: if true, fail with -EFAULT unless the mapping is
+	 * writable
 	 */
 	struct vm_area_struct *vma;
 	unsigned long address;
+	bool write;
 	/**
 	 * Internals:
 	 *
diff --git a/mm/memory.c b/mm/memory.c
index b5555217b121..27f5dcc319c8 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6774,12 +6774,15 @@ int __pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
 }
 #endif /* __PAGETABLE_PMD_FOLDED */
 
-static inline void pfnmap_args_setup(struct follow_pfnmap_args *args,
-				     spinlock_t *lock, pte_t *ptep,
-				     pgprot_t pgprot, unsigned long pfn_base,
-				     unsigned long addr_mask, bool writable,
-				     bool special)
+static inline int pfnmap_args_setup(struct follow_pfnmap_args *args,
+				    spinlock_t *lock, pte_t *ptep,
+				    pgprot_t pgprot, unsigned long pfn_base,
+				    unsigned long addr_mask, bool writable,
+				    bool special)
 {
+	if (!writable && args->write)
+		return -EFAULT;
+
 	args->lock = lock;
 	args->ptep = ptep;
 	args->pfn = pfn_base + ((args->address & ~addr_mask) >> PAGE_SHIFT);
@@ -6787,6 +6790,7 @@ static inline void pfnmap_args_setup(struct follow_pfnmap_args *args,
 	args->pgprot = pgprot;
 	args->writable = writable;
 	args->special = special;
+	return 0;
 }
 
 static inline void pfnmap_lockdep_assert(struct vm_area_struct *vma)
@@ -6808,8 +6812,9 @@ static inline void pfnmap_lockdep_assert(struct vm_area_struct *vma)
  * @args: Pointer to struct @follow_pfnmap_args
  *
  * The caller needs to setup args->vma and args->address to point to the
- * virtual address as the target of such lookup.  On a successful return,
- * the results will be put into other output fields.
+ * virtual address as the target of such lookup, and optionally set
+ * args->write to require a writable mapping.  On a successful
+ * return, the results will be put into other output fields.
  *
  * After the caller finished using the fields, the caller must invoke
  * another follow_pfnmap_end() to proper releases the locks and resources
@@ -6832,7 +6837,8 @@ static inline void pfnmap_lockdep_assert(struct vm_area_struct *vma)
  *
  * This function must not be used to modify PTE content.
  *
- * Return: zero on success, negative otherwise.
+ * Return: zero on success, -EFAULT if @args->write was set but the
+ * mapping is not writable, -EINVAL if there is no mapping at all.
  */
 int follow_pfnmap_start(struct follow_pfnmap_args *args)
 {
@@ -6845,6 +6851,7 @@ int follow_pfnmap_start(struct follow_pfnmap_args *args)
 	pud_t *pudp, pud;
 	pmd_t *pmdp, pmd;
 	pte_t *ptep, pte;
+	int r = -EINVAL;
 
 	pfnmap_lockdep_assert(vma);
 
@@ -6878,10 +6885,12 @@ int follow_pfnmap_start(struct follow_pfnmap_args *args)
 			spin_unlock(lock);
 			goto retry;
 		}
-		pfnmap_args_setup(args, lock, NULL, pud_pgprot(pud),
-				  pud_pfn(pud), PUD_MASK, pud_write(pud),
-				  pud_special(pud));
-		return 0;
+		r = pfnmap_args_setup(args, lock, NULL, pud_pgprot(pud),
+				      pud_pfn(pud), PUD_MASK, pud_write(pud),
+				      pud_special(pud));
+		if (r)
+			spin_unlock(lock);
+		return r;
 	}
 
 	pmdp = pmd_offset(pudp, address);
@@ -6899,10 +6908,12 @@ int follow_pfnmap_start(struct follow_pfnmap_args *args)
 			spin_unlock(lock);
 			goto retry;
 		}
-		pfnmap_args_setup(args, lock, NULL, pmd_pgprot(pmd),
-				  pmd_pfn(pmd), PMD_MASK, pmd_write(pmd),
-				  pmd_special(pmd));
-		return 0;
+		r = pfnmap_args_setup(args, lock, NULL, pmd_pgprot(pmd),
+				      pmd_pfn(pmd), PMD_MASK, pmd_write(pmd),
+				      pmd_special(pmd));
+		if (r)
+			spin_unlock(lock);
+		return r;
 	}
 
 	ptep = pte_offset_map_lock(mm, pmdp, address, &lock);
@@ -6911,14 +6922,16 @@ int follow_pfnmap_start(struct follow_pfnmap_args *args)
 	pte = ptep_get(ptep);
 	if (!pte_present(pte))
 		goto unlock;
-	pfnmap_args_setup(args, lock, ptep, pte_pgprot(pte),
-			  pte_pfn(pte), PAGE_MASK, pte_write(pte),
-			  pte_special(pte));
+	r = pfnmap_args_setup(args, lock, ptep, pte_pgprot(pte),
+			      pte_pfn(pte), PAGE_MASK, pte_write(pte),
+			      pte_special(pte));
+	if (r)
+		goto unlock;
 	return 0;
 unlock:
 	pte_unmap_unlock(ptep, lock);
 out:
-	return -EINVAL;
+	return r;
 }
 EXPORT_SYMBOL_GPL(follow_pfnmap_start);
 
@@ -6960,7 +6973,11 @@ int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
 	int offset = offset_in_page(addr);
 	int ret = -EINVAL;
 	bool writable;
-	struct follow_pfnmap_args args = { .vma = vma, .address = addr };
+	struct follow_pfnmap_args args = {
+		.vma = vma,
+		.address = addr,
+		.write = !!(write & FOLL_WRITE)
+	};
 
 retry:
 	if (follow_pfnmap_start(&args))
@@ -6970,9 +6987,6 @@ int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
 	writable = args.writable;
 	follow_pfnmap_end(&args);
 
-	if ((write & FOLL_WRITE) && !writable)
-		return -EINVAL;
-
 	maddr = ioremap_prot(phys_addr, PAGE_ALIGN(len + offset), prot);
 	if (!maddr)
 		return -ENOMEM;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 576bcb21be3a..b7c21a48a45c 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2928,8 +2928,11 @@ static int hva_to_pfn_slow(struct kvm_follow_pfn *kfp, kvm_pfn_t *pfn)
 static int hva_to_pfn_remapped(struct vm_area_struct *vma,
 			       struct kvm_follow_pfn *kfp, kvm_pfn_t *p_pfn)
 {
-	struct follow_pfnmap_args args = { .vma = vma, .address = kfp->hva };
-	bool write_fault = kfp->flags & FOLL_WRITE;
+	struct follow_pfnmap_args args = {
+		.vma = vma,
+		.address = kfp->hva,
+		.write = !!(kfp->flags & FOLL_WRITE),
+	};
 	int r;
 
 	/*
@@ -2948,7 +2951,7 @@ static int hva_to_pfn_remapped(struct vm_area_struct *vma,
 		 */
 		bool unlocked = false;
 		r = fixup_user_fault(current->mm, kfp->hva,
-				     (write_fault ? FAULT_FLAG_WRITE : 0),
+				     (args.write ? FAULT_FLAG_WRITE : 0),
 				     &unlocked);
 		if (unlocked)
 			return -EAGAIN;
@@ -2960,13 +2963,7 @@ static int hva_to_pfn_remapped(struct vm_area_struct *vma,
 			return r;
 	}
 
-	if (write_fault && !args.writable) {
-		*p_pfn = KVM_PFN_ERR_RO_FAULT;
-		goto out;
-	}
-
 	*p_pfn = kvm_resolve_pfn(kfp, NULL, &args, args.writable);
-out:
 	follow_pfnmap_end(&args);
 	return r;
 }
-- 
2.55.0

