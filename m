Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362DC284662;
	Fri, 19 Jun 2026 13:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781876674; cv=none; b=OUVubeB1QU/VXlCTcrrXG55nv9+MUzwtwM43MQpSJlSPHQy4rhLCCEc1T17RZ9wRzPPFTF/Omf4LNHd4ie2E4JVlLccyd0aZaeFHgTkOaHtwhocyO6Hvr0Qy2dHx/s5xaDUzyA7NXUj6DdChz3tmN/6XLXLhGuOhvBD5NfoHutk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781876674; c=relaxed/simple;
	bh=khm+DM7tr0W3HmYJ+IXWkzk5OZuLgGtOp7/MODfbGg4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=csFGFMqBUP7TVVk2MtkNwQoOUj+vC7MGb/0l4BabHuXHv2jESJxciyCtHXt/AK7fOrJQYaJ8Yjy4kJPHvASYeK83TTJiqnERrG7EZpRzS0WEICRCzVLfnf9shkuLbE5VqMMFiZNbLTqjh32j77xcyfg933FsXQCiOheEqlz8XJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQzkkU4F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQzkkU4F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449711F000E9;
	Fri, 19 Jun 2026 13:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781876672;
	bh=NOlJ0qkWwGjqOtI46GdlsCxvHcFNK9S64rnZbC57zPI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=lQzkkU4Fajz1t5MDntjr+eBXOgH/kqWDGPbPnNEl6OlP4DsAaE0JKuqovdDh57WYY
	 I/6ltpFvRt56sqvzdXsVfD5NofYwR/VqfDXfNqNt77Yx03Hf0sOR6e/Q6ZJSfeD9GO
	 MmbYnKiDy6yTiZjdCMwqi+8UMVqLgh0oXCGBXinMAlZ1DP4u2+GGJzF27w5GUsgnCT
	 Af+NzJvNa18t/AFT8LNiUDtN+85DcWRyilFlXUGHfHNM1wTlz4AIvIFrWjmsrrYPJ0
	 wqYIMCBqen+y6u04gcv4qb2+QSFkFebPKCBt/9BLwnbVHBt66NMmfUQHW+KW7B7/Ka
	 vLTBA3dhzOVKQ==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Alexey Kardashevskiy <aik@amd.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
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
Subject: Re: [PATCH v6 00/20] dma-mapping: Use DMA_ATTR_CC_SHARED through
 direct, pool and swiotlb paths
In-Reply-To: <20260619120309.GI231643@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <aigYbK12D8uKQvJF@arm.com> <20260609144746.GL2764304@ziepe.ca>
 <2ecfa1a8-6202-4319-9692-a6ffeb5a3dbf@amd.com>
 <yq5aqzm4dz25.fsf@kernel.org> <20260618153705.GH231643@ziepe.ca>
 <d4ef9a9f-18d9-40e1-9d02-87aeb9cb6540@amd.com>
 <20260619120309.GI231643@ziepe.ca>
Date: Fri, 19 Jun 2026 14:44:22 +0100
Message-ID: <yq5aik7eejbd.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Fri, Jun 19, 2026 at 12:05:45PM +1000, Alexey Kardashevskiy wrote:
>
>> > > > > IMHO that's an AMD issue, not with the design of this series..
>> > > > > 
>> > > > > The series is right, a device that is !force_dma_decrypted() must be
>> > > > > considerd to be a trusted device and we must never place any DMA
>> > > > > mappings for a trusted device into shared memory.
>> > > > 
>> > > > swiotlb=force forces swiotlb, not decryption.
>> > 
>> > If force_dma_decrypted() == true then swiotlb must allocate from a
>> > decrypted memory pool. It is right there in the name!
>> > 
>> > The hypervisor environment should *never* set force_dma_decrypted()
>> > because all devices can access all hypervisor memory, up to their IOVA
>> > limits.
>> 
>> True. But we do not have encrypted swiotlb pool today, right?
>
> "encrypted" is just normal struct page memory, that's the default for
> swiotlb.
>
> I think it was a big mistake for the AMD SME stuff to overload the
> decrypted/encrypted CC stuff which should mean shared/private in a
> guest context to also mean things about physical memory encryption in
> the host. It is really confusing.
>
> The SME side is just a bad arch choice, the real world doesn't work
> well if you set high address bits in your dma_addr_t. I think AMD
> needs to use those restricted swiotlb pool where it allocates this
> very special "SME Disabled" memory that will have a low
> dma_addr_t. Then alloc and bouncing will get memory with a suitable
> dma_addr_t. This has nothing to do with force_dma_unencrypted() which
> is only a CC guest concept and nothing else in the OS should ever
> touch decrypted memory.

Agreed. This would make the code much simpler.

-aneesh
