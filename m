Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441703F4110;
	Thu, 14 May 2026 07:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778742069; cv=none; b=c9wQSeNOHUYQeSJikEe7BqdIKtiicnPLb77zcOGtqL03sshuv3qqbDeDYBOfj+j9yPm7U/YpHwXbK0xCSZVlyiMC8WIK6chXOdMQFBGEDQZawNkVxNXXYPYoEN+NUGs/+l7IQW7swUKU878Zv20vWIoNK07ROd5Quqrcp6v7qzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778742069; c=relaxed/simple;
	bh=f66lgQPtTtd9CODAjOd3YiCN6f2o8c7PL46CffwEH+U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UsFUJrHxt9F7En3luKCimaLSOXne10bFfcEXs9uO9yEzxm2f3KXYjnUK/gKMb5gDFzetMOMxi0KdvhLBLl4JHtqWkBluzniCAbchODYx8JOfZW0gS1gPICjsN6jI/3RUSl58xCDUQK0CVNH/+1tdFwP4y9+pEOmbVE83dsCLZZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNCUigYp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNCUigYp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96842C2BCB7;
	Thu, 14 May 2026 07:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778742068;
	bh=f66lgQPtTtd9CODAjOd3YiCN6f2o8c7PL46CffwEH+U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=HNCUigYpQNIMO+LxVL5xbaa1ZBiZuV2vfRVdsc+y1HHuPEq+l5D5j/DC+iPE2kiIq
	 NpDsRHaoFXm34+ZqBocK830wWh70Kw2uZ7kNeJCIkV7COgnNUBdPHRKGHc1Irr6eqT
	 RzIdbuXwoG5RlINNMckfHkUIlsEBm8Q+6X6fbrNS2E7E458DcXOOWvUh3a7kWJKjHX
	 3EMGurhVhG6iArtsZj1jNDGSW6qS4EdUJUwdCenJ/uVYvP608IEFPORinOqSL2kojN
	 dZmmuskcWBS0eH8pFr7ZoMjQsMpu0LZsmkHF6dDbrjpt0d1kopfEpVNDU3hdnSFdSi
	 Ck4CbLAhd2How==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v4 03/13] dma-pool: track decrypted atomic pools and
 select them via attrs
In-Reply-To: <agSED6BdSXBhbDYI@google.com>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-4-aneesh.kumar@kernel.org>
 <agSED6BdSXBhbDYI@google.com>
Date: Thu, 14 May 2026 12:30:54 +0530
Message-ID: <yq5abjeia315.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mostafa Saleh <smostafa@google.com> writes:

...

>>  struct page *dma_alloc_from_pool(struct device *dev, size_t size,
>> -		void **cpu_addr, gfp_t gfp,
>> +		void **cpu_addr, gfp_t gfp, unsigned long attrs,
>>  		bool (*phys_addr_ok)(struct device *, phys_addr_t, size_t))
>>  {
>> -	struct gen_pool *pool =3D NULL;
>> +	struct dma_gen_pool *dma_pool =3D NULL;
>>  	struct page *page;
>>  	bool pool_found =3D false;
>>=20=20
>> -	while ((pool =3D dma_guess_pool(pool, gfp))) {
>> +	while ((dma_pool =3D dma_guess_pool(dma_pool, gfp))) {
>> +
>> +		if (dma_pool->unencrypted !=3D !!(attrs & DMA_ATTR_CC_SHARED))
>> +			continue;
>> +
>
> nit: If we fail to find a matching pool, a slightly misleading message
> is printed as pool_found =3D false
>

The message printed is

	WARN(1, "Failed to get suitable pool for %s\n", dev_name(dev));

That is correct, isn=E2=80=99t it? The kernel failed to find a pool with the
correct encryption attribute. For example, the request was for an
encrypted allocation from the pool, but no encrypted pool was available.

>
>>  		pool_found =3D true;
>> -		page =3D __dma_alloc_from_pool(dev, size, pool, cpu_addr,
>> +		page =3D __dma_alloc_from_pool(dev, size, dma_pool->pool, cpu_addr,
>>  					     phys_addr_ok);
>>  		if (page)
>>  			return page;
>> @@ -296,12 +345,14 @@ struct page *dma_alloc_from_pool(struct device *de=
v, size_t size,

-aneesh
