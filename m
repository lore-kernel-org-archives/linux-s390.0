Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CBA3D25D2;
	Thu, 24 Sep 2026 06:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790230134; cv=none; b=Ysu/Kt0Du05EMah97JHkiCp/2d2c+m6cOycdzCVVFlvGkuVak4ThMdTph+7Ootd6CGwzAvBga3mKa7mwRiIeerF+/4m9EALV1eIBSjyuVN8Kw64lGxjSoAyCJqx7mpYPTTPXc2qMeYFdHm4cmTRF8L0QNSdQpJLhTp6m+g27iZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790230134; c=relaxed/simple;
	bh=09mPp9QX3cV5CNigZJnjhYofuzJkVGyc6AFcGbQxlhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c0y+G83DZs7O+3HE6umOmk2sh9xzKaZhKqsOTuC5cjEC60u0DlN/sT63QTqD0zINq1HOyh9S89B9NV4wdP72wp/h/NduA/Mylr95UMV2I4Md9KMTwwbE6RvGF8G3Rbj+p+shnp1A9uwRKWHl1dXXXpIet9v8LOVXgLjDtnwW78A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNlQSxkP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNlQSxkP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A3B1F00898;
	Thu, 24 Sep 2026 06:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790230132;
	bh=bZdtkw5xik3/AxZvbApIZ+mvQYUki7df1BjpPFZ+vJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dNlQSxkP4yr5E+y/jSc5A9piYh3waKMTK0o2RQ+KX4Px78mVUyWMVx9iaSjIaJGK5
	 gJ4g5j1TZLpkHcvb7fbxl2m79KMOHT/PLr8y8EE+3Xo74V9mRwOllpaIDtPQzMilZu
	 hW/LtqZgULKhwFgn7FREEl00TZL1WXDzIg794JfVn8f8BXQ6TWKb89GOY6eGIOuQfB
	 BjgoA8DlLQJaarw5tulyvD0To6GNn2KQSrFmUqCKcJq96LCUq7AOzKBJxwqJ4GQbx3
	 lg+P62RmSv1/u1y+wVlTSzM3VhJYReFL4IRgUYIyL3IZWk9iEoNixE5/tp+C4Ns+2B
	 SxOHv5AMKOVww==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
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
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v6 2/8] dma: swiotlb: Consolidate slab rounding
Date: Thu, 24 Sep 2026 11:37:50 +0530
Message-ID: <20260924060756.1325156-3-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924060756.1325156-1-aneesh.kumar@kernel.org>
References: <20260924060756.1325156-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pass the area count explicitly to swiotlb_calc_nslabs() and keep the
calculation separate from updates to the default_nslabs . Move the
default_nslabs update into swiotlb_adjust_nareas().

Round slabs to a power of two even before the area count is initialized.
For early swiotlb_adjust_size() calls, this moves rounding from area
initialization to size adjustment, so early queries see the rounded
size.

Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 kernel/dma/swiotlb.c | 44 ++++++++++++++++++++------------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 42c51fb57e12..b59dd2a5984e 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -117,27 +117,20 @@ struct io_tlb_area {
 	spinlock_t lock;
 };
 
-/*
- * Round up number of slabs to the next power of 2. The last area is going
- * be smaller than the rest if default_nslabs is not power of two.
- * The number of slot in an area should be a multiple of IO_TLB_SEGSIZE,
- * otherwise a segment may span two or more areas. It conflicts with free
- * contiguous slots tracking: free slots are treated contiguous no matter
- * whether they cross an area boundary.
- *
- * Return true if default_nslabs is rounded up.
- */
-static bool round_up_default_nslabs(void)
+/* Return a power-of-two number of slabs that can be split between areas. */
+static unsigned long swiotlb_calc_nslabs(unsigned long size,
+		unsigned long nareas)
 {
-	if (!default_nareas)
-		return false;
+	unsigned long nslabs;
 
-	if (default_nslabs < IO_TLB_SEGSIZE * default_nareas)
-		default_nslabs = IO_TLB_SEGSIZE * default_nareas;
-	else if (is_power_of_2(default_nslabs))
-		return false;
-	default_nslabs = roundup_pow_of_two(default_nslabs);
-	return true;
+	nslabs = ALIGN(DIV_ROUND_UP(size, IO_TLB_SIZE), IO_TLB_SEGSIZE);
+	if (nareas && nslabs < IO_TLB_SEGSIZE * nareas)
+		nslabs = IO_TLB_SEGSIZE * nareas;
+
+	if (!is_power_of_2(nslabs))
+		nslabs = roundup_pow_of_two(nslabs);
+
+	return nslabs;
 }
 
 /**
@@ -150,6 +143,8 @@ static bool round_up_default_nslabs(void)
  */
 static void swiotlb_adjust_nareas(unsigned int nareas)
 {
+	unsigned long nslabs;
+
 	if (!nareas)
 		nareas = 1;
 	else if (!is_power_of_2(nareas))
@@ -158,9 +153,12 @@ static void swiotlb_adjust_nareas(unsigned int nareas)
 	default_nareas = nareas;
 
 	pr_info("area num %d.\n", nareas);
-	if (round_up_default_nslabs())
+	nslabs = swiotlb_calc_nslabs(default_nslabs << IO_TLB_SHIFT, nareas);
+	if (nslabs != default_nslabs) {
+		default_nslabs = nslabs;
 		pr_info("SWIOTLB bounce buffer size roundup to %luMB",
 			(default_nslabs << IO_TLB_SHIFT) >> 20);
+	}
 }
 
 /**
@@ -300,10 +298,8 @@ void __init swiotlb_adjust_size(unsigned long size)
 	if (default_nslabs != IO_TLB_DEFAULT_SIZE >> IO_TLB_SHIFT)
 		return;
 
-	size = ALIGN(size, IO_TLB_SIZE);
-	default_nslabs = ALIGN(size >> IO_TLB_SHIFT, IO_TLB_SEGSIZE);
-	if (round_up_default_nslabs())
-		size = default_nslabs << IO_TLB_SHIFT;
+	default_nslabs = swiotlb_calc_nslabs(size, default_nareas);
+	size = default_nslabs << IO_TLB_SHIFT;
 	pr_info("SWIOTLB bounce buffer size adjusted to %luMB", size >> 20);
 }
 
-- 
2.43.0

