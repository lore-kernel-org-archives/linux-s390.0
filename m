Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A481E36167B;
	Wed,  1 Jul 2026 05:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782885139; cv=none; b=QwxfW6vkO60CFhXc+eTokZqIDZ+88kQlap3hkerd5V4dgd6TgdYt8iUvH13TWPMejVH5VKKrwRlMPBTyUUJGgMeh15Sm5BNuY7pKCQN1MCGRShzyOluhUHul0A1Wgnj8n0gb0xMkndAFYh2DpEQi4SvRW7TJ+bHI/NszZp+v6XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782885139; c=relaxed/simple;
	bh=DekLrzqpA2u1VrCMqNuBoozUb2SnSNPeyWhNfttOa9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SVq6oKVeR8EBwK09Jrf5qIp1Jgj58YcWooR6VBjsu1UNLjjF0xaGvsG6sFl8gw6X8dQjqx184QSHI/vdDpqSoQdjr1NTDCBzuBc31ivZVbSODLq5RALH7FrjEs/Q/irhiwyzNq2mkUkFsGEAUh5E/06O1gnbXhrcdC1F/s8hhTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTOPEfvw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTOPEfvw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C60B01F00A3A;
	Wed,  1 Jul 2026 05:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782885138;
	bh=WaFole9WpH4WOdu0NoPZcwNtksyiD1swupReo/MXirw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CTOPEfvw+FTCjKT/3u4xNFzwHn2wRv7oSUt5koWJF9u9uNkLVk0MOmnuX0sfPKxAR
	 A5jTcoIgUSqlN78yWHoDkpWvbDcimQDU8TpT+DslgtdgKQx8C59xg4vXr1vvuqUN3+
	 ITwjK3Ea3288affFm4tea8Z478PtpCkPaAOF3umxoqmh2VlYK5pMD5fWUGfWeb9KQi
	 7wB+vIqlrcEmteCtLDA3If4owvXWb8HNSPY+YsWg2vFQU4DiwxHgNPwp+ezusSFQwi
	 ZkKgOwXfldX9XL6QJOAF3jv7OaGA5XsBKIP72v4dlk3/zl9yyyC7xQlOzbYzmi9eKV
	 0wIHdeWYMTnTQ==
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
Subject: [PATCH v7 14/22] dma-mapping: make dma_pgprot() honor __DMA_ATTR_ALLOC_CC_SHARED
Date: Wed,  1 Jul 2026 11:19:18 +0530
Message-ID: <20260701054926.825925-15-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701054926.825925-1-aneesh.kumar@kernel.org>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fold encrypted/decrypted pgprot selection into dma_pgprot() so callers
do not need to adjust the page protection separately.

Update dma_pgprot() to apply pgprot_decrypted() when DMA_ATTR_CC_SHARED or
__DMA_ATTR_ALLOC_CC_SHARED is set and pgprot_encrypted() otherwise Convert
the dma-direct mmap paths to pass DMA_ATTR_CC_SHARED instead of open-coding
force_dma_unencrypted() handling around dma_pgprot().

Tested-by: Jiri Pirko <jiri@nvidia.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 kernel/dma/direct.c  |  8 +++-----
 kernel/dma/mapping.c | 16 ++++++++++++----
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 64cb9f13ef03..9935f7caa459 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -283,9 +283,6 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	if (remap) {
 		pgprot_t prot = dma_pgprot(dev, PAGE_KERNEL, attrs);
 
-		if (force_dma_unencrypted(dev))
-			prot = pgprot_decrypted(prot);
-
 		/* remove any dirty cache lines on the kernel alias */
 		arch_dma_prep_coherent(page, size);
 
@@ -605,9 +602,10 @@ int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
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
index d2f70b6ccd0f..a628820fd10e 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -537,13 +537,21 @@ EXPORT_SYMBOL(dma_get_sgtable_attrs);
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
+	if (attrs & (DMA_ATTR_CC_SHARED | __DMA_ATTR_ALLOC_CC_SHARED))
+		return pgprot_decrypted(dma_prot);
+	else
+		return pgprot_encrypted(dma_prot);
 }
 #endif /* CONFIG_MMU */
 
-- 
2.43.0

