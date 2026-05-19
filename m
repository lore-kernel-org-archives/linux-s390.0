Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECE54028C9;
	Tue, 19 May 2026 14:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779199227; cv=none; b=bZuaW0h3KrhasYJuuJEcrV2Ema6njBfXOdeXbMY/CurrTTuCMprLFrCp799g+z7LCtg6i4VB8p81jTke3YPUJVQNwagZJloOjOO/d9W7opWZXAD93qEEbxu8IEEzM7Ah6s1oEzamGZinvw8AXwidixXRe7f2v7wPgGJdetm1N0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779199227; c=relaxed/simple;
	bh=3DPK2EbXv/3wsOl17AXXlVKobx6PME7rhn3Y2pD37rY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GpIBwLDjlYNXtIZBYgaZ1UVCUuJNiW2cmLjw2hrUqy3n3+EkhdvnEf030Q+EotszgE24o5wncn9/FZxuknJBmO7CwRXaT9CmyacP2YTlik43hnFJpKSW6AF/mBJ+uTrFyiegG0DvPCzqcT9wIxKV7+90Z+gRKI6R1DdpCPjdCds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJApOYnD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJApOYnD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D58C2BCB3;
	Tue, 19 May 2026 14:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779199227;
	bh=3DPK2EbXv/3wsOl17AXXlVKobx6PME7rhn3Y2pD37rY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FJApOYnDwaielcOINdOz1m25oZHbpn3hiDJIO3zmg0dNyspugG9+kJWbUgDPzC6d+
	 /ckU7YijNm2/TPN+Hz9RYOAUzY4hFu0d+0bNggkC3U/bzYs/3cZmAwn1DyeZSlzZvx
	 dH1PeSgRGGCQHSlDRvsay4KTbEzvQ504Kg3+MSpbrx/nvn3fChg43T26iLRVkK7/gt
	 8rcqRCSQy5u6NoaNncNwcxb0/MwBCLyjuB/JnTsulV4dvriOnfy7Bt7IitbvfRRQ0X
	 vP67ZNbXn4wwSpMF/8KYnn1WmsOdTRVJ8wYY9blbr8Eu8xLzQ5d3DqyyGuHqTPib1P
	 /nStnaekQuhpQ==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Mostafa Saleh <smostafa@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
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
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v4 04/13] dma: swiotlb: track pool encryption state and
 honor DMA_ATTR_CC_SHARED
In-Reply-To: <agxolksC_1nfO34X@google.com>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-5-aneesh.kumar@kernel.org>
 <agSKQrSIhizCXKwx@google.com> <yq5ah5oaa63h.fsf@kernel.org>
 <agW5rhE9n2gDQ0w5@google.com> <yq5apl2y5f96.fsf@kernel.org>
 <agXaby-7L7yS3Vva@google.com> <yq5ah5oa59wy.fsf@kernel.org>
 <agxDxdxynp4KEovA@google.com> <20260519132911.GA7702@ziepe.ca>
 <agxolksC_1nfO34X@google.com>
Date: Tue, 19 May 2026 19:30:16 +0530
Message-ID: <yq5ah5o3sdn3.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mostafa Saleh <smostafa@google.com> writes:

> On Tue, May 19, 2026 at 10:29:11AM -0300, Jason Gunthorpe wrote:
>> On Tue, May 19, 2026 at 11:04:37AM +0000, Mostafa Saleh wrote:
>> > On Thu, May 14, 2026 at 08:13:25PM +0530, Aneesh Kumar K.V wrote:
>> > > >>=20
>> > > >> What I meant was that we need a generic way to identify a pKVM gu=
est, so
>> > > >> that we can use it in the conditional above.
>> > > >
>> > > > I have this patch, with that I can boot with your series unmodifie=
d,
>> > > > but I will need to do more testing.
>> > > >
>> > >=20
>> > > Thanks, I can add this to the series once you complete the required =
testing.
>> > >=20
>> >=20
>> > I am still running more tests, but looking more into it. Setting
>> > force_dma_unencrypted() to true for pKVM guests is wrong, as the
>> > guest shouldn=E2=80=99t try to decrypt arbitrary memory as it can incl=
ude
>> > sensitive information (for example in case of virtio sub-page
>> > allocation) and should strictly rely on the restricted-dma-pool
>> > for that.
>>=20
>> ??
>>=20
>> Where does force_dma_unencrypted() cause arbitary memory passed into
>> the DMA API to be decrypted? That should never happen???
>
> Sorry, maybe arbitrary is not the right expression again :)
> I mean that, with emulated devices that use the DMA-API under pKVM,
> they will map memory coming from other layers (VFS, net) through
> vitrio-block, virtio-net... These can be smaller than a page, and
>

Don't we PAGE_ALIGN these requests?

dma_direct_alloc
	size =3D PAGE_ALIGN(size);

iommu_dma_alloc_pages
	size_t alloc_size =3D PAGE_ALIGN(size);



> using force_dma_unencrypted() will share the whole page.
> And as discussed, that leaks sensitive information to the untrusted
> host.
> I am currently investigating passing iova/phys/size
> to force_dma_unencrypted() and then we can share pages inplace only
> if possible without leaking extra information.
> I am trying to get some performance results first. But the tricky part
> is to get the semantics right, I believe in that case those devices
> shouldn=E2=80=99t use restricted-dma-pools as those should always force
> bouncing. Instead bouncing happens through the default SWIOTLB pool,
> if not possible to decrypt in place.
>

-aneesh
