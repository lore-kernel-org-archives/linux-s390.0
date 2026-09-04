Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28F43A6B8E;
	Fri,  4 Sep 2026 10:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788517162; cv=none; b=oxN/EFzeibYsYdRR4VDXaXDXTVyIgbq08RqbBI42iVoM1Hj0X3Yiq27RvAW+dDS/pLUIpiJZ8iIMuY3kBGtoRIDo8KvCKy+AMFJEcQvG0F63tKmiiOOM6ZJNKNvFk7s0WBWfXl4DdD0UzZwW5cTG5uOBn8NxbzvV1xtWEvpX9q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788517162; c=relaxed/simple;
	bh=uIPfmVzfQOxnvRnJWp+j4C9dru22tDYpeTAj6B4MIVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rbmTl2h8j5P2oxtCyseVn0Y0cdB1dSiFZ8ZAyVpEifx6baLypxBFR4OAqDJMiVJySTdjFFfYvghlM4syIUoh6CP+oGZCJ0SyAfZDMfUWpM2lsP/c4XGpkEGtyY2+WNaTgm3PkT8xTaBupIWkU98MTmoBgDMpFycRM/svkc4/0aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqPoXVwv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqPoXVwv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F66D1F00A3E;
	Fri,  4 Sep 2026 10:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788517154;
	bh=+9xlIfCpDodbNzTutet1jd66CO8G64K2HgI3pSqJXTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BqPoXVwvSDxCuM50rWiBm0reL+//U7erhnps2g2S2RDt0A+lTl7+hq8kRbUjfu0vu
	 p9pWzR4ybWbf7DItbSiyoRb/xX+sAUVlXxf4Pykpb+MmhEVejn/LgHOwnOs1EZrc4q
	 9O6etVU1SSrWcdzUxVqTD8OyKyt30zWn2fqroJhdj2bqTZdmEneN0nsvAj2kfIZ4jh
	 aSK5gQZa/KL9yOD1+DenfVLUGB82HVDdge2Bcu9U8gRalg/03BjnCokZs8ltcnnYa8
	 Zk3LCMRgzsqoJpT6rRA+W5hVgvb7WPVrhJgePOMXjzfirWryhJ8lCVHHg0G2BsT7Fe
	 gLSFBH8RIAfCQ==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev
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
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v3 3/4] dma: swiotlb: Centralize memory-encryption pool sizing
Date: Fri,  4 Sep 2026 15:48:09 +0530
Message-ID: <20260904101810.1193505-4-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904101810.1193505-1-aneesh.kumar@kernel.org>
References: <20260904101810.1193505-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Memory-encrypted guests use shared or unencrypted memory for DMA and may
route all DMA through SWIOTLB. The default pool can therefore be too
small for I/O-intensive workloads.

Move the existing x86 guest-sizing policy into the SWIOTLB core. For
SWIOTLB_POOL_CC_GUEST, size the pool to 6% of guest memory, clamped
between the normal default and 1 GiB. Preserve an explicit swiotlb=
size.

Provide swiotlb_adjusted_size() so early users, including the x86 crash
kernel reservation, can account for the prospective guest pool size
before SWIOTLB initialization. Use the same area-aware alignment for
both the prospective and allocated sizes.

Host memory encryption still selects a normal-sized shared pool and
does not use the guest-sizing policy.

A restricted DMA pool already provides shared bounce buffers for its
devices. Record its presence during reserved-memory initialization and
do not select the confidential-guest default-pool policy solely because
guest memory encryption is active.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/x86/include/asm/crash_reserve.h |  4 +--
 arch/x86/mm/mem_encrypt.c            | 24 --------------
 include/linux/swiotlb.h              |  6 ++++
 kernel/dma/swiotlb.c                 | 49 +++++++++++++++++++++++++++-
 4 files changed, 56 insertions(+), 27 deletions(-)

diff --git a/arch/x86/include/asm/crash_reserve.h b/arch/x86/include/asm/crash_reserve.h
index 7835b2cdff04..9f6b06e2f9bd 100644
--- a/arch/x86/include/asm/crash_reserve.h
+++ b/arch/x86/include/asm/crash_reserve.h
@@ -18,7 +18,7 @@
  * no good way to detect the paging mode of the target kernel which will be
  * loaded for dumping.
  */
-extern unsigned long swiotlb_size_or_default(void);
+unsigned long __init swiotlb_adjusted_size(void);
 
 #ifdef CONFIG_X86_32
 # define CRASH_ADDR_LOW_MAX     SZ_512M
@@ -33,7 +33,7 @@ extern unsigned long swiotlb_size_or_default(void);
 static inline unsigned long crash_low_size_default(void)
 {
 #ifdef CONFIG_X86_64
-	return max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20);
+	return max(swiotlb_adjusted_size() + (8UL << 20), 256UL << 20);
 #else
 	return 0;
 #endif
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 95bae74fdab2..912f22ca838f 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -101,9 +101,6 @@ void __init mem_encrypt_init(void)
 
 void __init mem_encrypt_setup_arch(void)
 {
-	phys_addr_t total_mem = memblock_phys_mem_size();
-	unsigned long size;
-
 	/*
 	 * Do RMP table fixups after the e820 tables have been setup by
 	 * e820__memory_setup().
@@ -114,27 +111,6 @@ void __init mem_encrypt_setup_arch(void)
 	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
 		return;
 
-	/*
-	 * For SEV and TDX, all DMA has to occur via shared/unencrypted pages.
-	 * Kernel uses SWIOTLB to make this happen without changing device
-	 * drivers. However, depending on the workload being run, the
-	 * default 64MB of SWIOTLB may not be enough and SWIOTLB may
-	 * run out of buffers for DMA, resulting in I/O errors and/or
-	 * performance degradation especially with high I/O workloads.
-	 *
-	 * Adjust the default size of SWIOTLB using a percentage of guest
-	 * memory for SWIOTLB buffers. Also, as the SWIOTLB bounce buffer
-	 * memory is allocated from low memory, ensure that the adjusted size
-	 * is within the limits of low available memory.
-	 *
-	 * The percentage of guest memory used here for SWIOTLB buffers
-	 * is more of an approximation of the static adjustment which
-	 * 64MB for <1G, and ~128M to 256M for 1G-to-4G, i.e., the 6%
-	 */
-	size = total_mem * 6 / 100;
-	size = clamp_val(size, IO_TLB_DEFAULT_SIZE, SZ_1G);
-	swiotlb_adjust_size(size);
-
 	/* Set restricted memory access for virtio. */
 	virtio_set_mem_acc_cb(virtio_require_restricted_mem_acc);
 }
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index d69370c08094..be3962a33fc6 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -193,6 +193,7 @@ void swiotlb_dev_init(struct device *dev);
 size_t swiotlb_max_mapping_size(struct device *dev);
 bool is_swiotlb_allocated(void);
 bool is_swiotlb_active(struct device *dev);
+unsigned long __init swiotlb_adjusted_size(void);
 void __init swiotlb_adjust_size(unsigned long size);
 phys_addr_t default_swiotlb_base(void);
 phys_addr_t default_swiotlb_limit(void);
@@ -232,6 +233,11 @@ static inline bool is_swiotlb_active(struct device *dev)
 	return false;
 }
 
+static inline unsigned long __init swiotlb_adjusted_size(void)
+{
+	return 0;
+}
+
 static inline void swiotlb_adjust_size(unsigned long size)
 {
 }
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 90e0bfd0715c..c4611b2c4540 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -80,6 +80,7 @@ struct io_tlb_slot {
 
 static bool swiotlb_force_bounce;
 static bool swiotlb_force_disable;
+static bool restricted_dma_pool_present __initdata;
 
 enum swiotlb_pool_policy {
 	SWIOTLB_POOL_NONE,
@@ -478,6 +479,48 @@ static bool __init swiotlb_kmalloc_needs_bounce(void)
 	       (dma_get_cache_alignment() > 1);
 }
 
+/**
+ * swiotlb_adjusted_size() - get the prospective adjusted SWIOTLB size
+ *
+ * Return the size that confidential-computing guest sizing would select for
+ * the default pool, without changing the configured SWIOTLB size. An
+ * explicit swiotlb= size is always preserved. An explicit area count is
+ * included in the size calculation. Automatic area sizing is initialized
+ * later from the running kernel's possible CPU map and any resulting size
+ * adjustment is therefore not reflected in the returned size.
+ */
+unsigned long __init swiotlb_adjusted_size(void)
+{
+	unsigned long nslabs, size = swiotlb_size_or_default();
+
+	if (swiotlb_default_size_changed() ||
+	    !cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
+		return size;
+	/*
+	 * For SEV and TDX and CCA, all DMA has to occur via
+	 * shared/unencrypted pages. Kernel uses SWIOTLB to make this
+	 * happen without changing device drivers. However, depending on
+	 * the workload being run, the default 64MB of SWIOTLB may not be
+	 * enough and SWIOTLB may run out of buffers for DMA, resulting in
+	 * I/O errors and/or performance degradation especially with high
+	 * I/O workloads.
+	 *
+	 * Adjust the default size of SWIOTLB using a percentage of guest
+	 * memory for SWIOTLB buffers. Also, as the SWIOTLB bounce buffer
+	 * memory is allocated from low memory, ensure that the adjusted
+	 * size is within the limits of low available memory.
+	 *
+	 * The percentage of guest memory used here for SWIOTLB buffers is
+	 * more of an approximation of the static adjustment which 64MB for
+	 * <1G, and ~128M to 256M for 1G-to-4G, i.e., the 6%
+	 */
+	size = memblock_phys_mem_size() * 6 / 100;
+	size = clamp_val(size, IO_TLB_DEFAULT_SIZE, SZ_1G);
+	nslabs = swiotlb_aligned_nslabs(size);
+
+	return nslabs << IO_TLB_SHIFT;
+}
+
 static void __init
 swiotlb_adjust_pool_size(enum swiotlb_pool_policy policy)
 {
@@ -494,6 +537,7 @@ swiotlb_adjust_pool_size(enum swiotlb_pool_policy policy)
 		break;
 	}
 	case SWIOTLB_POOL_CC_GUEST:
+		swiotlb_adjust_size(swiotlb_adjusted_size());
 		break;
 	case SWIOTLB_POOL_NONE:
 		WARN(true, "Cannot adjust SWIOTLB size without a pool\n");
@@ -509,7 +553,8 @@ swiotlb_select_pool_policy(unsigned int flags)
 	if (swiotlb_force_disable)
 		return SWIOTLB_POOL_NONE;
 
-	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
+	    !restricted_dma_pool_present)
 		return SWIOTLB_POOL_CC_GUEST;
 
 	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
@@ -2155,6 +2200,8 @@ static int __init rmem_swiotlb_setup(unsigned long node,
 	    of_get_flat_dt_prop(node, "no-map", NULL))
 		return -EINVAL;
 
+	restricted_dma_pool_present = true;
+
 	pr_info("Reserved memory: created restricted DMA pool at %pa, size %ld MiB\n",
 		&rmem->base, (unsigned long)rmem->size / SZ_1M);
 	return 0;
-- 
2.43.0

