Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794214446;
	b=hSbHggpP5DFFLbHFWasoqwWsbDDPlOm3JupmaPHPEV1VEsToGMiSvv0jbED+Wgac7Ecc
	 dgkQBt1lQjOl2QBCozceZb3vJypf415i2I2BN3O3ayxJX/RCkqomnHEG30KgMejfRExB4
	 9KJ16HC7t0YjuJd069raEqpAPo4LAKZJzI1NaD7L1e80/MUOZj9ti/Aclw6dLkH5JzZxh
	 P5+tmuEhumngGjCIMOci50YxMMGdPdiJ/IHvwAeel4MhuyiUhPhzlHKh9A1+AD0xjBe2d
	 rEPizj5TGaRp9ilxhL/MrHtQ4JAU0ylLNuguXh7XbYYJG/hTm94V/Spb6cq+s7xOf8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794214446;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5ilYqjbK73ATK9r57YmCBChej/EWWUPoZ8N1XuP8aY0=;
	b=3l46yHDUxJ7cUCF8YERMoTboYFIVXknmYR8ZKAUhClqP7j/3q/kNoJRI/YgrXs4AeVpD
	 oyujMbAN+UaHKgCAHrtK1ZWbr5riGzFEyu2HFt4CXLA/E7oUuGdQDREVOK8P15+Sa/Eyx
	 PJwNWHEDPkMX/g9jrdazHbD0Kh2FB4Nx+X3tN6VEKyj459RxN1BfGoaaEg1ROfQ+aeSoz
	 L1PWKTMjHpioMjzoKX5XzdQR14eUbmLLwAUk2TwQGdM7knbFyjBde3qmAAdrwZjxK3dfm
	 9Zgri0RfobXdszwlZC+bofeQUOzz42e3jC3nW1pZYJgmBpUPhJEDE5p0HT2OX4deNfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ffKfjFnP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981A9606A334
	for <linux-s390@vger.kernel.org>; Mon,  9 Nov 2026 08:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ffKfjFnP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE3801F0089F;
	Mon,  9 Nov 2026 08:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794214446;
	bh=5ilYqjbK73ATK9r57YmCBChej/EWWUPoZ8N1XuP8aY0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ffKfjFnP6T8LzzVkfYShW8vE3gcuixYtQ/nsJDM2yXZUrPYarWye0O8u4r0tsI2By
	 3CEpc1Zdr9DMpi80juUlB1eONVTjv3oI/XhDf/5NTreiOip/Az5jUJ+/RCHPbbUR29
	 eNWRdLe02XCp65cuOhqXuMBjRT92je6Rq4HN7TgRVlVIE1LZoFU8UsM91BMhL3Nu91
	 7IxpBDZyVG+9Oh448VUyTsLhgP7XIKp50Vm0gxkhc75Q2VlHKhDYZpNbkzJUobdhhw
	 eko565aFOPHmo9Jf63vDC5P1tT+wgU9AkEn3M94zHbhP5USMAVKBtTqDwUl9/CegN4
	 ynAwo671TjOuw==
Message-ID: <sashiko-outbox-204631@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] s390/vmlogrdr: Replace get_zeroed_page() with
 kzalloc()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261108-s390-char-ready-v1-3-3db507722530@kernel.org>
References: <20261108-s390-char-ready-v1-0-3db507722530@kernel.org>
 <20261108-s390-char-ready-v1-3-3db507722530@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 08:54:05 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> vmlogrdr_init() allocates the buffers used to receive z/VM system
> service records via IUCV.
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-s390-char-=
ready-v1-0-3db507722530@kernel.org?part=3D3

