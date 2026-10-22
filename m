Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685295;
	b=4tNVqH+bkm/B7IsH9T5K4GbOX+53yqiD3igEHMlWYRt9gTizaWKq0IPK4ok+G9yct1NH
	 ScMgtWufTO0jdSeoBKywRWKDw8L81zsxmw1uHsEw4Q/h49/5WBJCZSEtUeGHk5kBoC/dT
	 8I/ch/TqQg6BV8NjI8efRhiEM3uWU7m+i3IVC9HOpR2jtZH6GGy0KA2T8QBSEiJBmbL2E
	 6k3cG9Z03uQEPU4ztJoGCc27tfzzCJiDR7hxlIdFDX84qU4GksqJ1tOOBnZyQrybAEd9h
	 ttnVomXe9ebSRp6BTCNgP7QjCE2TKGWy3mE0WUG5x4Sd1foCkBZp1Rfq1dhSFh/eBMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685295;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wZrBvcb1OHz/U9JnMUxhETwNxoESyfxrM6ZCLAegT3M=;
	b=WT79/rPrdVYt0Gakm5N/Gwow/NXPhrFHrUq11yBFC7WSNnLxJj4iGNPl4NpWdu8G12ov
	 ns6UpQGLZJfBH98K/QuyttBmalcW4scOBGVMyrn7eMWGLVV2dLtHHjC/v3gSwCHS0P0ET
	 tqO9VqeC01/sdssZOLVEAbKBF1CNkLtahoZJlh3mQtU8NwmzaKS4J64opkXlNUSSingg0
	 A+hwhzqFomXAbu0ABTOUMzQBwjbeh4vfLwPYGrog35UJV1hA5RxLA0GXX0yshhbZ3ohow
	 YboADeMII/75b/pMspf8WC7kaQCD5VrY28IrbM9iHAE+LcnuW40eCJiImhInjnhQitQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=igdxDn8m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE33E606A31A
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 16:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=igdxDn8m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB641F01825;
	Thu, 22 Oct 2026 16:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792685294;
	bh=wZrBvcb1OHz/U9JnMUxhETwNxoESyfxrM6ZCLAegT3M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=igdxDn8mDZm/EpkOkFICaSDz5VsYLFZoFSB+TS1nAjy0f254MYKBNOs0lPl76WGq7
	 PMxmsPZAGBEaspAbqkhMzpG347Vhd/qoayk5S6CBCxl2i/Ewa63yTe+gWhqbYR3w+R
	 POIeCbwXK9ppQIMuNZ5dHuMYUnzb1r1JHGX18o0SpQTT3BNf6E0hHa0gMJdFlaCLbQ
	 XJ9Xa4/ck9FjU3ogEvOQB/7MGqjIlb8T+rR3qr1/Z8l53/zPJV+azi7Tq/rfphwNYW
	 Z4L1k66bn19+Ke4wIf5oLI9g4hRz7YyOXG056/f7PAdDhmRj0JYkVYfrrXjimMnFXx
	 MkUbG92wR4LeA==
Message-ID: <sashiko-outbox-181756@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] s390/diag204: Introduce diag204 rework
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mete Durlu" <meted@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261022-diag204ioctl-v3-1-c25e7147736e@linux.ibm.com>
References: <20261022-diag204ioctl-v3-0-c25e7147736e@linux.ibm.com>
 <20261022-diag204ioctl-v3-1-c25e7147736e@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 16:08:13 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] s390/diag204: diag204_store() rejects allow_busy when BIF is unsup=
ported
- [Medium] s390/diag204: diag204_store() returns -ERESTARTSYS when allow_bu=
sy_wait is 0
--

commit 4b4fb3ec71dc3de5bb7d6e208cc41238367d2b59
Author: Mete Durlu <meted@linux.ibm.com>

s390/diag204: Introduce diag204 rework

This commit introduces a caching layer for diagnose 204 calls in
arch/s390/kernel/diag/diag204.c to limit hardware invocations to at most
once per second, freeing the cache buffer via delayed work when idle.

> diff --git a/arch/s390/kernel/diag/diag204.c b/arch/s390/kernel/diag/diag=
204.c
> new file mode 100644
> index 0000000000000..f447bfaf756b4
> --- /dev/null
> +++ b/arch/s390/kernel/diag/diag204.c
> @@ -0,0 +1,293 @@

[ ... ]

> +static int diag204_update_cache(int allow_busy, int allow_busy_wait)
> +{
> +	unsigned long subcode;
> +	void *buf;
> +	int rc;
> +
> +	lockdep_assert_held(&diag204_mutex);
> +	buf =3D diag204_allocate_buffer();
> +	if (!buf)
> +		return -ENOMEM;
> +	subcode =3D g_info.type | g_info.subcode;
> +	if (g_info.has_bif && allow_busy)
> +		subcode |=3D DIAG204_BIF_BIT;

[ ... ]

> +int diag204_store(void *buf, int allow_busy, int allow_busy_wait)
> +{
> +	int rc;
> +
> +	if (!diag204_is_available())
> +		return -EOPNOTSUPP;
> +	if (!allow_busy && allow_busy_wait)
> +		return -EOPNOTSUPP;
> +	if (allow_busy && !g_info.has_bif)
> +		return -EINVAL;

[Severity: High]
Should diag204_store() in arch/s390/kernel/diag/diag204.c return -EINVAL wh=
en
allow_busy is set and g_info.has_bif is false, or should it fall back to a
regular blocking diagnose 204 call?

In diag204_update_cache(), the code checks both g_info.has_bif and allow_bu=
sy
before setting DIAG204_BIF_BIT:

	subcode =3D g_info.type | g_info.subcode;
	if (g_info.has_bif && allow_busy)
		subcode |=3D DIAG204_BIF_BIT;

Because diag204_update_cache() is only called from diag204_store(), the ear=
ly
return of -EINVAL in diag204_store() when allow_busy && !g_info.has_bif mak=
es
the g_info.has_bif check in diag204_update_cache() unreachable when
!g_info.has_bif.

When the follow-up change ("s390/diag204: Replace diag204 users with new
implementation") converts existing callers:

- dbfs_d204_create() in arch/s390/hypfs/hypfs_diag.c and
  hypfs_diag_create_files() in arch/s390/hypfs/hypfs_diag_fs.c both call
  diag204_store(..., 1, 1) unconditionally.
- diag204_get_data() in arch/s390/kernel/sthyi.c calls
  diag204_store(diag204_buf, diag204_allow_busy, 0), where
  diag204_allow_busy is true on every cache refresh after the initial fill.

On systems where !sclp.has_diag204_bif, will this cause hypfs initializatio=
n,
debugfs diag_204 reads, and sthyi cache updates to fail with -EINVAL instead
of falling back to a non-busy-indication diag204 call?

> +	if (!buf)
> +		return -ENOMEM;
> +	rc =3D 0;
> +	do {
> +		mutex_lock(&diag204_mutex);
> +		/* Exit loop with lock taken if there is no concurrent update */
> +		if (!READ_ONCE(g_cache.updating))
> +			break;
> +		mutex_unlock(&diag204_mutex);
> +		if (allow_busy && !allow_busy_wait)
> +			return -EBUSY;
> +		if (signal_pending(current))
> +			return -ERESTARTSYS;
> +		schedule_timeout_interruptible(DIAG204_BUSY_WAIT);
> +	} while (1);

[Severity: Medium]
Can this wait loop in diag204_store() in arch/s390/kernel/diag/diag204.c
unexpectedly sleep interruptibly and return -ERESTARTSYS when the caller
passes allow_busy =3D 0 and allow_busy_wait =3D 0?

If one thread is inside diag204_update_cache() with g_cache.updating set to
true while dropping diag204_mutex, a second thread calling
diag204_store(buf, 0, 0) will see READ_ONCE(g_cache.updating) as true:

	if (allow_busy && !allow_busy_wait)
		return -EBUSY;
	if (signal_pending(current))
		return -ERESTARTSYS;
	schedule_timeout_interruptible(DIAG204_BUSY_WAIT);

Because allow_busy is 0, the first condition is false and the loop checks
signal_pending(current) and returns -ERESTARTSYS even though allow_busy_wait
was not requested.

When the follow-up commits ("s390/diag204: Replace diag204 users with new
implementation" and "s390/diag: Add diag204 IOCTL to diag misc device") are
applied, callers such as diag204_buf() or the guest sthyi path:

handle_sthyi()
  -> sthyi_fill()
    -> sthyi_update_cache()
      -> fill_dst()
        -> diag204_get_data(false)
          -> diag204_store(diag204_buf, 0, 0)

can hit this path when a signal or TIF_NOTIFY_SIGNAL is pending during a
concurrent cache update. In handle_sthyi(), an unexpected -ERESTARTSYS retu=
rn
from sthyi_fill() when the sthyi cache is not yet populated causes
handle_sthyi() to return before filling the guest buffer or setting the gue=
st
condition code after the guest instruction pointer has already been advance=
d.

Should the concurrent update wait in diag204_store() avoid interruptible
sleep and -ERESTARTSYS when !allow_busy_wait?

> +	if (!diag204_is_cache_valid(DIAG204_CACHE_EXPIRY))
> +		rc =3D diag204_update_cache(allow_busy, allow_busy_wait);
> +	if (rc >=3D 0)
> +		memcpy(buf, READ_ONCE(g_cache.buf), diag204_get_buf_size());
> +	mutex_unlock(&diag204_mutex);
> +	return rc;
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-diag204ioc=
tl-v3-0-c25e7147736e@linux.ibm.com?part=3D1
