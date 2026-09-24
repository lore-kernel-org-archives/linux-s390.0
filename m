Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E8C3F6C42;
	Thu, 24 Sep 2026 06:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790230103; cv=none; b=DJPx48o4eNEna6Y+YV9FXVta7lFd/W2jcysElpFe3fDUSEQoPcdquRqDZBOv5N2xxBK3ONUV8R2w4ylBr/HhlLE9hsOhIJB9BbWwy29mHSuZdBTAdi8TADd9QeCy0msWm8h2DhOeSp6oDe89g5S/sAvktA6fbKVkSB1Agg9BWhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790230103; c=relaxed/simple;
	bh=v+9XRJTtvH3BqjVcGSVcYBfvf9q3PzWiAk0+il3HErc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nz1+ztePF+ssuakARklb0dG2Os8purwey7kWidUK/sw+HNzIIm89srv36oHVx4FnBFLcZxhg3rtov58e+HcYtrbslJRS5a+QsMf0xqRCLrms92ZxuVGtmBOsdLTmnTPkt7Q7CyzFSZOuSJ+WvuNjCGmful6PzPautSrPQ8/b4co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCLAyysY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCLAyysY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABCE41F000FF;
	Thu, 24 Sep 2026 06:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790230098;
	bh=A+b0QfMrBYdMcYFCICVqdR0OXDOa6w9OD48EIiSzDyI=;
	h=From:To:Cc:Subject:Date;
	b=dCLAyysYJq3tw3Zd89/8HfyIdVUUN6YTWImQbQtYWgNgSoX+q7H8933X4zO5vsix/
	 cWAmzjdMnk+PSNjJeT226kssBmm8ufXA7enM27yO7uWkccRxhHNQnYvO++Zr45t6eP
	 OeALh5UHn/vSCK0Rh4RSy3KJUeVFnG5TsvTPhd9ST8OCQK505QKdc6V0IFjBVNhBMy
	 xNiX0aNyHwI9CKrv7R9GSYhWwqqiaaErgu4K++3z+05rY+zy3QOaz8I96TAPuEeUjI
	 0Th7aF8pwVdxGD0s8uvsSbzv4vyoM16Mk5PfUSMlOWPka5qZHjNKC5wurOCZj94FfQ
	 SY60QB0CQgMvw==
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
Subject: [PATCH v6 0/8] dma: swiotlb: Centralize default pool policy and sizing
Date: Thu, 24 Sep 2026 11:37:48 +0530
Message-ID: <20260924060756.1325156-1-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series centralizes swiotlb default-pool selection and sizing, and
simplifies the initialization flags used to describe pool placement.

The first patch replaces the addressing-limit argument with initialization
flags and introduces explicit policies for the different reasons a default
pool may be needed. Architectures now report DMA addressing constraints with
SWIOTLB_INIT_ADDRESSING_LIMIT, while the core selects the corresponding pool
policy.

The second patch moves the reduced sizing used when the pool is needed only
for unaligned kmalloc bouncing from arm64 and RISC-V into the swiotlb core.

The third patch centralizes swiotlb sizing for memory-encrypted systems. It
moves the existing x86 guest-sizing policy into the core. Host memory
encryption retains the normal pool size, and a shared default pool is not
selected solely for guest memory encryption when a restricted DMA pool is
present.

The fourth patch removes SWIOTLB_ANY. Pool placement is derived directly from
SWIOTLB_INIT_ADDRESSING_LIMIT: pools required for limited DMA addressing are
allocated below the architecture's low address limit, while other pools may
be allocated anywhere in directly mapped memory. Xen continues to request a
pool explicitly with SWIOTLB_INIT_REMAP without imposing a low-address
constraint.

Changes from v5:
https://lore.kernel.org/all/20260921063628.362078-1-aneesh.kumar@kernel.org
* Collect Reviewed-by tags.
* Drop the x86 crash changes
* Add two new patches:
  "dma: swiotlb: Consolidate slab rounding"
  "dma: swiotlb: Rename swiotlb_size_or_default()"
* Drop the swiotlb_default_size_changed() helper.
* Simplify swiotlb_adjust_pool_size().

Changes from v4:
https://lore.kernel.org/all/20260914070135.313337-1-aneesh.kumar@kernel.org
* Collect Reviewed-by tags.
* Add a new patch, "dma: swiotlb: Track whether the pool size was explicitly set".
* Retain SWIOTLB_ANY usage for RISC-V until patch 6.
* Rename SWIOTLB_INIT_FORCE_DISABLE to SWIOTLB_INIT_DEFAULT_OFF.

Changes from v3:
https://lore.kernel.org/all/20260904101810.1193505-1-aneesh.kumar@kernel.org
* Add a new patch, "dma: swiotlb: Add an overridable architecture pool opt-out".
* Clarify the change in default behavior with the removal of SWIOTLB_ANY.

Changes from v2:
https://lore.kernel.org/all/20260813102521.1367737-1-aneesh.kumar@kernel.org
* Rebase to latest tree.
* Drop SWIOTLB_ANY and derive that based on SWIOTLB_INIT_ADDRESSING_LIMIT
* Add SWIOTLB_INIT_REMAP.

v1:
https://lore.kernel.org/all/20260811134056.756015-1-aneesh.kumar@kernel.org

Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Steven Price <steven.price@arm.com>
Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Mostafa Saleh <smostafa@google.com>
Cc: Petr Tesarik <ptesarik@suse.com>
Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Paul Walmsley <pjw@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexandre Ghiti <alex@ghiti.fr>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: loongarch@lists.linux.dev
Cc: linux-mips@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-s390@vger.kernel.org
Cc: x86@kernel.org

Aneesh Kumar K.V (Arm) (8):
  dma: swiotlb: Rename swiotlb_size_or_default()
  dma: swiotlb: Consolidate slab rounding
  dma: swiotlb: Track whether the pool size was explicitly set
  dma: swiotlb: Centralize default pool policy selection
  dma: swiotlb: Centralize minimal pool sizing
  dma: swiotlb: Centralize memory-encryption pool sizing
  dma: swiotlb: Add an overridable architecture pool opt-out
  dma: swiotlb: Remove SWIOTLB_ANY

 Documentation/core-api/swiotlb.rst   |   8 +-
 arch/arm/mm/init.c                   |   6 +-
 arch/arm/xen/mm.c                    |   2 +-
 arch/arm64/mm/init.c                 |  14 +-
 arch/loongarch/kernel/setup.c        |   2 +-
 arch/mips/cavium-octeon/dma-octeon.c |   2 +-
 arch/mips/loongson64/dma.c           |   2 +-
 arch/mips/sibyte/common/dma.c        |   2 +-
 arch/powerpc/kernel/dma-swiotlb.c    |   4 +-
 arch/powerpc/mm/mem.c                |  17 ++-
 arch/powerpc/platforms/pseries/svm.c |  10 --
 arch/powerpc/sysdev/fsl_pci.c        |   1 +
 arch/riscv/mm/init.c                 |  24 +---
 arch/s390/mm/init.c                  |   2 +-
 arch/x86/include/asm/crash_reserve.h |   4 +-
 arch/x86/kernel/pci-dma.c            |  23 +++-
 arch/x86/mm/mem_encrypt.c            |  24 ----
 include/linux/swiotlb.h              |  17 ++-
 kernel/dma/swiotlb.c                 | 193 +++++++++++++++++++--------
 19 files changed, 210 insertions(+), 147 deletions(-)


base-commit: 704340f1cd0dcef829eb62f5b48ae95a2ce17bdf
-- 
2.43.0

