Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22784445AFF
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 16:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785513928; cv=none; b=BcR1l3BhGwu0lVKZJeXiPg3ZL7/sxU9BQqlzo6ovjNXhBoBiE8RzeFv23iGoUY5ClY53NR0Eky21n1rnx8/a22ZEuNAmIE0J31YnLgU9bT8NW80R0LQ9PaN4WPnYLoH9ZC4blBTdmygZ9WOLI12P82gLCaB7sv5XAqcPGacHQ5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785513928; c=relaxed/simple;
	bh=FvAJtRZM3oRNkOyl4bjSYZVL2PnR54k3l10zUVMaLZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ViYMv026mVoHPNoVNrAuhd2ctbC+rnDjhqG1sxtoDUSy76j07LWRoCo2mGqDJdqmw6BHN2q4Mk+dbT/X+OGFOWd25YqD9z9JHSbasfavQMbj5Q3y9sVEtG4aNK0bSNpe5pfdMhzlVGiL0g5ysMjXyi9gSqU4Uk6IxS24RGuLjQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cF0inJdl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Apd+cy6X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cF0inJdl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Apd+cy6X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785513925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ryHo/Pk85RB1et4y6uESf2yi2i/ESrF3Kar7ZIFnpUk=;
	b=cF0inJdlPS4WhUGB3rSdfRVF2A5rfso4XQpLcafsiPKl03UxfENGnDzYPv7jUbNHchm5HH
	b0wt9YKInnRxJ7lX2Wq1Tbz/6FVgXQLjvJM44v/x2/Ly4XrPsPEOOaJ5l5ZH34qevRoZWt
	iYZnEViHs9OwF9AoO9WJI3DRpToKD7I=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-gaF2xdv2OK-wej-dm4HmVQ-1; Fri, 31 Jul 2026 12:05:23 -0400
X-MC-Unique: gaF2xdv2OK-wej-dm4HmVQ-1
X-Mimecast-MFC-AGG-ID: gaF2xdv2OK-wej-dm4HmVQ_1785513922
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c16711b9473so105338666b.2
        for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 09:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785513922; x=1786118722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ryHo/Pk85RB1et4y6uESf2yi2i/ESrF3Kar7ZIFnpUk=;
        b=Apd+cy6X19lX3mptmm4bAoQNsUQBUYGkDFEzqMSCnuNnVNr7JHshQGEl8KUAoS9EG0
         lDBxEMArIFlZwSGR0dTIVnrOKTKybzjdVQ5UDasinFpFAXDeFtESsgqvnpvYmDtMRFb2
         3iVL58HN5hRUDP8ldR7xS/lxk5QtUYjoUjumgKx72h7M2nTCqqCkmV2V5s14WDaP3X5j
         AoUTTSMwQTjw4s4VtC3a4mJXSm0kpq3kZep6nly+02+vTqv6usH059F0dpka0qxYcFni
         QugFxP53x3C3xSvTOEbKu/RLHF9SlEXuwudDwVjfKxwj7f0cyVWdMvjl25ODysV0IX7L
         dayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785513922; x=1786118722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ryHo/Pk85RB1et4y6uESf2yi2i/ESrF3Kar7ZIFnpUk=;
        b=IMMmqWPwO7MSkbd7gunvrxgVhuQln9jGFRWcfXjUHPOlJBnTkUkSxtmrVIB4a3vaHN
         oz4cmGcBxuB50Or7oOghAjrSOoUm4S+o+lQBsiAQ7SZFnmsoy+aj+2SRnTLq61xeHmw8
         4EwwgfzsCdmthU6ev1a0SpllUHk3iIUWQcqH48AODkKWA8KfYq8aLLEfnzhdwjV+jvgo
         9oWcZ7ElpIZ3LMkW3FHF0hf6BEstiUILd5PTsW81t+6MU96ufUBIXRnxyuCht7ryjCc0
         s75oMkKdY16Re0XKxaiJiAF/XgJr3v8d1iJQ0HKpJDPQbf4x5XlPXbCYrn65KsmpEuqH
         Ifvg==
X-Forwarded-Encrypted: i=1; AHgh+RoFdqWMRAVJhBFds34LJdCgbNrRjskD7j6VHNlYMrL+R0Rp/sUTKZYQSOyCrmwflatlwaF/eslY5nKc@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5/itxTcwg6iPeTOb0u33ptFtXhNIzubQ7olfMyk0y9Bl1jFRj
	1XJxzP5k12Tskg0KJoJ7iVUzqAUMJ5kFrBjMKWlJO8TETrjSpYO4sw7AHZI+tmtitJmo/aL4nGk
	S81BQAWS8FLKnAsqZS8UYSfEcw7YoRAgVJCN34jmGrF/gLkxBlZCgSnmFJVRQ/2U=
X-Gm-Gg: AR+sD133kVPpcfM3mJtefxK97nkJW0iItSrKZTP3iomRl+uYkZgUVDqDa+SNtiiwG/x
	hhSSRIevXtqbJXmCzq00qc4/Ydm1U90h+xjJUzWoHtFIvowLbKZaawJBFR3xw0uLV3XcFRIh3Ik
	WN8Yqf8tv6ubECVUITc/7Co35o2dmfrGmcowKVTwBIqm09EegUL/dhibRrSV4SZj0xBO7vxSB8W
	jWApD/Vrk2VylhaePIvR7Fz5mpGEOUQ1wxYcS2Bm4/LROzVsKkXAd7iBL8tOeAPpQ0ix5JdxGKt
	yWKzmSGtTAFMUwKVPSNH7HHMjNJHlmW4UUhuTteh/TRmrXnBXABzxioFFc60hmiBHPY20I6CwxB
	787DQCxLbRJWdx0nQ0HFmIejskPGmsFL6QgYlKJ4Tia3fOuw97WMYGVzt7VdUsYrXjuvhHGm8GQ
	jvrGY=
X-Received: by 2002:a17:906:ee81:b0:c15:9709:fb9b with SMTP id a640c23a62f3a-c1fe8373675mr8933866b.44.1785513921881;
        Fri, 31 Jul 2026 09:05:21 -0700 (PDT)
X-Received: by 2002:a17:906:ee81:b0:c15:9709:fb9b with SMTP id a640c23a62f3a-c1fe8373675mr8929866b.44.1785513921309;
        Fri, 31 Jul 2026 09:05:21 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd44542d2sm222203766b.35.2026.07.31.09.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 09:05:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Alex Williamson <alex@shazbot.org>,
	Fei Li <fei1.li@intel.com>,
	David Hildenbrand <david@kernel.org>,
	Peter Xu <peterx@redhat.com>,
	linux-s390@vger.kernel.org,
	linux-mm@kvack.org,
	Sergio Lopez <slp@redhat.com>
Subject: [PATCH] mm: pull writability check to follow_pfnmap_start()
Date: Fri, 31 Jul 2026 18:05:14 +0200
Message-ID: <20260731160514.1101989-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All callers of follow_pfnmap_start() except s390_pci_mmio_write() are
following it, if they are doing a write, with a check that args.writable
is true; for s390_pci_mmio_write() that's a bug.  Most of them return
-EFAULT if it is not, but because follow_pfnmap_start() returned success,
they do not attempt to upgrade the page from read-only to read-write
with fixup_user_fault().

Pull the check directly into follow_pfnmap_start() through another
input parameter args.write_fault; this eliminates the need to do it in
the caller and, for callers that do use fixup_user_fault(), lets it
attempt to upgrade the page.

The change in return code to -EFAULT is okay:

- s390 is the only one to have a functional change in this respect;
  but EINVAL is only documented for "Invalid length argument", while
  "The address in mmio_addr is invalid" should already return EFAULT
  (https://www.man7.org/linux/man-pages/man2/s390_pci_mmio_read.2.html)

- for VFIO and ACRN, -EFAULT was returned already

- for KVM, -EFAULT is eaten

- for generic_access_phys() the caller is __access_remote_vm()
  which does not care about the error code.

Reported-by: Sergio Lopez <slp@redhat.com>
Link: https://lore.kernel.org/kvm/CAAiTLFU1ALsDoJoKW3d9bUvv990AozAoX=bEHmfnG54qyBAHFg@mail.gmail.com/
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
	Sergio, this is half of the fix for your issue.  Please
	test both patches together if possible.

 arch/s390/pci/pci_mmio.c        |  2 ++
 drivers/vfio/vfio_iommu_type1.c | 17 +++++----
 drivers/virt/acrn/mm.c          | 10 +-----
 include/linux/mm.h              |  3 ++
 mm/memory.c                     | 62 ++++++++++++++++++++-------------
 virt/kvm/kvm_main.c             | 22 ++++++------
 6 files changed, 64 insertions(+), 52 deletions(-)

diff --git a/arch/s390/pci/pci_mmio.c b/arch/s390/pci/pci_mmio.c
index 51e7a28af899..526f80b8fb3b 100644
--- a/arch/s390/pci/pci_mmio.c
+++ b/arch/s390/pci/pci_mmio.c
@@ -180,6 +180,7 @@ SYSCALL_DEFINE3(s390_pci_mmio_write, unsigned long, mmio_addr,
 
 	args.address = mmio_addr;
 	args.vma = vma;
+	args.write_fault = true;
 	ret = follow_pfnmap_start(&args);
 	if (ret) {
 		fixup_user_fault(current->mm, mmio_addr, FAULT_FLAG_WRITE, NULL);
@@ -332,6 +333,7 @@ SYSCALL_DEFINE3(s390_pci_mmio_read, unsigned long, mmio_addr,
 
 	args.vma = vma;
 	args.address = mmio_addr;
+	args.write_fault = false;
 	ret = follow_pfnmap_start(&args);
 	if (ret) {
 		fixup_user_fault(current->mm, mmio_addr, 0, NULL);
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index c8151ba54de3..9ee92820b4de 100644
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
+		.write_fault = write_fault
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
index 5bca500a83e0..b057e78ef3f4 100644
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
+				.write_fault = !!(memmap->attr & ACRN_MEM_ACCESS_WRITE),
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
index 485df9c2dbdd..34c79b5fcb9b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3136,9 +3136,12 @@ struct follow_pfnmap_args {
 	 * Inputs:
 	 * @vma: Pointer to @vm_area_struct struct
 	 * @address: the virtual address to walk
+	 * @write_fault: if true, fail with -EFAULT unless the mapping is
+	 * writable
 	 */
 	struct vm_area_struct *vma;
 	unsigned long address;
+	bool write_fault;
 	/**
 	 * Internals:
 	 *
diff --git a/mm/memory.c b/mm/memory.c
index ff338c2abe92..40997a26846f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6786,12 +6786,15 @@ int __pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
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
+	if (!writable && args->write_fault)
+		return -EFAULT;
+
 	args->lock = lock;
 	args->ptep = ptep;
 	args->pfn = pfn_base + ((args->address & ~addr_mask) >> PAGE_SHIFT);
@@ -6799,6 +6802,7 @@ static inline void pfnmap_args_setup(struct follow_pfnmap_args *args,
 	args->pgprot = pgprot;
 	args->writable = writable;
 	args->special = special;
+	return 0;
 }
 
 static inline void pfnmap_lockdep_assert(struct vm_area_struct *vma)
@@ -6820,8 +6824,9 @@ static inline void pfnmap_lockdep_assert(struct vm_area_struct *vma)
  * @args: Pointer to struct @follow_pfnmap_args
  *
  * The caller needs to setup args->vma and args->address to point to the
- * virtual address as the target of such lookup.  On a successful return,
- * the results will be put into other output fields.
+ * virtual address as the target of such lookup, and optionally set
+ * args->write_fault to require a writable mapping.  On a successful
+ * return, the results will be put into other output fields.
  *
  * After the caller finished using the fields, the caller must invoke
  * another follow_pfnmap_end() to proper releases the locks and resources
@@ -6844,7 +6849,8 @@ static inline void pfnmap_lockdep_assert(struct vm_area_struct *vma)
  *
  * This function must not be used to modify PTE content.
  *
- * Return: zero on success, negative otherwise.
+ * Return: zero on success, -EFAULT if @args->write_fault was set but the
+ * mapping is not writable, -EINVAL if there is no mapping at all.
  */
 int follow_pfnmap_start(struct follow_pfnmap_args *args)
 {
@@ -6857,6 +6863,7 @@ int follow_pfnmap_start(struct follow_pfnmap_args *args)
 	pud_t *pudp, pud;
 	pmd_t *pmdp, pmd;
 	pte_t *ptep, pte;
+	int r = -EINVAL;
 
 	pfnmap_lockdep_assert(vma);
 
@@ -6890,10 +6897,12 @@ int follow_pfnmap_start(struct follow_pfnmap_args *args)
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
@@ -6911,10 +6920,12 @@ int follow_pfnmap_start(struct follow_pfnmap_args *args)
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
@@ -6923,14 +6934,16 @@ int follow_pfnmap_start(struct follow_pfnmap_args *args)
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
 
@@ -6972,7 +6985,11 @@ int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
 	int offset = offset_in_page(addr);
 	int ret = -EINVAL;
 	bool writable;
-	struct follow_pfnmap_args args = { .vma = vma, .address = addr };
+	struct follow_pfnmap_args args = {
+		.vma = vma,
+		.address = addr,
+		.write_fault = !!(write & FOLL_WRITE)
+	};
 
 retry:
 	if (follow_pfnmap_start(&args))
@@ -6982,9 +6999,6 @@ int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
 	writable = args.writable;
 	follow_pfnmap_end(&args);
 
-	if ((write & FOLL_WRITE) && !writable)
-		return -EINVAL;
-
 	maddr = ioremap_prot(phys_addr, PAGE_ALIGN(len + offset), prot);
 	if (!maddr)
 		return -ENOMEM;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 45e784462ec6..0c4ff223162b 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2939,8 +2939,11 @@ static bool vma_is_valid(struct vm_area_struct *vma, bool write_fault)
 static int hva_to_pfn_remapped(struct vm_area_struct *vma,
 			       struct kvm_follow_pfn *kfp, kvm_pfn_t *p_pfn)
 {
-	struct follow_pfnmap_args args = { .vma = vma, .address = kfp->hva };
-	bool write_fault = kfp->flags & FOLL_WRITE;
+	struct follow_pfnmap_args args = {
+		.vma = vma,
+		.address = kfp->hva,
+		.write_fault = !!(kfp->flags & FOLL_WRITE),
+	};
 	int r;
 
 	/*
@@ -2959,7 +2962,7 @@ static int hva_to_pfn_remapped(struct vm_area_struct *vma,
 		 */
 		bool unlocked = false;
 		r = fixup_user_fault(current->mm, kfp->hva,
-				     (write_fault ? FAULT_FLAG_WRITE : 0),
+				     (args.write_fault ? FAULT_FLAG_WRITE : 0),
 				     &unlocked);
 		if (unlocked)
 			return -EAGAIN;
@@ -2967,17 +2970,16 @@ static int hva_to_pfn_remapped(struct vm_area_struct *vma,
 			return r;
 
 		r = follow_pfnmap_start(&args);
-		if (r)
+		if (r) {
+			if (r == -EFAULT) {
+				*p_pfn = KVM_PFN_ERR_RO_FAULT;
+				return 0;
+			}
 			return r;
-	}
-
-	if (write_fault && !args.writable) {
-		*p_pfn = KVM_PFN_ERR_RO_FAULT;
-		goto out;
+		}
 	}
 
 	*p_pfn = kvm_resolve_pfn(kfp, NULL, &args, args.writable);
-out:
 	follow_pfnmap_end(&args);
 	return r;
 }
-- 
2.55.0

