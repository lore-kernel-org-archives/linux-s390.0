Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28373F105C
	for <linux-s390@vger.kernel.org>; Mon,  7 Sep 2026 10:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788777395; cv=none; b=rM9CVv3PBQvmpq787A/ihPxJj6d2kGDwwWDlk4FnWwcfX34I7bNuvpreQe2jxv+uu3ghsNKwYl1WTyUjJIoOrWbMogqg0J84Jt/MLRVnllpGZ7gYr/s6f787quafbSlCX26DbRFgHlfcx34IK7nG5vw1P7LeReb+w2nn7ZXxsS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788777395; c=relaxed/simple;
	bh=W4bRPAunIa5IE8po8TdrY230SpRG3dUUnkdQEtwaqrU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AtYuXr+srhNNSWYMtgHc7sExfomQDdbZxxLu3t464/mK+bYPBEGXhFdfbxMb6dGX8G/R1wI0xKkmukpjIhrjoqe5V1gBC3NaGXCK++geT8UalYg6+VE/c+CFI1Y6gFktczcOPjbcIZ0g2ro7ovK0wI8qhBlTNnCWdkCwZ4VSrFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9oVlLRx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9oVlLRx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D561F00A3D;
	Mon,  7 Sep 2026 10:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788777393;
	bh=lXJU/BYTv4rMkIFP2NxP0En9DSJU02wc14o9CkO5fj8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e9oVlLRxro3ZoF3S5oKA1sXD+tQD1uglgNnXpa2iTTkkqrH2lx05h+wzf1tDOgqIC
	 cgb9FBZtZ+kgR2Cgbg8Rr96RQDWNQNU8quCBNHExsl0QxgdNof4gz59PcyM3Jm1IGx
	 dMNvyT2CJnbdCZ1xJ95ANg4ipeInLve1nmRZyjrjcghJsTfFiAidbtnCJvnYGFoKQy
	 Jl5Vyf7IaZVVpatSCrUndqJ3hU0qUHL+A+I0uQZoKCXW4rmfZIGpVmrDfL5fnif8UH
	 FdouhHPCFkW1LOE8xAO+yWQKj70yZn0qbCsDTEZOJTZsrWK4KDnM8zhBDipKZ1p/99
	 E7tIiOPpMxNFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/13] s390/qdio_setup: Use kzalloc() for QDIO buffers
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260907-s390-cio-ready-v1-10-ca7f39806234@kernel.org>
References: <20260907-s390-cio-ready-v1-0-ca7f39806234@kernel.org>
 <20260907-s390-cio-ready-v1-10-ca7f39806234@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 10:36:32 +0000
Message-Id: <20260907103633.39D561F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Replacing get_zeroed_page() with kzalloc() breaks the strict 256-b=
yte hardware alignment requirement for QDIO SBALs when memory debugging is =
enabled.
--

commit cef648048ee4dbd28b972a034767786968da0d5a
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>

s390/qdio_setup: Use kzalloc() for QDIO buffers

This commit replaces the use of get_zeroed_page() and free_page() with
kzalloc() and kfree() for allocating and freeing QDIO buffers.

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redh=
at.com

> diff --git a/drivers/s390/cio/qdio_setup.c b/drivers/s390/cio/qdio_setup.c
> --- a/drivers/s390/cio/qdio_setup.c
> +++ b/drivers/s390/cio/qdio_setup.c

[ ... ]

> @@ -49,7 +49,7 @@ int qdio_alloc_buffers(struct qdio_buffer **buf, unsign=
ed int count)
>  	int pos;
> =20
>  	for (pos =3D 0; pos < count; pos +=3D QBUFF_PER_PAGE) {
> -		buf[pos] =3D (void *) get_zeroed_page(GFP_KERNEL);
> +		buf[pos] =3D kzalloc(PAGE_SIZE, GFP_KERNEL);

[Severity: High]
Does this kzalloc() change break the 256-byte hardware alignment requirement
for QDIO SBALs?

The s390 QDIO hardware requires struct qdio_buffer to be strictly 256-byte
aligned.

While get_zeroed_page() guarantees page alignment, using kzalloc() with
PAGE_SIZE will fall into the kmalloc-4096 cache. If a memory debugging
feature like CONFIG_SLUB_DEBUG is enabled, the SLUB allocator adds a left
redzone before the object.

On s390, this redzone shifts the payload address by ARCH_KMALLOC_MINALIGN
(8 bytes). This shifts the address so the returned pointer is no longer
256-byte aligned, which can cause device probe failures or system crashes
when the misaligned address is rejected by the channel subsystem.

>  		if (!buf[pos]) {
>  			qdio_free_buffers(buf, count);
>  			return -ENOMEM;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907-s390-cio-r=
eady-v1-0-ca7f39806234@kernel.org?part=3D10
