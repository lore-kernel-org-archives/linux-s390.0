Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2223283FCF;
	Tue, 14 Jul 2026 04:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784001764; cv=none; b=kJtKpFY+eN/k4KvlVPqNbzI9ofxd5JPItd2cuKWxdJTbAbSfNAf4ZR0O7MwYjS0LtBu+O/jExj2JAnAShnrqvU2koK6XRifPPQR42LAYKjgwjP9k5LGhNBzeoJe6V97N7eggkWG5H7ii2vBK1g2oL30RpGrQ1dQlAgSYhzcU7QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784001764; c=relaxed/simple;
	bh=zWct6K3uIvjDGlZKeyZrRRKmfg1akXIOeRFLxArwtfA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p3zEOmVOk/KAkTjFVeZhH97S6xxcJsoUpZYLb4vAAU8xxdiHAZY3IVf98RR78e6+OVKjZ1mmkfsWVc86Ov0twzCZHP6hCKVePoVq3Pri1UuC2zNSUO1KKs/DRNK1xO/fds/lGs/xCTZoQmlfGXf+vU5E3sMoFmEEkiblwydcZwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sz+jLGb5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sz+jLGb5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA5F1F000E9;
	Tue, 14 Jul 2026 04:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784001760;
	bh=I+ZBXykHnbEwGIuh63wccmA7DmHMIqMB7lgyh5rZR2Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Sz+jLGb5lqaIZdWXV5CgOFgtGhqpCdS9TzBy3Zi/FZdiL/JcpHnSOLFWaVYHy2tEu
	 0z60X/PsuJFrCARLJjubigCSTZRICnH353bC8OXad9IyIY1+enenSt0y3KaF+xL+sW
	 8lQgb6amuJFbAq4Z7TcDyrBgJFMIjy39lUR5T7hoQVIygJmSNBiAoM5TuHUBIWcLut
	 2EEU0Hw+Op7oSrVx/EtawGwStFg7Ok6X4NqNJM4I2Db/C/xB0XLNZOyBmyxFoT/3er
	 DeOXIY8HufW/cYyNZJxzZZ+EDvupXNVMaU/JsNpu6rlNiKMwKGhQi4/GS9d4rdv9qi
	 YoUbvZuFqm5LQ==
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
	Jiri Pirko <jiri@nvidia.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v7 11/22] dma-pool: track decrypted atomic pools and
 select them via attrs
In-Reply-To: <20260713175616.GJ3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-12-aneesh.kumar@kernel.org>
 <20260713175616.GJ3133966@ziepe.ca>
Date: Tue, 14 Jul 2026 09:32:27 +0530
Message-ID: <yq5atsq2md64.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Wed, Jul 01, 2026 at 11:19:15AM +0530, Aneesh Kumar K.V (Arm) wrote:
>> -static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>> +static int atomic_pool_expand(struct dma_gen_pool *dma_pool, size_t pool_size,
>>  			      gfp_t gfp)
>>  {
>>  	unsigned int order;
>> @@ -114,14 +120,17 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>>  	 * Memory in the atomic DMA pools must be unencrypted, the pools do not
>>  	 * shrink so no re-encryption occurs in dma_direct_free().
>>  	 */
>> -	ret = set_memory_decrypted((unsigned long)page_to_virt(page),
>> -				   1 << order);
>> -	if (ret) {
>> -		leak_pages = true;
>> -		goto remove_mapping;
>> +	if (dma_pool->cc_shared) {
>> +		ret = set_memory_decrypted((unsigned long)page_to_virt(page),
>> +					   1 << order);
>> +		if (ret) {
>> +			leak_pages = true;
>> +			goto remove_mapping;
>> +		}
>>  	}
>> -	ret = gen_pool_add_virt(pool, (unsigned long)addr, page_to_phys(page),
>> -				pool_size, NUMA_NO_NODE);
>> +
>> +	ret = gen_pool_add_virt(dma_pool->pool, (unsigned long)addr,
>> +				page_to_phys(page), pool_size, NUMA_NO_NODE);
>>  	if (ret)
>>  		goto encrypt_mapping;
>>  
>> @@ -129,12 +138,10 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>>  	return 0;
>>  
>>  encrypt_mapping:
>> -	ret = set_memory_encrypted((unsigned long)page_to_virt(page),
>> -				   1 << order);
>> -	if (WARN_ON_ONCE(ret)) {
>> -		/* Decrypt succeeded but encrypt failed, purposely leak */
>> +	if (dma_pool->cc_shared &&
>> +	    set_memory_encrypted((unsigned long)page_to_virt(page), 1 << order))
>>  		leak_pages = true;
>> -	}
>> +
>
> Was it intentional to remove the WARN_ON and comment ?

That WARN_ON() was a bit inconsistent. Not all page leaks due to
encrypt/decrypt failures triggered a warning, so I removed it.

If we want to warn about such failures, we should add the warning
consistently across the code. We may also want to handle decrypt
failures by encrypting the page again to avoid leaking it.

I will work on that as a tree-wide change in a separate patch.

-aneesh
