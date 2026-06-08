Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CA53B2FFB;
	Mon,  8 Jun 2026 10:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780915492; cv=none; b=JnkXL0B8QAlHdqc6Jfu/7c29aU1eD1sIzkOfTfy6s8GpzmJtOxCsKTL83a1Yu5q2HwOI1uvmXOTXnLx00ZusQUgCOwmWK13GU/fnrlECPvdMTVRFF7ALFh5kFC/uY6Tq8/EY7pL/eGa28D/i0GkSESczzft81OyvkZXXtXR4A14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780915492; c=relaxed/simple;
	bh=S39wh1Aor7xPqz2F0/ELhdZtaK0sGHh/tjvXrBVkkHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=VC8grHNAnMYhfHfMDexi7TV+c+v5bFPKH3npni/v1mfCWkecNWW82+FCyG2SmKAkSS08176mcOzsPaXU+GnyirrEMuzr26Ux/HHO8x1oOfNdEnKC03QbitmKDRm+YI6PlSCIMAbEtBcfAEeq+tLanzy1uw7GYFFUdhBHl3uotao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=JoCZ/WKI; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JoCZ/WKI"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260608104448euoutp02462bcf49bb960e5e74d4dfba6373e0ce~3FTN8Nl8Y2450824508euoutp02S;
	Mon,  8 Jun 2026 10:44:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260608104448euoutp02462bcf49bb960e5e74d4dfba6373e0ce~3FTN8Nl8Y2450824508euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1780915488;
	bh=plNYBzzaUu+CjxUfVgmwKMU0d70IRGPw0rK3BmwuPjc=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=JoCZ/WKIAI4ynKcKsLsemvNM9WajLCXA73D5zw2xoD7lCL3z54ZkMrkLh/JyPdEyE
	 /kqCaIilwuycoqSIz0z02aXZrhcLMotd35EHMU7drq2vG8mZar/SYgy1xT2vcdWCN6
	 uGoRfxIdzyZOSLqUCzO80yrI3lBIVEMsvs8BDl3o=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260608104448eucas1p1685dd3246a9e2b35613d32758481919c~3FTNnAVOb0713807138eucas1p1-;
	Mon,  8 Jun 2026 10:44:48 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260608104446eusmtip22e466d5ec2468bd35b4ff28e72e16298~3FTMH8FJe2930429304eusmtip2T;
	Mon,  8 Jun 2026 10:44:46 +0000 (GMT)
Message-ID: <4d30ec2d-72e4-4d5d-98aa-d2519ed6737e@samsung.com>
Date: Mon, 8 Jun 2026 12:44:45 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v5 05/20] dma-pool: track decrypted atomic pools and
 select them via attrs
To: Jason Gunthorpe <jgg@ziepe.ca>, "Aneesh Kumar K.V"
	<aneesh.kumar@kernel.org>
Cc: Michael Kelley <mhklinux@outlook.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, Robin Murphy <robin.murphy@arm.com>, Will
	Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Steven Price
	<steven.price@arm.com>, Suzuki K Poulose <Suzuki.Poulose@arm.com>, Catalin
	Marinas <catalin.marinas@arm.com>, Jiri Pirko <jiri@resnulli.us>, Mostafa
	Saleh <smostafa@google.com>, Petr Tesarik <ptesarik@suse.com>, Alexey
	Kardashevskiy <aik@amd.com>, Dan Williams <dan.j.williams@intel.com>, Xu
	Yilun <yilun.xu@linux.intel.com>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "linux-s390@vger.kernel.org"
	<linux-s390@vger.kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Alexander Gordeev
	<agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
	<svens@linux.ibm.com>, "x86@kernel.org" <x86@kernel.org>, Jiri Pirko
	<jiri@nvidia.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260604182419.GC2487554@ziepe.ca>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260608104448eucas1p1685dd3246a9e2b35613d32758481919c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260604182425eucas1p172fc82b218cbed92f71a093549902d3a
X-EPHeader: CA
X-CMS-RootMailID: 20260604182425eucas1p172fc82b218cbed92f71a093549902d3a
References: <20260522042815.370873-1-aneesh.kumar@kernel.org>
	<20260522042815.370873-6-aneesh.kumar@kernel.org>
	<SN6PR02MB415754E94A9505C2B9739E4DD4092@SN6PR02MB4157.namprd02.prod.outlook.com>
	<yq5afr35sciu.fsf@kernel.org>
	<SN6PR02MB4157D9955A93244014AB7978D4122@SN6PR02MB4157.namprd02.prod.outlook.com>
	<20260603005454.GM2487554@ziepe.ca>
	<SN6PR02MB4157F94C902B78E55E99372DD4102@SN6PR02MB4157.namprd02.prod.outlook.com>
	<yq5apl26qrof.fsf@kernel.org>
	<CGME20260604182425eucas1p172fc82b218cbed92f71a093549902d3a@eucas1p1.samsung.com>
	<20260604182419.GC2487554@ziepe.ca>

On 04.06.2026 20:24, Jason Gunthorpe wrote:
> On Thu, Jun 04, 2026 at 08:27:36PM +0530, Aneesh Kumar K.V wrote:
>> I already sent a v6 in the hope of getting this merged for the next
>> merge window. Should I send a v7, or would you prefer that I do the
>> rename on top of v6?
> I think it is too late for such a major change, but this should be
> imaginged to be for rc2ish next cycle. You also have to spell out how
> the pkvm patch will get sequenced as well, it would be best to push
> that it gets picked up right away.


I would like to give this a bit of time in linux-next so it is a bit too
late for v7.2, but before merging it I would also like to have this code
reviewed by someone with confidential computing knowledge.


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

