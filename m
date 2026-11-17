Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794924771;
	b=WtbmWrSt2BqgWeJZjYux7qrdUqFZk+BHWT5SkLK8lnqTkimlLIsbO7hXztzL4tff+4kQ
	 mJFyxlXx9m3m8xb5KY+2fNayc/BP9/OzuqGBKa5VKrYeH6RRinbAcQ9H9HAoJayCyZjRd
	 I3HbocFsbzwkFenFmzJ0xDTZieNnCQMUCLZFz1G2+M9Nx20c6IoC2IQC7ldebzVWBHvwK
	 GhdTKGwK/yfAEWTT0KEvb3hVdISmc7NRkV7ZjDi18RjR+Ap0XLHgkFXQW5qZQxBULNTGj
	 bHxFzREZPpPtMpRM87PxwXFiyxe1627S9TAhWujfCA1Ktv16h5mikevHgKOuN7FDCwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924771;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ziraelQg+R4YuBucIfQrkm/YgZK5016QW1dY9XK4wJ0=;
	b=rdvIVumjHMN8jX4ERJzWh/80FX27l8Euhmw7gywy+Rhhu6ebze4C4QJeNmwxARXII4cF
	 qzitBKJHNHsjGKj/cyqasow9Ps11IDH4KAyUKoWOI1oOvai4H7Gbfrl/DrOUpPv0dQJui
	 eaKMW09K1vt0Z6seqZPGjI29/qjgsv7gfhiQliMPsIZ7DhojvXWADsQ9YJrH7q7v0dDm8
	 w2ki7R0usegPC1iYZIh1RRnZ0Eze2DS+tm45DRB0e15/+jevXKVq86KvIzrlri0TVT0j6
	 vgLlvOtN1P11nRbP5CNbkKaeNli0t5l2FwP5kznXcjj2xDHa5tQE3haPLKvBel3cYgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mnff2AZL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1294606A33F
	for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2026 14:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mnff2AZL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA3C1F000C4;
	Tue, 17 Nov 2026 14:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794924770;
	bh=ziraelQg+R4YuBucIfQrkm/YgZK5016QW1dY9XK4wJ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mnff2AZLxoisvv6gxwq6ToGySrN8BmG4k9inge0joxziXZRijmrHR66Kavv71kVRB
	 9j3aJ7yXPJlXRKvSpz/YJLNSIz9bQYaD0i1nwqphItMx5BgW02RRRS1y73fpWYYA1A
	 YyJbpo1obqoaDfFxDpHsN4Ca6LRF0GgVIA1Iv3acPch6DJQjbBPdiwzURFAXDFyYzU
	 6sNGoTJW1A7dLpDG62PgVZ9MsjOWoxwSaOCX08bXkIhl6YaqEcwBVdr2r/WmlXZwvk
	 qYxtrvjAKChMiH+Ok0VsuWnetWvtKN0Jp6k9xp1u8uv4NLxEZkRk5keiXYEbdk4LYR
	 ZT4B4eNHAMdZQ==
Message-ID: <sashiko-outbox-218935@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/14] s390/sclp_vt220: Replace get_zeroed_page()
 with kzalloc()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261117-s390-sclp-ready-v2-1-e518c99622c6@kernel.org>
References: <20261117-s390-sclp-ready-v2-0-e518c99622c6@kernel.org>
 <20261117-s390-sclp-ready-v2-1-e518c99622c6@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 14:12:49 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> __sclp_vt220_init() allocates the SCCBs that are used as the output
> buffers of the VT220 console driver.
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
> Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-s390-sclp-=
ready-v2-0-e518c99622c6@kernel.org?part=3D1

