Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794924780;
	b=porbRNkK4rpQfEe6Vcl5qPPQhK6QCpOv9gspT7QEs+48yydd88CtRExNZR+J08RmLXU7
	 P0f99JcIZjHSSFyA5puR3wNUdzSu7HZf4Dpf0ZV5PcH/lHV+S55DaB5poMakhCdE6GhVO
	 /pHkq4fskbDimeEuvjUojLZhJlfFliuQttFuklKmbz2lii3gIK40RHP+b1lSt+t4WQmN0
	 ROpnjCt6DSAKQMsb0eaKiN5Wei2y8+HH/EbK5jBjXL+nsbBXcQ6fzuBgSgcFcEZoNwyTK
	 bcCwQrvp27Pd5gLF8tHDZjzG462JH5BEKIuVEVeJNNJEODnbb293mTa+NfDTRZJxToA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924780;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CIChDSih5qZYwkMyz5MYKYQUKe+7NlPRC6Nqa2dYP7Y=;
	b=CrrQ8FFSLOdQoLY3K6yppwjskE4t4WQZlh3YlN/JBc/Ua1hnQpYYbOJFRgtJXLbQusB5
	 qnBAKnsId87OygSp3i03oVSEWKwh/ZiIluw0o7zcg58htMSFlrGUO6e3p/UMVIqFb7KVd
	 RoQ1FeBOO3sy44OrmEOVz3Ndef9K05sPjD/gYU6aUbUCsig05VXCuz3IC1zcgxCua5K9r
	 LS8IXPs6x/mGPI5tHfFPtkFlJiCtuZ+eBYy0tD0XcnLkXoGSfQaVcu+mcHDNy/Ly/0+uL
	 mRMpC5B24afszeQzTZJT+t+j701jh1d4tdgbyLfjP2WRCQJuqF2WHRevkHHJwrRDR6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ERfZnwtR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD286606B088
	for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2026 14:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ERfZnwtR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E7371F000C5;
	Tue, 17 Nov 2026 14:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794924780;
	bh=CIChDSih5qZYwkMyz5MYKYQUKe+7NlPRC6Nqa2dYP7Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ERfZnwtR6PlDBHeOwjhPInl3WJ0Nx3V3fbHx0l4zeVo2LBXgR+ZX4cJEXSRDhKPX0
	 +cZuPUAEu+HEAafYM5sfgnEWaIkLgMviairjsTE+5kWonDikrdM1DOi4iHt+Ja9DwM
	 eZSot9PCFxqgu0yf68f4Js1htnqY/B4VgZRWOgSejd4m5iwZbJO+aMCOHSUlQu3Xps
	 6J6PH6tqk0HI1vg0VjwazLfQ/h8F7DjYWkj5pFLa5jygHUwAZMVT00G5H+N9iOzEfT
	 Pjsm/5XS1QXmYh3xSNCifJxYEEVOtmvFqwRbkIRpBS3I/nvV8Wazo42+JJuzYksLA+
	 hoMKHjjjaTGwQ==
Message-ID: <sashiko-outbox-218942@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/14] s390/sclp_sdias: Replace __get_free_page()
 with kmalloc()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261117-s390-sclp-ready-v2-8-e518c99622c6@kernel.org>
References: <20261117-s390-sclp-ready-v2-0-e518c99622c6@kernel.org>
 <20261117-s390-sclp-ready-v2-8-e518c99622c6@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 14:12:59 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> sclp_sdias_init() allocates the SCCB used for the SCLP store dump
> information requests.
>=20
> This buffer can be allocated with kmalloc() as there's nothing special
> about it to go directly to the page allocator.
>=20
> kmalloc() provides a better API that does not require ugly casts and
> kfree() does not need to know the size of the freed object.
>=20
> Performance difference between kmalloc() and __get_free_pages() is not
> measurable as both allocators take an object/page from a per-CPU list for
> fast path allocations.
>=20
> For the slow path the performance is anyway determined by the amount of
> reclaim involved rather than by what allocator is used.
>=20
> Replace use of __get_free_page() with kmalloc() and free_page() with
> kfree().
>=20
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@re=
dhat.com
> Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-s390-sclp-=
ready-v2-0-e518c99622c6@kernel.org?part=3D8

