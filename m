Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350813E5A15;
	Thu,  4 Jun 2026 08:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562429; cv=none; b=IeQuYRsrmIcE74uzwsp6MD7kTPRtZJSQsmLmpl1lBI3XTyFYfkVBVd/f7RJSHEwyNMjU8rSXLbwb6xWOT/TQPxbpdIA5TH9jJVJnnG3cClqJkUEJrO7rZdL9BTz5cLPQf0dCq9DoNZt4W2wPDsCvfhCUmpqX/HC4WXP8tcUFsNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562429; c=relaxed/simple;
	bh=iylfyXBNO6S14YbSeAPeNtbQXHgcnAOZOy6z6gxK0Ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=stLKpNxYue4lxPbhI8fZjvofA5BbSRvKzYGyyqIUb0UMO5lQo2J/5APx064Kb1cjdxQUGgJWxR7oSwMWLQ8ig2Qhe1qrVCM1XrT2ZFsCCGYxJCwGQKZrzRh40xbabs4yvyjSUlJPkkVsAzwUh+u+wZ5oozteCHMCV/dDP/iLdZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSAcfFlh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSAcfFlh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC06B1F00898;
	Thu,  4 Jun 2026 08:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780562422;
	bh=4aF9+d8jwgDAX56PY9Oecf4wOZ9YOQdZwhZO6X/dmDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZSAcfFlhwVoXj+bvE9YfbowEqQBV1/lgoSIeAFRJcpkKHwSs/j6JzCILJWkoZrYhQ
	 kFn6+KM7tJBsYQQBgnfTV2opqNsAG0x3D+sFC7a+6IWdM24Wvu579IiQJr5KPHuhpk
	 +Q9cG9POofUpPzLkKXLr2AZMA1JBJtglWRqpYpO92nmXndSknhtqkGaYmPxAYJnxBB
	 L1c6KC8V5RRssQOFW3NZC1aoelPWsOtMhR8NSBtEEqbQMOE0yOwQoHtOgjbBM/1abX
	 9MjBsnZeCbQt1ioCBWhXC62eBjVL0V2x4ezbsIA4JafSB7JeyX+7WS922MqP2zcwpf
	 bk1DLeIniUmLw==
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
	Halil Pasic <pasic@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Jaehoon Kim <jhkim@linux.ibm.com>
Subject: [PATCH v6 01/20] s390: Expose protected virtualization through cc_platform_has()
Date: Thu,  4 Jun 2026 14:09:40 +0530
Message-ID: <20260604083959.1265923-2-aneesh.kumar@kernel.org>
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

Protected virtualization guests use memory encryption, so advertise that to
the rest of the kernel through cc_platform_has(CC_ATTR_MEM_ENCRYPT).

s390 already forces DMA mappings to be unencrypted for protected
virtualization guests through force_dma_unencrypted(). Add
ARCH_HAS_CC_PLATFORM and provide the matching cc_platform_has()
implementation

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Jaehoon  Kim <jhkim@linux.ibm.com>
---
 arch/s390/Kconfig   |  1 +
 arch/s390/mm/init.c | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index ecbcbb781e40..9b5e6029e043 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -87,6 +87,7 @@ config S390
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
 	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
 	select ARCH_HAS_CC_CAN_LINK
+	select ARCH_HAS_CC_PLATFORM
 	select ARCH_HAS_CPU_FINALIZE_INIT
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 1f72efc2a579..ad3c6d92b801 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -50,6 +50,7 @@
 #include <linux/virtio_anchor.h>
 #include <linux/virtio_config.h>
 #include <linux/execmem.h>
+#include <linux/cc_platform.h>
 
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __section(".bss..swapper_pg_dir");
 pgd_t invalid_pg_dir[PTRS_PER_PGD] __section(".bss..invalid_pg_dir");
@@ -140,6 +141,19 @@ bool force_dma_unencrypted(struct device *dev)
 	return is_prot_virt_guest();
 }
 
+
+bool cc_platform_has(enum cc_attr attr)
+{
+	switch (attr) {
+	case CC_ATTR_MEM_ENCRYPT:
+		return is_prot_virt_guest();
+
+	default:
+		return false;
+	}
+}
+EXPORT_SYMBOL_GPL(cc_platform_has);
+
 /* protected virtualization */
 static void __init pv_init(void)
 {
-- 
2.43.0

