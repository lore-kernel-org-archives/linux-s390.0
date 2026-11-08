Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794179718;
	b=O7vBCbryc3DiWfWvAsSZxIiaQSYlwKnbT9zkxn0yOQJr34g5OzLAonAj3eBHhgWmEbxU
	 uVI5FWthL+n2JwS1cE9RyTgIXUQFF6mRegyyUWCkEHPZsVS3T0A8AEymlZaWxK4fd8/Aw
	 7HkKCe11zhelnXr8bBbBhmvjF8p7seiz8Uj54k/xe5Q9zNSZaamGHsqa5U2Z2N3Vsd9ER
	 ZvSHnCL5xjJKQY68R8iv8RVsEfwII4bfX0fcpUXfwt+MS+uCaeAKwmJqKAZi5Bp4bnurk
	 1OmLIDvF7hbiD7OAJx9pW0uLSoSLAZTL9z0utkIsyTduI7RD4YQyoXF6KjHsNmvpQ0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794179718;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7/b3TFPlclLYtXcXdX7ZWXulHYFrWQ/YZ9zLq2/px5o=;
	b=1Que2G9Q7nIX1vvoll1DEig/wmyp9AmPn87lMOnPQpfafCY/j5dxKZf7a2NtnCKRX7vM
	 l+aTGp0dezIywy42ZmTvdLR0r8r50jUM0695VbvJQkyNVB9qYIM9q5cYFlhVNAvCVEHcd
	 GWnM1fERcWk75B9ALA43UYUdQN4EgXoP0dY8H2RiSt9z6eYgL6jL6m3sTNOxQgHfyYheS
	 E9OSwdVXoAvSqPfD/bd6u23vBQi2endI6JWTXhvNc3kjGe/cKBkFukfedTPXpsGSqKb5R
	 3OEPjbGr6eM6z5sApGzNaJJWIV0sJKe+w0e3uA9pcUevmNxITAlLk4ErHS1NIoMWx5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IOcKUE1T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7F8606A323
	for <linux-s390@vger.kernel.org>; Sun,  8 Nov 2026 23:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IOcKUE1T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 296BB1F0089F;
	Sun,  8 Nov 2026 23:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794179717;
	bh=7/b3TFPlclLYtXcXdX7ZWXulHYFrWQ/YZ9zLq2/px5o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IOcKUE1TF75+XpV14s+XAzy0n1J66QTa1C8IrfTCwQwT+vr248PLSy/2BMXdtj6XW
	 i0j+dVLrUgubsw4R1ZYkfZfc2oZYq4W/HAQHr3Kf2fS17Sh4yOQwGsS9lU8LGM20tf
	 Nk06qkWXukXwF6SNXGQTmXk31EYRqP/Ac8yaHdYfpZsqvaM1bhTVg8t4HwvOm2j8jd
	 wrHh7oYGHKg5VfLzSNSUVCwiaFfR4DoEqrMVtMR4Nf2G2JAPa6JY1VvnpduKEgMNpq
	 rDwrCwbhqF4pb2p1jNdpqkXhwHxzQBgxPWE8d2IJB41dvFAPrpaLSTFEYphrv/w4dl
	 6PK2431TGLJuA==
Message-ID: <sashiko-outbox-204154@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 8/9] drm/amdkfd: Free queue in procfs_queue_type
 kobject release callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261108223913.3624571-9-irogers@google.com>
References: <20261108223913.3624571-1-irogers@google.com>
 <20261108223913.3624571-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 23:15:16 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> struct queue embeds a struct kobject (q->kobj) for procfs entries, but
> procfs_queue_type had no .release callback and uninit_queue() freed q
> immediately after kfd_procfs_del_queue() called kobject_put(&q->kobj).
> With CONFIG_DEBUG_KOBJECT_RELEASE=3Dy, this causes a use-after-free.
>=20
> Add kfd_procfs_queue_release() to free struct queue from the kobject
> release callback, change kfd_procfs_del_queue() to only remove the
> kobject from sysfs via kobject_del(), and drop the final reference in
> uninit_queue() via kobject_put(). Check q->kobj.state_in_sysfs before
> calling kobject_del() in kfd_procfs_del_queue() to avoid warnings if
> sysfs creation previously failed.
>=20
> Fixes: 6d220a7e7971 ("drm/amdkfd: Add queue information to sysfs")
> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108223913.3624=
571-1-irogers@google.com?part=3D8

