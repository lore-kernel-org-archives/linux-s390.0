Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794215129;
	b=ghRq5SEg3vB2FqFy8wL7MWwKPrnd7lJFQ3EbHWT7WqewdiIhnMRtd/rV9ZO3r6idCxvG
	 xgf+SJd+RZdcOX9UMu4VDf5ZJ5IdjUzn+zK2rtJvAFRF/5DI+nniLROZCS8E8cCWca0dj
	 RsxTNtiVIg2DFXdeoR36hVnirs2yUERQkFktYo6ZCkbtDDyFR3elBqUBhQIPjfX8yX+QG
	 3H4rY1s0QRX2l8YeGoghWl3mGRj6Hzm1g4YPA4HJEhpYA/kLnjVNFnP+GiuKpki+L0SR8
	 WGAyIU+PJ+Y8hZuz+/rAVsb/CbpULMyZ5gPAYDMT9bQXPeF4MFR/Az17Ajgxc/q3jmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794215129;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GWU9KjBZLSpwisRdYIjEfL4j1WqSUnySQ/hs3HOe8hw=;
	b=IxApyR+09xVEN6xBXR0UKg43svH+AE9M0ToAmiUXUDISVPOvWneOvUwmsgZK6vQrUSQ7
	 3Kj3WeXR4GnYpPUJMD0vglUee1vePZsxe/Q/B3vcffUhKB9m7L85rby8SSYBYTK7PWwbY
	 SY1UnNTzCB4nWAji4TC3rbvJjIeql3LhPSsUzjLnFDADBD8kEuFscLuz+orMq7FQFc8K+
	 o35fxblV4k+W4wJK6BxVNjlVLCWhg8P2lQZXL5zjctBz0p6zn65kdiL8M4B96jFMGQ13e
	 rSiNrj18aFImJfVIGGBj7YGFR8PcfzDkH1Tuxhc7XsMuVu6x2jXuRvH81onupTnLa3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PL2cYzBS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCB1606A322
	for <linux-s390@vger.kernel.org>; Mon,  9 Nov 2026 09:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PL2cYzBS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645F31F0089F;
	Mon,  9 Nov 2026 09:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794215128;
	bh=GWU9KjBZLSpwisRdYIjEfL4j1WqSUnySQ/hs3HOe8hw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PL2cYzBSkU+n+33HPbI0v/x8vexuUq7dZQMR/SgZ/YsxGmspKTBpLf9c9X07c9cCd
	 Xq5SzC+neSJ0h4pprmPqOi7jOB3dhqCcSuvrR3c8yggg/ZwHZqBVFobuBdanD0Re1/
	 oxon+9y2cxlzzjavTWSwywS065kTRuoklA1b0wxtShaxih8C9D6bhOBRN1HCL49QAa
	 57ieqRnkIJiOg8VS25oxmyM77VVRkUEVCmIvIDEWm6eyuvtVq6Zr6VScHT2J0+cO0M
	 QF/GD3ua95c688gDuSWoCWbfBnwi9d1axr/4H8b2aAih7FozSS2IU/+dKCmNnGpk7q
	 MkfY5VVokfo4g==
Message-ID: <sashiko-outbox-204665@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/14] s390/sclp_mem: Replace page allocator calls with
 k[mz]alloc()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261108-s390-sclp-ready-v1-13-3e7c90eb6676@kernel.org>
References: <20261108-s390-sclp-ready-v1-0-3e7c90eb6676@kernel.org>
 <20261108-s390-sclp-ready-v1-13-3e7c90eb6676@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 09:05:28 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> do_assign_storage(), sclp_attach_storage() and sclp_setup_memory()
> allocate the SCCBs used to assign, attach and query standby memory.
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
> Replace use of get_zeroed_page() with kzalloc(), __get_free_page() with
> kmalloc() and free_page() with kfree().
>=20
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@re=
dhat.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-s390-sclp-=
ready-v1-0-3e7c90eb6676@kernel.org?part=3D13

