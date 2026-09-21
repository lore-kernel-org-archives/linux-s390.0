Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFA836728D;
	Mon, 21 Sep 2026 06:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789972643; cv=none; b=SIisrOCjqeoXRulvIwUJ+tiR95pHpF8Fxq9Q8rqvW1nwW2lKJZaEwd8GtKBv1ibqDxsjPJVOerJurzdxqXoEfo7o/TlxaJQ3LrBIGi1aDRvP5Pj/t0rAaXGVsMsmB4WW6ELA9jqpbzAKlPyfBMW83bC+enJgEur98IsHTY/M+aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789972643; c=relaxed/simple;
	bh=3NZZgsHxKBP7v1GdHnt4LolCEmdGRI3t+ZpeeKUA/MY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fcjm6PkwlpmsOK7gTUe0kJgvhPUZ8yox628LfvHXmnn+hjlvFTtDsR/GlKvLZZZCjvkEM9Lh+BLGMWaSavxBP8Djlo66wQ704OK4ArRg3qzrCrxoUL+8U6JmsQEjHWYSHn1uBME1cpMqwhhFjFM85/czhXtKclUdeiKCQItlyCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItCAWN/b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItCAWN/b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D478A1F00899;
	Mon, 21 Sep 2026 06:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789972642;
	bh=fUCvSD545AGqyJgwYc/GicxI6hMF/t9YAHwv4jFcQak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ItCAWN/bZKXBVisaCNeR/Zme4Bhaf0Rs8NXllfTFEHHwczMFALk0glxv5UtwQ2E1M
	 A8qyeQOutrpDF0GB73be/Dhp7UyA76pr93qyXCp/SBgZlJv/us4v9DB8544n2XS0LO
	 ZmWn9ULvzsnJeFZSk1zQIKMZHULsZm5+e33H56EKAvDfqjypjXEl/2I5CUNPqTuhyp
	 HsqgaPygQtGAqNarWWmiPfWWkx7rgJDdc80k6kWbQ6xkbHO9IRuLGCTv9wtfUK4+vT
	 TzOFDt8Xlr8T/WTX3YWtL/0YYcr0Rv2B1mevPDJnI55O5NaYEPvy5tlnh6c02ULEjb
	 PLdVf4MFo0IFg==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
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
	Russell King <linux@armlinux.org.uk>,
	Huacai Chen <chenhuacai@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v5 2/6] dma: swiotlb: Track whether the pool size was explicitly set
Date: Mon, 21 Sep 2026 12:06:24 +0530
Message-ID: <20260921063628.362078-3-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921063628.362078-1-aneesh.kumar@kernel.org>
References: <20260921063628.362078-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

swiotlb_adjust_size() must not override a pool size supplied through the
swiotlb= command-line parameter.

Currently, it determines whether a size was supplied by comparing
default_nslabs with IO_TLB_DEFAULT_SIZE. This fails when the user
explicitly requests the compiled-in default size, allowing the request
to be overwritten by automatic pool sizing.

Record whether swiotlb= supplied a numeric size and add
swiotlb_default_size_changed() to query that state.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 kernel/dma/swiotlb.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index aa19e81ae544..8f86deb25be2 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -107,6 +107,7 @@ static struct io_tlb_mem io_tlb_default_mem;
 
 static unsigned long default_nslabs = IO_TLB_DEFAULT_SIZE >> IO_TLB_SHIFT;
 static unsigned long default_nareas;
+static bool swiotlb_size_set __initdata;
 
 /**
  * struct io_tlb_area - IO TLB memory area descriptor
@@ -269,6 +270,7 @@ setup_io_tlb_npages(char *str)
 		/* avoid tail segment of size < IO_TLB_SEGSIZE */
 		default_nslabs =
 			ALIGN(simple_strtoul(str, &str, 0), IO_TLB_SEGSIZE);
+		swiotlb_size_set = true;
 	}
 	if (*str == ',')
 		++str;
@@ -304,6 +306,11 @@ unsigned long swiotlb_size_or_default(void)
 	return default_nslabs << IO_TLB_SHIFT;
 }
 
+static bool __init swiotlb_default_size_changed(void)
+{
+	return swiotlb_size_set;
+}
+
 void __init swiotlb_adjust_size(unsigned long size)
 {
 	/*
@@ -311,7 +318,7 @@ void __init swiotlb_adjust_size(unsigned long size)
 	 * architectures such as those supporting memory encryption to
 	 * adjust/expand SWIOTLB size for their use.
 	 */
-	if (default_nslabs != IO_TLB_DEFAULT_SIZE >> IO_TLB_SHIFT)
+	if (swiotlb_default_size_changed())
 		return;
 
 	default_nslabs = swiotlb_aligned_nslabs(size);
-- 
2.43.0

