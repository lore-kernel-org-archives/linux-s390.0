Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0591D47126F;
	Fri, 25 Sep 2026 09:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790327182; cv=none; b=itVmmrr8yO1O37PYaMgTY3as4y3P062qBekIk6D5e+H0F/zu4ai3iZISLSOPTqVyvRlwW7sMvZNd/eTb+JIAPpNORKcoKiwhj/9DmowX25/G/wMcL/oIzvzzXdcj4si92daC5Ipls/91n+bzJewtZ7qebBh6ZgKHs4e4aeRd+88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790327182; c=relaxed/simple;
	bh=SJVcI/EkKT5qN9PuN96627g2c1HT0j46qZH1zpOIzGo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:In-Reply-To:
	 Content-Type:References; b=APZSyMOvQ2Rnp/QoF94xJaGMe/Y/C3rSGj7b2m3iwYflfNg72tQOsdy2CgFwGoN490Y9dBxa3ohXODqxwHi+zlr4yJx9UdE86fLqCooI728Pb/jaQYgDJkt0IpIEG7bj7cyoe05jKwYBVDczGgu3FXAq8s/a1rL/BGTy/cfSLlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=vanVKrSk; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vanVKrSk"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260925085711euoutp023034b78e8628550a3ae5d7840b37570c~YhJYCLvL92670226702euoutp022;
	Fri, 25 Sep 2026 08:57:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260925085711euoutp023034b78e8628550a3ae5d7840b37570c~YhJYCLvL92670226702euoutp022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1790326631;
	bh=fRkS/AwRvXfqS9hACKPrCrxlhkEVLAdRbTDbRYWa8VU=;
	h=Date:From:Subject:To:Cc:In-Reply-To:References:From;
	b=vanVKrSk5T6FjDTn74/1SUO/LMXVqJxekusjmh+babZgiVJMQp94HjScOSgxnGlOR
	 5d4koPLRi1e6pSrU0IEHhOTj75hlbtCMapcYoGSA9uiDQv+BCXn4dZic+bQLLvKziH
	 LU69fdmLb9XCyuTFLtUEuYD6O202XJ3H6/pu8JBg=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260925085711eucas1p1485ce5a6153e8db654ed3cd6ed2fb70c~YhJX0T9dK1519715197eucas1p1s;
	Fri, 25 Sep 2026 08:57:11 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260925085707eusmtip2203bb57f8f737ff31c8cf3ba1f2b8a50~YhJULSaYY1254612546eusmtip2q;
	Fri, 25 Sep 2026 08:57:07 +0000 (GMT)
Message-ID: <40d8c179-f240-486d-b446-c76549d72772@samsung.com>
Date: Fri, 25 Sep 2026 10:57:07 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v6 0/8] dma: swiotlb: Centralize default pool policy and
 sizing
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, Mark
	Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, Steven Price
	<steven.price@arm.com>, Suzuki K Poulose <Suzuki.Poulose@arm.com>, Catalin
	Marinas <catalin.marinas@arm.com>, Jiri Pirko <jiri@resnulli.us>, Jason
	Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Petr Tesarik
	<ptesarik@suse.com>, Alexey Kardashevskiy <aik@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>, Madhavan
	Srinivasan <maddy@linux.ibm.com>, WANG Xuerui <kernel@xen0n.name>, Albert Ou
	<aou@eecs.berkeley.edu>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, x86@kernel.org
Content-Language: en-US
In-Reply-To: <20260924060756.1325156-1-aneesh.kumar@kernel.org>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260925085711eucas1p1485ce5a6153e8db654ed3cd6ed2fb70c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260924060823eucas1p1d27fbf57221c9b4c0e9831a9b0cdd7d3
X-EPHeader: CA
X-CMS-RootMailID: 20260924060823eucas1p1d27fbf57221c9b4c0e9831a9b0cdd7d3
References: <CGME20260924060823eucas1p1d27fbf57221c9b4c0e9831a9b0cdd7d3@eucas1p1.samsung.com>
	<20260924060756.1325156-1-aneesh.kumar@kernel.org>

On 24.09.2026 08:07, Aneesh Kumar K.V (Arm) wrote:
> This series centralizes swiotlb default-pool selection and sizing, and
> simplifies the initialization flags used to describe pool placement.
>
> The first patch replaces the addressing-limit argument with initialization
> flags and introduces explicit policies for the different reasons a default
> pool may be needed. Architectures now report DMA addressing constraints with
> SWIOTLB_INIT_ADDRESSING_LIMIT, while the core selects the corresponding pool
> policy.
>
> The second patch moves the reduced sizing used when the pool is needed only
> for unaligned kmalloc bouncing from arm64 and RISC-V into the swiotlb core.
>
> The third patch centralizes swiotlb sizing for memory-encrypted systems. It
> moves the existing x86 guest-sizing policy into the core. Host memory
> encryption retains the normal pool size, and a shared default pool is not
> selected solely for guest memory encryption when a restricted DMA pool is
> present.
>
> The fourth patch removes SWIOTLB_ANY. Pool placement is derived directly from
> SWIOTLB_INIT_ADDRESSING_LIMIT: pools required for limited DMA addressing are
> allocated below the architecture's low address limit, while other pools may
> be allocated anywhere in directly mapped memory. Xen continues to request a
> pool explicitly with SWIOTLB_INIT_REMAP without imposing a low-address
> constraint.


I would like to give this patchset some tests in linux-next and merge this to
v7.4-rc1, as this is important continuation of the code already merged to v7.3.


Any chance to get some more acks from arch maintainers (especially x86)?
Unfortunately I had to reduce the CC list due to my smtp limits...

> ...
>
>  Documentation/core-api/swiotlb.rst   |   8 +-
>  arch/arm/mm/init.c                   |   6 +-
>  arch/arm/xen/mm.c                    |   2 +-
>  arch/arm64/mm/init.c                 |  14 +-
>  arch/loongarch/kernel/setup.c        |   2 +-
>  arch/mips/cavium-octeon/dma-octeon.c |   2 +-
>  arch/mips/loongson64/dma.c           |   2 +-
>  arch/mips/sibyte/common/dma.c        |   2 +-
>  arch/powerpc/kernel/dma-swiotlb.c    |   4 +-
>  arch/powerpc/mm/mem.c                |  17 ++-
>  arch/powerpc/platforms/pseries/svm.c |  10 --
>  arch/powerpc/sysdev/fsl_pci.c        |   1 +
>  arch/riscv/mm/init.c                 |  24 +---
>  arch/s390/mm/init.c                  |   2 +-
>  arch/x86/include/asm/crash_reserve.h |   4 +-
>  arch/x86/kernel/pci-dma.c            |  23 +++-
>  arch/x86/mm/mem_encrypt.c            |  24 ----
>  include/linux/swiotlb.h              |  17 ++-
>  kernel/dma/swiotlb.c                 | 193 +++++++++++++++++++--------
>  19 files changed, 210 insertions(+), 147 deletions(-)

Best regards

-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

