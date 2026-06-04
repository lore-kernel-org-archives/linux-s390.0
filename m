Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98473F54AD;
	Thu,  4 Jun 2026 08:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562485; cv=none; b=dNQxTYQNsKGtFVF1WbhBHpEEFVoDufbyE7Q4wLzJ+MCtUL9QIen+aMyTK/PhEOGzhCs/aGQ9hArkAP5dkh8zzZce35EvxRFHiAPnepBOmj9nnR0mhH8uNSjPzp+u89yBGjC5T8nAYW0pyoKUJsE2NZTTqOs4j0FKH1hkPLlEPj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562485; c=relaxed/simple;
	bh=nvh8fIDNVPfMC0ICTaQnFFRAmvBIOsOrYj/UqKcPxjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pyXv4lLDifI8WVdGH7ivBaYsRHhbcjkuUraHN5DS6SKyY03RHJezFDIJsoYNBKlWn+bHPTVE6UbbwzMwn53dunl7q09tDMGAOBC8ECMilacKCIbNvrOvqBA7n1RBoZsyh7MxJENa+AiwONamgmVjmqlUQhzFBhL4U+vkrCat/sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGHCOI2B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGHCOI2B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91CED1F00893;
	Thu,  4 Jun 2026 08:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780562478;
	bh=7TH+Qx6Oz0KBtBZSC9IyhaEGjXmJSkpAjhqTot9QjuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dGHCOI2Bz9um/GE0RCmyC1Qk8mhygoFuyVx4f9RWLcknMIrnOeO1o89nB7cD6S1eF
	 HCwS2uugMipB1BZZH5MOmysdZMPH0ywJ3v9XoAj1yRJIpnDZO+zVuVaxmS7xdumvUp
	 NhS3o2stcEn3JDpf4ibdzQtQIEtCrc8xyj9TzgZgAX2LAxwHSvOZoGAOydxesY33LJ
	 w/TE2fgsn7CR7xJMRQ2Yv8WjUDeo1bXqs/XKP2MCtX+ZKF4fT7bhuDsxbjYKpoWdVf
	 WEkG7JikC58CakVgsl1VdHpKsKTWdOMBv770v1GQXd2lrC7+ywI2slHBfh2xQzbqhw
	 voPqTvIfAquqw==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	x86@kernel.org,
	Jiri Pirko <jiri@nvidia.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: [PATCH v6 07/20] dma-mapping: make dma_pgprot() honor DMA_ATTR_CC_SHARED
Date: Thu,  4 Jun 2026 14:09:46 +0530
Message-ID: <20260604083959.1265923-8-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fold encrypted/decrypted pgprot selection into dma_pgprot() so callers
do not need to adjust the page protection separately.

Update dma_pgprot() to apply pgprot_decrypted() when
DMA_ATTR_CC_SHARED is set and pgprot_encrypted() otherwise Convert
the dma-direct allocation and mmap paths to pass DMA_ATTR_CC_SHARED
instead of open-coding force_dma_unencrypted() handling around
dma_pgprot().

Tested-by: Jiri Pirko <jiri@nvidia.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 kernel/dma/direct.c  |  8 +++-----
 kernel/dma/mapping.c | 16 ++++++++++++----
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 0b4a26c6b6fd..e4cba322386d 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -290,9 +290,6 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	if (remap) {
 		pgprot_t prot = dma_pgprot(dev, PAGE_KERNEL, attrs);
 
-		if (force_dma_unencrypted(dev))
-			prot = pgprot_decrypted(prot);
-
 		/* remove any dirty cache lines on the kernel alias */
 		arch_dma_prep_coherent(page, size);
 
@@ -614,9 +611,10 @@ int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
 	unsigned long pfn = PHYS_PFN(dma_to_phys(dev, dma_addr));
 	int ret = -ENXIO;
 
-	vma->vm_page_prot = dma_pgprot(dev, vma->vm_page_prot, attrs);
 	if (force_dma_unencrypted(dev))
-		vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
+		attrs |= DMA_ATTR_CC_SHARED;
+
+	vma->vm_page_prot = dma_pgprot(dev, vma->vm_page_prot, attrs);
 
 	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
 		return ret;
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index e6b07f160d20..3f4ae283c466 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -539,13 +539,21 @@ EXPORT_SYMBOL(dma_get_sgtable_attrs);
  */
 pgprot_t dma_pgprot(struct device *dev, pgprot_t prot, unsigned long attrs)
 {
+	pgprot_t dma_prot;
+
 	if (dev_is_dma_coherent(dev))
-		return prot;
+		dma_prot = prot;
 #ifdef CONFIG_ARCH_HAS_DMA_WRITE_COMBINE
-	if (attrs & DMA_ATTR_WRITE_COMBINE)
-		return pgprot_writecombine(prot);
+	else if (attrs & DMA_ATTR_WRITE_COMBINE)
+		dma_prot = pgprot_writecombine(prot);
 #endif
-	return pgprot_dmacoherent(prot);
+	else
+		dma_prot = pgprot_dmacoherent(prot);
+
+	if (attrs & DMA_ATTR_CC_SHARED)
+		return pgprot_decrypted(dma_prot);
+	else
+		return pgprot_encrypted(dma_prot);
 }
 #endif /* CONFIG_MMU */
 
-- 
2.43.0

