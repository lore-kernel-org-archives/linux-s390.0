Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794215128;
	b=uC6Hy7eA2CeGGRYX2VTrpx/4ALl//7JinqSZPnkXolNhl5yvQhPt6yknNr45ZGzRpTSD
	 918Rq1uBqk5AqU1jAdfE1d5EgSLTRe6a+xgV82bYg/5SV4rydJYIoZ7446rfGIlTkg5+O
	 zHtl6UnqLpEvV26y6aLmidt6cidZC8bADUdJOn2kmHEhDffK9pXhaiTdk4g+Vn8D3N5Nj
	 SEbo/7VSTN7wn2iw2VPjia/PrMmXoejRdKchQQh35fdETu/CbGA52dPrVWSDKgoZRsbAq
	 9IW3epb+fxwgfKv8+gGoUGwGRgGH5/Qe0p+8GcEsX+XMGPezlcuWZU+CruG9senDr5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794215128;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=95kQOG7UF205HxNJnA0g7sSyyV4+ju9wI7uW7uP1Qa8=;
	b=rKHwlQdDkzEUZbTDu/XsXfEe/BIVlHHrczFHkwCQshbxCVcMLz6sPQxsY9D3r2clO6JN
	 nn/r8mVA0cr213RF/nlXLWxzm45NSwzmsoFhLqlaLzfVgmEDOuYwZyGHDa7WXRWRBuyFx
	 znKa7gsAUH0Ram7jQft4OzmaUhVRWUYvamo2WgHhKgyVpmlX6iX1ZM3sB2GZ0ttOX863o
	 M1Sk3BBS+gV3kUPQW+akNMtNbXr01Cnrgt8pRKXaL8WUJ9URc0deFyROVJFuao0UvppmF
	 TrAUcsm1ysRZg7ZPUByglamPYJv9ycb3X4Z2VASnGf5plmSfw6GrqASa685wbo0p1XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="T8xH28H/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B40606A322
	for <linux-s390@vger.kernel.org>; Mon,  9 Nov 2026 09:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T8xH28H/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B421F008A2;
	Mon,  9 Nov 2026 09:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794215127;
	bh=95kQOG7UF205HxNJnA0g7sSyyV4+ju9wI7uW7uP1Qa8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T8xH28H/MJNyxVLh1qLwDA0lf1q2ywUF0qPt6eRSKqjsQCYsFpUruD0npOTnpHS41
	 1/qod5xM0YGlgRwY+Ui8694O9d02GKMyGP63aksP4CU9io/EFLpqeelSoDjqbQ95cn
	 Z7oGqfuc0G9pldrPbeSBklycM3sVGURPYBIfbRMQmWR+5VA242yDdkLvGDjq1KT5NH
	 BzEV88y7fugXNDCG8iZbQfBMs0teBXRBodeIgodv04Rbqekv98Z1kpylx/k2IjhV3d
	 Mb9MhQzquORJ3dYFMeXlPKCrTVSSCcIYDJ4Nmb5tEetyQYoYpdczys6ld9XIQosGbR
	 eLalpmC3kfyaw==
Message-ID: <sashiko-outbox-204664@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/14] s390/sclp_ftp: Replace get_zeroed_page() with
 kzalloc()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "David Hildenbrand" <david@kernel.org>, "Sven
 Schnelle" <svens@linux.ibm.com>, "Vlastimil Babka" <vbabka@kernel.org>, linux-s390@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20261108-s390-sclp-ready-v1-12-3e7c90eb6676@kernel.org>
References: <20261108-s390-sclp-ready-v1-0-3e7c90eb6676@kernel.org>
 <20261108-s390-sclp-ready-v1-12-3e7c90eb6676@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 09:05:27 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] s390/sclp_ftp: unnecessary unsigned long casts in
  sclp_ftp_startup()
--

commit a25923b8503ee3e56046245296e0025552cfe251
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>

s390/sclp_ftp: Replace get_zeroed_page() with kzalloc()

This commit replaces get_zeroed_page() and free_page() with kzalloc() and
kfree() in sclp_ftp_et7() and sclp_ftp_startup().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redh=
at.com

> diff --git a/drivers/s390/char/sclp_ftp.c b/drivers/s390/char/sclp_ftp.c
> index 853492d53953c..c46fd056e9daf 100644
> --- a/drivers/s390/char/sclp_ftp.c
> +++ b/drivers/s390/char/sclp_ftp.c

[ ... ]

> @@ -250,7 +250,7 @@ int sclp_ftp_startup(void)
>  		return rc;
> =20
>  #ifdef DEBUG
> -	info =3D get_zeroed_page(GFP_KERNEL);
> +	info =3D (unsigned long)kzalloc(PAGE_SIZE, GFP_KERNEL);
> =20
>  	if (info !=3D 0) {
>  		struct sysinfo_2_2_2 *info222 =3D (struct sysinfo_2_2_2 *)info;
> @@ -262,7 +262,7 @@ int sclp_ftp_startup(void)
>  				 info222->lpar_number, info222->name);
>  		}
> =20
> -		free_page(info);
> +		kfree((void *)info);
>  	}
>  #endif	/* DEBUG */
>  	return 0;

[Severity: Low]
This isn't a bug, but since the commit message notes that kmalloc() avoids
ugly casts, could info be replaced directly with struct sysinfo_2_2_2
*info222 here?  info was only declared as unsigned long for
get_zeroed_page() and free_page(), and keeping it as unsigned long adds
two new casts in addition to the existing struct sysinfo_2_2_2 * cast.

Also, the commit message says sclp_ftp_startup() allocates an SCCB to read
SCLP info, whereas this buffer is a struct sysinfo_2_2_2 (SYSIB 2.2.2)
passed to stsi().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-s390-sclp-=
ready-v1-0-3e7c90eb6676@kernel.org?part=3D12
