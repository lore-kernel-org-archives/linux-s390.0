Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9F233938C;
	Thu, 13 Aug 2026 10:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786616744; cv=none; b=QC5BoWFCy1yBa1FERde2m162vfxjoQpP11WcDmnaoxXNtQjOh5RiwwRgcSYQ5Tt/5k/SM/ZhDGcby0HwzLhHbS0iRmczfLTraXvYPT0675Hftid7fs2eYEx+tj7QEB6fjfMa3qKlABTGj53C6z275n3MOIe/7mfaFHU8fRoFGcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786616744; c=relaxed/simple;
	bh=8jPNB0GsE6FMPAgU+eMZSRef/lrFxuws/PudjOje8Uk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xl0oduxkUwkVX18gIvZvnKxeztTB7h0Kf/TOgrtGdLSmeXQVi64bb4pLEI41fTSS9GFm8DHUZ1y33PJAfEGQsjUE5Cn997e9LyDT//Fs3nyBuH+g0bNgWgNNKtQK2aYEwmXVOSIO81exMaldo66Miv/mrBx8T3BB8RQVFSKjnH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMbBUmmd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMbBUmmd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C402D1F000E9;
	Thu, 13 Aug 2026 10:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786616742;
	bh=FVNjqM+zwy4QYexnpN/41yp4Y21cpzfvt2MhMZndR8w=;
	h=From:To:Cc:Subject:Date;
	b=aMbBUmmdjZgu5lCS1WS9hyBaTLJtu5WeLInClKtcETAgtdsa7oT78Xoo4MYmEWcMk
	 ce0CMx4pQSLjG/zl16WJ5eHQTGg/ULfDMsXRiu6aTjft7uODu51SJLodq2dDWjc2ZG
	 TxSsQnaqidxriuLm8klE37n3/8crAKvY6lRdMvkRPo/IW2u6HiNWljLK4uvFrefGlp
	 cgYugSEDYb0tcM5oA3lFaQj4Z5Q6GDz8mjd5aVi0mTyUPkq1f6592AItSK/PKG8uzh
	 9LzjYlThZCxpb1suwn2oG4sACwFRlHapPhhI3FJiloWVbbtz0tWBqcTwaZUMpZJkRW
	 SeyruFS2PkVLA==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev
Cc: Robin Murphy <robin.murphy@arm.com>,
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
	Xu Yilun <yilun.xu@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	x86@kernel.org,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Subject: [RFC PATCH v2 0/2] dma: swiotlb: Centralize default pool sizing
Date: Thu, 13 Aug 2026 15:55:19 +0530
Message-ID: <20260813102521.1367737-1-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series centralizes swiotlb default-pool initialization and sizing.

The first patch replaces the addressing-limit argument with initialization
flags. It also moves the reduced kmalloc-bounce sizing policy into the
swiotlb core.

The second patch centralizes swiotlb sizing for memory-encrypted systems.
It moves the existing x86 guest-sizing policy into the core. Host memory
encryption retains the normal pool size. A shared default pool is not
needed when a restricted DMA pool is present.

SWIOTLB_INIT_CC_SHARED keeps the first patch self-contained. It is removed
by the second patch when the policy moves into the core.

This series is based on the dma-mapping-for-next branch of:
https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git

Aneesh Kumar K.V (Arm) (2):
  dma: swiotlb: Centralize default pool initialization and sizing
  dma: swiotlb: Initialize and size shared default pools for memory
    encryption

 arch/arm/mm/init.c                   |   6 +-
 arch/arm64/mm/init.c                 |  14 +---
 arch/loongarch/kernel/setup.c        |   2 +-
 arch/mips/cavium-octeon/dma-octeon.c |   2 +-
 arch/mips/loongson64/dma.c           |   2 +-
 arch/mips/sibyte/common/dma.c        |   2 +-
 arch/powerpc/kernel/dma-swiotlb.c    |   4 +-
 arch/powerpc/mm/mem.c                |  15 +++-
 arch/powerpc/platforms/pseries/svm.c |  10 ---
 arch/powerpc/sysdev/fsl_pci.c        |   1 +
 arch/riscv/mm/init.c                 |  18 +----
 arch/s390/mm/init.c                  |   2 +-
 arch/x86/include/asm/iommu.h         |   2 +
 arch/x86/kernel/amd_gart_64.c        |   1 +
 arch/x86/kernel/pci-dma.c            |  17 +++--
 arch/x86/mm/mem_encrypt.c            |  24 ------
 include/linux/swiotlb.h              |  10 ++-
 kernel/dma/swiotlb.c                 | 110 ++++++++++++++++++++++-----
 18 files changed, 146 insertions(+), 96 deletions(-)

-- 
2.43.0

