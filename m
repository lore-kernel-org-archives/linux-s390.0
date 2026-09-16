Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618BB378D74
	for <linux-s390@vger.kernel.org>; Wed, 16 Sep 2026 12:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789561130; cv=none; b=Pi6C4wgRwuoqxHeCRaMKXOlkQGS9KA+aaWjGbGvrx5ZjIaKNb4wAdboRJTPONrJoySIEfaw0sR0EPwx7u9f0tOAHBsjwTJNtZeUQGrkc0n3KUJoskSED0Z6yk3NdYsqQnPjmaKENXavApZzhT2tdK2MqHKXC0PhKKd2crQbhlJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789561130; c=relaxed/simple;
	bh=fyDLzwrqNtSPazzninbMVzdBmGqrQ3996CQHQpQT8AU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XrcOsfQC0/cva8Lzmf2pqIoLVdP97yXW3xtdBXKpOeP3alnobkDXhPAgeVonaLyDEIrL0TO+csxEK7VlchEH5JDQIkaO3zKbYssNMWwHb57md0oKxFLeX16gfbEYerRaZbplVSuZm+s3DNat43Awxi+4tKxQJyUH3v2b/2xJKA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bew1PIz1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bew1PIz1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B611F000FF;
	Wed, 16 Sep 2026 12:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789561129;
	bh=K22UipEt/bGexFucLtse2iwQADpXxlrb8UFSG5qrMZY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bew1PIz1okvna3/sDWYTEm3IPhwHDIoEWn0bQ32YzGaQ7Lcmv28TMzF+Fp7X/cD6G
	 AGWBSjuc6EG19SjJrolhW5ASBeBKt2vBC3XpypNyaiasCD97PBsJpntk3A0kkbBswl
	 mCF5p78Sj44AFy05NWjAGaU2a8UDAD2RrW6OvsF+iQR7wh2JIdJ4C6h/3U7aDZQp9L
	 s4CVwO1U2eyyAgsPMKWg6pr57J1h9gfFNGm0Jjm1PYFdxY3QegooBOuEmJ40CFJtwB
	 8bJ0x9v5LoTeappcBnIO+ZqoaYFkBneBxRpBxKejEP2l4LgOsX5hMs+/WF6CeBuAjw
	 ZJk4gbyp1Owbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/13] s390/cmf: Use kmalloc() for the CMB area
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260916-s390-cio-ready-v3-6-39e4894637d6@kernel.org>
References: <20260916-s390-cio-ready-v3-0-39e4894637d6@kernel.org>
 <20260916-s390-cio-ready-v3-6-39e4894637d6@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 12:18:47 +0000
Message-Id: <20260916121848.E3B611F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] s390/cio: hardware alignment violation in alloc_cmb() due to kmall=
oc()
--

commit 8f39fa3622bcd7032d06a1645dbaec85cdb07a1f
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>

s390/cmf: Use kmalloc() for the CMB area

alloc_cmb() allocates the channel measurement block area shared by
devices using the basic channel measurement format. This commit replaces
__get_free_pages() with kmalloc() and free_pages() with kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redh=
at.com

> diff --git a/drivers/s390/cio/cmf.c b/drivers/s390/cio/cmf.c
> index 92ab3d546fe47..8fd41a7dfc20b 100644
> --- a/drivers/s390/cio/cmf.c
> +++ b/drivers/s390/cio/cmf.c
[ ... ]
> @@ -501,12 +504,12 @@ static int alloc_cmb(struct ccw_device *cdev)
>  		WARN_ON(!list_empty(&cmb_area.list));
> =20
>  		spin_unlock(&cmb_area.lock);
> -		mem =3D (void *)__get_free_pages(GFP_KERNEL, get_order(size));
> +		mem =3D kmalloc(size, GFP_KERNEL);

[Severity: High]
Does this allocation still guarantee the 32-byte alignment required by the
hardware for the measurement block origin (MBO)?

While kmalloc() naturally aligns power-of-two multiples in default
configurations, if memory debugging options like CONFIG_SLUB_DEBUG
(redzoning) or CONFIG_KASAN are enabled, SLUB can insert metadata padding
before the object payload.

This padding shifts the returned physical address so it is only guaranteed
to be aligned to ARCH_KMALLOC_MINALIGN (8 bytes on s390), potentially
breaking the 32-byte alignment requirement.

If the unaligned address is then used in cmf_activate():

drivers/s390/cio/cmf.c:cmf_activate() {
    ...
	asm volatile(
		"	lgr	1,%[r1]\n"
		"	lgr	2,%[mbo]\n"
		"	schm"
		:
		: [r1] "d" ((unsigned long)onoff),
		  [mbo] "d" (virt_to_phys(area))
		: "1", "2");
    ...
}

could this trigger a specification exception and crash the kernel when the
schm instruction executes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-s390-cio-r=
eady-v3-0-39e4894637d6@kernel.org?part=3D6
