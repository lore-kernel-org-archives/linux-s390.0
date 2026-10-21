Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792579962;
	b=q64Ug159uen6iVwVQOqRN4xhpiN+O4uAwGj8qXcLqqnScdsZqX/ysOPDeoA8+Iv+LKCt
	 DYJ7DrImMxbqgrDiIXo013y/nPrr4gVjvfLHCyVmQQ6OWPqZgnq5AUCKgdcccnBmnKMi6
	 y/CCiKYyRmblPkb/aPpMrkdVyH2WeZtuBuN4gfXc2lme8c/kE3sqjkcGSHIk+5xJfTQTd
	 TIeQ+WFZUuytoAHuL3ibK6kjpdIoCAaZtEYpsEub0YUocyxJ+VE3mj+ClRJ92euwKO0sX
	 Y7OBQLGBehJAkjNNCTuPPeiGi5Gpl1ap5SncHQhEBxIaaWRJYbeOK3flnYuZWhjDz6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792579962;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/AGMrSKzi92z5OdgcX/JjVuo06ukzyT9QHNl6pEJt/g=;
	b=Sx5zidISLhXtElvSFRqnYN4HVMXL7ohRzibod1Bx6y0N5J5Er/188GHIqdeXzvZWJ0RS
	 WSzCFVxb/Nl1SA08UhCGQMTrXBWlLbQ6KhyWR2PlHYDm6pTz+SG/MOwgAe15KAv53Gv3e
	 EMjPNYpshr41yVl8fr2S444Wycuc6K30+L+2tHj23o3e7b9+q7UcsNvKZ1gvbmjTxBWEh
	 diYlqUHVUm/sJQkRXlR4gF77sjQb88bpVb6Zs7V0NCaEeIYxZHBCLrhw+5zSuZmfg44fu
	 5ZvPQ/T+fyKp1vz3sIZjuNDD8JS3l72dnOBWqKkb+jVFCSEIFSPWr72JFqohWS08OPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YMbcfrMD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A11606A328
	for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2026 10:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YMbcfrMD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A5401F000D0;
	Wed, 21 Oct 2026 10:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792579961;
	bh=/AGMrSKzi92z5OdgcX/JjVuo06ukzyT9QHNl6pEJt/g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YMbcfrMDnbo7bB+gCoR7M9H2vCe1Bqh6j84JorzR3TOJw27rh84x4OFcAH557m9en
	 d0kv/fj90wE/Wx/1rghP5/RQbtjBU5nfVHAMvK3Yhf5UoS+k0RpohcB2+mfZKTQjP/
	 QlbXe2iPq4+O1sWeFG+dYhIgvPQby+Bp1yoKUF+X5HsjwG+ArEyWKFbHbpQ0MFfTgW
	 rjmPkMGY4wvSUt9WT/AhH+iLs4/l5395TgjVO2LFlnxAc++hKvK3WFiagCNlIXMq4j
	 vhp7Pd2lH9wTukjjQumqdNQU4ARTr53hEPWYwBnyQYPi82BzDyjkRZ2bwz5Dibmdk0
	 HlWeoB3INNHww==
Message-ID: <sashiko-outbox-180128@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] s390/diag204: Introduce diag204 rework
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mete Durlu" <meted@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261021-diag204ioctl-v1-1-25645b97bf4e@linux.ibm.com>
References: <20261021-diag204ioctl-v1-0-25645b97bf4e@linux.ibm.com>
 <20261021-diag204ioctl-v1-1-25645b97bf4e@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 10:52:40 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Medium] s390/diag204: premature -EBUSY in diag204_update_cache() when ca=
che is empty
- [Medium] s390/diag204: wrong break check on error in diag204_cache_replac=
e()
- [Medium] s390/diag204: missing subcode 4 fallback in diag204_probe()
- [Medium] s390/diag204: unexpected -ERESTARTSYS in diag204_store() when al=
low_busy_wait is 0
- [Low] s390/diag204: redundant work rearm after cache free in diag204_work=
_fn()
--

commit d2828ceeab655eb5035c6aab276ad1fae954baa3
Author: Mete Durlu <meted@linux.ibm.com>

s390/diag204: Introduce diag204 rework

This commit introduces a new diag204 implementation in
arch/s390/kernel/diag/diag204.c that caches diag204 data for up to one
second to rate-limit expensive hypervisor calls and frees the cache buffer
via a delayed work item after a period of inactivity.

> diff --git a/arch/s390/kernel/diag/diag204.c b/arch/s390/kernel/diag/diag=
204.c
> new file mode 100644
> index 0000000000000..8e1909e6caf90
> --- /dev/null
> +++ b/arch/s390/kernel/diag/diag204.c

[ ... ]

> +static void diag204_work_fn(struct work_struct *work)
> +{
> +	mutex_lock(&diag204_mutex);
> +	if (!READ_ONCE(g_cache.buf))
> +		goto unlock;
> +	if (diag204_is_cache_valid(DIAG204_CACHE_EXPIRY))
> +		goto rearm;
> +	if (READ_ONCE(g_cache.updating))
> +		goto rearm;
> +	diag204_set_cache(NULL);
> +rearm:
> +	diag204_schedule_work();
> +unlock:
> +	mutex_unlock(&diag204_mutex);
> +}

[Severity: Low]
In diag204_work_fn(), when the cache has expired and is not being updated,
diag204_set_cache(NULL) frees g_cache.buf and clears the pointer, but then
execution falls through to the rearm label and calls diag204_schedule_work(=
).

Should this jump to unlock after diag204_set_cache(NULL) instead of
scheduling another delayed work run 10 seconds later when the cache is
already empty?

> +
> +static int diag204_cache_new(void *buf, unsigned long subcode)
> +{
> +	int rc;
> +
> +	lockdep_assert_held(&diag204_mutex);
> +	/*
> +	 * Don't allow busy wait or busy looping when g_cache.buf has
> +	 * no data yet. We first need a valid data cache before we
> +	 * can do updates with busy looping.
> +	 */
> +	rc =3D diag204(subcode, g_info.pages, buf);
> +	if (rc < 0)
> +		return rc;
> +	diag204_set_cache(buf);
> +	return rc;
> +}
> +
> +static int diag204_cache_replace(void *buf, unsigned long subcode, int a=
llow_busy_wait)
> +{
> +	int rc;
> +
> +	lockdep_assert_held(&diag204_mutex);
> +	if (!allow_busy_wait) {
> +		rc =3D diag204(subcode, g_info.pages, buf);
> +	} else {
> +		/*
> +		 * Unlock before BUSY loop so updater can sleep, we rely on
> +		 * g_cache.updating flag here for synchronising with diag204
> +		 * work function and other diag204 callers.
> +		 */
> +		mutex_unlock(&diag204_mutex);
> +		do {
> +			rc =3D diag204(subcode, g_info.pages, buf);
> +			if (rc >=3D 0)
> +				break;
> +			if (signal_pending(current)) {
> +				mutex_lock(&diag204_mutex);
> +				return -ERESTARTSYS;
> +			}
> +			schedule_timeout_interruptible(DIAG204_BUSY_WAIT);
> +		} while (rc =3D=3D -EBUSY);

[Severity: Medium]
In diag204_cache_replace(), when allow_busy_wait is set, the retry loop only
breaks early on rc >=3D 0.

If diag204() fails with a negative error other than -EBUSY (such as
-EOPNOTSUPP or -EINVAL), won't this loop either overwrite the error with
-ERESTARTSYS if a signal is pending, or sleep unnecessarily for
DIAG204_BUSY_WAIT before checking the loop condition? Should the break
condition check for rc !=3D -EBUSY instead?

> +		mutex_lock(&diag204_mutex);
> +	}
> +	if (rc < 0)
> +		return rc;
> +	diag204_set_cache(buf);
> +	return rc;
> +}
> +
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
> +	if (!READ_ONCE(g_cache.buf))
> +		rc =3D diag204_cache_new(buf, subcode);
> +	else
> +		rc =3D diag204_cache_replace(buf, subcode, allow_busy_wait);

[Severity: Medium]
In diag204_update_cache(), DIAG204_BIF_BIT is set in subcode when
g_info.has_bif && allow_busy is true, before checking whether g_cache.buf is
NULL.

When g_cache.buf is NULL (on the initial call to diag204_store() or after
diag204_work_fn() has freed the expired cache) and a caller passes
allow_busy =3D 1, diag204_cache_new() is called with DIAG204_BIF_BIT set in
subcode.

The comment in diag204_cache_new() notes that busy waiting or busy looping
should not be used when g_cache.buf has no data yet, and diag204_cache_new()
does not loop on -EBUSY. If the hypervisor is busy, won't diag204() return
-EBUSY immediately instead of blocking to populate the initial cache (or
performing the requested busy wait)?

> +	WRITE_ONCE(g_cache.updating, false);
> +	if (rc < 0)
> +		diag204_free_buffer(buf);
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
> +	if (allow_busy && !allow_busy_wait) {
> +		mutex_lock(&diag204_mutex);
> +		/*
> +		 * Drop the lock if an update is ongoing, user allows to return
> +		 * BUSY without waiting
> +		 */
> +		if (READ_ONCE(g_cache.updating)) {
> +			mutex_unlock(&diag204_mutex);
> +			diag204_schedule_work();
> +			return -EBUSY;
> +		}
> +	} else {
> +		/* Wait for the ongoing update to end */
> +		while (1) {
> +			mutex_lock(&diag204_mutex);
> +			if (!READ_ONCE(g_cache.updating))
> +				break;
> +			mutex_unlock(&diag204_mutex);
> +			if (signal_pending(current))
> +				return -ERESTARTSYS;
> +			schedule_timeout_interruptible(DIAG204_BUSY_WAIT);
> +		}
> +	}

[Severity: Medium]
Can diag204_store() unexpectedly return -ERESTARTSYS when called with
allow_busy =3D 0 and allow_busy_wait =3D 0?

If one thread calls diag204_store() with allow_busy =3D 1 and
allow_busy_wait =3D 1 while g_cache.buf is non-NULL and expired,
diag204_update_cache() -> diag204_cache_replace() sets g_cache.updating =3D=
 true
and drops diag204_mutex while sleeping in its -EBUSY loop.

If a second thread concurrently calls diag204_store(buf, 0, 0), the
allow_busy && !allow_busy_wait check is false, so it enters the else branch
above, sees g_cache.updating =3D=3D true, drops diag204_mutex, and returns
-ERESTARTSYS if a signal is pending on current, even though the caller did =
not
request an interruptible wait.

In the follow-up commit "s390/diag204: Replace diag204 users with new
implementation", callers such as hypfs_diag_create_files() (via
hypfs_write_iter() after hypfs_delete_tree() has already removed the hypfs
directory tree, and via hypfs_fill_super()) and diag204_get_data() in
arch/s390/kernel/sthyi.c (via sthyi_fill(), including KVM's handle_sthyi()
intercept handler) call diag204_store() with allow_busy =3D 0 and
allow_busy_wait =3D 0 and do not expect -ERESTARTSYS, which can leave the h=
ypfs
tree deleted or abort STHYI emulation after SIE has already advanced the gu=
est
PSW.

[ ... ]

> +/*
> + * diag204_probe() has to find out, which type of diagnose 204 implement=
ation
> + * we have on our machine. Currently there are three possible scanarios:
> + *   - subcode 4   + simple data format (only one page)
> + *   - subcode 4-6 + extended data format
> + *   - subcode 4-7 + extended data format
> + *
> + * Subcode 5 is used to retrieve the size of the data, provided by subco=
des
> + * 6 and 7. Subcode 7 basically has the same function as subcode 6. In a=
ddition
> + * to subcode 6 it provides also information about secondary cpus.
> + * In order to get as much information as possible, we first try
> + * subcode 7, then 6 and if both fail, we use subcode 4.
> + */
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
> +	} else {
> +		/* extended data format is not available, fallback to simple */
> +		pages =3D 1;
> +		buf =3D __diag204_allocate_buffer(pages);
> +		if (!buf) {
> +			rc =3D -ENOMEM;
> +			goto fail_alloc;
> +		}
> +		type =3D DIAG204_INFO_SIMPLE;
> +		if (diag204(DIAG204_SUBC_STIB4 | type, pages, buf) >=3D 0) {
> +			subcode =3D DIAG204_SUBC_STIB4;
> +			goto out;
> +		}
> +	}
> +	rc =3D -EOPNOTSUPP;
> +	goto fail_store;

[Severity: Medium]
In diag204_init() -> diag204_probe(), the fallback to DIAG204_INFO_SIMPLE w=
ith
DIAG204_SUBC_STIB4 is inside the else branch of if (pages > 0).

If the DIAG204_SUBC_RSI call returns pages > 0, but both DIAG204_SUBC_STIB7
and DIAG204_SUBC_STIB6 fail, won't diag204_probe() skip the DIAG204_SUBC_ST=
IB4
fallback and fail with -EOPNOTSUPP, contrary to the function comment and the
previous probe logic in arch/s390/hypfs/hypfs_diag.c?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021-diag204ioc=
tl-v1-0-25645b97bf4e@linux.ibm.com?part=3D1
