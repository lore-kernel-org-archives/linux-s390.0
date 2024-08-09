Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D05C19CD17
	for <linux-s390@vger.kernel.org>; Fri,  9 Aug 2024 16:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723219784; cv=none; b=MYZboVWyhtHsX+ok/7vrh/mYKqitm2quQjQBwX1Z5FpAhNQWLfHJ5PExxl2oQXTCLMxCpbFsk6h5zAjZzlSX8xcF1s4hFdgqh+81Ol8Pktt+Bd8Qc0Ln/OsWFjdpGTO5fEb9INdjzYxYzt1GyGE4ThvZLbIIItq9iQOEwCz+K54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723219784; c=relaxed/simple;
	bh=F3zrw7GW4L3DDhmifn0KqTitiZnPFDtSbk8TCndoYpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UbmDOvPL+49mlGeKgkUEorUKryh2uL/wTN4AYeWY1CJW6W3OJDgmCngKd0zFL8xfk72OTn0xOBE94KzGsapOayqgJ6U29AUCUMXxjTHbI4jdQfbAJl+WmoP3fM4GBsp79GSsTXwFYziqJzJl51xVnTy6gvghG87UOikIe2eabpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ENtipaz7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ENtipaz7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723219782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kaY3EfeA+k09YWgS+MfGM8qkjlv58srLyvVau/9jXnU=;
	b=ENtipaz71rh2SAEy6Xo9IA/buT9UMTfHL6cA5S+sVuOehMSBPE1/+eSkZQYWDUfUcpe0Gt
	Rf18eqOlJ9N4WhQE4LKahRnOg57KbatxJzFRTjXxQnH0+isW5TRfstVspvF3vfvqzcOC4h
	AOSOrCTbe+Ca8o0gtbdzbtO4mzhglmM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-trgCVm8ZMMeKZJU0tOlzxg-1; Fri, 09 Aug 2024 12:09:41 -0400
X-MC-Unique: trgCVm8ZMMeKZJU0tOlzxg-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-45009e27b83so4905661cf.1
        for <linux-s390@vger.kernel.org>; Fri, 09 Aug 2024 09:09:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723219781; x=1723824581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kaY3EfeA+k09YWgS+MfGM8qkjlv58srLyvVau/9jXnU=;
        b=s2p5/E+cMZpmCyqIik1bdhQrcy4RKWS7weCWwrj2/7iV0AX6P10GF+rmdZry764qNe
         PlDlObGg/MaMXpB6wjAsz828xKjR4ICGvRVVkWsb+EexT8EvW05y/e25vRTYz+yRnn3l
         CsGo1Wo9o7Pwu35MU3YhLfrQbIqbue/2xPEKwG+dTH4CdNbwCK/StohWMsFTJP7ZtdQx
         jsrKUw20blnncXFW9Psnp62sxylwlE2pDK/nz8+y8rqvi80NxRS1lhlrsYbIVjATq6DB
         nQCkH1j4yctLI0M+Qqoyuj4vvmCK10rklRbI+IHGr4CDkV2thaKlfUSqR/qV1jM2LuhV
         EKVA==
X-Forwarded-Encrypted: i=1; AJvYcCUle39INcFc/EPy4/Hks4snRJW9nTKIyBrzBM6lOK/MoyfGG702WGUgQVzQtBVFEtHFBA6iEaGv98kanDt/EqpwsIVVFeXuXsx6nA==
X-Gm-Message-State: AOJu0YyfOalENgqB56Hxfzw3SZ+xMH+A2/Mg4tizCF4fLbCcu4M3oq58
	1dXTyObEfcvOo+lL2lwdxo9Sxl16bMd7N1DUtmiyh0wuVzjTjoZjZh2Qd6ctWiojNED+yrWyJsS
	y5S5pNdbmoaKnPGe6YXlvOnSmJSONzqxEne9EE/yLvpYAm3qMGzk4yashBMo=
X-Received: by 2002:ac8:5912:0:b0:450:efd:723 with SMTP id d75a77b69052e-453125552fbmr13163261cf.4.1723219780561;
        Fri, 09 Aug 2024 09:09:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtbIkutydCKQHHfrahTRflQkyMYGSh3zYrObmthmw14T659Ni251Xo72HIqIFQZU+hooLp2A==
X-Received: by 2002:ac8:5912:0:b0:450:efd:723 with SMTP id d75a77b69052e-453125552fbmr13162951cf.4.1723219780083;
        Fri, 09 Aug 2024 09:09:40 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-451c870016csm22526741cf.19.2024.08.09.09.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 09:09:39 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Oscar Salvador <osalvador@suse.de>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	peterx@redhat.com,
	Will Deacon <will@kernel.org>,
	Gavin Shan <gshan@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Alistair Popple <apopple@nvidia.com>,
	Borislav Petkov <bp@alien8.de>,
	David Hildenbrand <david@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	kvm@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Yan Zhao <yan.y.zhao@intel.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	linux-s390@vger.kernel.org
Subject: [PATCH 11/19] s390/pci_mmio: Use follow_pfnmap API
Date: Fri,  9 Aug 2024 12:09:01 -0400
Message-ID: <20240809160909.1023470-12-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240809160909.1023470-1-peterx@redhat.com>
References: <20240809160909.1023470-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the new API that can understand huge pfn mappings.

Cc: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/s390/pci/pci_mmio.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/s390/pci/pci_mmio.c b/arch/s390/pci/pci_mmio.c
index 5398729bfe1b..de5c0b389a3e 100644
--- a/arch/s390/pci/pci_mmio.c
+++ b/arch/s390/pci/pci_mmio.c
@@ -118,12 +118,11 @@ static inline int __memcpy_toio_inuser(void __iomem *dst,
 SYSCALL_DEFINE3(s390_pci_mmio_write, unsigned long, mmio_addr,
 		const void __user *, user_buffer, size_t, length)
 {
+	struct follow_pfnmap_args args = { };
 	u8 local_buf[64];
 	void __iomem *io_addr;
 	void *buf;
 	struct vm_area_struct *vma;
-	pte_t *ptep;
-	spinlock_t *ptl;
 	long ret;
 
 	if (!zpci_is_enabled())
@@ -169,11 +168,13 @@ SYSCALL_DEFINE3(s390_pci_mmio_write, unsigned long, mmio_addr,
 	if (!(vma->vm_flags & VM_WRITE))
 		goto out_unlock_mmap;
 
-	ret = follow_pte(vma, mmio_addr, &ptep, &ptl);
+	args.address = mmio_addr;
+	args.vma = vma;
+	ret = follow_pfnmap_start(&args);
 	if (ret)
 		goto out_unlock_mmap;
 
-	io_addr = (void __iomem *)((pte_pfn(*ptep) << PAGE_SHIFT) |
+	io_addr = (void __iomem *)((args.pfn << PAGE_SHIFT) |
 			(mmio_addr & ~PAGE_MASK));
 
 	if ((unsigned long) io_addr < ZPCI_IOMAP_ADDR_BASE)
@@ -181,7 +182,7 @@ SYSCALL_DEFINE3(s390_pci_mmio_write, unsigned long, mmio_addr,
 
 	ret = zpci_memcpy_toio(io_addr, buf, length);
 out_unlock_pt:
-	pte_unmap_unlock(ptep, ptl);
+	follow_pfnmap_end(&args);
 out_unlock_mmap:
 	mmap_read_unlock(current->mm);
 out_free:
@@ -260,12 +261,11 @@ static inline int __memcpy_fromio_inuser(void __user *dst,
 SYSCALL_DEFINE3(s390_pci_mmio_read, unsigned long, mmio_addr,
 		void __user *, user_buffer, size_t, length)
 {
+	struct follow_pfnmap_args args = { };
 	u8 local_buf[64];
 	void __iomem *io_addr;
 	void *buf;
 	struct vm_area_struct *vma;
-	pte_t *ptep;
-	spinlock_t *ptl;
 	long ret;
 
 	if (!zpci_is_enabled())
@@ -308,11 +308,13 @@ SYSCALL_DEFINE3(s390_pci_mmio_read, unsigned long, mmio_addr,
 	if (!(vma->vm_flags & VM_WRITE))
 		goto out_unlock_mmap;
 
-	ret = follow_pte(vma, mmio_addr, &ptep, &ptl);
+	args.vma = vma;
+	args.address = mmio_addr;
+	ret = follow_pfnmap_start(&args);
 	if (ret)
 		goto out_unlock_mmap;
 
-	io_addr = (void __iomem *)((pte_pfn(*ptep) << PAGE_SHIFT) |
+	io_addr = (void __iomem *)((args.pfn << PAGE_SHIFT) |
 			(mmio_addr & ~PAGE_MASK));
 
 	if ((unsigned long) io_addr < ZPCI_IOMAP_ADDR_BASE) {
@@ -322,7 +324,7 @@ SYSCALL_DEFINE3(s390_pci_mmio_read, unsigned long, mmio_addr,
 	ret = zpci_memcpy_fromio(buf, io_addr, length);
 
 out_unlock_pt:
-	pte_unmap_unlock(ptep, ptl);
+	follow_pfnmap_end(&args);
 out_unlock_mmap:
 	mmap_read_unlock(current->mm);
 
-- 
2.45.0

