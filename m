Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E02B36F900;
	Tue, 12 May 2026 09:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778576789; cv=none; b=XS2QPbLwN6vQ2qQq82+MomoJi4M59cMzNKRxfirjulUKnSpoHnIHtlry8FAUuZpJykWRiIeFbS1gzdr6yGsempsTwebmT4qoSiCveCIoZcyH8/3qnmpqmnv+57ReBPFyYzQYRpGWiCkRMtZsy5zjou/xVYcaXT4m+pbpnqsEx7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778576789; c=relaxed/simple;
	bh=veSEmK9Ug4szH3v0qgbFOODgpY5EJGxq5OFtSmQEZoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EzYXPRcZcQ5l5rsqZOyOGbrBJynjGyuxp2z5fk5zWbvWAl1JtOurHWa+51BrTnX/iqj4n+W3ehAhMrUiPlzN8x6q429/gAzQCJMyT3eBwbmhyqTKt477nQcABslctb65ZDL2ENCTwPxXWUGvVVMZywrk6vrTdOaVn57tvn3BMQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfEmbaD1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfEmbaD1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C140BC2BCC7;
	Tue, 12 May 2026 09:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778576788;
	bh=veSEmK9Ug4szH3v0qgbFOODgpY5EJGxq5OFtSmQEZoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hfEmbaD1vx0OtPyt/2zEwcfXvzz2enHIUHpU/ddgBvzPmsG0FKkM8cGvnL6yBHpxk
	 4jHpHHoYShzlZH9rztYvxJBggVXmDlGdmaU2VTP1Twa68ti+ABZKBLBjOyGE2Glmva
	 4eLsOWHe3HEgbKtQeVTPtBwyxACwv0llrWmj024jJKEohKuYvakIwLhtsSCD/y7/Z+
	 0Alxpd03yhdikbAyeOllS8BT/tFi2PamwbpCUvLLoPmv81EyPHdPMxORvnuulZP/8B
	 v3ozOATeqYxIv/FKeuK5uxsHLgCPQeZgin3CqA4AOi9eOLu3iXFg7ZWbifu1AU0/gT
	 cmtPif0ZHnFIw==
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
Subject: [PATCH v4 10/13] dma-pool: fix page leak in atomic_pool_expand() cleanup
Date: Tue, 12 May 2026 14:34:05 +0530
Message-ID: <20260512090408.794195-11-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512090408.794195-1-aneesh.kumar@kernel.org>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
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
index 75f0eba48a23..5abd30c5119f 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -149,8 +149,8 @@ static int atomic_pool_expand(struct dma_gen_pool *dma_pool, size_t pool_size,
 #ifdef CONFIG_DMA_DIRECT_REMAP
 	dma_common_free_remap(addr, pool_size);
 free_page:
-	__free_pages(page, order);
 #endif
+	__free_pages(page, order);
 out:
 	return ret;
 }
-- 
2.43.0

