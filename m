Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B363AE71F;
	Mon, 10 Aug 2026 09:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786353218; cv=none; b=Qkk9rmyewZItBXCxCafO3FbllSq2MENfK+rqGNYXGTeufwjuXiAVmVKzIdJ4qBpn2AWlVvDx2w8G/E1ZDVAmav1tWuZY5wBj0AZDSM7q5MVRbyKHvNGk6armfHhPifI6gT5QwX662171h+fFLBp2HB73NVucJB3OWN8/cG6zLQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786353218; c=relaxed/simple;
	bh=dUBXOfg87ZiuztptkE9T0zFs+vAm7PXBwSL22ZfQ46Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=TvUAzD8pykhtEOXvuFy+X+Dscfc4NML5KtstuJMOH+GVuj5bo5ukhGGc5Wmb3lI9llH6ciAi97lUP9ZASDclbtz0nqvPan7fI2yGyQr/f1yjzLgaWI9G2YbXbc7VMB3WPJF/mFLT5Ogw6Gmz7w5hg0z799gE25mPcmiKWXUznSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=lxfWDNt4; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lxfWDNt4"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260810091334euoutp02b90f2f488c302ac4039b7efbd8aebb04~KZsi7HVtz1748917489euoutp02C;
	Mon, 10 Aug 2026 09:13:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260810091334euoutp02b90f2f488c302ac4039b7efbd8aebb04~KZsi7HVtz1748917489euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1786353214;
	bh=9F2+hqEi/pOkUD0Sk5/5UFMk/Jt0LKrILlP4x/Pr3As=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=lxfWDNt4pgEBF2hGBprplDfS9ZiG8PU4QIWr1XTy3IRJQST0jDMlcjb6C2xQflNho
	 aen+A3Jx31spZzgUNGO+k3HbMv/jTGuHy0D1yuJ14RYPvP7BOanhJPtyIa25CHs0U6
	 5w3PfE1mfJVMAAg5BOlPbbbLVO96I2Sq0ySYnDFw=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260810091334eucas1p1e0ed221ce5794cf7bd02a4bed868a380~KZsiumB1n1295212952eucas1p1G;
	Mon, 10 Aug 2026 09:13:34 +0000 (GMT)
Received: from [106.120.50.46] (unknown [106.120.50.46]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260810091332eusmtip28966b93d0c29582d58567c792b4bd9ba~KZshKoKkG2582625826eusmtip2O;
	Mon, 10 Aug 2026 09:13:32 +0000 (GMT)
Message-ID: <7d22482f-d5fd-4cf4-9d32-6a54e02f2fbb@samsung.com>
Date: Mon, 10 Aug 2026 11:13:32 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] arm64: swiotlb: Keep the default size for protected
 guests
To: Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>
Cc: Will Deacon <will@kernel.org>, "Aneesh Kumar K.V"
	<aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>, Marc
	Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>, Suzuki K
	Poulose <Suzuki.Poulose@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Petr Tesarik <ptesarik@suse.com>, Alexey
	Kardashevskiy <aik@amd.com>, Dan Williams <dan.j.williams@intel.com>, Xu
	Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>, Alexander Gordeev
	<agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
	<svens@linux.ibm.com>, x86@kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260807182017.GH200537@ziepe.ca>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260810091334eucas1p1e0ed221ce5794cf7bd02a4bed868a380
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260807182023eucas1p1f653436207b2b00338e99ea1d8f847df
X-EPHeader: CA
X-CMS-RootMailID: 20260807182023eucas1p1f653436207b2b00338e99ea1d8f847df
References: <20260717180442.110954-18-aneesh.kumar@kernel.org>
	<20260807092612.2202005-1-aneesh.kumar@kernel.org>
	<anXIZSh9lq99VG9X@willie-the-truck> <yq5acxvu2ict.fsf@kernel.org>
	<anXbJ2O4DWgPxCeg@willie-the-truck> <20260807135810.GA200537@ziepe.ca>
	<anX7F7dnKOtAOIIe@google.com> <20260807164734.GE200537@ziepe.ca>
	<anYgXSR4VAi3TpOj@google.com>
	<CGME20260807182023eucas1p1f653436207b2b00338e99ea1d8f847df@eucas1p1.samsung.com>
	<20260807182017.GH200537@ziepe.ca>

On 07.08.2026 20:20, Jason Gunthorpe wrote:
> On Fri, Aug 07, 2026 at 06:13:49PM +0000, Mostafa Saleh wrote:
>> But the whole thing is best effort anyway, the kernel picks
>> IO_TLB_DEFAULT_SIZE which does not depend on the system topology or
>> how many devices or how much DMA they do.
>> SWIOTLB memory is wasted if unused so we should be careful around
>> that as it would be the other way around and users would have to
>> decrease it manually.
> Yeah, it is why the arch code shouldn't really be sizing it directly,
> it should be done in common code and, yes, we are probably going to
> have to do something alot smarter to have the common code better
> auto-tune this for the CC case..

What about the $subject patch? I assume that it is still needed to

restore the behavior that was altered by the "[PATCH v8 00/23]

dma-mapping: Track shared DMA state through direct, pool and swiotlb

paths?" patchset?

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

