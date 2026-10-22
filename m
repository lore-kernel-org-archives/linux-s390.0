Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792670720;
	b=t6XOBShMyftMqkBGbaOfRBcutD1Z8liEflSFhbbAQ/bHf4+l3U1SiOhRJfOBiEpnD8Xn
	 cwrfODJB7i05mJmuFFx6cfCgvbhvQzOvzu2Uyj2SqfHwWWWqKy7o6nJ1odgXcsPyZWSjs
	 ZQbViKiQqpjeF7M3pEVDeYthDbBDIQurHv3uOSuCjx7ZovJFhMvuqLCnSxkc0vmwt02Yf
	 qrxSb2pQdXMyRcFMjNo545ePpaBHNuAAkVuMAh4ruXq6q8DPhaRBWJ6lNwjSsMzbR0hlT
	 EbiGg+DJpHIWfRa0HipaWfz7S5nHsvaoSpbMnZl13UDqpqOH315QPQgA+/m3rBp5UkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792670720;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Xn2oOoyP3k3eXsSZD4vW+AvfcYpdsHhxuhnPFQzBvKk=;
	b=Ffpu6kBE+ldaukc4CZAIDN+OUgqs8UzCNrle8/z6amN+mMuc4qyuqdDpwEPdcJpJ73cs
	 B20ZqUFrgl6HxgCQv5HT7rh1uCn9ObP+8Ygmsuvf/WYxMiVKfGwhM6X2QW7eVHytN2+3S
	 Ytm27rtGUJ2aLcDU8iQhVycbBkzxBF5MWjK6oL0c1lSWe8XnSZWvGeYtN8+g/VnjHKKPY
	 dKyIQ5jL8GZeCu1GF36HRX0Qn7RSi6msF6KKk40ECLy7Gkocx6ukIdFLond/k3rZTtZjP
	 ReZ6fr2JzHIxdephH8oM39Q6Uj/+gvyfNtn8K649xiAYrWkN6gwS3F2hw4YLFM/x1bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="c0jjnk/f";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BF8606A319
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 12:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c0jjnk/f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8EDD1F000C1;
	Thu, 22 Oct 2026 12:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792670719;
	bh=Xn2oOoyP3k3eXsSZD4vW+AvfcYpdsHhxuhnPFQzBvKk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c0jjnk/fI2kyvN52OKVgIts6txXSLr1fWD6yre3UIunD+/CxWO8DZr2zrlABn4Pb8
	 KS8Y+KqXBUJ3Aezaer0TM2AUSTu2ugydIejF8a2x/W2lmXjFmksgP0/mSb6LSIVq9/
	 3/g7bVlz9gW6S8cpDnCaByBqOGGJRNFSiBWXHu7/Bvwoix2Lg5Q0VYx+qDAv0LYg5Y
	 xFVd+O7AE+U07xUltMsD/OrdZ3Gy2JnTRy8kjvFCGPv9gnlui3Hxy5k5uXb6XaCvFi
	 1Gi2sSRrQdRDX7F1KUfTWZZvVs1FYFLQX5JCBNEphqeqZmct4BsLAGddcKgDNrxgND
	 1Grd5NGQWi3tA==
Message-ID: <sashiko-outbox-181412@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] s390/diag204: Introduce diag204 rework
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mete Durlu" <meted@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261022-diag204ioctl-v2-1-7e5a9d1cd21a@linux.ibm.com>
References: <20261022-diag204ioctl-v2-0-7e5a9d1cd21a@linux.ibm.com>
 <20261022-diag204ioctl-v2-1-7e5a9d1cd21a@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 12:05:18 +0000
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
- [High] s390/diag204: unlocked cache access and mutex unlock in diag204_st=
ore()
- [Medium] s390/diag204: memory leak of extended buffer in diag204_probe()
--

commit f46a8c5c5620f265bdccaca5580ec5409ce81f8b
Author: Mete Durlu <meted@linux.ibm.com>

s390/diag204: Introduce diag204 rework

This commit introduces a caching mechanism in arch/s390/kernel/diag/diag204=
.c
to limit diag204 calls to at most once per second across all users. A delay=
ed
work function frees the cached buffer when diag204 data is not fetched with=
in
the expiration window.

> diff --git a/arch/s390/kernel/diag/diag204.c b/arch/s390/kernel/diag/diag=
204.c
> new file mode 100644
> index 0000000000000..7f366ea12a673
> --- /dev/null
> +++ b/arch/s390/kernel/diag/diag204.c
> @@ -0,0 +1,290 @@

[ ... ]

> +static void diag204_set_cache(void *buf)
> +{
> +	diag204_free_buffer(READ_ONCE(g_cache.buf));
> +	WRITE_ONCE(g_cache.buf, buf);
> +	if (!buf)
> +		WRITE_ONCE(g_cache.timestamp, 0);
> +	else
> +		WRITE_ONCE(g_cache.timestamp, ktime_get());
> +}

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
> +	WRITE_ONCE(g_cache.updating, true);
> +	mutex_unlock(&diag204_mutex);
> +	do {
> +		rc =3D diag204(subcode, g_info.pages, buf);
> +		if (rc !=3D -EBUSY || !allow_busy_wait)
> +			break;
> +		if (signal_pending(current)) {
> +			rc =3D -ERESTARTSYS;
> +			break;
> +		}
> +		schedule_timeout_interruptible(DIAG204_BUSY_WAIT);
> +	} while (allow_busy_wait);
> +	mutex_lock(&diag204_mutex);
> +	if (rc >=3D 0) {
> +		diag204_set_cache(buf);
> +		diag204_schedule_work();
> +	} else {
> +		diag204_free_buffer(buf);
> +	}
> +	WRITE_ONCE(g_cache.updating, false);
> +	return rc;
> +}

[ ... ]

> +int diag204_store(void *buf, int allow_busy, int allow_busy_wait)
> +{
> +	int rc;
> +
> +	if (!diag204_is_available())
> +		return -EOPNOTSUPP;
> +	if (!allow_busy && allow_busy_wait)
> +		return -EOPNOTSUPP;
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
> +	} while (allow_busy_wait);
> +	if (!diag204_is_cache_valid(DIAG204_CACHE_EXPIRY))
> +		rc =3D diag204_update_cache(allow_busy, allow_busy_wait);
> +	if (rc >=3D 0)
> +		memcpy(buf, READ_ONCE(g_cache.buf), diag204_get_buf_size());
> +	mutex_unlock(&diag204_mutex);
> +	return rc;
> +}

[Severity: High]
In arch/s390/kernel/diag/diag204.c, what happens in diag204_store() when a
caller passes allow_busy =3D=3D 0 and allow_busy_wait =3D=3D 0 while anothe=
r thread
is concurrently updating the cache in diag204_update_cache()?

While the first thread is inside diag204_update_cache(), it sets
g_cache.updating to true and drops diag204_mutex across the diag204() call:

	WRITE_ONCE(g_cache.updating, true);
	mutex_unlock(&diag204_mutex);

If a second thread calls diag204_store(buf, 0, 0) during that window, it
acquires diag204_mutex, sees READ_ONCE(g_cache.updating) is true, and calls
mutex_unlock(&diag204_mutex). Because allow_busy is 0, the -EBUSY return is
not taken. The thread then checks signal_pending(current) (returning
-ERESTARTSYS even though allow_busy_wait is 0) or sleeps in
schedule_timeout_interruptible(DIAG204_BUSY_WAIT).

At the end of the loop:

	} while (allow_busy_wait);

Because allow_busy_wait is 0, the loop terminates without holding
diag204_mutex and without rechecking g_cache.updating.

The second thread then calls diag204_is_cache_valid() and
diag204_update_cache() (both of which assert lockdep_assert_held(&diag204_m=
utex),
with diag204_update_cache() also calling mutex_unlock(&diag204_mutex)), cop=
ies
from g_cache.buf via memcpy() while diag204_set_cache() or diag204_work_fn()
may concurrently free or clear g_cache.buf via vfree(), and finally calls
mutex_unlock(&diag204_mutex) at the end of diag204_store() on an unheld or
other-thread-held mutex.

Should the loop in diag204_store() keep waiting until g_cache.updating is
false when allow_busy is 0, or how should non-busy callers synchronize with
an in-progress update?

> +static int diag204_probe(void)
> +{
> +	unsigned long subcode, type;
> +	int pages, rc;
> +	void *buf;
> +
> +	pages =3D diag204((unsigned long)DIAG204_INFO_EXT |
> +			(unsigned long)DIAG204_SUBC_RSI, 0, NULL);
> +	if (pages > 0) {
> +		buf =3D __diag204_allocate_buffer(pages);
> +		if (!buf) {
> +			rc =3D -ENOMEM;
> +			goto fail_alloc;
> +		}
> +		type =3D DIAG204_INFO_EXT;
> +		if (diag204(DIAG204_SUBC_STIB7 | type, pages, buf) >=3D 0) {
> +			subcode =3D DIAG204_SUBC_STIB7;
> +			goto out;
> +		}
> +		if (diag204(DIAG204_SUBC_STIB6 | type, pages, buf) >=3D 0) {
> +			subcode =3D DIAG204_SUBC_STIB6;
> +			goto out;
> +		}
> +	}
> +	/* extended data format is not available, fallback to simple */
> +	pages =3D 1;
> +	buf =3D __diag204_allocate_buffer(pages);

[Severity: Medium]
In diag204_probe() in arch/s390/kernel/diag/diag204.c, if the
DIAG204_SUBC_RSI call returns pages > 0 and __diag204_allocate_buffer(pages)
succeeds, but both the DIAG204_SUBC_STIB7 and DIAG204_SUBC_STIB6 calls fail,
does falling through to the simple format fallback overwrite buf without
calling vfree(buf) first and leak the extended vmalloc buffer?

[ ... ]

> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-diag204ioc=
tl-v2-0-7e5a9d1cd21a@linux.ibm.com?part=3D1
