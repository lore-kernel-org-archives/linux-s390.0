Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794924785;
	b=ICwfUt+BCMgcz5BLGiOoUy3sfvjEgMPfy9d2k2ObvVbCc9w6GzvCNolAmTS80RHNaHfs
	 J/1rgiyMC7tp0HRTmADfrGbTFr2IOX4pT7J2N+exmva6pdN9Hs4q3PU0+OXGxQQcl/KqB
	 KDBj+7b4dOSotdx+hloOwPopoI4UGQWqMPGLO8o2ZMrxELtqDxpPCUNwkSaVof1tvnvjk
	 w6cVfI0IKpZBnSZsGm9A0IiKq3TvSu7mAhDHMaTWXJabUx5YRHwStEJ8sDyEw2TCc+ka/
	 N2AwW8xio8HroMPOajeZXNVU5T2msqkF4Hs20s6OPHeJeLk2CSOaAWgjPuBrcQ0DdBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924785;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LJAJsSaRYxzjPMislGygO24BI01ZD9knD+FHAzm6cis=;
	b=4sIYyo0PS99eE+4dWP3hnA3xrXRGfYHMQiNDxvdVhaowkLScj8QVaXEpjgTfcjVzdqn/
	 ipkp0WF9tRQwOmOxDOlltWGynGhkOMKmaqDwrRaaU3QyeuG49GQZjPwBFTpaE+BDTlP0u
	 CaxoNv5EWv7AZRaJsdKWn+jXeEIqtYc00jBWmfLpWr7es6kZdTGOtag+RkF1lb/uIpbFA
	 4jUUky8TmeMl+WDlbu32gSi0/vvsgpOxmJJr4MENaW3HG+tZhBABEUzVXYs9qVKhdJ1j0
	 KNvIZjXs1HiqDyt1Jybfg/ubO82WCgL6L6JMv5/oxRn/G/ODCWQO5XxUnXQY2nl7Igg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="jy1SQ/De";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA95A606BD0B
	for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2026 14:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jy1SQ/De
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA281F000C4;
	Tue, 17 Nov 2026 14:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794924785;
	bh=LJAJsSaRYxzjPMislGygO24BI01ZD9knD+FHAzm6cis=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jy1SQ/DeA3/lTc17CxoVg+9og4shqhsYQqlhjiGi5TgvC5X0KwBNvr/oBRA8l9mam
	 8/mxZ3FUYQqokpORs1C/jsA2Afp7DmjVfA0qROolnU3u05bNQZqd0FT1ViCd4uUnxB
	 fxEXX7bl02KeNlHWxH8DtRUk93SoeJv2pQUoHb2+J/WcDGVBuLOJOW0tLo0S9u6yE2
	 84U7ydMsiIffJaAR/VOpLWRhr+hF0yiaJcuMoQOzY028bXl2f9PaYy9wZ9YMzKsq6A
	 grK+jl5aZU/8F0MXlgN2IInAHiAM8sXVCKK0HRpbZnL9JX6JhXheAZWPeqgKLUUf/n
	 ERtjyZZzo5dfQ==
Message-ID: <sashiko-outbox-218946@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/14] s390/sclp_ftp: Replace get_zeroed_page() with
 kzalloc()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261117-s390-sclp-ready-v2-12-e518c99622c6@kernel.org>
References: <20261117-s390-sclp-ready-v2-0-e518c99622c6@kernel.org>
 <20261117-s390-sclp-ready-v2-12-e518c99622c6@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 14:13:04 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> sclp_ftp_et7() allocates the SCCB used for an HMC file transfer request
> and sclp_ftp_startup() allocates the buffer for the SYSIB 2.2.2 stored
> by stsi() in the debug code.
>=20
> These buffers can be allocated with kmalloc() as there's nothing special
> about them to go directly to the page allocator.
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
> While on it, make the SYSIB 2.2.2 buffer a struct sysinfo_2_2_2 pointer
> to get rid of the casts.
>=20
> Replace use of get_zeroed_page() with kzalloc() and free_page() with
> kfree().
>=20
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@re=
dhat.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-s390-sclp-=
ready-v2-0-e518c99622c6@kernel.org?part=3D12

