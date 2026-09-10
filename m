Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EAA46EF9F
	for <linux-s390@vger.kernel.org>; Thu, 10 Sep 2026 11:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038876; cv=none; b=ENyjc12JC2nYCi50htqYj13PMU6Vt2oUokq1xP/Gss0+rx1m/mDg/Qn5ALeBDaCWsaFXRdXEvefiZbFOWn5J4AkrfBVQT3RTx/We9cl6igRu5nCtfbkTxTKLOgRSRBXkR+be47jqq6xMG/Ch2rrNVhn5HJR5eJCjFN1LF079Bo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038876; c=relaxed/simple;
	bh=LlZq+3iNsBtBolfghhSjC/oM1W620yjOVqaKU+/ObSA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pePnpROA/THZclubTOscfvVHc+ize0FAoTYkR0rkoG2U40aGlU8WQdIxRNe6biB0qpHCcdEjEf6GonHMCuvau7xQI5yBB+5Hn7IbKswtfow8t+RBOzCUQg+6kklrZSz1xtS8tVpE64rYpSIyhZWah3u1mpKJpYJGMx3a64UkKxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPgoUexY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPgoUexY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE0F1F000FF;
	Thu, 10 Sep 2026 11:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789038874;
	bh=7ZCukYOFARYjaWcFXeUR3uhmoYpspqzNPVZZ79tUVUI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jPgoUexY5/ciIgdY50Yx35iJQx98uZLzAzkS3JujZW6J/q6J7CHZ8jZl9qpCPuoXe
	 xM2ivFDnuxI4+a6ZafXaqrlt4Qqc8QXIThHqzsjy943g2EvydZ+ZelH3iU0stMdDo7
	 mVg4Og6RYol356RO1in5wd7yyO8WH+n3I5r2eDhDIV+ze2ZCOrQ4DGWDcJPjBjIDp9
	 sR9PmJUtIzEXTD1c2D8gAXwgmT1H8PTf6+NUU+1W0kapCS4HmWUpbMTAkqD6fzRKvm
	 RxRTcefu+XUcj6ToNoKUwipuCjeSpwBED/a+S6iKYHua2PZZrJBppilbRBxM9xiJWD
	 OJVjHuvqPrSow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/13] s390/idals: Use kmalloc() for IDAL data
 buffers
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-s390@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260910-s390-cio-ready-v2-7-e931086fdde1@kernel.org>
References: <20260910-s390-cio-ready-v2-0-e931086fdde1@kernel.org>
 <20260910-s390-cio-ready-v2-7-e931086fdde1@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 11:14:33 +0000
Message-Id: <20260910111433.DEE0F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Critical] Hardware Alignment Violation / I/O Error due to kmalloc

Pre-existing issues:
- [High] KASAN out-of-bounds read in idal_buffer_from_user() when count is 0
--

commit 009d471661da8ef804c875150de919b995098cb8
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>

s390/idals: Use kmalloc() for IDAL data buffers

idal_buffer_alloc() allocates the data chunks of an IDAL buffer that is
used for channel I/O. These buffers can be allocated with kmalloc() as
there's nothing special about them to go directly to the page allocator.
kmalloc() provides a better API that does not require ugly casts.

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redh=
at.com

> diff --git a/arch/s390/include/asm/idals.h b/arch/s390/include/asm/idals.h
> index 06e1ec2afd5af..213f430a8d33a 100644
> --- a/arch/s390/include/asm/idals.h
> +++ b/arch/s390/include/asm/idals.h

[ ... ]

> @@ -147,9 +148,11 @@ static inline struct idal_buffer *idal_buffer_alloc(=
size_t size, int page_order)
>  			ib->data[i] =3D dma64_add(ib->data[i - 1], IDA_BLOCK_SIZE);
>  			continue;
>  		}
> -		vaddr =3D (void *)__get_free_pages(GFP_KERNEL, page_order);
> +		vaddr =3D kmalloc(PAGE_SIZE << page_order, GFP_KERNEL);

[Severity: Critical]
Does replacing __get_free_pages() with kmalloc() break the page-alignment
guarantee required for IDAWs?

The s390 architecture mandates that while the first IDAW (Indirect Data
Address Word) can specify any byte offset, all subsequent IDAWs must be
strictly aligned to a 2K or 4K boundary. Furthermore, hardware transfers
data on the first IDAW only up to the next physical 2K/4K boundary.

When CONFIG_SLUB_DEBUG is enabled, kmalloc redzoning shifts the payload away
from a page boundary. This unaligned address is stored in ib->data[0], and
dma64_add() propagates it to subsequent IDAWs:

arch/s390/include/asm/idals.h:idal_buffer_alloc() {
    ...
		if (i & (nr_chunks - 1)) {
			ib->data[i] =3D dma64_add(ib->data[i - 1], IDA_BLOCK_SIZE);
			continue;
		}
    ...
}

Will this unaligned base violate the hardware alignment requirement and cau=
se
a channel-program check, as well as silently corrupt data since hardware
splits the transfer at the physical 4K boundary?

>  		if (!vaddr)
>  			goto error;
> +		/* Only DMA addresses are retained in ib->data. */
> +		kmemleak_ignore(vaddr);
>  		ib->data[i] =3D virt_to_dma64(vaddr);
>  	}
>  	return ib;

[Severity: High]
This isn't a bug introduced by this patch, but is it possible to trigger a
KASAN out-of-bounds read in idal_buffer_from_user() when count is 0?

In drivers/s390/char/fs3270.c, fs3270_write() takes a count parameter from
the user and passes it directly to the allocator without checking if it is =
0:

drivers/s390/char/fs3270.c:fs3270_write() {
    ...
	ib =3D idal_buffer_alloc(count, 0);
	if (IS_ERR(ib))
		return -ENOMEM;
    ...
		if (idal_buffer_from_user(ib, data, count) =3D=3D 0) {
    ...
}

If count is 0, idal_buffer_alloc() calculates nr_ptrs =3D 0 and allocates
exactly sizeof(struct idal_buffer) with 0 elements for the data flex-array.

Then idal_buffer_from_user() accesses the first element of this array
unconditionally:

arch/s390/include/asm/idals.h:idal_buffer_from_user() {
    ...
	for (i =3D 0; count > IDA_BLOCK_SIZE; i++) {
        ...
	}
	vaddr =3D dma64_to_virt(ib->data[i]);
	return copy_from_user(vaddr, from, count);
}

When count is 0, the loop is skipped and it evaluates ib->data[0]. Since the
array was allocated with 0 elements, does this read 8 bytes past the alloca=
ted
16-byte boundary of the struct?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910-s390-cio-r=
eady-v2-0-e931086fdde1@kernel.org?part=3D7
