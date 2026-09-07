Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E261945041C
	for <linux-s390@vger.kernel.org>; Mon,  7 Sep 2026 10:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788777441; cv=none; b=ltjxfhF9PmwZ0H3Hjl6gmxtuNCEPs2H9xTlYbA7icRURNRKoevSH6xPsFAzjFvQXfOUnZArFR4X8pGGzhHsl2GOvWxfxRJu42hy/nLdvrfkxmf+Z5+ZpewvVE8ZDOLrWjcatOI6X3u1Y7bzaXDDdIdfZhMTp+rqSyL6ZKdPo9k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788777441; c=relaxed/simple;
	bh=T1pd43diN57dUvTcrvCguDzCSmtB8qOoSc9liTKOjY0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OPffpXFy/tY3zgSvqnIqa77F11lwxS3iAWUjWW26gL7UumGyTCfllXzlQ+8udyEI4HsHnryi8SHbht9meHAcVHAGBZjJZyyvHYSOv6T68OdLMNXh4JvdIedkZymqGlSGIv2KA2RQUr3e61SrEC10s60c2AVQgtp3GFh/Eic0BXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=En+kIJ0N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="En+kIJ0N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D671F00A3A;
	Mon,  7 Sep 2026 10:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788777439;
	bh=AmUO8NHwIUg3MGY8VC1cBElLk3pH0T2Z8w2lS/oVmN4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=En+kIJ0Nc4R7NxBWGNgXvF1ycbwMwr3g57O41A80XCq1Jb14td6Tvckl9ZoBg3r+D
	 4+TvPvReWQ2iTkTC6qPVXtL0nVX3na99dnlZv8Qhdnk9BFMLmxrvHBX1TpttzMhNY4
	 u8pel03+umTPFxH8om4hGfgjXw0YBy2VuegJBZug9chJZaW4TcIj94yCWiOgtu8EEK
	 ulIFV3fEsokDsgO93KqqsXCDN09EoxNEsqKmtwJjURSiUFfl3mijiuI6rwJeygEbDa
	 ih5KbMpqpwbg7+K0r6ygAMHsMRp1t001/sPJej4gVmG6KbfMlM0o5fmWHk52FH/602
	 Jp6gHoIO3mO0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/13] s390/chsc: Use kzalloc() for CUBs
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260907-s390-cio-ready-v1-1-ca7f39806234@kernel.org>
References: <20260907-s390-cio-ready-v1-0-ca7f39806234@kernel.org>
 <20260907-s390-cio-ready-v1-1-ca7f39806234@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 10:37:18 +0000
Message-Id: <20260907103719.32D671F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Critical] Hardware Alignment Violation

Pre-existing issues:
- [High] DMA Use-After-Free
--

commit c0b30acb33e9033572c3388a78f4e8cd3bf3f838
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>

s390/chsc: Use kzalloc() for CUBs

cub_alloc() allocates the channel measurement unit blocks and their
extended counterparts.

This memory can be allocated with kmalloc() as there's nothing special
about it to go directly to the page allocator.

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

[Severity: Critical]
Does replacing get_zeroed_page() with kzalloc() break hardware alignment
requirements?

The original get_zeroed_page() allocated directly from the page allocator,
which strictly guarantees 4KB page alignment. kzalloc(PAGE_SIZE) allocates
from the generic slab allocator, which does not guarantee page alignment
when slab debugging (SLUB_DEBUG) or KASAN is enabled due to redzones and
padding.

When these pointers are passed to the hardware:

drivers/s390/cio/chsc.c:__chsc_do_secm() {
    ...
    for (i =3D 0; i < CSS_NUM_CUB_PAGES; i++)
        secm_area->cub[i] =3D (__force dma64_t)virt_to_dma32(css->cub[i]);
    ...
}

The s390 Store Extended Channel Measurement (SECM) hardware expects the
measurement unit blocks to be strictly aligned to a 4KB boundary. If the
pointer from kzalloc() is not aligned, the hardware will either reject the
instruction or mask off the lower 12 bits, writing DMA data to the start
of the slab page instead of the object offset. This can silently overwrite
redzones or preceding objects in the slab.

Can we continue to use a page-aligned allocator for these DMA blocks?

>  		if (!css->cub[i])
>  			return -ENOMEM;
>  	}
[ ... ]
> @@ -949,11 +949,11 @@ static void cub_free(struct channel_subsystem *css)
>  	int i;
> =20
>  	for (i =3D 0; i < CSS_NUM_CUB_PAGES; i++) {
> -		free_page((unsigned long)css->cub[i]);
> +		kfree(css->cub[i]);
>  		css->cub[i] =3D NULL;
>  	}
>  	for (i =3D 0; i < CSS_NUM_ECUB_PAGES; i++) {
> -		free_page((unsigned long)css->ecub[i]);
> +		kfree(css->ecub[i]);
>  		css->ecub[i] =3D NULL;
>  	}
>  }

[Severity: High]
This isn't a bug introduced by this patch, but can this error path lead to a
DMA use-after-free?

In the rollback path of chsc_secm() which eventually calls cub_free():

drivers/s390/cio/chsc.c:chsc_secm() {
    ...
    if (!ret) {
        css->cm_enabled =3D enable;
        if (css->cm_enabled) {
            ret =3D chsc_add_cmg_attr(css);
            if (ret) {
                __chsc_do_secm(css, 0);
                css->cm_enabled =3D 0;
            }
    ...
out:
    if (!css->cm_enabled)
        cub_free(css);

If __chsc_do_secm(css, 0) fails (for example, returning -EBUSY because the
channel subsystem is busy), the hardware ignores the stop command and
continues performing DMA writes to the allocated memory blocks.

However, the code ignores the return value, unconditionally clears
css->cm_enabled, and frees the DMA memory via cub_free(). The hardware will
then continue to update the measurement blocks in the freed memory.

Should this path handle the failure of __chsc_do_secm() before freeing the
memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907-s390-cio-r=
eady-v1-0-ca7f39806234@kernel.org?part=3D1
