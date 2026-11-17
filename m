Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794924787;
	b=3ly19HoCVuLWkdnXjYG3iYLgXzc40HRbcSVijkYYxFKPBnQ7XApEGLf8N0Xy2Q+LHD1p
	 JZSWqNEJ+h/aR/7aPvOu79tdABRxfoigV9255DLHIK2s9VTCik+UtSCgvUhAlmzUpkcOS
	 VrpTEO8l33LSVvSI0d9Agct0CKglgw7zV+K9I59j7wKiPxQrxNWfNSuo9ATUzmfa9JfMw
	 xd5qqLFXARfe201fOaNmCrP+iho/mlAPKAjrKP/anXPyH9nO9Sq6j7xFwVKatkxz5SvOH
	 PG5/vQguxzicXADlvATPlLUfVCWr09f3VUNkur1xtigbADpVjUuYFGYavV4lrptDlww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924787;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3b2jqym2YL1wy9zM6lx/t3ZAK5+zvV3YS048P9/eCV0=;
	b=iUZYHhle5MPEL4oFR40zJjN671ViUo3L0ogdJvIm8zYuMqk2ZZ1Na1Yw3B7S5fyjjDZ1
	 +iLDpcPPlGanzwFmBFGAqCyVu5Npw/1FN/HrM2W8l7zBBLRkFmmok5GTA5e9mfSQrf90a
	 Fk5Eu0FNXE8TBqv3jrVwWMHgSXregyoEHEIM+/aghwNTohtpi8QLcUCUV7Dzk7UVHbxA6
	 zOIGEc/1F3rzIHZyK7tZUxZCecZfqXgMKkYF9NDN3x+qe/Mi22Tbj2z4BFlTUWTTVaWdy
	 NIBl+Aa7v/BOh06L9Pa7Z+XztikA0cKaCrWLMAvHb9/MF12J+fuJHLN62ic3PIqFRPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="OX2/yCF/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A78606BD1D
	for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2026 14:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OX2/yCF/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF27A1F00933;
	Tue, 17 Nov 2026 14:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794924787;
	bh=3b2jqym2YL1wy9zM6lx/t3ZAK5+zvV3YS048P9/eCV0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OX2/yCF/3pNbocpb1X1Pe5cGcGfrVeynqhqg/+XO9rSsNWPJQ03ceQ/ipnhcG8HZP
	 gxO6raL6XolrRwbFPxM85AntB0e/Uv2WW9Zr/0Ccx3VAEon5eaN7g+uORQ5jwH6MlP
	 UHaD8jCZc7fck85ZM3SkxVpJks97N+x5SpHxsxwuywK4H/d33uZx0ueXIXh/2YeTz3
	 xY910rLLL+1gCGki0C10b5Jq9UaU7pLXse3RImynHUKRUJ/G8uTzCiMsjdieXkwBBW
	 AybF42rtVZK/X+QliOYb7HavpXBCo00CfbHFMoSf+XVqwo0LxJd9HwwkkzFrePQ1kz
	 tl9MAlhRflBxw==
Message-ID: <sashiko-outbox-218948@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 14/14] s390/sclp_ap: Replace get_zeroed_page() with
 kzalloc()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261117-s390-sclp-ready-v2-14-e518c99622c6@kernel.org>
References: <20261117-s390-sclp-ready-v2-0-e518c99622c6@kernel.org>
 <20261117-s390-sclp-ready-v2-14-e518c99622c6@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 14:13:06 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> do_ap_configure() allocates the SCCB used to configure and deconfigure
> AP adapters.
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
ready-v2-0-e518c99622c6@kernel.org?part=3D14

