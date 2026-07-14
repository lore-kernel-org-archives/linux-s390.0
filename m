Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D3C3655F0;
	Tue, 14 Jul 2026 03:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784001436; cv=none; b=J+KMdJS1inRQG4BSoGZTscwrbev8YsYhLXBQjmnKyEyuH3/rMdHUBLCK+uQy1hMoe8XWV50qfIkFaBc1jszy8kd+5IAvy1lU6tC/CNRLqqoRrvAWCnpcwdZazA5TUZmABswDsOk3wzJ9+9VFLe2VnkshaOmZSQ1miuJiyvnj+tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784001436; c=relaxed/simple;
	bh=StS7UKvJ/np+93VrnACK0jk1cBXTnkp0ijBgNiHgeYU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j2mbUobtJle4wJIgwoaY1V+5OxX+dMnP4jqr5uLGzUCcgzi/wuY4/c95MY9N/oZXZECBSLtRhBKEU6jzxdgLgeOMld2uDVQsRdf0vB5sJUGsW2WrxKbmuWk9tBvNC4XxAxkBhbYx02Nwhzyr+3aHdWF49AqPFP0sCqBDDiNE2aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=liTaKP1C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="liTaKP1C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0781F000E9;
	Tue, 14 Jul 2026 03:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784001434;
	bh=0DTF91RjgvUm3CkB4plK9HEQr87d/ix1i757jTGkFXY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=liTaKP1CyQrmvF0csupiCFTNVzXrIF4DX9PY42lGELqbECDbZSqXHFZ9ZmTU2m0e9
	 5KWxINF9sfknPV5nVNQ1W/TliVFmJMCkEjFEYGHUfMP22YLVwQTk3GvT9OKdkoUmd7
	 O6t/MMHc03XpwRzKpXb5NBzNwRLz6dmuIH1uOX5bFJfbq9eOuqVSgWUPXIHBRMH22u
	 AmQ2hRYMtzI26BCCfdviKKLYvAzWyATOKECrGshO0bgqaHnTSbVIB7dcZWobY+G5/R
	 hXLxwzKEw2QW/46MBn1MokgBPlijaMw8orHsIzchJadQjcBC1HAK2Epj4bNYTUnO6g
	 2ZAHiwxtlSCjQ==
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
Subject: Re: [PATCH v7 04/22] dma: free atomic pool pages by physical address
In-Reply-To: <20260713181059.GL3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-5-aneesh.kumar@kernel.org>
 <20260713181059.GL3133966@ziepe.ca>
Date: Tue, 14 Jul 2026 09:27:01 +0530
Message-ID: <yq5awluymdf6.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Wed, Jul 01, 2026 at 11:19:08AM +0530, Aneesh Kumar K.V (Arm) wrote:
>> dma_direct_alloc_pages() may satisfy atomic allocations from the coherent
>> atomic pools. The pool allocation is keyed by the virtual address stored in
>> the gen_pool, but the pages API returns only the backing struct page.
>> 
>> On architectures with CONFIG_DMA_DIRECT_REMAP, atomic pool chunks are added
>> to the gen_pool using their remapped virtual address.
>> dma_direct_free_pages() reconstructs a linear-map address with
>> page_address(page) and passes that to dma_free_from_pool(). That address
>> does not match the gen_pool virtual range, so the pool lookup can fail and
>> the code can fall through to freeing a pool-owned page through the normal
>> page allocator path.
>> 
>> Add a page-based pool free helper that looks up the owning pool chunk by
>> physical address, translates it back to the gen_pool virtual address, and
>> frees that address to the pool. Use it from dma_direct_free_pages() while
>> keeping the existing virtual-address helper for coherent allocation frees.
>> 
>> Tested-by: Michael Kelley <mhklinux@outlook.com>
>> Tested-by: Mostafa Saleh <smostafa@google.com>
>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>> ---
>>  include/linux/dma-map-ops.h |  1 +
>>  kernel/dma/direct.c         |  4 +--
>>  kernel/dma/pool.c           | 54 +++++++++++++++++++++++++++++++++++++
>>  3 files changed, 57 insertions(+), 2 deletions(-)
>
> This seems pretty suboptimal?
>
> If !CONFIG_DMA_DIRECT_REMAP then page_to_virt() was used to compute
> the genpool's addr so dma_free_from_pool_page() can use the same
> logic, which is how things must be working at all today
>
> The CONFIG_DMA_DIRECT_REMAP scenario does look broken, so I'm
> surprised there isn't a Fixes line on this commit? I don't have an
> opinion on the search, but since alloc_pages() is used there is 8
> bytes in the struct page that could be used to store the remapped
> vaddr to avoid the search if someday someone wants to improve
> this. Maybe a small comment hinting that direction would be a nice
> addition.
>
> Jason
>

Something like

+/*
+ * FIXME!! We could avoid this by storing the remapped virtual address in
+ * struct page and using that for lookup.
+ */
 bool dma_free_from_pool_page(struct device *dev, struct page *page, size_t size)

-aneesh
