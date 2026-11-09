Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794215118;
	b=eiT+emdTjQ6cbwzdIG7Y7KL+1/RtWKKYgp6iVvH4AUtJscmKnICvi4zxSODvSZ6bRaxS
	 CyDQLqjmH0qSKnVBlArJ/J4+zdNGuV5F3uYgTHmw4XamGiRHQqzzpFmzgBLoiBfNHLwQ1
	 VPv0nhT1WWxdqXX3qEFJKPvPsbbIxPg8zn9sefXyjW2qvdA+lxT3b68pg0iGbfCi8o2iX
	 Kfi7cKM2zvIY5cMdOiNS8RzWSatPGQJv5SxEwhKW8uDY8RhxvUppu1EJ259Kl9ymgcL+y
	 9OoT1sDaZUgRG9cUdFgu59LK2UqzjT8sjMxTg3u0ENPgVXa0mQDAytKEZp/IEnANa1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794215118;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iBmFngbu/bhQp2Iooem1HJ6wytaw75uBJ9vMMZRBCak=;
	b=jH2uQFdOwp4Ywti+L/QoPRNGBsrzYlbokD5VvDG7iGDCBb5EL1rpN+ze4Z50aO6LKy/v
	 JGG1dIXQL6jj+yeX+JpbQonNDQLiSB0+OeEvUXegvrBwsOr8AwGalmZaDFIXuPNWAj5/c
	 Abo8fxyojj2rgiX0OkdVL9gzx1SOjwupTOUmO5BZQz7NdfihiFRC0Pt1SX4yKgQTyl3Bj
	 3qkHt9uuj3tWZip/R45lqBuaWnrQHvAvhzvrD0eKWBZYcroOJscPvpxd57+ABhAAF2IrP
	 RgPUTEzE6OZNfvM+a7WgwTfB2hyD/gXouwGJLZ8JRH2p191Ghdrgml70QjCt8bDzg+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L4AiaQoc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96370606A321
	for <linux-s390@vger.kernel.org>; Mon,  9 Nov 2026 09:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L4AiaQoc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2959D1F0089F;
	Mon,  9 Nov 2026 09:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794215118;
	bh=iBmFngbu/bhQp2Iooem1HJ6wytaw75uBJ9vMMZRBCak=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L4AiaQoce5zw0nZV5gVKnqDhhRJcu5ZGjhU7BGpQ6mpUUfTy1tVNeN51IHSdtFp0i
	 L0NKppR81QCVTRBr6eeQtHb4O0xwsRWtDa3wplpM/x/XTGvcSBIDr/iOJpzDP94NJE
	 zAKFAyW4OjIwlggdShSHoEG3T1Rwf2xiN8kp5LkiPn037yTkwLQurBW7INRJOJbVVr
	 VPQ5wEFC2nSJ5gzSqBCpxyGIx09NBk2J1ckeQ4gOh0r6iafBKUgQ7e5p0zpRkig0cO
	 FZ/Xg9RUaZbobl1HpAQ+VOi6KxBpWs94H15zybro/pycbncZGfMNkLU0C1AQ9hSedf
	 lB6jwKXCTLPpQ==
Message-ID: <sashiko-outbox-204653@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/14] s390/sclp_vt220: Replace get_zeroed_page() with
 kzalloc()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261108-s390-sclp-ready-v1-1-3e7c90eb6676@kernel.org>
References: <20261108-s390-sclp-ready-v1-0-3e7c90eb6676@kernel.org>
 <20261108-s390-sclp-ready-v1-1-3e7c90eb6676@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 09:05:17 +0000
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
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-s390-sclp-=
ready-v1-0-3e7c90eb6676@kernel.org?part=3D1

