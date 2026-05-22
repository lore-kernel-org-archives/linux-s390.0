Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0CA1A23A4;
	Fri, 22 May 2026 04:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779424266; cv=none; b=RpqJCwrk5HBa4oQ7l4FpvWR+aqJwMy0tzLvT/KD8/2QoiWDrBLOLCszcYhe5REnWAB7jLKhZoAsz9eH/drM1MPAkpQXo1fEgxMa5/dBNLT3XqTFw5fh2ijCGbgaWv/Adp1GvAQYMTuHxGxftQOB3ZaUpRZPLCoUgT4paLaRCqA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779424266; c=relaxed/simple;
	bh=RWeuaTQuJCQ4oNrEuU7Wto5E5+vjyR3cNo5Y5QWJsgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wjz6JMYtR0FdwVkTsTl8QNDV96AnDfYB8nvSYZh2DbCGSvWluy4MdXY+o6pSPsWdaFLxFq4gR5kRWQEw/gxPUEdcs99NGeeh5nOnFNJofUPleJP5keSjgKaCCwLXf4lo2MTChqiBRbH7/0dqoRcS7lfb8XH/Wt9o96L9y8wGxAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJqOdGXU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJqOdGXU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295411F00A3D;
	Fri, 22 May 2026 04:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779424265;
	bh=BRoOTjIXEIfZY33xB/HfCrHMNoIMuz43xHMqdbl/MXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QJqOdGXUzoeK/2txik8hoWdiGyYw3ctMEtyPvywn3Wu8DCk3sMglax3QlyOPFYUVm
	 8R8/BKN2Pb5a9JjZcGIh2+8jAI+HZzKk1myOUuKKFuVs4/Xi969HK3/F0ktmoU8hwr
	 vQazAEaw5n9TwQ9VvmkrjlczEPvakOpbQd3Z69nW22XSfcxfiRCFxQkyRiwzUbM56D
	 Wrsqr4HHYb8mXz7NwrbgrDRNxbXy9s3hw+8PPcBENymcvkPLcF6Jwfzh3kTnal2jDl
	 xMuN2HcG+gwdFOdUIPxeDkD4gKLcj/208Gaf84OvuNRB0uDd08BUx/z1Db+drjlkGm
	 c2tylJmWR1M+A==
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
Subject: [PATCH v5 13/20] dma-pool: fix page leak in atomic_pool_expand() cleanup
Date: Fri, 22 May 2026 09:58:08 +0530
Message-ID: <20260522042815.370873-14-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522042815.370873-1-aneesh.kumar@kernel.org>
References: <20260522042815.370873-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

atomic_pool_expand() frees the allocated pages from the remove_mapping
error path only when CONFIG_DMA_DIRECT_REMAP is enabled.

When CONFIG_DMA_DIRECT_REMAP is disabled, failures after page allocation,
such as gen_pool_add_virt(), jump to remove_mapping and return without
freeing the pages.

Move __free_pages(page, order) out of the CONFIG_DMA_DIRECT_REMAP block so
that cleanup paths always release the allocation.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 kernel/dma/pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index be78474a6c49..e7df8d279e75 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -146,9 +146,9 @@ static int atomic_pool_expand(struct dma_gen_pool *dma_pool, size_t pool_size,
 #ifdef CONFIG_DMA_DIRECT_REMAP
 	dma_common_free_remap(addr, pool_size);
 free_page:
+#endif
 	if (!leak_pages)
 		__free_pages(page, order);
-#endif
 out:
 	return ret;
 }
-- 
2.43.0

