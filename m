Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0813D7D64;
	Tue, 14 Jul 2026 06:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784009192; cv=none; b=jbzCmUA+ItoHgcQ9g3ackbIyHwv6zdl/9J/cYZi0gv9YPCpc/NYWEbRIL9u9YbE9wn3J0dvuhDybZ4Dpj1tjoV99/w4HRBuTlaE7c1xbAGUgGQEfgnz0pPdtWW9NDZ4f63KVoBbCHO/Hm7DcSkGz9FRenckBmJ8zTIHu9u2U794=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784009192; c=relaxed/simple;
	bh=XaIlS9fgd3AEanAj5vg/Kvs5bTs9A2Sp7Z1J4nmBJGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=tcjb2pbVLMwMejvJ/LQ2Q9pUHV5sup143+a5DcRpvlpliAs84CXFFiLht8SnizDfiK45tEAZ4mjjG6c25Sg/nR3r/xTt2gfYWTEKcUwoYym6pfOU9UPqt5l3B2SIrF3krNHoypqTBwN88tnxL8kF+12zn9SZGjcnsl8Ku0uAWGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ZmTRfa3d; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZmTRfa3d"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260714060628euoutp01cbda150c069210e5715ab2648f4e44a1~CEue2A0331287012870euoutp01N;
	Tue, 14 Jul 2026 06:06:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260714060628euoutp01cbda150c069210e5715ab2648f4e44a1~CEue2A0331287012870euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1784009188;
	bh=DIRiSHikDbk3Q53e+YjP2I19kY7qxurY8Pb5lmd5nSc=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=ZmTRfa3dChwOjLkZGeEMSnDLvOnVbXVLWi/yY8oYelFIbUKhjxrUwNtWWyt9jGG57
	 zLrE3UwKmxXKyqmroZgcu+zD6Pbp7nUy338G8F1TCB+JxTfBCdRlT5n+ocrtCDB3hF
	 sBgzrXGbIcPqqW8KQ2dQeq3cV4UO/lgDK3/yDeeA=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260714060628eucas1p1de9b3680fe41ab77cb6ab5e0681da787~CEuesp4gf1760517605eucas1p1P;
	Tue, 14 Jul 2026 06:06:28 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260714060627eusmtip1653aae226e9613f0154d29407d6f5622~CEudQw15C0714907149eusmtip1g;
	Tue, 14 Jul 2026 06:06:27 +0000 (GMT)
Message-ID: <cd5d0504-1592-4b48-89ea-1efe8aa57968@samsung.com>
Date: Tue, 14 Jul 2026 08:06:26 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v7 00/22] dma-mapping: Track shared DMA state through
 direct, pool and swiotlb paths
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>, Will Deacon
	<will@kernel.org>, Marc Zyngier <maz@kernel.org>, Steven Price
	<steven.price@arm.com>, Suzuki K Poulose <Suzuki.Poulose@arm.com>, Catalin
	Marinas <catalin.marinas@arm.com>, Jiri Pirko <jiri@resnulli.us>, Mostafa
	Saleh <smostafa@google.com>, Petr Tesarik <ptesarik@suse.com>, Alexey
	Kardashevskiy <aik@amd.com>, Dan Williams <dan.j.williams@intel.com>, Xu
	Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Alexander Gordeev
	<agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
	<svens@linux.ibm.com>, x86@kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260713194323.GC3133966@ziepe.ca>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260714060628eucas1p1de9b3680fe41ab77cb6ab5e0681da787
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260707080628eucas1p13fa8a57e60ef5dd3ec651e19e42af0a1
X-EPHeader: CA
X-CMS-RootMailID: 20260707080628eucas1p13fa8a57e60ef5dd3ec651e19e42af0a1
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
	<CGME20260707080628eucas1p13fa8a57e60ef5dd3ec651e19e42af0a1@eucas1p1.samsung.com>
	<yq5av7argr65.fsf@kernel.org>
	<fc804746-4fb8-4ea9-997f-a4cae9ba8c14@samsung.com>
	<20260713194323.GC3133966@ziepe.ca>

On 13.07.2026 21:43, Jason Gunthorpe wrote:
> On Tue, Jul 07, 2026 at 03:03:48PM +0200, Marek Szyprowski wrote:
>> I'm fine with merging on top of the topic branch and I assume that this
>> patchset is mature enough to give it a try in linux-next, but first I
>> would like to get a review or at least acks from others with good CC
>> knowledge or experience.
> I think it is good to go from a CC perspective, there are still some
> more items to fix up (like the MMIO) but I'd rather they be followups
> at this point.

Great. Aneesh, any chance You could send v8 with the remaining items fixed till end of this week? I will be happy to push it to dma-mapping-for-next for testing in linux-next asap.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

