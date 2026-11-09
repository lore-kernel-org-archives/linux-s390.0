Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794215126;
	b=P2gJgVbYFFgFJwwMgHuWKtvcZs1MS/3h1jkwhnb9ZloOirA3QVddcZKroZ/zfxTWXAmJ
	 zuu+kaqP7TweZzAMzCeFLZjKSctBg+2DRq97T1IfTV+Hru00213FOdkhhGd2AHcERbovG
	 tzSJl8YZyRsx6ClMMqGKiTikBXCGUYTznkMDGcUoTByKB9wXH+KMBdYl+2Z7fZYrKedhX
	 IcNIIcw5cL71Wr66UCMNjNiX0Kti+04fVu5ZUhlS4P+uVIkNQ1dPMqieR5MCa+kimYFLn
	 zCndOvcA6gMCGWd2ripRTkiGB5YQmum3L5S1tJ6K5x16HPOL3pSoShhQgBYfEFe2THg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794215126;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ra6DTiScJw6E5kCvFj4UqA1hRiBTdueOo+qnMiv2TGU=;
	b=lUrAcy4TvWq4QPZnLhi43a5Nt/1h3CWekjBA7aoD5AD1xCTTItjQjC4XK+MBXs9BIQzj
	 oQkztlGX0S6AwRh1zdSRFf6FDGmAJf/DLI4CWYZIbfWeewCt7k8VJyQqlgniWUvJSKVve
	 dG6bWPlCLKySplAwOKzp4joF/ErUbq9nkE8juphWa0uNdMyhb11kJzeAqA4JDfT46ULmF
	 DW7wKLb0YXSPSHJOPgx7ZPsgbLHrcFirbAcMlBU89T4zbmeLBZ0IZs7O4Gd20ucJ1yk96
	 XZUvEScA4h8cHhuXKbk9IgyfT3VAa0KHYIKZDZgji0kHjaN0rzQ/F28ID8K0HCuKL1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nuAJfPgR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C31606A339
	for <linux-s390@vger.kernel.org>; Mon,  9 Nov 2026 09:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nuAJfPgR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 425AB1F008A1;
	Mon,  9 Nov 2026 09:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794215125;
	bh=Ra6DTiScJw6E5kCvFj4UqA1hRiBTdueOo+qnMiv2TGU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nuAJfPgRn0nMKxbvLhkSfVXQpMD7bnGL0HM6+LUrSmHJKKgqs7ZLMLVWzC47ER9X6
	 sG8HswiOBNOeCx18W1G0ojvkquHHavaXOsBlFsVET6zQEuhw1KBpWJdiWTu0/VLuov
	 x7jPj6/93oUIP7/BDB4Metr2Db/UzdYaP0tYfK/A6NKePwc3rvPJ0G8lCUQaQ2ygB6
	 oAg2aHaJu7OIw9mlldGmagBrxu6J5FTVAna7u/jNAcHYmuLxktD7LTyLKULDK7fpec
	 rKaGLRr+Stbjrwi2KiXTulMNqXMu3IBiN0ng6hlkYaoacGkiM1OC/ZTS/UW8pLU78k
	 lCdl6Z6eclePg==
Message-ID: <sashiko-outbox-204661@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/14] s390/sclp_sd: Replace __get_free_page() with
 kmalloc()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261108-s390-sclp-ready-v1-9-3e7c90eb6676@kernel.org>
References: <20261108-s390-sclp-ready-v1-0-3e7c90eb6676@kernel.org>
 <20261108-s390-sclp-ready-v1-9-3e7c90eb6676@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 09:05:24 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> sclp_sd_store_data() allocates the SCCB used for the SCLP store data
> requests.
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
> While on it, pass the SCCB to sclp_sd_sync() as a typed pointer instead
> of an unsigned long.
>=20
> Replace use of __get_free_page() with kmalloc() and free_page() with
> kfree().
>=20
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@re=
dhat.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-s390-sclp-=
ready-v1-0-3e7c90eb6676@kernel.org?part=3D9

