Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946093CA49D;
	Tue,  6 Oct 2026 21:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791322985; cv=none; b=QiKrzKRW0Fz5sPEQ2wuk4Ko47E/VeKtLTzodldVPHNfssLrUe9oiMvdt6zCy4cjWWF+4CCTKGSUVuK/Krv4dKXWvXjwi6kHw2KoLRikhMY6tcNhAy7lVVAsO5FgTgTOWKDMnF2xN2xanFmQVaIot8AeqbB6oWUEbHnIkFYdR/UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791322985; c=relaxed/simple;
	bh=oCSkRp6GuCzlh/94BooGUaQCzy26rKPOU+FL0sDDpuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=qGLygcqJK0UAK5itimXBil9F5KxLKLTu1CBm4dgnggKeo4R1vQ+CqKNjz/FVpVXalKdv5qBIhm9Y6AexVBbWSQ6ENysRBy6VX4PVaM8vcwQfCE0WSk9nNk+oS3t2D4zOPC/8DkBBX7saErhnE+1wbTdP8RSJBVZQ8m9+6BVjqWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=X7izBr5m; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="X7izBr5m"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261006214259euoutp01c5bc7ee57334b408af09a066c2d8412b~cDsI8Wk8f1988319883euoutp01S;
	Tue,  6 Oct 2026 21:42:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261006214259euoutp01c5bc7ee57334b408af09a066c2d8412b~cDsI8Wk8f1988319883euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1791322979;
	bh=ZioSMG43MEHFd9pfn3EIJe0Ig/c7Qq/kf97OHfOELpI=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=X7izBr5m8cmXF7INH1PfY//K2/ri63BnSaoZWWQn+J7F7DSyWLAOh8zyLCqoA49T1
	 fLrFXwNe1fB08G783PVdG9eZQswPfnng02g4QBXO6NsFZq0Etq3vQI7hHj5Ixmn3ua
	 C9iDLQSmItu72iRpHKjS66EAZ/bv/+aIrijM19SA=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20261006214258eucas1p21c51f2c73891f0ad8a848a058ab4e7b2~cDsH4gZff0914409144eucas1p2i;
	Tue,  6 Oct 2026 21:42:58 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261006214255eusmtip2826fd9cdfb4c80046b451ff2238aee5d~cDsFarzwa1576315763eusmtip2a;
	Tue,  6 Oct 2026 21:42:55 +0000 (GMT)
Message-ID: <ff4f59ea-6c51-41d6-a92d-d1dd205b1e78@samsung.com>
Date: Tue, 6 Oct 2026 23:42:54 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v6 0/8] dma: swiotlb: Centralize default pool policy and
 sizing
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Robin Murphy <robin.murphy@arm.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
	<rdunlap@infradead.org>, Will Deacon <will@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, Steven Price
	<steven.price@arm.com>, Suzuki K Poulose <Suzuki.Poulose@arm.com>, Catalin
	Marinas <catalin.marinas@arm.com>, Jiri Pirko <jiri@resnulli.us>, Jason
	Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Petr Tesarik
	<ptesarik@suse.com>, Alexey Kardashevskiy <aik@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>, Madhavan
	Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)"
	<chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>, Alexander Gordeev
	<agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
	<svens@linux.ibm.com>, Stefano Stabellini <sstabellini@kernel.org>, Russell
	King <linux@armlinux.org.uk>, Huacai Chen <chenhuacai@kernel.org>, WANG
	Xuerui <kernel@xen0n.name>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>, Andy Lutomirski <luto@kernel.org>, Peter
	Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Ingo
	Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, x86@kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260924060756.1325156-1-aneesh.kumar@kernel.org>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261006214258eucas1p21c51f2c73891f0ad8a848a058ab4e7b2
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


I will give this patchset a chance in linux-next. If one feels that it still needs
to be improved or sees any other reason why it shouldn't be merged, let me know
asap.


Applied to dma-mapping-for-next.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

