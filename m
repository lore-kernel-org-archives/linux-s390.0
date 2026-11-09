Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794214445;
	b=0eFTh8pBD6eYcn8A/EhttAeKkkbcGdT3mhL4OrD4aJ+ztkVGzFciLH1dIj+1/HXCiwkV
	 OSz5Be1wjiIrC1ZH45/Jiug8hPaKrLAxlj8fXuK+gMQhkedFg4O3NHCivv+OSrCYY12GI
	 a0q00t/bF/8DSAePTsDN+A/Nci4PMXF6beATkkqNf8J4qLm4X/Avze9I7SZTxXQCzRIxK
	 /qWJwZkiBwCpGyv1/upICPiLwuwqzK/HT8ch8vsBm8YJIt8N99ctbtKSEIbR+pWJpnI9y
	 ZxGeujj2ood6hbo2M0h2t4kNiOmOjPYVPo4SSEBWZfY9FWku8ie6qh+PNyeC8gsQ/mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794214445;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xKA+QT7sKuu3wcjGhGcEDGKtJRYDa9jDBiRrZ3A9Iuk=;
	b=jhJRyCR5bNtISGXbkRUgxJPAUVhCSyhHiCyZZpIDMPLt/BOjpo6GBfFpp3IitIhKTkrt
	 iXRuGJm5bieHepCFwVBqmMG7cmexhiVH3oBaWTpvJSKbSN4CX8A0fPgagf3BadIErInvl
	 5rCImshQX90hnazRIkip44h80Q+5rfeQWv95kxwXDrKqeTLTvDWzdapR5pGW0ty/+c9K5
	 igGg+C41ol19GnjnBosOoZxfuE4TUmHTYMhA6+a+10WIjdXawFYo56O7f3QiLCDExDFXK
	 SuS4826H8iHskbdLjcbvktxpahy1GnAi63kMFhai/ZayFOjEBEA5x+uRAZc1GZpyMOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X8RwGctF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD03606A321
	for <linux-s390@vger.kernel.org>; Mon,  9 Nov 2026 08:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X8RwGctF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702F71F0089F;
	Mon,  9 Nov 2026 08:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794214444;
	bh=xKA+QT7sKuu3wcjGhGcEDGKtJRYDa9jDBiRrZ3A9Iuk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X8RwGctFYNEMxvy5ABPEIxTBbRWa4c6uUU5fbY5bFBoIuoIRto1heVv0LdvP/wiwV
	 Sgg689qfwQZxYPxTdkfOX+NaInX3cYiSBd6CHpw8XKcKJvyKmZ/6/5wRotBeGiq4RH
	 QTPYmXRAtKGCR5akV8s/AHTn344uCnpCQy0IG4C9f6TaoZ+19qSMUKq0FgSV7MFa5J
	 wt4GC9kp6ActK3Nsq4/TrAEGkGapysV+u0/FyPG0wj17jU8TaCL4RbwRxUP/ZFcN5K
	 m7Bpodpk/CPD+e0JAFB6asbtgpYEeLRMtXrRdeboGJpF+GyggSKho5D9m/DnMlX39l
	 FJ11w1Np55nZg==
Message-ID: <sashiko-outbox-204629@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] s390/zcore: Replace __get_free_page() with
 kmalloc()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261108-s390-char-ready-v1-1-3db507722530@kernel.org>
References: <20261108-s390-char-ready-v1-0-3db507722530@kernel.org>
 <20261108-s390-char-ready-v1-1-3db507722530@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 08:54:03 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> zcore_reipl_init() allocates buffers that keep a copy of the IPL block
> and of the OS info structure of the crashed system.
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
> Replace use of __get_free_page() with kmalloc() and free_page() with
> kfree().
>=20
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@re=
dhat.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-s390-char-=
ready-v1-0-3db507722530@kernel.org?part=3D1

