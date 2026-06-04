Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5683F7A83;
	Thu,  4 Jun 2026 08:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562597; cv=none; b=n9fsCKe7gpUg0pFITlNschJKetZU2Uh5iUJ2jXEWBxEA1fL45iafrWRjvvltRQMxYhH60eCB6yncB9Eai1EA0eE81N4Yuz91sBI24PJ1gSsK5Z0cLcCpwPds7I8msXa4xsMJfKNAgdnQsQkTF3vcG/zXRhmQIbG15iO1wX0BENM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562597; c=relaxed/simple;
	bh=FQaMnL+ddLrG1vPODW9NwFl0dcAcGQZGEyYQRkwIpHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LfeS2vMz0GdRok6IBSHeUKd9w0Al87yscDAGWf5YN1kH+LjyQeqDjfss+rx7qZmB0J5D8K83j2uHFrUOmbypGl6kEV4Ky3aHpLjs1TRzRtjBDbmu0ldO3PGOoLsZ+rgX2eBz7kS2SNGyXrG6cpZfHrqxCHgE0Nu32ojGH1HSuDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cgae1E98; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cgae1E98"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480651F00898;
	Thu,  4 Jun 2026 08:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780562596;
	bh=ePeZTaXNJBx/2RYYA/AuIc3DdpRwUBlOsN24dG2IECQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cgae1E98GtHsFcI4+E6f2e3cq2gB5ntC7mDmNNAmlcu5ofgb9Rubm286CJNZMNO10
	 qSFJCmn7ZFC61rYD6tfmuyK2Pzcg2VxIatIJe4OAZ5ves1nEMvLkEV/62k1e+xJ//b
	 nXAAvIdPZbsJnOB0bCNBUOXCMcnl51t8XBadLEDJSbPxMoUwt9hpY2bJyOQRq7k+Tb
	 ZXEo7XRzcFBuF2TBZpyM78U0taYt44WBdBG2MnDNlV5a6W/7EMKvsx0Rsg20fl8Xkz
	 RFARCUaz4S8GDwUqoxWryHd722PxfNT5E8SHmtzPEgPvhIKK5O3G0JsyBaIGYbWz+8
	 DaVLcJHMYLEGQ==
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
	x86@kernel.org
Subject: [PATCH v6 20/20] swiotlb: remove unused SWIOTLB_FORCE flag
Date: Thu,  4 Jun 2026 14:09:59 +0530
Message-ID: <20260604083959.1265923-21-aneesh.kumar@kernel.org>
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

SWIOTLB_FORCE has no remaining in-tree users. Forced bouncing is now
controlled through the swiotlb=force command line option via
swiotlb_force_bounce.

Remove the unused flag and simplify the force_bounce initialization.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 include/linux/swiotlb.h | 1 -
 kernel/dma/swiotlb.c    | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 526f82e9da45..af88ca7182f4 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -15,7 +15,6 @@ struct page;
 struct scatterlist;
 
 #define SWIOTLB_VERBOSE	(1 << 0) /* verbose initialization */
-#define SWIOTLB_FORCE	(1 << 1) /* force bounce buffering */
 #define SWIOTLB_ANY	(1 << 2) /* allow any memory for the buffer */
 
 /*
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index e4bd8c9eaeda..81cc4928e949 100644
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

