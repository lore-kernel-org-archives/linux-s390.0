Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64D737D126;
	Fri, 17 Jul 2026 18:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784311770; cv=none; b=UKCLuTWZjeL16bzjsMjf8wWaguvrDRzR92Yz4QSIAXPPt/beIp5ZJ/wELe962EeohWA5dyImyGz1qQKqs+HAVx+4cZRhJv4aWjuw3+arVi9ZqbLlgEBx7XqcwFywheR31gWPDsOr716/E4vr22ZUJOCFInIjvac/QFocsYkYD2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784311770; c=relaxed/simple;
	bh=pGo1yPgsER01aQ8A4oxLe7N9Xn4S7xozVAJYzXGd0dQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZDKdxwts/GWJixJfOteVWo2FLbbw7WqfCXPoEggxeaNUXJuTfoYZ7/YV/E+KtLDjQg/wCkOuqRD2IvcRygzTdOEmcuqKeeo558NZodjuOClgbGR/+CoRxouiTNmHnji9kk4r3OWL7+on4M6yAs/V5sAAuwNZdxNwzacRMeLnejI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKEaTtkj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKEaTtkj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CFE1F00A3A;
	Fri, 17 Jul 2026 18:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784311768;
	bh=tkXR0ipZ7ma+5T3tic3bVYqHfLRJ5/MS0548pdfa6Q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZKEaTtkjlsYTecPUwUZYY5boRz8Hl5p9D2dk5Y5OHE5V+KrdaCWiMHICIVvyeZo8l
	 bfDENN6CkL/X2Nhd1Dhikwp79Ii7RZhp6+TdbxOWmncy5evwDeUC0PrecgKYvOfJ2i
	 z5t5X7pIAq2lJxusYJVvtvqityS5Yt1NuT1GCEYBv/ZX+VxYwD85Oz7Abz4+1TQJdX
	 wcai+O3Dp9MiHid7sAM+sdbkz+TE4Ihrj2BOXgkzKovblm2cKclw8oi9o7WFLwiD3J
	 OUQsZBxyG2lJSEe2eHv3+KJZZXFXBOwVqSpI2S4/WrMB2IqHdqF6IqWNhGaswGM9hg
	 XgoRYSziMoMAQ==
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
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v8 23/23] swiotlb: remove unused SWIOTLB_FORCE flag
Date: Fri, 17 Jul 2026 23:34:41 +0530
Message-ID: <20260717180442.110954-24-aneesh.kumar@kernel.org>
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

SWIOTLB_FORCE has no remaining in-tree users. Forced bouncing is now
controlled through the swiotlb=force command line option via
swiotlb_force_bounce.

Remove the unused flag and simplify the force_bounce initialization.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 include/linux/swiotlb.h | 3 +--
 kernel/dma/swiotlb.c    | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index c3bf7ed6f7a6..9caca923c380 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -15,8 +15,7 @@ struct page;
 struct scatterlist;
 
 #define SWIOTLB_VERBOSE	(1 << 0) /* verbose initialization */
-#define SWIOTLB_FORCE	(1 << 1) /* force bounce buffering */
-#define SWIOTLB_ANY	(1 << 2) /* allow any memory for the buffer */
+#define SWIOTLB_ANY	(1 << 1) /* allow any memory for the buffer */
 
 /*
  * Maximum allowable number of contiguous slabs to map,
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 8b7e47504304..897aba538c5b 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -400,8 +400,7 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 	if (swiotlb_force_disable)
 		return;
 
-	io_tlb_default_mem.force_bounce =
-		swiotlb_force_bounce || (flags & SWIOTLB_FORCE);
+	io_tlb_default_mem.force_bounce = swiotlb_force_bounce;
 
 #ifdef CONFIG_SWIOTLB_DYNAMIC
 	if (!remap)
-- 
2.43.0

