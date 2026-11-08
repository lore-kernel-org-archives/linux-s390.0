Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794179281;
	b=0stiE8jXwmRwtCkXZtxrUmWTyjEMQsDLdCHR6MPJTvU1J2jz9+aDXC15E6DjGHJYK4GC
	 oEbeBAZ+x1vJjZgQYycj0HXo48mu6I6pqyGgeKwmveYrE+ax67O36DjGwrNz6/p3Xywwk
	 fMUYk78ODzvKG8Q45q6x+klx5iv9QzVKMzIXUCOrcd2KmXmOcERvUjwZwz4mIXm0qJdkH
	 muPjCXvJXkC8ZlnHhHDMFDsp/H9pvfnWnAZuVBm/dYm1Gm82QLed44r2PCqT4nVn1IlXD
	 dXNCi2YKeGbeUpLPVjEjaUryoWCbpsyGoX/Zs5SMW1kvAalw4CuafQoHtn7ecQZxEYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794179281;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=l2DDcpsWNm6l2UIWJSBzasAS5V+IM+PpF/x5aMvN7nU=;
	b=wGYEYpQDfhOeSTqMFN1n3QgIjBBiu0wj+qUYv+BI3y5L2DM4RbUw+Ly+WzNk9zF2vAFm
	 OZXNEqH2ruyZaa0puTBDVibI7pIGLHNSPGWT3ZYfA0pHrmRbJ1aDTD4G3jRO0vzdPBuFa
	 Wqfy50HWJPs2RADsZSc36r2DY+b6L5UEc4cIaMzdr/Ls4tm4Ji+fq0s+GhiXvnCEEIZGX
	 WKNb3DeDMqdso+M/R1fMBAVxBhHDChqmJyAJrdvAath6jNUmFLPhyJEO/Vl9dNutvA1sa
	 kzQhZRPx+4Xzh78XeuxKGITyBOaD2NtuNk6OyuyoTlFg0XtTxB75y6xl0U5ziLfKL7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T5A5pDo4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29925606A31C
	for <linux-s390@vger.kernel.org>; Sun,  8 Nov 2026 23:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T5A5pDo4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A201F0089F;
	Sun,  8 Nov 2026 23:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794179280;
	bh=l2DDcpsWNm6l2UIWJSBzasAS5V+IM+PpF/x5aMvN7nU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T5A5pDo4tZnj/aHWPHkjgW++mfS/WgdrifNbfRw2PmOKR3AuG30F2gsApD6pDOort
	 mtH3F4dNmMtDMuLyEIFidFdDnxAN0Wo9NgYi/ztIX3Wyp2Q+IvA20q7RCdgSaTeAkQ
	 voNn5Nqq9yPNbzr0MZN1VTXfFjAGFED92AMdFo6WOhmzsQUf6BB3mv1eD/iU2mayWY
	 6z6WAlG+VzMGdjlUOX5hzHDRZAIAsSa4gA8pNggahMJSLDzqToVkrJ7KbPoyF3BY+6
	 UFxXK0PiNEQnQZ8xm80wofr9GvekuUFWW35LLj1MGlJBr6zhWr9p5WeZhk0SGGDrLk
	 bQX1UVZ7fbTFg==
Message-ID: <sashiko-outbox-204151@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/9] xen/sys-hypervisor: Add release callback to
 hyp_sysfs_kobj_type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261108223913.3624571-7-irogers@google.com>
References: <20261108223913.3624571-1-irogers@google.com>
 <20261108223913.3624571-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 23:08:00 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> hypervisor_init() in drivers/base/hypervisor.c creates hypervisor_kobj
> with kobject_create_and_add() (which allocates a dynamic kobject using
> dynamic_kobj_ktype), and hypervisor_subsys_init() in
> drivers/xen/sys-hypervisor.c then overwrites hypervisor_kobj->ktype with
> &hyp_sysfs_kobj_type, which had no .release callback.
>=20
> Add hyp_sysfs_release() calling kfree(kobj) to preserve the dynamic
> kobject release behavior.
>=20
> Fixes: cff7e81b3dd7 ("xen: add /sys/hypervisor support")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108223913.3624=
571-1-irogers@google.com?part=3D6

