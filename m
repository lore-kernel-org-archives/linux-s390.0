Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E371B4257;
	Tue, 14 Jul 2026 05:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784005444; cv=none; b=HqvFJX+IndUu0ODJWbJvyao0cdVd+87XbmNn9UipIVAznrkg25ti+OqumdWpAKE9ANjzIDetJks1aNFi4hEs136NuY07l+tx3La+6NBYbj9uF98L6SHwoGuTcdr9+pssEVbeWedrUS49xC9h0r/2SVUth25MKiJ8cHKnIfLk2lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784005444; c=relaxed/simple;
	bh=Li/FLq14l3YQwMeUO9VAFSuyZNfWfWu/mGe4yAjNY70=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aHkiafj5cHUCuZgLwf3WaBJ7o+fYGY2Cz9NF+V0W/OgTGSlQIsaqphpnRen6v36H8jiHmcwWMmgPUA9k0P2qHxMjIcnBAIrmJivPtCk6by/jdnv2xeBNCKNtoC9Vz6Uw4nYWq+S36ND3flxEzHNbVpGz8+LPzGAaDUzI58uceAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKlMkUeo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKlMkUeo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B5E1F000E9;
	Tue, 14 Jul 2026 05:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784005442;
	bh=GWX7BHocDQy79xg1nWh2GEbrLAdwjBZsgjhN9hnUanY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=CKlMkUeoK3O/MtOhbbbjwFwTm02ZhG1JN0IrLP/cep1imp4Q1D4dC+CryFlGQdYf0
	 p9WAKGQzC5wBQM5okRin6feO0hARpilwewRhbaiNNcCKM1j8Jc7MocDpN5cw2tKRK8
	 nj+1LYvvaTzSiKhPl4FiIFz0yQWKY4HCBfMNmOWwUa9RX0yKX9PkcYdXM49sULT1/h
	 UYL/h7YPtNp3dRvfiutw7m+FoTgPWe+acBb+18F1Q4lrBV7r68ZIbrLJjQvU18da7D
	 JyZBOTNljbEhD6ihH8+PmlV84vY3FW+tDDZSgTIf8Zax7ZuCxIIFsxyvwgxavAix6i
	 2U6+oR3PBWaIQ==
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
Subject: Re: [PATCH v7 20/22] dma: swiotlb: free dynamic pools from process
 context
In-Reply-To: <20260713194131.GZ3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-21-aneesh.kumar@kernel.org>
 <20260713194131.GZ3133966@ziepe.ca>
Date: Tue, 14 Jul 2026 10:33:49 +0530
Message-ID: <yq5ao6gamabu.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Wed, Jul 01, 2026 at 11:19:24AM +0530, Aneesh Kumar K.V (Arm) wrote:
>
>> @@ -840,7 +843,7 @@ static void swiotlb_del_pool(struct device *dev, struct io_tlb_pool *pool)
>>  	list_del_rcu(&pool->node);
>>  	spin_unlock_irqrestore(&dev->dma_io_tlb_lock, flags);
>>  
>> -	call_rcu(&pool->rcu, swiotlb_dyn_free);
>> +	swiotlb_schedule_dyn_free(pool);
>
> This knows if the pool has cc_shared memory in it since there is now a
> flag tracking that? So should the work queue version be conditional on
> that flag?
>

We could definitely do that. I was not sure whether it was worth it,
considering that it would add two paths for SWIOTLB dynamic free.

-aneesh
