Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EECE3EAC80;
	Thu, 13 Aug 2026 05:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786599155; cv=none; b=kCiu/a12jZErOffYRKmcPQACC1nFZ6aMax9rnYcY+6OIdVBEj4M47hO0fZga5p4x7/XypMj/esu6ukopfYY5UAFVD+a5C2rG8KMC09T+z/vs+fVbppKqDHnJPHSIFYhT/wRDkagZp8JO7lngF4HJRkfC7S0Flb6pLmsB6v8XUBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786599155; c=relaxed/simple;
	bh=PDLcwSnTv7PhVg76Tv5W2zcVBlxbUbLw7dv4p4yTRYQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KJnTzMdSBHjRHzWaJZy0U22c3d0pF4uHIwdDXVGAZ25iQcqLdrxbWTPee+SktNnLR5sd7c3LO/W0b41XBI54vVmuT7AGg2ojutY5opwtbYAFUPlXaPtzLyQaUXN4uVGrJvVp0CcNjOenhdw1nvIVOVCowHSv+7Z3/AF2JMcFIUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzMCM7a7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzMCM7a7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE4C71F000E9;
	Thu, 13 Aug 2026 05:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786599150;
	bh=Q7+1TgLjh64mc8wlI/+wRCUp/0uoB/o0TuwaP6ybUds=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=QzMCM7a7UPs+Up9SpbK9AGgUKNnJcq7JtJt2BxrN8xxedAYAC26wz140VuaR0ttCj
	 WX0GXl6z9TOj1EBKf+69He9/9QCoTVnrFPKfCLybSPeVU41AxLSKWLoWH2sQ7Znjcl
	 ScXog++R46Zku5P3HOzNfxdmnmW1RiX6j3Vhxcj5eDDHF8iHqZUAPIX4zAvuvzNPFv
	 jc6a4ZURfR+w3exZGHROC5GXfdZs9mTmZ5olvt6Wak1wNuVVexb84hpqHJIDbrsLie
	 HM5+LxMP45QmHLKFLcJCalkAYC2VyoVEAvEe+uOAp8up12PqmH0i/tC4Ji4cAc3zv6
	 bO8Gu75D+lRQg==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
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
Subject: Re: [RFC PATCH] dma: swiotlb: Size shared default pools for memory
 encryption
In-Reply-To: <anysnQFVTO_RAYxp@arm.com>
References: <20260811134056.756015-1-aneesh.kumar@kernel.org>
 <anxEc8EHmJQywVI5@arm.com> <yq5ajypvioks.fsf@kernel.org>
 <anysnQFVTO_RAYxp@arm.com>
Date: Thu, 13 Aug 2026 11:02:17 +0530
Message-ID: <yq5aecg2io0u.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Catalin Marinas <catalin.marinas@arm.com> writes:

> On Wed, Aug 12, 2026 at 04:38:03PM +0530, Aneesh Kumar K.V wrote:
>> Catalin Marinas <catalin.marinas@arm.com> writes:
>> > On Tue, Aug 11, 2026 at 07:10:56PM +0530, Aneesh Kumar K.V (Arm) wrote:
>> >> Systems with memory encryption use swiotlb to provide shared or
>> >> unencrypted buffers for device DMA. Confidential guests may route all
>> >> DMA through these buffers, while SME hosts use them for devices that
>> >> cannot address encrypted memory. The default swiotlb pool can therefore
>> >> be exhausted under I/O-intensive workloads.
>> >> 
>> >> Let architectures mark the default swiotlb pool as shared before
>> >> swiotlb_init().
>> >
>> > I thought we wanted even this decision to be moved out of the arch code.
>> 
>> Architectures may want to use an unencrypted swiotlb pool for different
>> reasons, one of them being CC_ATTR_GUEST_MEM_ENCRYPT. x86 hosts also
>> require unencrypted pool to support SME. We can cover both cases using
>> CC_ATTR_MEM_ENCRYPT.
>
> Yes but in one case it did not do resizing. With your proposal, it now
> does swiotlb resizing even for SME.
>

Isn't that a bug with x86 SME? I would expect both SME and SEV to
require that swiotlb resize.


>
>> However, pKVM does not want an unencrypted SWIOTLB
>> pool. So I was thinking it would be much cleaner to let the architecture
>> code drive that decision.
>
> Let's not single out pKVM but rather the reason it does not want one -
> it relies heavily on restricted mem. If you started a pKVM guest
> without rmem in DT, I assume it will need swiotlb to function properly.
> It's not a great heuristic (devices may not use rmem) but it preserves
> the current behaviour and can be overridden on the command line.
>
>> > BTW, why does arm64 report CC_ATTR_MEM_ENCRYPT instead of the GUEST
>> > option in realms?


This is getting fixed in  
https://lore.kernel.org/all/20260701054926.825925-9-aneesh.kumar@kernel.org/

>
> It's still not clear to me why we went for CC_ATTR_MEM_ENCRYPT instead
> of CC_ATTR_GUEST_MEM_ENCRYPT.
>

This is done for x86 to handle SME. SME also requires an unencrypted
swiotlb pool

>
>> For the same reason I mentioned above, architectures may have different
>> reasons for setting cc_shared = true. IMHO, it is cleaner to let the
>> architecture code make that decision before swiotlb_init().
>
> The arch code already reports cc_platform_has(), can we not rely on
> this in the core code instead of specific is_realm_world() and a new
> SWIOTLB_INIT_CC_SHARED flag or function call?
>
> We have three different decisions that shouldn't be driven by a single
> flag from the arch code:
>
> 1. allocate default pool
> 2. make default pool shared
> 3. resize default pool
>
> (1) is traditionally driven by arch code and that's fine. For (2), the
> core code has the information via CC_ATTR_*. For (3), we can enlarge it
> based on CC_ATTR_GUEST_MEM_ENCRYPT in combination with rmem (but not
> CC_ATTR_MEM_ENCRYPT to keep the current x86 behaviour).
>

Okay, if the presence of restricted-dma-pool is taken as a hint, we can
definitely move that to generic code.

I still think not resizing the swiotlb pool on the host for SME is an
x86 bug. However, I'll keep it compatible with the current behavior and
use CC_ATTR_GUEST_MEM_ENCRYPT for now. We can handle host SME in a
separate patch if needed.

>
> I think we should also move the reduction based on
> CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC into the core code. Riscv copied the
> same heuristic as arm64, so there's precedent for sharing.

I already have a patch doing that.

-aneesh
