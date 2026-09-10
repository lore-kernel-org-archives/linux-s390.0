Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D338746EC90
	for <linux-s390@vger.kernel.org>; Thu, 10 Sep 2026 11:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038667; cv=none; b=FdXLkPmFPu/B/Zo/RNZpuPThhTNTonOQ44xWsJ8gXRoremUA+v2c5VmXRUXgHOqxTPXIQakSGUi6CuXN3O8OfbE/2prANpPaeJK+4cirgsVSEkA5A9gWYUNRqlg7DuT71w5W2tTvCJHw3fzjTUgvsdf+0VqBSVlVenh2817zzzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038667; c=relaxed/simple;
	bh=DGfzU3Bewm9237LTA0VlryRrpvenjlLSjPFIegxPhTI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nz4xlO4dEgi+eRt2w2TfZxA02a/w33NWcv9Uuw9cAQpPuuIHAMrF/4oyu7qJ2LSdWeObcrsspvynuCkHWgAhFOyfgMr4HW7U+ymHSLTrQjUCwhWK+rkoNL9+9bEtzhu6Kv2RVluPS23gqlVUuPQN57upW/JtLUP9tiu60MooXvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBxZh5PV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBxZh5PV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1551C1F000FF;
	Thu, 10 Sep 2026 11:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789038665;
	bh=yP2Y8h566+qJImv7OLhK1yXbw1g4NTdoVM1xehfZMk0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gBxZh5PVbyJb6V5VF+TX7X5kPDLenhixHXYJosP8hrf8Bt9Hs8JHRoYRBZFiMvnQc
	 I1lHi5sx4wI6DPW3M/bQXYX454Kht1KaZwe8TtKGCmB4B6ZF9vJRTg8l/OfTo3K5BP
	 gYFaV6fGEr1bva6Wr5D801u9H0AcPjsZMs03AgrPgOD467yVHanZKoCGk9sidb4x79
	 w2SwzbGz+mFOSjW9iP4fyR/uuXjzSwDFyq2g1793O+rWFOtGcbP9vK5GTNs+v++bK4
	 8qUFDNZfVK2sXi+eiMZlOMaFAhPb+cBqAQCtmwajKwpRnuEp0BhECzgUy1emKk8VBg
	 5jzQFFYqzdTpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/13] s390/chsc: Use kzalloc() for CUBs
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260910-s390-cio-ready-v2-1-e931086fdde1@kernel.org>
References: <20260910-s390-cio-ready-v2-0-e931086fdde1@kernel.org>
 <20260910-s390-cio-ready-v2-1-e931086fdde1@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 11:11:04 +0000
Message-Id: <20260910111105.1551C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Replacing get_zeroed_page() with kzalloc() for channel measurement=
 unit blocks (CUB/ECUB) removes the strict 4K page-alignment guarantee requ=
ired by the s390 hardware.

Pre-existing issues:
- [High] Hardware DMA Use-After-Free during error rollback if the SECM disa=
ble command fails.
--

commit a4009c99c45aacf3c6ede46b7f75f80186fc50f9
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>

s390/chsc: Use kzalloc() for CUBs

This commit replaces the use of get_zeroed_page() and free_page() with
kzalloc() and kfree() for allocating channel measurement unit blocks (CUBs
and ECUBs). The author notes that kmalloc() provides a better API without
requiring casts and that performance differences are negligible for these
allocations.

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redh=
at.com

> diff --git a/drivers/s390/cio/chsc.c b/drivers/s390/cio/chsc.c
> index 9689f722c863c..60a4a7e6086ce 100644
> --- a/drivers/s390/cio/chsc.c
> +++ b/drivers/s390/cio/chsc.c
> @@ -931,12 +931,12 @@ static int cub_alloc(struct channel_subsystem *css)
>  	int i;
> =20
>  	for (i =3D 0; i < CSS_NUM_CUB_PAGES; i++) {
> -		css->cub[i] =3D (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
> +		css->cub[i] =3D kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);

[Severity: High]
Does replacing get_zeroed_page() with kzalloc() break the strict 4K
page-alignment required for the CUB blocks?

The s390 hardware SECM command expects the physical addresses of the CUB
measurement blocks to be strictly 4KB page-aligned. When KASAN or SLUB
debugging is enabled, kzalloc(PAGE_SIZE) offsets the returned pointer with
redzones, which destroys page alignment.

When this unaligned virtual address is passed to virt_to_dma32() in
__chsc_do_secm(), it yields an unaligned physical address. Could this cause
the hardware to reject the command or write 4KB of measurement data to the
unaligned boundary, potentially corrupting SLUB metadata or adjacent object=
s?

>  		if (!css->cub[i])
>  			return -ENOMEM;
>  	}
>  	for (i =3D 0; i < CSS_NUM_ECUB_PAGES; i++) {
> -		css->ecub[i] =3D (void *)get_zeroed_page(GFP_KERNEL);
> +		css->ecub[i] =3D kzalloc(PAGE_SIZE, GFP_KERNEL);

[Severity: High]
Similarly, does kzalloc() remove the strict page alignment guarantee for the
ECUB blocks?

Like the CUB blocks, if SLUB debugging offsets the pointer, the physical
address sent to the hardware will be unaligned.

>  		if (!css->ecub[i])
>  			return -ENOMEM;
>  	}
> @@ -949,11 +949,11 @@ static void cub_free(struct channel_subsystem *css)
>  	int i;
> =20
>  	for (i =3D 0; i < CSS_NUM_CUB_PAGES; i++) {
> -		free_page((unsigned long)css->cub[i]);
> +		kfree(css->cub[i]);

[Severity: High]
This isn't a bug introduced by this patch, but can this lead to a DMA
use-after-free if the SECM disable command fails?

Looking at the error rollback path in chsc_secm(), if enabling SECM succeeds
but chsc_add_cmg_attr() fails, it attempts to rollback with
__chsc_do_secm(css, 0):

drivers/s390/cio/chsc.c:chsc_secm() {
    ...
		if (css->cm_enabled) {
			ret =3D chsc_add_cmg_attr(css);
			if (ret) {
				__chsc_do_secm(css, 0);
				css->cm_enabled =3D 0;
			}
		}
    ...
out:
	if (!css->cm_enabled)
		cub_free(css);
    ...
}

The return value of __chsc_do_secm(css, 0) is ignored. If the hardware disa=
ble
command fails (e.g., due to a timeout or busy state), the hardware remains
active and will continue writing measurement data to these DMA buffers.=20

However, the code unconditionally sets css->cm_enabled =3D 0, which causes =
the
out label to call cub_free(css). Could this free actively-used DMA buffers
back to the allocator and cause silent memory corruption for any subsequent
user of this memory?

>  		css->cub[i] =3D NULL;
>  	}
>  	for (i =3D 0; i < CSS_NUM_ECUB_PAGES; i++) {
> -		free_page((unsigned long)css->ecub[i]);
> +		kfree(css->ecub[i]);
>  		css->ecub[i] =3D NULL;
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910-s390-cio-r=
eady-v2-0-e931086fdde1@kernel.org?part=3D1
