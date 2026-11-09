Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794215124;
	b=4Xg4se1ZnnvfxhxyQXWHzbCsIoRs/8DPrQw3TKp7bzpL0lOrqJYNmBT2+REl7wLEjNku
	 +OCyISQvu3PPTHjgOwiGvA3MDAymUP/rQJhVgtPN31gpC0PnQfsrzX8RlaipcC5GytcoB
	 Vy+OAZ1J015YX9udlNVTAeQHhtckwgTWIsqJbTWl4v6Ep2FCGBt8X+8dO6QA71/vE+sHS
	 jn0fMYtuFfKKGDiRvyiFwB3dTUwFUu3EBiCzwYpnV200JHds/xQM9/FOEZENyRrYSzA8w
	 YFVDJxLE5uFUU8zClo4TupbTT6+wWMuURCekm5pY6DMDa3kVzjo2ClFxOwBbVw0iWkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794215124;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=l6A/Vl6u1sRChgByut88dwdy2ySwcDYVMV59cFtXFtE=;
	b=qrJwwVouTwm5nn+09CZxAsZOIa1oaNElMFvM8W3Opy4qQCn9ar5phP4E3/G4F31pjHd+
	 37NGEgFjIwP8wkgRq6V+9+m6BQ2UPsf5jv9tQ57bNXkjT4iPQlNJKJl4yfuhFruTk+tCi
	 3GwFyjetbnzjpcYwdSyvvGe8rFgMWkLtM6Q1sDFQ5DvJQExXLxKb9PF2Pg54Btq4VgA3q
	 3lladvAvLCEyXDrmjvlrw+fY11zFiDbHceBBAG46NmQpMvYugBpuEI/DzM83CMdmjFXMh
	 2TldO8+URsG+TdVcTcMPH7gKLAKFbjp1SakWdH8T5TTNxCFJQsSVzmYw73zwPnuhWNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LzHNrWUX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80706606A32A
	for <linux-s390@vger.kernel.org>; Mon,  9 Nov 2026 09:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LzHNrWUX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3AC01F008A2;
	Mon,  9 Nov 2026 09:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794215124;
	bh=l6A/Vl6u1sRChgByut88dwdy2ySwcDYVMV59cFtXFtE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LzHNrWUXQvgqBeQeJc0sDwV5cXA7wn2Zh9mngKL/5glfGSmy6jpQPexdtDkurkTS8
	 F/dzHfK8esWHQWl9YHAzYoWVu1Ab/sPXa13acuAXMPZxnVs2+byaFqCaTYMLh5Y8Q0
	 KdA5w+NM62gXSEujTgZeSyBNgyeG3VsjNC8QWOJg/MDlxp2mCk8w+jdr56ck1ktTpM
	 0mk0yWh/UrmMSMhuc9Xo5nXszB8Clg7aKC26bp0nPkrd5jeFu/ELmIIcjZYKEs1xpi
	 xMpytYdjM2m30wi1JdnkPOi87gmqfKXCrbTIRGE8apZ4H/LSEiHeN1aUL1FFiL/w97
	 XfWmqpnKkuHTw==
Message-ID: <sashiko-outbox-204659@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/14] s390/sclp: Replace __get_free_page() with
 kmalloc()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261108-s390-sclp-ready-v1-7-3e7c90eb6676@kernel.org>
References: <20261108-s390-sclp-ready-v1-0-3e7c90eb6676@kernel.org>
 <20261108-s390-sclp-ready-v1-7-3e7c90eb6676@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 09:05:23 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> sclp_init() allocates the SCCBs used for reading SCLP events and for
> the SCLP init mask request.
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-s390-sclp-=
ready-v1-0-3e7c90eb6676@kernel.org?part=3D7

