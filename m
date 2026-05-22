Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622F45FDA7;
	Fri, 22 May 2026 04:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779424131; cv=none; b=PGL+F1Ti3+Zq0+vyAJIz1DzsiBQJxu/f02UWbTVBqGfP/rwlRxWr8Mf2Ep/29uzMPgFJX1ivFnHjDoxKPD9azF3teiA2CsZQFE5tthmu95+xd7IfDPxQAYUyzqMwr+AJfAnZWimeGfg20FhTVmYFTmJh+zSoALmn6hUOyh2BDYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779424131; c=relaxed/simple;
	bh=K3DN8+vdSo15J0oWGBTO6XyJKH+l3IUXmlWKiJTGMdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KVacUEZKjd7nUYPV1/g2rHBSfBEEER9vjEWpnKfix6BcZFgRtgoHJcu9xfmncRmr5enP0k7mrHVz017iT4W4L/iTShUzdN8tLIHp6LsQD2HtJ2+S1/bsj+62/0emS/sVhordr4M3lLZw70GCl9YISaPwmHhC/mI4q+xLZ5dw7aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oofhJ+Bn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oofhJ+Bn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D9E1F00A3D;
	Fri, 22 May 2026 04:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779424130;
	bh=EN0IQUuPXitnl1iltsyZkrJ7mdFplVIW+Qac7dXtXac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oofhJ+BnD8hM/LCVdJ/7G55+n1MfvMzsj1mvKIs9w+pDJYq+ccbHNjqkIxMBcMsOI
	 IYRjlhqi87N4ou0jrg8o6TYwheH8tqcQW+W6RvZNEy5/RiBBWG59HTEH7imcMyRY78
	 5/FXpn57pnIkN9R+y0xvddQGPGhc1Fihzc94yaxS4G9cm94A92wehVQmntTf0ceGoP
	 EqaRcHfsrsIFCyQeY7lGyxVXnADKgk4z1iHqzSRL+6PrxS/DIveIY6JZWQDQmDwNUf
	 ne3/dijtNZY+hUzTFcJggFSsezzF436KsKMclkD8FbeXxxhRKLI+pnP1/+1D51tgO7
	 0D9yvrU1JTw9w==
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
Subject: [PATCH v5 01/20] [DO NOT MERGE] arm64/coco: Add pKVM as a CC platform
Date: Fri, 22 May 2026 09:57:56 +0530
Message-ID: <20260522042815.370873-2-aneesh.kumar@kernel.org>
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

pKVM does support memory encryption, expose that to the rest of
the kernel through cc_platform_has()

At the moment, all devices inside the guest are emulated which
requires its memory to be shared back to the host (decrypted), so
set force_dma_unencrypted() to always return true.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/include/asm/hypervisor.h           |  6 ++++++
 arch/arm64/include/asm/mem_encrypt.h          |  3 ++-
 arch/arm64/kernel/rsi.c                       | 12 ------------
 arch/arm64/mm/init.c                          | 13 +++++++++++++
 drivers/virt/coco/pkvm-guest/arm-pkvm-guest.c |  5 +++++
 5 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/hypervisor.h b/arch/arm64/include/asm/hypervisor.h
index a12fd897c877..1b0e15f290be 100644
--- a/arch/arm64/include/asm/hypervisor.h
+++ b/arch/arm64/include/asm/hypervisor.h
@@ -10,8 +10,14 @@ void kvm_arm_target_impl_cpu_init(void);
 
 #ifdef CONFIG_ARM_PKVM_GUEST
 void pkvm_init_hyp_services(void);
+bool is_protected_kvm_guest(void);
 #else
 static inline void pkvm_init_hyp_services(void) { };
+
+static inline bool is_protected_kvm_guest(void)
+{
+	return false;
+}
 #endif
 
 static inline void kvm_arch_init_hyp_services(void)
diff --git a/arch/arm64/include/asm/mem_encrypt.h b/arch/arm64/include/asm/mem_encrypt.h
index 314b2b52025f..636f45b4d8af 100644
--- a/arch/arm64/include/asm/mem_encrypt.h
+++ b/arch/arm64/include/asm/mem_encrypt.h
@@ -2,6 +2,7 @@
 #ifndef __ASM_MEM_ENCRYPT_H
 #define __ASM_MEM_ENCRYPT_H
 
+#include <asm/hypervisor.h>
 #include <asm/rsi.h>
 
 struct device;
@@ -20,7 +21,7 @@ int realm_register_memory_enc_ops(void);
 
 static inline bool force_dma_unencrypted(struct device *dev)
 {
-	return is_realm_world();
+	return is_realm_world() || is_protected_kvm_guest();
 }
 
 /*
diff --git a/arch/arm64/kernel/rsi.c b/arch/arm64/kernel/rsi.c
index 92160f2e57ff..25ca75ce1a4d 100644
--- a/arch/arm64/kernel/rsi.c
+++ b/arch/arm64/kernel/rsi.c
@@ -7,7 +7,6 @@
 #include <linux/memblock.h>
 #include <linux/psci.h>
 #include <linux/swiotlb.h>
-#include <linux/cc_platform.h>
 #include <linux/platform_device.h>
 
 #include <asm/io.h>
@@ -23,17 +22,6 @@ EXPORT_SYMBOL(prot_ns_shared);
 DEFINE_STATIC_KEY_FALSE_RO(rsi_present);
 EXPORT_SYMBOL(rsi_present);
 
-bool cc_platform_has(enum cc_attr attr)
-{
-	switch (attr) {
-	case CC_ATTR_MEM_ENCRYPT:
-		return is_realm_world();
-	default:
-		return false;
-	}
-}
-EXPORT_SYMBOL_GPL(cc_platform_has);
-
 static bool rsi_version_matches(void)
 {
 	unsigned long ver_lower, ver_higher;
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 97987f850a33..c1b223e7cc8e 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -12,6 +12,7 @@
 #include <linux/swap.h>
 #include <linux/init.h>
 #include <linux/cache.h>
+#include <linux/cc_platform.h>
 #include <linux/mman.h>
 #include <linux/nodemask.h>
 #include <linux/initrd.h>
@@ -36,6 +37,7 @@
 
 #include <asm/boot.h>
 #include <asm/fixmap.h>
+#include <asm/hypervisor.h>
 #include <asm/kasan.h>
 #include <asm/kernel-pgtable.h>
 #include <asm/kvm_host.h>
@@ -416,6 +418,17 @@ void dump_mem_limit(void)
 	}
 }
 
+bool cc_platform_has(enum cc_attr attr)
+{
+	switch (attr) {
+	case CC_ATTR_MEM_ENCRYPT:
+		return is_realm_world() || is_protected_kvm_guest();
+	default:
+		return false;
+	}
+}
+EXPORT_SYMBOL_GPL(cc_platform_has);
+
 #ifdef CONFIG_EXECMEM
 static u64 module_direct_base __ro_after_init = 0;
 static u64 module_plt_base __ro_after_init = 0;
diff --git a/drivers/virt/coco/pkvm-guest/arm-pkvm-guest.c b/drivers/virt/coco/pkvm-guest/arm-pkvm-guest.c
index 4230b817a80b..297e6d6019b8 100644
--- a/drivers/virt/coco/pkvm-guest/arm-pkvm-guest.c
+++ b/drivers/virt/coco/pkvm-guest/arm-pkvm-guest.c
@@ -95,6 +95,11 @@ static int mmio_guard_ioremap_hook(phys_addr_t phys, size_t size,
 	return 0;
 }
 
+bool is_protected_kvm_guest(void)
+{
+	return !!pkvm_granule;
+}
+
 void pkvm_init_hyp_services(void)
 {
 	int i;
-- 
2.43.0

