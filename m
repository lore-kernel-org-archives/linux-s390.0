Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793141117;
	b=40iBttYq/WCy+SHHa1+gfRt9JLEECCzbM1FIbdWl5Qndo1ayoTqWgtlEszJwAUV2lVg9
	 V1APv7eYCOZ1KeRua0pWNcIBU8vTEnXjztxkx3+d9+uWKuaS3VscEfX+2DfPLbCU6w7oy
	 bvMMjrpOME0Zq/L1qYTf+q+PyM2nznirb9IBwngtcTM4laAl980WOVxNGtQQXvHfTNsvk
	 SxHa2utghU9vDbVa6AtnkCrH0c4qXzYf3pQeIrYHrJskQ/V+8RD7p3SXdqvGy1Jmkb78n
	 9F7TwXupzRNbKGi8ir2bG6xP78S8fRowkHwYt/v/+LoO6ENYo1py265b9IkabLObXwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793141117;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ge8wQrSctNgq+InjgGnUHJf4lvqXX3f0kK6as2obkmI=;
	b=0ZBkoM/VVx6+gkLYbiGoNU0ABztSYX52ohnUYyf6Es1Nqp2H0z9vBE4hOxij+n2zDVX5
	 H/wbl5BkMvhgH86FvLsmifa6WzaCinN0o+QWAlgOGFJQRtemVSTCQnqwMd+oC5sEKJaaf
	 9lPGRkHJc4LM836Znm2MBI3XTm2MIgFG0BvnmnUphuCnWlB0AF5liLzdRKZ/Za7wO/O/8
	 Kfelo+AUm5D5syCjkx5w94i4qNdmGtnjyOnN4dH1UxLetbmiaXHp01/9wYXmZUnBnn/Al
	 BvPEOIf/FJOoiDyQ8+omUhxM0f4Q74e9oHVJ5cMmoiQeWmapZv/wLgt84ISR+WJSRuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kJlxsqHF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465F1606A31E
	for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 22:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kJlxsqHF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A1DD1F01825;
	Tue, 27 Oct 2026 22:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793141116;
	bh=ge8wQrSctNgq+InjgGnUHJf4lvqXX3f0kK6as2obkmI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kJlxsqHFN+KIpitUEdBRYhLrlCP4hXjJIXYx8gOW7dMOLwAE6xORQpTtvBuAmvOLm
	 nFm0hz18exuDCpWhalfkCwXXFk0VpfaEW2tVIvd37uTNUUUbiDICCdOCmN0k3Pxe1k
	 8Xia/eOnnL5uxzM/qxrBTWQKZg+OqEbP6dMmSN1vG3a04a3K7iod15bKwK+6HHF8xL
	 zYlJ081BH8i1JWbgzJJXuPsGBEKwWQQc2wMB9xQ3oYiD6N6e0Q+jKRA9lyGUblO+bD
	 ut31hG7jJscU1btVLJ5Zc+D+AaHp/X7Hb2adop/XxIpgtAxgGvQE3u9LPOVt9IB+HU
	 w6704LQUpgYFQ==
Message-ID: <sashiko-outbox-187175@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 8/9] drm/amdkfd: Free queue in procfs_queue_type
 kobject release callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261027223847.652884-9-irogers@google.com>
References: <20261027223847.652884-1-irogers@google.com>
 <20261027223847.652884-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 22:45:16 +0000
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
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027223847.6528=
84-1-irogers@google.com?part=3D8

