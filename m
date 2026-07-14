Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E786230C63B;
	Tue, 14 Jul 2026 03:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784000139; cv=none; b=HTIslSVkiImKpi5MFvd7SiVGlVDf8CSxDaogzFAB8llQb7pOjf8oVYquS7rkIib/3Jpkui0XHyLIUXeIi6JbzL5ecma+naOWJPl70qrjpp+QrCmpQBm3NBH1chwbyZRSRxgJ+r4k+2qwxE7LaSvzisKeuNjOZke2Mupmyqp5Ce4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784000139; c=relaxed/simple;
	bh=oPcAVwulTEZqwgt+ROBzzFLUXbQYJQG9mLa7fFzzZ0o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GFg6G9wCLH/cJ2Kw7XMDhPTAdWUzPSy4S9o4kAjoXvZiP3IrcLTYkgrju6zCOwxmtJW94pGg/zN2DyhpS9nJWEvL6sm2U80vhfao8RWnHryJZkL0fCS5OwKpfPc6u5Tykouep5aTGoOYZwoxHN71krJcyy9N2JQJkuFYG1wdkk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EcW9AEgv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EcW9AEgv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3675A1F000E9;
	Tue, 14 Jul 2026 03:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784000138;
	bh=J8EROicyvyqBHzNN9rE23d0T/JySclZqP++7t7T4RaE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=EcW9AEgvcMudcqLdd5C8/BiDRQ3ckffoh+3joXtfcvQArty1Bqy7GiIydvzIBCLJI
	 ZYtj7PhBn7KY5xOXpbDoYrxVdGcfi3vpdsHKGCNWFha4MIt+IhEV5jDEBjBoyWy2iq
	 bj05AAquiv+sKEDadr4DNLJ3+mfRTpc6qQeInr7Odr7bDn+pbXtO5yQMpfS+FUvAU4
	 8ZpHoUc5+sQxY4Zemd+uQ3SKfXOCSJ2Ui1KfmTI6rr1/awo2nLjrYkhAKzaSTOFy+Z
	 5A/hh2E0gsAAMZGguGSuY4n+PIlelCOb6vjM8CYbnyg5x9L/brWLTpdEsmw8Hz8Ctc
	 KsvvwB6a/KzRw==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Mostafa Saleh <smostafa@google.com>,
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v7 02/22] dma-pool: fix page leak in
 atomic_pool_expand() cleanup
In-Reply-To: <20260713175433.GI3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-3-aneesh.kumar@kernel.org>
 <20260713175433.GI3133966@ziepe.ca>
Date: Tue, 14 Jul 2026 09:05:25 +0530
Message-ID: <yq5azezumef6.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Wed, Jul 01, 2026 at 11:19:06AM +0530, Aneesh Kumar K.V (Arm) wrote:
>> @@ -115,8 +116,10 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>>  	 */
>>  	ret = set_memory_decrypted((unsigned long)page_to_virt(page),
>>  				   1 << order);
>> -	if (ret)
>> +	if (ret) {
>> +		leak_pages = true;
>>  		goto remove_mapping;
>> +	}
>
> Truely these _set_memory_decrypted() things are an insane API. So a if
> it fails to decrypt it can be in any messy state?
>

Yes, we could possibly try to encrypt the page again and, if that
succeeds, avoid leaking it. We might want to do that tree-wide in a
separate patch.

>
>> @@ -130,14 +133,15 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>>  				   1 << order);
>>  	if (WARN_ON_ONCE(ret)) {
>>  		/* Decrypt succeeded but encrypt failed, purposely leak */
>> -		goto out;
>> +		leak_pages = true;
>
> At least this one makes some sense..
>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>
> Jason

-aneesh
