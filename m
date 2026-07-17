Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6EE32570D;
	Fri, 17 Jul 2026 18:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784311537; cv=none; b=elneCjz5ese6NNQIJoJ9czTUuLl0hTgzjNSae9RUdPmdx33A5HDc0nSjYsTd95Pw6I4BSHfk4cCSaVeo3GmGBdaMIYRlThGVq4TF5URt2sAbRCiHL3cbxXLpikfFHGBFSeUwtNuIT2CncljIxVTlLiuX+9uXQpaj/RnysrH92HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784311537; c=relaxed/simple;
	bh=I+x2QPZqGU6QLJFjyfra/KkgEvRsmXqnm/8TIga5+kQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U/PnGAlRLV2vLLHZn2z7QbsPaKbDqW+N3ub01sc1bq6nbiSVc8caORy4Aa3gNMV/X/QYVhvk86p8+XXZl0AMAIj/LiXQZHT85gTOxyfYxyTurQeO5cgdMkK7tdZGkXmMakHqBMMXLR0GC+riGKowePj3ipq44BJdA1ErVhtxo6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PiVA0z2H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PiVA0z2H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85BB81F00A3D;
	Fri, 17 Jul 2026 18:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784311536;
	bh=6JAWb8OTjOFId3JccbNdiGr1f8/BydsRdPfwaJAJRw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PiVA0z2H4Snzd6lFwW/aQE3N8yGaK1f96qr9raHxxnqHLOyMqLswOfAV3OmODRrA7
	 KWUigEa1nQENHkk2fpPUawIZcoNGzZNukyqTGX742GZmzNW6aE5IMprZ53p8Gl0ReC
	 PMiHzCvvyGrqH1+lS0m8KzVFNwiaw7wxbBglg+5j0c4X9d5VMAV2b8SiIO55sh8C1J
	 rRegbQR7pFr11wRS4d3YTLrh7NmJTjul0aBRX04PN8ZcVlAgfLB053IG6duvKqH9/Q
	 QbgfQb2XG57vWlQvnpcQYOqY+7NpdXzDTtJ0ZtvQWUXoQjjlNO9YmGnJeWLKkp7rqQ
	 O0E8L88PGpcHA==
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
	Jason Gunthorpe <jgg@nvidia.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: [PATCH v8 03/23] iommu/dma: Check atomic pool allocation result directly
Date: Fri, 17 Jul 2026 23:34:21 +0530
Message-ID: <20260717180442.110954-4-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717180442.110954-1-aneesh.kumar@kernel.org>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
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
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Petr Tesarik <ptesarik@suse.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/iommu/dma-iommu.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 5598ed4bff72..6a45acbbfb0c 100644
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

