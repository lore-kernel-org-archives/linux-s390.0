Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36DB32470A;
	Wed,  1 Jul 2026 05:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782885226; cv=none; b=dL0cV5nHNnoehO6hUAby/IHxm+57KpJVj9epfyOOsoN0RLssouaIIZY+Fa8q6E80HOfu1kkKg5TIZjTeOFfOPXe8Blw1u2LyyuyrJCf03XCt24Vbz15KVn5Xo23iN8YUI4pXAyENUylcIz29OAl6ODnvNSOip+W04/yJQ6GXaj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782885226; c=relaxed/simple;
	bh=hM3lAVLh0SUrkRUyWQwPuKLFlcNPsX/Jb65pYFjPFi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dy9Q9YWXhGzCB+QYy7dfu5sWr6KHT4nQwyFlVASSAVjVKRRAxyu3cHgoXr//fAnQfMNJArtWui03UjILJ6MazLKejCm16BNu5utAGZdo3Sumbf3jP3edvp9cBDCVhW6FE3Mfr2/h/hSJ1YOr7TG91ks+KP2dR/Bi+Y24uhiGtiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4vj3mIC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4vj3mIC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14681F000E9;
	Wed,  1 Jul 2026 05:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782885225;
	bh=s22aUv759o7jOuYTf2EHjxStbcsNFUSunZW4b9jUGRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B4vj3mICqCBG5J6Qz1J6ZL/CdmqQL9ug/kU7JGVQcXS/8c208ZLND9bS6m7eybLO3
	 wRL6NLoxPnyItyX6BkBvidUfufZTBjxayOXlZzNA2azgv4I1eWOEZB2TaqCfWlcnQC
	 Lhg+GmezbOHy6Z7trc8XjTQcmIocngXXawx1bfAk7MzOh6wGLGd6dsiULHFTHsgGUi
	 mAHVzEmlUlVthSQ+H6gHh09sCL2AdPHYDtYkKMEzikE7XJmHgMtxeB0B3Yh2RRNl9u
	 b1gMBtydG6RDBRmQfYyjayYc7c0SSo+Et5Q5wau0fZfwIuCBXoBqwuXpFpy3E3b5vi
	 XcxBdGsO01mCg==
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
Subject: [PATCH v7 22/22] swiotlb: remove unused SWIOTLB_FORCE flag
Date: Wed,  1 Jul 2026 11:19:26 +0530
Message-ID: <20260701054926.825925-23-aneesh.kumar@kernel.org>
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

SWIOTLB_FORCE has no remaining in-tree users. Forced bouncing is now
controlled through the swiotlb=force command line option via
swiotlb_force_bounce.

Remove the unused flag and simplify the force_bounce initialization.

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

