Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B9F4964F
	for <linux-s390@vger.kernel.org>; Mon,  7 Sep 2026 10:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788777524; cv=none; b=a5JNBIlt4uqMx+jFsQ5JLYQAb8jP5XoAVJiLwQeMqSr1Gl/2ql8oHzScnQlQXbOWYtez8f6ZifoyKDHSLD6Vg7QiMyRi9B7XahIyUtIzvMpUcUAkO5rhtO5Z83EXo2pFYsw+YSeScNNANOk1uEVFqw0fvI4425p9RRvMhnWSzqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788777524; c=relaxed/simple;
	bh=33zfWCu3JJLioML3uD8Hs2PymB2vTcexp5imiSV6/mI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=az2lXveANzPf/oqLM//VIG6RNa6wr94qIlyhFAQBFMKJGnp1/5meC95UkVu1NkvIopZ1osDK0XIbxJ0j9cg9CvwZiUUi2cKFVljvgtUXstUsO+jSLrH4ctYg5ybkJLX8v/bW1O4GqyjaR4VGap2ArWB2py78RIELoSV8EdmMfZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxVcd84p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxVcd84p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27ADA1F00A3A;
	Mon,  7 Sep 2026 10:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788777522;
	bh=pZcVscYUyGYw+xfUpZ4brUSHIaP9nASjxEpAQU9welo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YxVcd84pWjcNjQqtyXBJnhZD9HDZwpcu7Wv+vqNZH7MOqb1tWWJX+Q82LcnyrET+i
	 d8Fy+lWiAloFUqJENHh1rZRAMhIDzpldtroxSuUVmlG+uib3PfvNDt8pXDuvHsIOaE
	 2OEOkRPIB8ft673rCSewijPPIjnBIlz1o/t2xnqMu/KzusF67SmMXj2J7OP2QLr4ZQ
	 hJEovRjZpF0zUP4Q30ZeIRQZTiULnVB7ZAuf/NkYOE7OIxDiMtzvY9Ht8pVsv3gN5z
	 2o6M8kzVGJLy/E+26qkQmaQn9+ZMl5C6s2wjAYLRfWd/klL1Zwap6s5Hf8or44mVpW
	 Ztz2W7q+gbaXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/13] s390/idals: Use kmalloc() for IDAL data buffers
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260907-s390-cio-ready-v1-7-ca7f39806234@kernel.org>
References: <20260907-s390-cio-ready-v1-0-ca7f39806234@kernel.org>
 <20260907-s390-cio-ready-v1-7-ca7f39806234@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 10:38:41 +0000
Message-Id: <20260907103842.27ADA1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Replacing __get_free_pages() with kmalloc() violates the strict 4K=
 page-alignment requirement for s390 Indirect Data Address Words (IDAWs), l=
eading to hardware I/O rejection and out-of-bounds memory access.
- [Medium] Kmemleak will falsely report IDAL data chunks as memory leaks be=
cause only their physical addresses are stored.

Pre-existing issues:
- [High] Unprotected concurrent modification of device->char_data.ibs in ta=
pe_check_idalbuffer() leading to a Use-After-Free.
--

commit ee00e66345d4d1d6997d0f2f7bda11ae7ad10516
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>

s390/idals: Use kmalloc() for IDAL data buffers

idal_buffer_alloc() allocates the data chunks of an IDAL buffer that is
used for channel I/O.
These buffers can be allocated with kmalloc() as there's nothing special
about them to go directly to the page allocator.

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redh=
at.com

> diff --git a/arch/s390/include/asm/idals.h b/arch/s390/include/asm/idals.h
> index 06e1ec2afd5af..248829d461bce 100644
> --- a/arch/s390/include/asm/idals.h
> +++ b/arch/s390/include/asm/idals.h
> @@ -147,7 +147,7 @@ static inline struct idal_buffer *idal_buffer_alloc(s=
ize_t size, int page_order)
>  			ib->data[i] =3D dma64_add(ib->data[i - 1], IDA_BLOCK_SIZE);
>  			continue;
>  		}
> -		vaddr =3D (void *)__get_free_pages(GFP_KERNEL, page_order);
> +		vaddr =3D kmalloc(PAGE_SIZE << page_order, GFP_KERNEL);

[Severity: High]
Does replacing __get_free_pages() with kmalloc() violate the strict 4K
page-alignment requirement for s390 Indirect Data Address Words (IDAWs)?

kmalloc() with memory debugging enabled (like SLUB redzoning) can return
unaligned addresses for PAGE_SIZE allocations. Since the s390 Channel
Subsystem mandates that second and subsequent IDAWs must be aligned to a
4K boundary, could this unaligned address cause hardware I/O rejection?

Additionally, if the base address is unaligned, does adding 4K via
dma64_add() result in out-of-bounds array access, since the nr_ptrs
calculation mathematically assumes a 4K-aligned start address?

>  		if (!vaddr)
>  			goto error;
>  		ib->data[i] =3D virt_to_dma64(vaddr);

[Severity: Medium]
Will kmemleak falsely report these IDAL data chunks as memory leaks?

Since virt_to_dma64() stores the physical address, the kmemleak scanner
won't find the exact virtual address bit pattern returned by kmalloc()
during its garbage collection scan.

[ ... ]

This is a pre-existing issue, but I noticed a potential race condition in
the tape driver when checking IDAL buffers.

In drivers/s390/char/tape_char.c:tapechar_read():

    rc =3D tape_check_idalbuffer(device, block_size);

And in drivers/s390/char/tape_core.c:tape_check_idalbuffer():

    idal_buffer_array_free(&device->char_data.ibs);
    device->char_data.ibs =3D new;

[Severity: High]
If two threads call read() or write() concurrently without device->mutex
being held, could one thread free device->char_data.ibs while the other
is executing tape_do_io() or iterating over the old ibs array? Can this
lead to a use-after-free or data corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907-s390-cio-r=
eady-v1-0-ca7f39806234@kernel.org?part=3D7
