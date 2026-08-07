Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D728D285CAA;
	Fri,  7 Aug 2026 18:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786125666; cv=none; b=seOrMjtnjnVwBhIjn1Ync/r/9UluNYx67cvea8YG//6QLmm4wPh+mzVebBTAbdnFmcjJ/vGsi8wodZIWkjd3P9Awv5H8mG5m7FKTLeWg8HhdwmYSb1akxDWCzfAok/1NUZUX0lRgDpTGFGIA3S92pL5ZuqCEdE4d2rXHjSRUvkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786125666; c=relaxed/simple;
	bh=5TCH+Enl+al8DDeNF2jVl03VHEzckvKqSduSEVd9N1g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R0Alm8/j77SD5O0K9NzFSblNYMff71tf7x1TRq3hpU+zFd5PRoF+Ckpy4m9TKnTNdc7kT+1bDz2alfOq0jUgxYqr7et+/QRJ/kFhCKwYk1abWK3YPvNB9Ie1hssvcHk/yBiXe1PSztuJU9WUD8Ff67v2ECKXwSwqQSNOSVYSBfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2KP1Buw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2KP1Buw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6464F1F000E9;
	Fri,  7 Aug 2026 18:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786125665;
	bh=9M1k5SlL5Su3vC0BTK1X+EZdBDJQy7Ds7MO/9dG8qvo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=k2KP1BuwvBL3uUlPBpKv0J0Pm0yBgEOZ6G/A5UhKjJIS+jWDTjRG4EioD3Dp2//SZ
	 pY8YHcUZOqaotakwE11W09YnuJjVFeJKAhYBTL2nKs0RsCS4wzvHV18t+XmOetroYJ
	 gnqCdm82zmjLjAURA7aPUN49jhWtqEh6LSkkoML93+Nzloet5QKfiQ4StPRY1bvESW
	 ActGHYqTISBAKwDmrPW11A0MSURZGvzkWn3qPoAauu57PTvP6AWMOndXhEZvcW97ck
	 mtG/lpXbVMiA04jqQx6iI0gySsIUw2bwnMvuXuIl3zkajdZDJUAtWIfo59dTnZF+vf
	 hUaHTEP+kpSMg==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Will Deacon <will@kernel.org>,
	Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH] arm64: swiotlb: Keep the default size for protected guests
In-Reply-To: <20260807135810.GA200537@ziepe.ca>
References: <20260717180442.110954-18-aneesh.kumar@kernel.org>
 <20260807092612.2202005-1-aneesh.kumar@kernel.org>
 <anXIZSh9lq99VG9X@willie-the-truck> <yq5acxvu2ict.fsf@kernel.org>
 <anXbJ2O4DWgPxCeg@willie-the-truck> <20260807135810.GA200537@ziepe.ca>
Date: Fri, 07 Aug 2026 23:30:51 +0530
Message-ID: <yq5awlu1yfn0.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Fri, Aug 07, 2026 at 02:18:31PM +0100, Will Deacon wrote:
>
>> > I was under the impression that there is a possibility of using swiotlb
>> > instead of restricted-dma-pool with pKVM.
>> 
>> Yes, that patch enables swiotlb as a possibility for protected guests
>> but with your patch we avoid shrinking the swiotlb buffer even when
>> restricted dma pools are being used and that's a waste of memory.
>
> I also thought we switched pkvm to use CC-like swiotlb as part of the
> alignment in this rework? Mostafa ?
>
>> > If that is not the case, then we could change:
>> > 
>> > !cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
>> > 
>> > to
>> > 
>> > !is_realm_world() &&
>> 
>> Perhaps, or you could just pass the swiotlb= option if the defaults don't
>> work for you. Can you give more details about the slots exhaustion you're
>> seeing under CCA?
>
> We see badness with swiotlb too, it basically doesn't work out of the
> box if you have to use it 100% for real devices. It easily runs out
> of memory.
>
> Auto tuning to higher levels makes sense to me, but I'd rather the
> core code handled adjusting its size to the estimated need, not arch
> code.

Agreed

-aneesh
