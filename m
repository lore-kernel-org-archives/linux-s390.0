Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE4845DF71
	for <linux-s390@vger.kernel.org>; Mon,  7 Sep 2026 10:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788777733; cv=none; b=pAWfy2c9AEg98lkdgKLGkqY05+Jk6uNgSc8EIh1yvDRK0jAPwjdc4RZO3ro3f6NeEVOSPtXTCBytsRYhfq+waFSqV2ZWUaYj8FpQWrVOKbZ5pVT8G6GVQcAY3884pZkuvkcrDlAyvmWzu0mjEjLsG8hPpOjnYjIeiKyfePZu0fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788777733; c=relaxed/simple;
	bh=uM6tC3rhMHDJF5SGRPdi9lvsiIkDAE4oP2NQwVHmWaE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ASWIf3GFOsDYqix/sy5vsEkUTZxftQLGLCVSwZQJs7bzomKq22wBmmhN7FU6QeP510DYqh3W9H0kpwaJLKhBs5zCXIDBALeWgj5H+un2Uoz/4cBJ9r1q89mZjJtbZ7gzhHPu1WleHnAGqC7E32yuxxXgaUXOTYPhcjwJTVVzUsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/dB9TPd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/dB9TPd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE25F1F00A3A;
	Mon,  7 Sep 2026 10:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788777729;
	bh=uM6tC3rhMHDJF5SGRPdi9lvsiIkDAE4oP2NQwVHmWaE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M/dB9TPd48vFhj1dQeTogLe0H2L6RdHiSDOwHnixx44bB1w7xYdyAyoACogmEjWM/
	 wBePZQFAz/CHYWxHtF/9yvDAUcexC8zpnPpw2UHFCXx5JwssobtAbAttcG1EmfUZ46
	 ZSQTWmQKSG5iIasqPZCX/HJTdKHw5PL4i57KF42+gPkZs0cpbDcrfnqiZwciRFm94F
	 Ptz2APrsXAoMWHuebdxGRDDNIgshImS28Zlv7TvwnFJbCOAcdUlMQz0c5+2iGo2H+h
	 J7NUa4RnWr39U/vcXWhwLQ/wEZ/en8RZipI8+BIEerb6SMiHZHd72WOVffRcWKF0OM
	 LllTHjA9FeQwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/13] s390/qdio_setup: Use kzalloc() for the storage
 list
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260907-s390-cio-ready-v1-11-ca7f39806234@kernel.org>
References: <20260907-s390-cio-ready-v1-0-ca7f39806234@kernel.org>
 <20260907-s390-cio-ready-v1-11-ca7f39806234@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 10:42:07 +0000
Message-Id: <20260907104208.BE25F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> __qdio_allocate_qs() allocates the storage list information block of a
> queue.
>=20
> This memory can be allocated with kmalloc() as there's nothing special
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
> Replace use of __get_free_page() with kzalloc() and free_page() with
> kfree().
>=20
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@re=
dhat.com
> Assisted-by: copilot:claude-opus
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907-s390-cio-r=
eady-v1-0-ca7f39806234@kernel.org?part=3D11

