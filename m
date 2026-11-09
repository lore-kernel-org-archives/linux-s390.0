Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794215121;
	b=nkR7CcYHsrzV+PDoPk5TaIx8ODjA9kXVSgoiuHoaUey86gKkQRarfWdjqKsRDjDVHQw5
	 sqv3BNY57TWz8OITBGguhOGQ4rAIoEseFjkJUApnJ4Dr0xH8K1dUC626rQv3hvX67pPjJ
	 Uq0Gqs8iau3wC+pxLad2IoZVPCak+fcQPJ5pUUIXd1xmEzP6rZUVBWMDf42/RiJbiBqtN
	 H/KwSnvTX6V8mzEbhRMXam+JM2cxbfx/k4iS0fPKDRrmsOxjXfGyQr7o755d10IuNpDFQ
	 p7hzPUrkr6J+YcTKHMJUWkw8uxMmMJaBkUvI1ZJf6C962ea6Qd/daPstIkTh2vCyaoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794215121;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8VM6AAvq4VkD0y7UrCvjWbqX/42B1ONUc+CNP/k2KQ8=;
	b=eT4V7qA6jieqEP+38c6updwhHjxQF9PKdegnJR4bnhsxPi7olLEwNB/cJ3STg92UU9le
	 QjJ/VhtH3Ig/DQgUnIMyp8OkxK+JItWlBSxiz3V/Q+acWevFYKd7T8jPrM2XmeMiBSXLU
	 QPfmlW5U1hTzcLDAr9G0CDEGAZLkfv6q8hPKo3Xs7ZNiFw/CAijXOQjrURzLIiz0YQA37
	 5xYRsZ/DV+JbHeM2XcmnZOtsJwU1lkTnvNVdYjh2H7knTHNlNdNF91dQqE07CCNZi0/f3
	 R++wY+cCH7W5ZWQbw4ntk40kcIxq72SBcLcyhP9otQTS3HcruoTXwrwK27m5ygrPItQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JiqP8+nR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3F4606A323
	for <linux-s390@vger.kernel.org>; Mon,  9 Nov 2026 09:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JiqP8+nR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 901771F008A2;
	Mon,  9 Nov 2026 09:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794215120;
	bh=8VM6AAvq4VkD0y7UrCvjWbqX/42B1ONUc+CNP/k2KQ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JiqP8+nR2MxLzn1utv+fSVL+cHPoMZ7ugrMTG2qM59frV0UaOxBaKaKTO+oaFGIh6
	 W62DIuWMyaUDnKmHrINN1mpxD9DWNI3K3OiMMdj6/PwjrN7TnsohWGMq+AglFAsuQg
	 0F7uPhsj6m9MN6TEcOHatyluIioECgBVQjqeByVoHaTzF3bsXIJHTqfOQwXbWd8RMM
	 SDjYqXYnkDElMbw2vQkoHU3z5KKl/paQAr+C4oyt6Va/i7ap75blnCph/qLvNQ0mi/
	 QAqMGLwajzqCjFPL3N4YeVH7SfPfcbQWz0AsCnJ5rzXnuES8GHF85bClGxfBEMAvDm
	 7l+/VtEJsWZ5Q==
Message-ID: <sashiko-outbox-204655@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/14] s390/sclp_pci: Replace get_zeroed_page() with
 kzalloc()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261108-s390-sclp-ready-v1-3-3e7c90eb6676@kernel.org>
References: <20261108-s390-sclp-ready-v1-0-3e7c90eb6676@kernel.org>
 <20261108-s390-sclp-ready-v1-3-3e7c90eb6676@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 09:05:19 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> do_pci_configure() and sclp_pci_report() allocate the SCCBs used to
> (de)configure a PCI function and to report PCI errors to the SCLP.
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
> Replace use of get_zeroed_page() with kzalloc() and free_page() with
> kfree().
>=20
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@re=
dhat.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-s390-sclp-=
ready-v1-0-3e7c90eb6676@kernel.org?part=3D3

