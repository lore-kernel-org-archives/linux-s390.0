Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794924784;
	b=3jwbSjIzTtyNINAUDx2yiqRVx65KjVPUh3KgJO/cynn0XY+mGHnPgeDbaio0dj9L2GLC
	 NiDMINu9xD9RtyyVMvzkTzWDDpmZrxVX9ZMsaM1TuWV/1XrvMCJSJTaBdHkT/eW80ovs8
	 q1AfEy0clzL0+i1FaDrz+7qzCvz10d/zjIAwJUoiDs+CpLI5Q1WIgduPgCipLZ/DNL+rN
	 3x6ZhL+TJZforNnasdkime0+krjSriRC7ZyN+EOKvZJay2ie4I/o+7Ebr2B6FlVkSsWY4
	 G87ba0mzJ6GquZVpgenM0rFLEsWam+rCiJ0NVmhDm/K27h//sSwJ0NlYc06Kyo4OH+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924784;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=j75nUYEeqU6/VMzNrXRMjyVg6SsWwOOzK6bMxCYaDr0=;
	b=EukYpO9YN08RV5N2TgK/W3iQ32NLXEAbleUV5fZAdxTNsyLnyLCTpDwIcqGw78vKTlY3
	 gBn3AzzWYHHmuYqZR0d6Sm4k8cY7kEWt2qYcLhpFoYdaFaNokqwTkfFE/CHIJYwBKX/o1
	 kDxi3UjQ4AUkF7a6J5wiB35JkuRiCfBkZ7VEDTFGOhVbyZ1nod6hGXEdUn5g62yM87Om4
	 A4IA4UB7ZgtFdulMrViY7mVh3KwlOIR0nW7lKV1x/zP0EUWYqxm3eCTA+TvsoZrRw8CIN
	 CtW2C/Yqr76E1mB06bocksOAr+8XCiz9FdavdapbUjcr09tisoupIRkRZN1VrMPTB7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VAbUS38J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70E6606A8A7
	for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2026 14:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VAbUS38J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F301F000C4;
	Tue, 17 Nov 2026 14:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794924784;
	bh=j75nUYEeqU6/VMzNrXRMjyVg6SsWwOOzK6bMxCYaDr0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VAbUS38J8oWScrI4wotwI3gCcNH57wxr5EeEciX/+3o59KkOqHc4yuLcdeOOtl2/J
	 BHmbZ0ZBzZilU3RFISfpamAGDkflSE4t+GydudNEhAQj/PiTzXtRdz2EJdZZopNi3H
	 2wYoaDEFiJlFzZTdPFSaOMkLgF5gFKbsB7w4EuDZjyPzKXRxFYL7pWkE2emc+81Kom
	 2A7/fkec/CVxIq9zXXtj8Uu31MMwmfV9j/+f8iXry8cZMvJ7uVkIUHn0dPpOCen0IB
	 CcC8z+DqqMS1RQkCtxcAWfw15qMda0qgD4u826b9K6u/RoXJEAdFsogM8xwt/0ETcm
	 /Ml9wNLrUTPzw==
Message-ID: <sashiko-outbox-218945@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/14] s390/sclp_cpi: Replace get_zeroed_page() with
 kzalloc()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261117-s390-sclp-ready-v2-11-e518c99622c6@kernel.org>
References: <20261117-s390-sclp-ready-v2-0-e518c99622c6@kernel.org>
 <20261117-s390-sclp-ready-v2-11-e518c99622c6@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 14:13:03 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> cpi_prepare_req() allocates the SCCB used to send the control program
> identification to the SCLP.
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
ready-v2-0-e518c99622c6@kernel.org?part=3D11

