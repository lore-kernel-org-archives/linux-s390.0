Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D48359A91
	for <linux-s390@vger.kernel.org>; Wed, 16 Sep 2026 12:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789561006; cv=none; b=SxBJUhXuFAaLlTouwc0v0W7YyWJctvykSqpk46Wx6gSlDqJSI3DaMxHV3m95WWDqmaJS0od0lrcFP0bGD8dpPeN6pWUwp1SGUCj/zrTHe6wLNXN1LJFVwKfiZ6KeJ4bYEIr9xZLkXY9WDptElEqMo5xtixHJkshQ57HoxSJ9cSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789561006; c=relaxed/simple;
	bh=x1JxknBBSv4IDJgN0H5n4yBSbJuK+IZH10rISPysft8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kYkw2RaULTD3I1soRMYxDT14DTP/X8BJAAkIEPuUai8o4AOM7bsC+6QpXRfV92RXFSWJy4odq5n/45i0Zqowatx9VDNQNlgsm5BcBeE2Juk7ZJWvl4TWovTfqXWGQo/8tyU6WdmPGdKqmRcmFYdukYhTtToQ3PIveVI9JQoFuwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Psg4UP7x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Psg4UP7x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FEF71F000FF;
	Wed, 16 Sep 2026 12:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789561004;
	bh=utPqcnSm48C9WyZIXmc+Vxuh9XQOdOhfNP6og/dmrsY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Psg4UP7xkCOLFITkEsaST2w2qLoRwooPCUkk7yIsNy1shGbBGsR7u3ppA5qul8SKQ
	 QoWLRkbiGGZRAp+jcRGoTP0wBQXXS+/eK/zhAfP/O+hA4EsgoxBpUFR/2ocljvDewx
	 8D39Eb4fRDxIQhKVJ4noWHfEaHiJUTNNTnBRLK42TfsNYLjy5fiXbeu39VY0QUuxG/
	 NeNRVgT0U4PFIsHzfuagfw79LWr7+QmWiB04wsdoDJpuDYoeDwNqDNw4E3cNLGk1GO
	 6Cz1zRmNx4mKC3RDoQGkK8iZ1sStbwioSSTOxzpeA3ms6b824/4XWcSwVwoXGHRA+Y
	 4BMuJlxg9p3ZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/13] s390/idals: Use kmalloc() for IDAL data
 buffers
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260916-s390-cio-ready-v3-7-39e4894637d6@kernel.org>
References: <20260916-s390-cio-ready-v3-0-39e4894637d6@kernel.org>
 <20260916-s390-cio-ready-v3-7-39e4894637d6@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 12:16:43 +0000
Message-Id: <20260916121644.6FEF71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] s390/idals: hardware alignment violation in IDAL buffers due t=
o kmalloc()
--

commit d18db8674582ba776adea76af1cc752b0a5fcd3a
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>

s390/idals: Use kmalloc() for IDAL data buffers

idal_buffer_alloc() allocates the data chunks of an IDAL buffer that is
used for channel I/O. Replace use of __get_free_pages() with kmalloc()
and free_pages() with kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redh=
at.com

> diff --git a/arch/s390/include/asm/idals.h b/arch/s390/include/asm/idals.h
> index 06e1ec2afd5af..213f430a8d33a 100644
> --- a/arch/s390/include/asm/idals.h
> +++ b/arch/s390/include/asm/idals.h

[ ... ]

> @@ -135,21 +136,23 @@ struct idal_buffer {
>   * Allocate an idal buffer
>   */
>  static inline struct idal_buffer *idal_buffer_alloc(size_t size, int pag=
e_order)
>  {
>  	int nr_chunks, nr_ptrs, i;
>  	struct idal_buffer *ib;
>  	void *vaddr;
> =20
>  	nr_ptrs =3D (size + IDA_BLOCK_SIZE - 1) >> IDA_SIZE_SHIFT;
>  	nr_chunks =3D (PAGE_SIZE << page_order) >> IDA_SIZE_SHIFT;
>  	ib =3D kmalloc_flex(*ib, data, nr_ptrs, GFP_DMA | GFP_KERNEL);
>  	if (!ib)
>  		return ERR_PTR(-ENOMEM);
>  	ib->size =3D size;
>  	ib->page_order =3D page_order;
>  	for (i =3D 0; i < nr_ptrs; i++) {
>  		if (i & (nr_chunks - 1)) {
>  			ib->data[i] =3D dma64_add(ib->data[i - 1], IDA_BLOCK_SIZE);
>  			continue;
>  		}
> -		vaddr =3D (void *)__get_free_pages(GFP_KERNEL, page_order);
> +		vaddr =3D kmalloc(PAGE_SIZE << page_order, GFP_KERNEL);

[Severity: Critical]
Does using kmalloc() here drop the hardware alignment guarantees required f=
or
IDAL data buffers?

The s390 Channel Subsystem strictly requires all Indirect Data Address Words
(IDAWs), except the first, to be aligned to absolute 2K or 4K boundaries.

kmalloc() does not guarantee page alignment, especially when debugging opti=
ons
like SLAB_RED_ZONE or KFENCE are enabled.

If an unaligned address is returned and passed to the channel subsystem, it
will generate a program check (I/O error).

Also, subsequent IDAW addresses are computed from the base pointer slightly
earlier in this loop:

	ib->data[i] =3D dma64_add(ib->data[i - 1], IDA_BLOCK_SIZE);

If the base pointer from kmalloc() is unaligned, does this corrupt all
subsequent IDAWs and violate the hardware alignment rules?

Furthermore, if the first IDAW is unaligned, the hardware transfers data on=
ly
up to the next 4K boundary (fewer than 4096 bytes).

The software size calculation earlier in idal_buffer_alloc() assumes exactly
4096 bytes are transferred per IDAW:

	nr_ptrs =3D (size + IDA_BLOCK_SIZE - 1) >> IDA_SIZE_SHIFT;

To satisfy the total transfer count, will the hardware attempt to fetch more
IDAWs than were allocated in the ib->data array?

This could lead to an out-of-bounds read where the hardware interprets rand=
om
data past the array bounds as a physical address, causing silent memory
corruption during DMA I/O.

>  		if (!vaddr)
>  			goto error;
> +		/* Only DMA addresses are retained in ib->data. */
> +		kmemleak_ignore(vaddr);
>  		ib->data[i] =3D virt_to_dma64(vaddr);
>  	}
>  	return ib;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-s390-cio-r=
eady-v3-0-39e4894637d6@kernel.org?part=3D7
