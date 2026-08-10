Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F15415F07;
	Mon, 10 Aug 2026 15:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786376701; cv=none; b=r1qFK+DbT+i9S6N/QomahK1gg86hVKUpyML/pJtWM1iTAjOze+OL8704wUd9coHYMF8kUSwI/Dj24lXufXCpAYcfjt/+hC6uWGORJG5B/Q2Z06fMUYpgtoTGyc9yvhDypTdwgvdhBZfdvKnvFGW6Ii1kNwStqgaLVD8HU010O+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786376701; c=relaxed/simple;
	bh=yQJww7ZGdYxbBgqIq9LKqYsedFQNlIaK8p+eVX/QSMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TI0Z/+lQrzh3NC/g+Wctyn90vqlq9gw0SffMqtBr7wr+7OKcg6nzuOEcZ4SMDki3DQiBfFtwDbB0Kor0llqqM9eIGhOLX0Uni9YiMcZCzt2BbIxjCGBkSrnF3aJOMRTj98aaMflokeIP/9TUN9kA6Eus03BClIklo9cNewmKwVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=H7xR0Sxb; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="H7xR0Sxb"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F24814BF;
	Mon, 10 Aug 2026 08:44:53 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E89943F632;
	Mon, 10 Aug 2026 08:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786376697; bh=yQJww7ZGdYxbBgqIq9LKqYsedFQNlIaK8p+eVX/QSMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H7xR0SxbusLzG7Sb2NlewiR4LBLzuyCgcVaKV/mKoQPpnR6bHNwkOyVwOWyGpfp4k
	 d7shVtjki8k5SijDUSvkaCBaPFYfjWglGLvWzmgSD/R+NCvdMcdAMlGjf4JUDx7ab2
	 oXZo8hi566R+Gne4NSKq2YKsMKBRKFhYIG8CsXKs=
Date: Mon, 10 Aug 2026 16:44:51 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marc Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
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
Subject: Re: [PATCH] arm64: swiotlb: Keep the default size for protected
 guests
Message-ID: <annx8-HDjTq933vp@arm.com>
References: <anYgXSR4VAi3TpOj@google.com>
 <CGME20260807182023eucas1p1f653436207b2b00338e99ea1d8f847df@eucas1p1.samsung.com>
 <20260807182017.GH200537@ziepe.ca>
 <7d22482f-d5fd-4cf4-9d32-6a54e02f2fbb@samsung.com>
 <yq5av79iiard.fsf@kernel.org>
 <anml6lLRERm1Iv-_@willie-the-truck>
 <28442500-1d53-4776-bae5-459c3ffc1cc6@samsung.com>
 <anm6K2umtx4iKnyZ@willie-the-truck>
 <20260810130818.GN200537@ziepe.ca>
 <annc1ynWUsWQc4JM@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <annc1ynWUsWQc4JM@willie-the-truck>

On Mon, Aug 10, 2026 at 03:14:47PM +0100, Will Deacon wrote:
> On Mon, Aug 10, 2026 at 10:08:18AM -0300, Jason Gunthorpe wrote:
> > On Mon, Aug 10, 2026 at 12:46:51PM +0100, Will Deacon wrote:
> > > On Mon, Aug 10, 2026 at 01:37:11PM +0200, Marek Szyprowski wrote:
> > > > On 10.08.2026 12:20, Will Deacon wrote:
> > > > > On Mon, Aug 10, 2026 at 02:59:42PM +0530, Aneesh Kumar K.V wrote:
> > > > >> Marek Szyprowski <m.szyprowski@samsung.com> writes:
> > > > >>
> > > > >>> On 07.08.2026 20:20, Jason Gunthorpe wrote:
> > > > >>>> On Fri, Aug 07, 2026 at 06:13:49PM +0000, Mostafa Saleh wrote:
> > > > >>>>> But the whole thing is best effort anyway, the kernel picks
> > > > >>>>> IO_TLB_DEFAULT_SIZE which does not depend on the system topology or
> > > > >>>>> how many devices or how much DMA they do.
> > > > >>>>> SWIOTLB memory is wasted if unused so we should be careful around
> > > > >>>>> that as it would be the other way around and users would have to
> > > > >>>>> decrease it manually.
> > > > >>>> Yeah, it is why the arch code shouldn't really be sizing it directly,
> > > > >>>> it should be done in common code and, yes, we are probably going to
> > > > >>>> have to do something alot smarter to have the common code better
> > > > >>>> auto-tune this for the CC case..
> > > > >>> What about the $subject patch? I assume that it is still needed to
> > > > >>>
> > > > >>> restore the behavior that was altered by the "[PATCH v8 00/23]
> > > > >>>
> > > > >>> dma-mapping: Track shared DMA state through direct, pool and swiotlb
> > > > >>>
> > > > >>> paths?" patchset?
> > > > >>>
> > > > >> I would request that we pick this patch to fix the regression described
> > > > >> in https://lore.kernel.org/all/yq5azeyxyfol.fsf@kernel.org/.
> > > > > I really don't think we need it. CCA hardware isn't exactly widespread
> > > > > and the KVM host side patches don't appear close to being merged.
> > > > 
> > > > Does this mean that the branch for-next/coco [1] won't go to v7.3-rc1?
> > 
> > Let's not make progress on guest support contingent on KVM CCA host
> > side patches please. I expect the CSPs will have VM instance types
> > available based on CCA within quarters, and Linux as a Guest should
> > work in those environments regardless of what KVM is doing. I don't
> > really expect full KVM support for years, frankly, the patchset is
> > massive. Even Intel and AMD don't have full KVM support yet.
> 
> To be clear: the only part I'm pushing back on is the realm-specific hack
> to size the SWIOTLB area in arch/arm64/. Even with that hack applied, I
> don't believe a one-size-fits-all value is going to work for everybody,
> so it was really great to see that special-case removed in:
> 
> https://lore.kernel.org/all/20260717180442.110954-18-aneesh.kumar@kernel.org/

We had Mostafa's patch here:

https://lore.kernel.org/all/20260603110522.3331819-4-smostafa@google.com/

adding the same swiotlb buffer allocation for pKVM guests and realms.

Aneesh's cleanup of SWIOTLB_FORCE inadvertently removed the 'else'
clause and limited_addressing is now always checked, meaning that we get
size limiting irrespective of whether we still need a default swiotlb.

Normally I would consider this a regression on top of mainline and
Mostafa's patches rather than a cleanup. However, if the default size of
the bounce buffer was never sufficient for realms, as you said, we may
need something better here anyway, so not worth fixing.

I can see x86 in mem_encrypt_setup_arch() adjusting the bounce buffer to
6% of the guest memory. We could make up similar logic for arm64 or we
could just rely on CONFIG_SWIOTLB_DYNAMIC (default off currently for
arm64 I think).

-- 
Catalin
