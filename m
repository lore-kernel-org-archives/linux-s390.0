Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF43E4028FF;
	Tue, 19 May 2026 14:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779200279; cv=none; b=fbCcUicB5s8o0H4v6o1Qfh8G8cCtW3W9dWJKUHuXe2OX5C/iWMuQaHwIm7+3NlOETovE0pxsaLHq9mDJVVzQhV8a/RUR1s2U6D+QedRaORM5p3IPVo01gGQlUdgBlqKcvMVKiWCujSrYa8Ec9/GtgPGRvgXJ7Xi72BrYiTz0QlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779200279; c=relaxed/simple;
	bh=omX4jWGqSc4euJhfKZDzYDEyAA00xkxKBKP+MlYpCw8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AaGyJXfBRm4hUwuH+v5wIDSU9CP2AkkNsW3/4YaJw6boGG3zxiSX6PD8+ltXenhvhmU8CLcagePZ3wK2XzJnjNW9loGVV95RAI4tSHMgcjAU7DVvnDW1ZGbDYvLTqY7opEbsygca6Sg6Ex8YEs2cEYdKPoMhnQe/93/olNhW028=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTYt6sua; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTYt6sua"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3CDC2BCB3;
	Tue, 19 May 2026 14:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779200279;
	bh=omX4jWGqSc4euJhfKZDzYDEyAA00xkxKBKP+MlYpCw8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=lTYt6sua65tkoXlE6Q2BlS8sWIBZa2T8L6x1+ychuvbjhIgKDes/YlNtctIs5MurS
	 wD2Sl12rive3qkbqzpkk+tCLwkjQs/DxCrfGdUoXLC02uYIc1JCFEdy86S52d2uc9y
	 g9FC2LhMSJtxI6g9uj7rH6gjLQpb0NEpM4k1SN6H2g7ngPyox//4uss4/gZtV+Ifkr
	 HJA7XMc52oT9bXh/mEx/JXlwnYV1qcuMWkMR9VA/wBbF3wBtAG826RnNSvIIDkS5uY
	 AZew3Mf53E71+ceTl7ybvn6GgsZDq0hT4sHTpN4L72FhePHSUiBlWNlbwgUDVM05nW
	 MgRHtOceOiSng==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
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
In-Reply-To: <agxt7SFGT7OLMIah@google.com>
References: <agSKQrSIhizCXKwx@google.com> <yq5ah5oaa63h.fsf@kernel.org>
 <agW5rhE9n2gDQ0w5@google.com> <yq5apl2y5f96.fsf@kernel.org>
 <agXaby-7L7yS3Vva@google.com> <yq5ah5oa59wy.fsf@kernel.org>
 <agxDxdxynp4KEovA@google.com> <20260519132911.GA7702@ziepe.ca>
 <agxolksC_1nfO34X@google.com> <yq5ah5o3sdn3.fsf@kernel.org>
 <agxt7SFGT7OLMIah@google.com>
Date: Tue, 19 May 2026 19:47:48 +0530
Message-ID: <yq5aecj7sctv.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mostafa Saleh <smostafa@google.com> writes:

> On Tue, May 19, 2026 at 07:30:16PM +0530, Aneesh Kumar K.V wrote:
>> Mostafa Saleh <smostafa@google.com> writes:
>>=20
>> >> >=20
>> >> > I am still running more tests, but looking more into it. Setting
>> >> > force_dma_unencrypted() to true for pKVM guests is wrong, as the
>> >> > guest shouldn=E2=80=99t try to decrypt arbitrary memory as it can i=
nclude
>> >> > sensitive information (for example in case of virtio sub-page
>> >> > allocation) and should strictly rely on the restricted-dma-pool
>> >> > for that.
>> >>=20
>> >> ??
>> >>=20
>> >> Where does force_dma_unencrypted() cause arbitary memory passed into
>> >> the DMA API to be decrypted? That should never happen???
>> >
>> > Sorry, maybe arbitrary is not the right expression again :)
>> > I mean that, with emulated devices that use the DMA-API under pKVM,
>> > they will map memory coming from other layers (VFS, net) through
>> > vitrio-block, virtio-net... These can be smaller than a page, and
>> >
>>=20
>> Don't we PAGE_ALIGN these requests?
>>=20
>> dma_direct_alloc
>> 	size =3D PAGE_ALIGN(size);
>>=20
>> iommu_dma_alloc_pages
>> 	size_t alloc_size =3D PAGE_ALIGN(size);
>>=20
>>=20
>
> For allocation, yes, and that's fine because we bring memory from
> the pool.
> But not for mapping, as dma_direct_map_phys(), where the memory is
> allocated from the driver or other parts in the kernel and the page
> may be shared with other kernel components.
>

But if we are using restricted-dma-pool, we also have:

mem->force_bounce =3D true;
mem->for_alloc =3D true;

So, will we use the swiotlb buffers for mapping and copy only the shared
content into those swiotlb buffers?

-aneesh
