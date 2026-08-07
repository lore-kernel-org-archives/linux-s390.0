Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6BC3DA7D0;
	Fri,  7 Aug 2026 09:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786094787; cv=none; b=pb6bJT2Y8faH816BptDKCc/f/ATDgCCtSmybFnKqSmsWJT9QphDQGkumbzI1BWn+NSPEwudVMj1I/1LNkK3x6XXVwkCz41riKoXsdSwv6s5i/1zA+kOoid6/PlDM3M8A5p/umXheMl6pDzxNQLAJiBtQAKi/MzuxRi3xAxKR9X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786094787; c=relaxed/simple;
	bh=yC53ntSAx5TD4rakJuUXTcBjWTcwV9oM0D7eTaR4xPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jxOlJuW0LL6Hvc1j9H5jqXodV+VJv9Fx2Gas6JEbYO4FwpwtS4LrhTFq74ljw5XSVLOuS9sihhpmpJKqVwO9GsNRXjLblentIBIaJM1VxT5UuCoOqm9Wi4NUiljJrS/LI8/SAeFBeEZPlFWWlyd5LUXhLvpuur+gRSbbycOG6Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfRd+7a/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfRd+7a/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15F61F000E9;
	Fri,  7 Aug 2026 09:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786094786;
	bh=n1DOBxxHQjvAtdVCr2XmzOoDCY/LkKFWumLIHDVnml4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KfRd+7a/nQO5IHNyvsOPwguzYdeKqDRBtEiWacDi8mGZTtLnEJKuLyO6lsWudhrXX
	 Vjjh9c97Ixvp/GYuP/+8kczArrIotpjs+kee9O4So34wX1//sc1uZ4vU5zKkxj5o8C
	 ybxndGlgdAlKbBuROyiRVYbKZnwpCrnt+bqJe/XwtNOLHjc6fybJgRFYODdA3/hHsd
	 1iBuJRXBPFB4CfqFWpvLpZJSf3wPTHCNFxEieHBehqy968HIRk80iepSvtieSEy2DJ
	 OqfvvdvfLrRXVQ4vx9/D1V+LE6LR6bnyPivnccbVVWDr5bA4t1vmy5GyKPlCdC5712
	 NlmIj347nR/FQ==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev
Cc: Robin Murphy <robin.murphy@arm.com>,
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
	Christophe Leroy <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	x86@kernel.org,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Subject: [PATCH] arm64: swiotlb: Keep the default size for protected guests
Date: Fri,  7 Aug 2026 14:56:12 +0530
Message-ID: <20260807092612.2202005-1-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717180442.110954-18-aneesh.kumar@kernel.org>
References: <20260717180442.110954-18-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Realm guests and protected KVM guests may require swiotlb for device DMA
even when all system RAM is addressable by the DMA zones.

Do not reduce the SWIOTLB buffer to the kmalloc-bouncing size for these
guests, as the reduced number of slots can be exhausted during CCA guest
operation.

Fixes: 30c5e45ee2c5 ("dma-direct: make dma_direct_map_phys() honor DMA_ATTR_CC_SHARED")
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/mm/init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index e308a7cabd12..24caaf10e755 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -339,7 +339,8 @@ void __init arch_mm_preinit(void)
 {
 	unsigned int flags = SWIOTLB_VERBOSE;
 
-	if (max_pfn <= PFN_DOWN(arm64_dma_phys_limit)) {
+	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
+	    max_pfn <= PFN_DOWN(arm64_dma_phys_limit)) {
 		/*
 		 * If no bouncing needed for ZONE_DMA, reduce the swiotlb
 		 * buffer for kmalloc() bouncing to 1MB per 1GB of RAM.
-- 
2.43.0

