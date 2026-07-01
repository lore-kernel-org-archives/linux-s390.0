Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DA1363082;
	Wed,  1 Jul 2026 05:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782885018; cv=none; b=t3of6HUfnbQUug5dMB8c2fU5zUfFpZEM540ahD6enNZf9CqstfuVbI6a3gHJ9FDhBa/g2KJ31JqXFo2cBEoe8GKQDQiX7F6kow+LxVGl0mhFix+EG4VIpgrBqG5BmKIk/VnOUHFgH9sIyQ0/SI3FA9HXCmsqvnH14rWsmnNkTXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782885018; c=relaxed/simple;
	bh=7FbhRVw8cBPyD1/jLexpAz1rsj92vYAUFbhd2ZINj9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QM9iH9mTPrl6ysZjVgxbalblVmSAGQyKuCRzwgBMWjHvwa+7n8FMyLaN4V+c7jrpZSGsvDxJCDEAAy6Pm+KG8DxGNuIiICOQkN7RQqWErzFqbHBnKgcDKXyFZd/9lAsOIgXPLWosQ4MH1ABNYYcBuqGOVg6IJeO2O7nUgdvtRbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PqLZczq9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqLZczq9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384CC1F000E9;
	Wed,  1 Jul 2026 05:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782885017;
	bh=zIStNUVzsvlerZ+QizOjlOviNoWs8cBtD6MZ6LvxLus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PqLZczq9nytjMBIz1gRDydlihYseOQeVOh/BvcuAXuc9JPjZOlmiht58x0FPEjo+t
	 hRTrQEt8VRYn0Dmcz4xIr9jogYS72zVWWm9a1wZ1RRULLb64cBOhUMCrYC/swel+dA
	 ZyoLBtoKkFRKCuwhTEHXgXRQoGO1RCGg0G9QHrwCdVZWRp3/5fgBR2fo9OtJT9KpMy
	 XL/T7gq6c3pHw6pRYYctQ9qxoPHQ6jOcXx9d8+17+Dj+FsUiao8LxmkbJRnelGgGGu
	 dfjeSVnAKzkDyZ9j/uewEKB74utsKJdh7dQJNELbyyNu9l2yEGf0+ry2LSNxuS+LBI
	 0P6ZUT1CXWeLw==
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
	Michael Kelley <mhklinux@outlook.com>
Subject: [PATCH v7 03/22] iommu/dma: Check atomic pool allocation result directly
Date: Wed,  1 Jul 2026 11:19:07 +0530
Message-ID: <20260701054926.825925-4-aneesh.kumar@kernel.org>
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

The non-blocking, non-coherent allocation path uses dma_alloc_from_pool(),
which returns the allocated page and fills cpu_addr only on success.

Do not rely on cpu_addr to detect allocation failure in this path. Check
the returned page directly before using it for the IOMMU mapping.

Fixes: 9420139f516d ("dma-pool: fix coherent pool allocations for IOMMU mappings")
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Petr Tesarik <ptesarik@suse.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/iommu/dma-iommu.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 9abaec0703ef..68c686c1e81a 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1671,13 +1671,16 @@ void *iommu_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 	}
 
 	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
-	    !gfpflags_allow_blocking(gfp) && !coherent)
+	    !gfpflags_allow_blocking(gfp) && !coherent) {
 		page = dma_alloc_from_pool(dev, PAGE_ALIGN(size), &cpu_addr,
-					       gfp, NULL);
-	else
+					   gfp, NULL);
+		if (!page)
+			return NULL;
+	} else {
 		cpu_addr = iommu_dma_alloc_pages(dev, size, &page, gfp, attrs);
-	if (!cpu_addr)
-		return NULL;
+		if (!cpu_addr)
+			return NULL;
+	}
 
 	*handle = __iommu_dma_map(dev, page_to_phys(page), size, ioprot,
 			dev->coherent_dma_mask);
-- 
2.43.0

