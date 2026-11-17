Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794924786;
	b=WpmcWc7/vlDVVCMNLbOlR42jmyPDWbDhHfQT6Cq2mR2wT6rKbiqyFbdE1+sa/+jkmYn1
	 F2pjZyWcdYHc6cb0Nuct9yTJUTdDHczmj4K3jGrQn2vG3DliM3JkgClzQlJ2o4VqSLcHN
	 ibwTQmF5m7W09x50EKEnP+fNk9Xu3dClTfPTkAJ4ceIy1bm1/ejF1LoqrBGP1KlaxmzCp
	 eGLZXS05KMKPC/44h59m5IB4jgiOalU78V9ZqKvuJo8KHaylXW6QQYtKF3IQZUsLKftEW
	 CpXaFyYyCWVw9w4+dLNGxIql+I6V+DjJVfFQt9A2obCSrvNCpYgNUZLsXbXIxhE+XQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924786;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2dOvli9IRtV/+Pmt4A3r6OmzQ3pxnON6tWr6Sn5hNkg=;
	b=gxLgRF3xybswQMr2WZmCzWlo4pd378cur9+VhMiBt+eXZmAuDMcdyZxn+IbYca9TkxXV
	 2N/uu7HaC9m5Y+DyjQGbSJ74LcrWqYbixrvA+1ZiloKp28KGeZ3p9tc3z2rWrJbGJ7zy6
	 BQNyGuXXzOAlBm2CZMygmcSabrI75BM4iLU9OT90q/kB5+KWSzH18N0/y8TO8xKyCyTgp
	 xaRmXZJGUHEzjEpscb2h/AtDr9o3sHKHm8826c5GjuQ7O3ZpToAKQmNKn3EareYvtTTZr
	 6mF4x+hnv8c+fqRJxmRlgpQl1W4+B9ZTRii09hwN0yTR1XrXXH6AjQJTJ/RVK8b2/AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EA9HiMnq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F89606BD1A
	for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2026 14:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EA9HiMnq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3801F000CA;
	Tue, 17 Nov 2026 14:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794924786;
	bh=2dOvli9IRtV/+Pmt4A3r6OmzQ3pxnON6tWr6Sn5hNkg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EA9HiMnqqm6UHb1sPwlvSPRkFHL3UIviUoO2GBJYMQcVVvdkxTfLrEHbPgzOksz0H
	 ewfaGdrAtYM7KVNOQGPw9BMC1D2CHO8WAhpMOatGlgONIoXb8FDGuRAqqi9c538DUc
	 CC5q+iMenbj4mc7/W/52i6e2ljLpeWmDpfauvZO5YwFOP9p2Si74P3WFcrRUDaMNVi
	 2SKjYYklRnYhvXdhvVpSSpQ4kLOmIJT+Q94E4s5i49WulNcEns8a7+fDHi9xdDBimI
	 Allm+YYYYwBUGA9ev+A/9z8Na3xtpeIKwMJt73qA5z5wgZFdkRX9KZZg0/41wrQ1F6
	 P9Wt8zh28bJZQ==
Message-ID: <sashiko-outbox-218947@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/14] s390/sclp_mem: Replace page allocator calls
 with k[mz]alloc()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261117-s390-sclp-ready-v2-13-e518c99622c6@kernel.org>
References: <20261117-s390-sclp-ready-v2-0-e518c99622c6@kernel.org>
 <20261117-s390-sclp-ready-v2-13-e518c99622c6@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 14:13:05 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> do_assign_storage(), sclp_attach_storage() and sclp_setup_memory()
> allocate the SCCBs used to assign, attach and query standby memory.
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
> Replace use of get_zeroed_page() with kzalloc(), __get_free_page() with
> kmalloc() and free_page() with kfree().
>=20
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@re=
dhat.com
> Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-s390-sclp-=
ready-v2-0-e518c99622c6@kernel.org?part=3D13

