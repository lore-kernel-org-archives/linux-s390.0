Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEEE3E7141;
	Mon, 10 Aug 2026 14:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786372405; cv=none; b=Tj9OsgU/ulhWskZy+HKFUr/D9yIyb6AUOsJXTtsaMhdiYyI+hMITL2isQOO0O1rCxHwoxNgp6c0ilh2OF3AolQ58b08kIaDt9SW8eL2TSG1It5epSDzZhI8wRniYi/Rizk8TI7czCAiPwOO999OJbhJ/4tjXWdidWQZwwav8u+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786372405; c=relaxed/simple;
	bh=7nq4F6eVa+igOyPizq1W0mha35WNgJ79/K+NijHuU08=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rQI9VJ1TrbK70oMGppJN8BchP/sJ/V1c886GytD+avr9rZuocNB2331N/pqmqe6WEGAH53RvIcLXgFb4+l9XmFqN+kMVng7UAEH2Bbuc+/u6r6DolKaxYMzwvZWtbG2TeGSiZNzTX/62dIVUIi1DB5BnyowHckrHUQN0Cfc7GSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSEg5P7W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSEg5P7W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 694EF1F000E9;
	Mon, 10 Aug 2026 14:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786372403;
	bh=7nq4F6eVa+igOyPizq1W0mha35WNgJ79/K+NijHuU08=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=FSEg5P7W76NmVIq/uL3ZJ2JQ93MR3s+H6sZ8oMjTjqoQtXHtpU2o8sZMVTuz5+8hg
	 s/icfW+TbRoP+BIL+Loawx2mDkc39Fga6I40bNBiXUw3nB8b264pGFeY2r4EsV+SQ/
	 Q48Vqv2S8+JWnnwUTV2LAOB1KEzUy1OtCTc2kDiWMYMhfgicWh6aJLxgocxnjXteXp
	 Uh7ToRG+nxYY1VwUX4I2D+iq7cDjxmG7Qmo1ULPbcjMYqklUgFlWSNeJqJLZLC9zWi
	 jGnT9IpWporSvmykehgrhxxupjX8d/mSoeZuCdmoSHpGyNGZ6YcvG7+JV12NxM75p3
	 1qv9ezVXXbK8w==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Will Deacon <will@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
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
In-Reply-To: <20260810130818.GN200537@ziepe.ca>
References: <anX7F7dnKOtAOIIe@google.com> <20260807164734.GE200537@ziepe.ca>
 <anYgXSR4VAi3TpOj@google.com>
 <CGME20260807182023eucas1p1f653436207b2b00338e99ea1d8f847df@eucas1p1.samsung.com>
 <20260807182017.GH200537@ziepe.ca>
 <7d22482f-d5fd-4cf4-9d32-6a54e02f2fbb@samsung.com>
 <yq5av79iiard.fsf@kernel.org> <anml6lLRERm1Iv-_@willie-the-truck>
 <28442500-1d53-4776-bae5-459c3ffc1cc6@samsung.com>
 <anm6K2umtx4iKnyZ@willie-the-truck> <20260810130818.GN200537@ziepe.ca>
Date: Mon, 10 Aug 2026 20:03:09 +0530
Message-ID: <yq5amruuhwpm.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Mon, Aug 10, 2026 at 12:46:51PM +0100, Will Deacon wrote:
>> On Mon, Aug 10, 2026 at 01:37:11PM +0200, Marek Szyprowski wrote:
>> > On 10.08.2026 12:20, Will Deacon wrote:
>> > > On Mon, Aug 10, 2026 at 02:59:42PM +0530, Aneesh Kumar K.V wrote:
>> > >> Marek Szyprowski <m.szyprowski@samsung.com> writes:
>> > >>
>> > >>> On 07.08.2026 20:20, Jason Gunthorpe wrote:
>> > >>>> On Fri, Aug 07, 2026 at 06:13:49PM +0000, Mostafa Saleh wrote:
>> > >>>>> But the whole thing is best effort anyway, the kernel picks
>> > >>>>> IO_TLB_DEFAULT_SIZE which does not depend on the system topology=
 or
>> > >>>>> how many devices or how much DMA they do.
>> > >>>>> SWIOTLB memory is wasted if unused so we should be careful around
>> > >>>>> that as it would be the other way around and users would have to
>> > >>>>> decrease it manually.
>> > >>>> Yeah, it is why the arch code shouldn't really be sizing it direc=
tly,
>> > >>>> it should be done in common code and, yes, we are probably going =
to
>> > >>>> have to do something alot smarter to have the common code better
>> > >>>> auto-tune this for the CC case..
>> > >>> What about the $subject patch? I assume that it is still needed to
>> > >>>
>> > >>> restore the behavior that was altered by the "[PATCH v8 00/23]
>> > >>>
>> > >>> dma-mapping: Track shared DMA state through direct, pool and swiot=
lb
>> > >>>
>> > >>> paths?" patchset?
>> > >>>
>> > >> I would request that we pick this patch to fix the regression descr=
ibed
>> > >> in https://lore.kernel.org/all/yq5azeyxyfol.fsf@kernel.org/.
>> > > I really don't think we need it. CCA hardware isn't exactly widespre=
ad
>> > > and the KVM host side patches don't appear close to being merged.
>> >=20
>> > Does this mean that the branch for-next/coco [1]=C2=A0won't go to v7.3=
-rc1?
>
> Let's not make progress on guest support contingent on KVM CCA host
> side patches please. I expect the CSPs will have VM instance types
> available based on CCA within quarters, and Linux as a Guest should
> work in those environments regardless of what KVM is doing. I don't
> really expect full KVM support for years, frankly, the patchset is
> massive. Even Intel and AMD don't have full KVM support yet.
>
> People already have CCA capable HW, are already testing this stuff and
> the closer upstream can get to being workable as a guest without a
> mountain of OOT patches the better.
>
> I agree the thing is not ideal, but it was merged to ARM like this a
> long time ago, this patch is just fixing a small oopsie (was it a
> merge conflict?) to put it back. I don't the objection.
>

It was not a merge conflict issue. The change was introduced by an
incorrect rebase I did when updating the patch series on top of the pKVM
changes.


-aneesh
