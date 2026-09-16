Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7BD496D5C
	for <linux-s390@vger.kernel.org>; Wed, 16 Sep 2026 12:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789560908; cv=none; b=JqU6iOZkVRTwCvoICt/Muhyt5cD2ty45785m9C4L/LTdoESZKoT2Gd+ZHHCwv9duSYdpI+/iLHpkrnKu8plxlhrB/irxjA9P3BYQNXEnA9vCF/UQQtUA+7HXOhnUXDtMENOet4l7uknWR4jc6VDbGm0dMF6DPzOGCj/2UUHxZxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789560908; c=relaxed/simple;
	bh=y5Dp8OaZdoie09nlXBpXcMz/+xQNMd2l3SOmxiL8xU8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qo1sByIbl41x7Nv7ri5WvKeP5B3ywMG+TD9ve0omTpoGSgIbujSQ8MlXiLgU8G2HMf7lwvY5ODD64gUB+egYV6vUHrs1AaC/5YwpHWQfxv8xMPQ4WwMbMjDFMzDI5pUCXvlYhUr7qLCoJZNY9et7wCvabVGhLFE5Jh2y6AnIHok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EF4hdlYZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EF4hdlYZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA6B1F000FF;
	Wed, 16 Sep 2026 12:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789560906;
	bh=qnSyCiX6VLe7YsabVpSw4lXpISxhdLLC54G02PXrLpw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EF4hdlYZ3C3ePW2tVG2sZKpLcAfaBRosKWfdsXkHLa2VVkern32JJGiBmGuhsCZ6i
	 KE7kpdeDNTknYvZzE+CZHLHiQzsN86IwdPE416CDGAw7GFJqCOkmtcGVfT/xjGsVn2
	 e3E/WL346rSHpxpgIX6HoHPHhtU1dMtUym0Ud8dN3+zr++swR8aD591CphgBSCnkLd
	 ptkl8ED8TjxpY5Vwcp4IHlidObf2PdODov3PQVeaERTghH6+knvCyGpj6ctSPT3ndb
	 PrqoTqtiQtw9B7rsvyqxadl5HIA4+L+6e3aI3DyllVl549sin0xRrky3SthJ0A5ePc
	 7AysM/0C0emXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/13] s390/chsc: Use kzalloc() for CUBs
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260916-s390-cio-ready-v3-1-39e4894637d6@kernel.org>
References: <20260916-s390-cio-ready-v3-0-39e4894637d6@kernel.org>
 <20260916-s390-cio-ready-v3-1-39e4894637d6@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 12:15:05 +0000
Message-Id: <20260916121506.2BA6B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] s390/cio: kzalloc() breaks strict 4K page-alignment for CUB/ECUB D=
MA
--

commit 6b733741b98fcfa57ed4ac8655c793a212c8f4aa
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>
s390/chsc: Use kzalloc() for CUBs

This commit replaces the use of get_zeroed_page() with kzalloc() and
free_page() with kfree() for allocating and freeing channel measurement unit
blocks (CUBs) and extended CUBs.

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
Is it safe to use kzalloc() here when the s390 hardware strictly expects
4K-aligned page addresses for Channel Measurement Blocks?

When SLUB debugging or KASAN is enabled, kzalloc() can return a pointer that
is shifted away from the 4K page boundary due to padding and redzones. Since
__chsc_do_secm() passes these pointers to hardware which truncates the lower
12 bits:

drivers/s390/cio/chsc.c:__chsc_do_secm() {
    ...
    secm_area->cub[i] =3D (__force dma64_t)virt_to_dma32(css->cub[i]);
    ...
}

Would this cause the hardware to DMA write to the start of the slab page,
potentially overwriting SLUB metadata or adjacent objects when channel
measurement is enabled?

>  		if (!css->cub[i])
>  			return -ENOMEM;
>  	}
>  	for (i =3D 0; i < CSS_NUM_ECUB_PAGES; i++) {
> -		css->ecub[i] =3D (void *)get_zeroed_page(GFP_KERNEL);
> +		css->ecub[i] =3D kzalloc(PAGE_SIZE, GFP_KERNEL);

[Severity: High]
Does this allocation have the same 4K alignment requirement as CUB pages
above, and could it cause the same DMA memory corruption if the pointer is
not page-aligned?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-s390-cio-r=
eady-v3-0-39e4894637d6@kernel.org?part=3D1
