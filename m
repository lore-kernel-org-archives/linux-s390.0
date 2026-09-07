Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D94345CBE
	for <linux-s390@vger.kernel.org>; Mon,  7 Sep 2026 10:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788777880; cv=none; b=r4InJnHf+CF3umwwFDFeO5SR3ps3t/bH4asO+D9+TSn/0SM1nxyMhBRCFNIsHeAh/anPrpcp+UBT2Y4lCWrtRTWtBANuiT1zXvBrrSnNmN/1eR3SAh5g3yU5uqepybC6d/8HNYsERHacmNx744wnYtGkVz0I8VhmTDrHoDjm1Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788777880; c=relaxed/simple;
	bh=HIb8qY6X+FtqVNEZluBBJrqiB8ValpWhQUdykZwdPAI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JhulJW07nMdncu0ruf7FDrKug1QzsZ2+lySFaWcguIyTPxflqZeQ9xIuBpQPiufkUtPCXzaXbsUJqeRYHxVg8xn8cdTQSFqvVSGDIfPGOYbrDy6acxG1bmh9b0AFiUDx8/Fv34W6ZATYsYLtwFhA26h3bGEFq/Zo9O9+TLlBOD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JzykLFuW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JzykLFuW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 163361F00A3A;
	Mon,  7 Sep 2026 10:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788777879;
	bh=DA3HcUc22DeF7UzGMXVITEnvxwSeie5oYXsqUdeO5yo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JzykLFuWQna0a9ywnnYfo3VT/zXtbIcUmD/feU7+F4cugLKCbOqo1RampANFLq1s/
	 lue226H3oGuEe0GimqQS35e6fcuiysMz2tFmdm6JjJGruQmmikJV0r3KYW4E2+WYVj
	 sc8oIGZAiNpAgGf07HoroBIGqKDKST0U3kd0iyHlv+gSqU3zUCUA5c5POrGsQlbctl
	 bQLgaW3/boYwjx/yZYqwBwLdR/wHPIBy1O2zc4IgqbDiGkYwZFOlcyaBohodSfTrKc
	 HCioeIG0pL76N8EvoCjRBA4jbFv8cvpVwiNd16GI7Z8r9FC9h3XAKjbw9NHVYACwv4
	 UDoaqpII4IGLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/13] s390/scm: Use kmalloc() for SCM information
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260907-s390-cio-ready-v1-13-ca7f39806234@kernel.org>
References: <20260907-s390-cio-ready-v1-0-ca7f39806234@kernel.org>
 <20260907-s390-cio-ready-v1-13-ca7f39806234@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 10:44:37 +0000
Message-Id: <20260907104439.163361F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Replacing `__get_free_page()` with `kmalloc(PAGE_SIZE)` breaks the=
 strict 4K page-alignment requirement of the CHSC instruction when SLUB deb=
ugging is enabled.
--

commit ad79881d62e47e7d8ac373d9ac1ace6a762ae9a4
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>

s390/scm: Use kmalloc() for SCM information

This commit replaces the allocation of the CHSC Store SCM Information comma=
nd
response buffer from __get_free_page() to kmalloc(). It also updates the
local response buffer to use the __free(kfree) scope-based cleanup helper.

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redh=
at.com

> diff --git a/drivers/s390/cio/scm.c b/drivers/s390/cio/scm.c
> index 171212a6d2d9c..b79fe023ab8d1 100644
> --- a/drivers/s390/cio/scm.c
> +++ b/drivers/s390/cio/scm.c
[ ... ]
> @@ -224,12 +225,12 @@ static int scm_add(struct chsc_scm_info *scm_info, =
size_t num)
> =20
>  int scm_update_information(void)
>  {
> -	struct chsc_scm_info *scm_info;
> +	struct chsc_scm_info *scm_info __free(kfree) =3D NULL;
>  	u64 token =3D 0;
>  	size_t num;
>  	int ret;
> =20
> -	scm_info =3D (void *)__get_free_page(GFP_KERNEL | GFP_DMA);
> +	scm_info =3D kmalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);

[Severity: High]
Does this change break the 4K page-alignment requirement for the CHSC
instruction?

In drivers/s390/cio/scm.c:scm_update_information(), replacing the natively
page-aligned __get_free_page() with kmalloc(PAGE_SIZE) means the returned
pointer can be unaligned when SLUB debugging or KASAN is enabled, due to
padding added before the object.

This scm_info pointer is passed down and ultimately used by the CHSC
instruction in drivers/s390/cio/ioasm.c:chsc(). The s390 architecture
strictly mandates that CHSC command blocks be placed on a 4K-byte boundary.

Executing the instruction with an unaligned address triggers a hardware
Specification Exception kernel crash.

>  	if (!scm_info)
>  		return -ENOMEM;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907-s390-cio-r=
eady-v1-0-ca7f39806234@kernel.org?part=3D13
