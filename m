Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228F13D9DD8;
	Mon, 27 Jul 2026 19:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785182347; cv=none; b=CASgzWU4AWv1WgC1jo+R4HBSEL8KJZOnZp4H6XsStj2D9Mo0KLhpaBntWbOBt5DthL3byDyBnyBTKGZ7F35nXK1em81ww2cgpC7t1PotAEnZiA7WDnbFkjdVCiEsHwgJ4EfPO+3dItoBXzra8fdtvKt5quXh67hU9yzHhZ1Hwh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785182347; c=relaxed/simple;
	bh=HdYZgU3/wJGXAdm6SwzVsiOKmR+BO3F9LUl+cJguCRs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bIGou5fVwxHRXXkp0U6o63o+V50iylNngdXHkXr6W9+01Qh5ieD+XQOLiOWrrkmTCLFXJ6ovETUe69JF/k2CVA29eBIICtpwUJSUIMxraXEyyKhHqcEJZujnkeeUC66RvhxP157vjMjVQrqs2xwi4gcu7dgTf6DeM+Bajk6EbHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWPZm4VM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWPZm4VM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B93DD1F000E9;
	Mon, 27 Jul 2026 19:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785182342;
	bh=e06+tz6yo/BzAsJgB8j3LnZXe51j3gB0IA4gbcsFLSI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hWPZm4VM7+nhKPKiMPYvCaNuJ/uEQnQJRIwvBE68w4k8mV+ab+v5bRXrxjp1xO1ZW
	 3KaS+ke/51qrM0ssHnMhRM4nRzdFu5s4Wy1Y8YmuNkdn17kpClxQ3oOTgZ/vijB9dm
	 L7hsFw+vmfbPsyA5ivgJ8xS87sFkQREL3KaJH6FQZGXQvNbT7GYktJ2zYbOwqvxvI1
	 I7VNKOwyilxQe3dZ06yvL6uhA023X1Ber/bp7AlTLz3nB4a7rBvlaOVyvTzmdZrm5l
	 bBuDvCr3aZqx76/kmAJWEuqIUiqy3oM4iuP5iw7RNPo8qpVddmbhQ46hs3v6AfZZma
	 p75o0ouypiEnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 04/10] s390/vfio_ccw: ensure first IDAW remains
 constant
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260727192230.2715207-5-farman@linux.ibm.com>
References: <20260727192230.2715207-1-farman@linux.ibm.com>
 <20260727192230.2715207-5-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 19:59:01 +0000
Message-Id: <20260727195901.B93DD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `get_guest_idal()` calculates the length of the guest IDAL incorre=
ctly for 32-bit (Format-1) IDAWs, resulting in an out-of-bounds DMA read fr=
om guest memory that can cause valid channel programs to be rejected.
--

--- Patch [4]: [PATCH v7 04/10] s390/vfio_ccw: ensure first IDAW remains co=
nstant ---
commit aa8d48cf11f4cace4871ca597e3aa07dec1573e4
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: ensure first IDAW remains constant

This patch ensures the first IDAW in a list is unchanged between reads to
maintain a consistent set of IDAWs.

> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_c=
p.c
> index af632f9d54535..6275794751cb4 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -523,6 +523,7 @@ static dma64_t *get_guest_idal(struct ccw1 *ccw, stru=
ct channel_program *cp, int
>  		&container_of(cp, struct vfio_ccw_private, cp)->vdev;
>  	dma64_t *idaws;
>  	dma32_t *idaws_f1;
> +	u64 first_idaw;
>  	int idal_len =3D idaw_nr * sizeof(*idaws);

[Severity: High]
This is a pre-existing issue, but does this calculate the guest IDAL length
incorrectly for 32-bit (Format-1) IDAWs?

Since idaws is a dma64_t pointer, sizeof(*idaws) is 8 bytes. If the guest is
submitting a channel program with Format-1 32-bit IDAWs (cp->orb.cmd.c64 =
=3D=3D 0),
this calculates idal_len as idaw_nr * 8 instead of idaw_nr * 4.

When vfio_dma_rw() is later called with this inflated idal_len, could it
perform an out-of-bounds DMA read from guest memory? If the guest's 32-bit
IDAL ends at a memory boundary, the over-read could fail with -EFAULT or
-EINVAL, causing valid channel programs to be unnecessarily rejected.

>  	int idaw_size =3D idal_is_2k(cp) ? PAGE_SIZE / 2 : PAGE_SIZE;
>  	int idaw_mask =3D ~(idaw_size - 1);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727192230.2715=
207-1-farman@linux.ibm.com?part=3D4
