Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792670643;
	b=ekYiwztVPMUD5onbXZXyedTgoY7lQmiug+tA/oD39F6xO5P4GXJ8QbUSMuzZ27ctGkwN
	 LRmOk0440x4KS7++THFVzl6hJe/IWL+hAuTIoASWfxBI2Q2rTElMyv+pxwG3tiWVbv1Ep
	 PYhYpK0XIlGsVVgbjFKlzK2/DR4rNC0suB7OpENZzPVERSAylvo8D6x4gYzaIOwCh8FGZ
	 xCs3hI3s55hGOldpkyXoeuHSvDGC6OiHLDwzoKFzNvBeZkNQskTlbDQt6rMLavfWoVKRN
	 dPtG4Vwhvsd2jGMV1cmBUeLrw7YjQQqD2SG28OwqXMBh1HtfkcOHTYGhhfRolmiuLGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792670643;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IbQpMElBM+jgBi/8Iu3zioEMJo4s6jJpW/29NQUTfTE=;
	b=ASBkCidKEj5W3xshl3oOUD6Vbb7M/td92dar5VU0ALQJc43gNnO52VTkJuOGkABR8LMQ
	 3oJDYBkQzlXrVPETOA0xp7c4OGAZn3kwkS5yfKUv0u3GLnLNAhEDK114kACEAxTv365j9
	 PjodDOs5FExd+YM8atB4cUATkUp1Zb/0zX4Zl6pt6z01cRzKlnQO9TW/lXlwkr4vUPx6L
	 Xl0VcBsG5Vpt6mGRT1dBZ/Jn3+wjUv5dNgXTTBy62EKe5VxP6GQGOMn8azUofS3cd9/Zx
	 5ZkNYpH+328vf2FaB2LHpNdEmjJCd89Ej6qM3+cDHGUCSxowFOTMphCmW10AXEKvWKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D2Gx1Z1s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF8C606A31A
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 12:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D2Gx1Z1s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAFB21F000C1;
	Thu, 22 Oct 2026 12:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792670642;
	bh=IbQpMElBM+jgBi/8Iu3zioEMJo4s6jJpW/29NQUTfTE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D2Gx1Z1sCUB0vDU+UQIeQQdJUPjXH4U60Ss8y64Ku24DR2rMo2XukUL2o2o1W0tYn
	 3gtKVcAOUFDlbyLRgOPRC2iDmS94dbfJI5OSWG49JrT37mOX5tkv6f9cv0DSwzDZ2z
	 tM8EmNDTT8HHK+luwpBMQEy30M0FPov/FpY102OHJ/exJeL90RA5YZWKuuM+sMd1Ti
	 KdgEORAt9ZPDPHGWHRFcJQXst+ND+pEsChgw2ruVGvLifgaAGRV4bDJGB0t/cgGYrJ
	 oTvpVWueupiZcP+w1afsGGiB2YfEfGKkYBkt58Ukq0NoKW/+HtoIKce0LpNYPqRQRj
	 x9/yUUkhbR6Jg==
Message-ID: <sashiko-outbox-181410@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] s390/diag: Add diag204 IOCTL to diag misc device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mete Durlu" <meted@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261022-diag204ioctl-v2-3-7e5a9d1cd21a@linux.ibm.com>
References: <20261022-diag204ioctl-v2-0-7e5a9d1cd21a@linux.ibm.com>
 <20261022-diag204ioctl-v2-3-7e5a9d1cd21a@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 12:04:01 +0000
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
- [Critical] s390/diag: unlocked cache access and mutex unlock in diag204_s=
tore()
- [Medium] s390/diag: missing subcode metadata and non-UAPI types in diag20=
4 ioctl
--

commit 8eea5b568c2725dd27a2e3675754996596fdf2e4
Author: Mete Durlu <meted@linux.ibm.com>

s390/diag: Add diag204 IOCTL to diag misc device

This commit adds ioctl handlers to the s390 diag misc device to query the
diag204 buffer length and retrieve diag204 data from userspace.

> diff --git a/arch/s390/include/uapi/asm/diag.h b/arch/s390/include/uapi/a=
sm/diag.h
> index b7e6ccb4ff6e4..985667b2917a5 100644
> --- a/arch/s390/include/uapi/asm/diag.h
> +++ b/arch/s390/include/uapi/asm/diag.h
> @@ -22,11 +22,19 @@ struct diag310_memtop {
>  	__u64 nesting_lvl;
>  };
> =20
> +struct diag204_request {
> +	__u64 address;
> +	int allow_busy;
> +	int allow_busy_wait;
> +};
> +
>  /* Diag ioctl definitions */
>  #define DIAG324_GET_PIBBUF	_IOWR(DIAG_MAGIC_STR, 0x77, struct diag324_pi=
b)
>  #define DIAG324_GET_PIBLEN	_IOR(DIAG_MAGIC_STR, 0x78, size_t)
>  #define DIAG310_GET_STRIDE	_IOR(DIAG_MAGIC_STR, 0x79, size_t)
>  #define DIAG310_GET_MEMTOPLEN	_IOWR(DIAG_MAGIC_STR, 0x7a, size_t)
>  #define DIAG310_GET_MEMTOPBUF	_IOWR(DIAG_MAGIC_STR, 0x7b, struct diag310=
_memtop)
> +#define DIAG204_GET_LEN		_IOR(DIAG_MAGIC_STR, 0x7c, size_t)
> +#define DIAG204_GET_BUF		_IOWR(DIAG_MAGIC_STR, 0x7d, struct diag204_requ=
est)
> =20
>  #endif /* __S390_UAPI_ASM_DIAG_H */

[Severity: Medium]
During boot, diag204_probe() in arch/s390/kernel/diag/diag204.c selects
between subcodes 4, 6, and 7 and sets g_info.subcode and g_info.type
(simple vs. extended format). When userspace calls diag_ioctl() ->
diag204_buf(), the raw hardware buffer is copied to req.address via
copy_to_user() without exposing g_info.subcode (diag204_get_subcode()) or
g_info.type (diag204_get_info_type()).

Unlike dbfs_d204_create() in arch/s390/hypfs/hypfs_diag.c, which prepends
struct dbfs_d204_hdr containing d204->hdr.sc =3D diag204_get_subcode(), the
raw hardware headers (struct diag204_info_blk_hdr and
struct diag204_x_info_blk_hdr) do not contain a subcode or format field.
Because simple and extended formats have different header and entry sizes
(and subcodes 6 and 7 share the extended header layout while differing in
secondary processor reporting), how can userspace determine which subcode
or format was used to populate the buffer returned by diag204_buf()?

Also, in struct diag204_request, should allow_busy and allow_busy_wait use
fixed-width types (__u32 or __u64) instead of raw int, and should the
ioctl definition use _IOW instead of _IOWR since diag204_buf() only reads
struct diag204_request?

> diff --git a/arch/s390/kernel/diag/diag204.c b/arch/s390/kernel/diag/diag=
204.c
> index 7f366ea12a673..3450a013258fd 100644
> --- a/arch/s390/kernel/diag/diag204.c
> +++ b/arch/s390/kernel/diag/diag204.c

[ ... ]

> @@ -220,6 +222,45 @@ int diag204_store(void *buf, int allow_busy, int all=
ow_busy_wait)
>  	return rc;
>  }

[ ... ]

> +long diag204_buf(unsigned long arg)
> +{
> +	struct diag204_request __user *udata;
> +	int rc, allow_busy, allow_busy_wait;
> +	u64 address;
> +	void *buf;
> +
> +	if (!diag204_is_available())
> +		return -EOPNOTSUPP;
> +	udata =3D (struct diag204_request __user *)arg;
> +	if (get_user(address, &udata->address))
> +		return -EFAULT;
> +	if (get_user(allow_busy, &udata->allow_busy))
> +		return -EFAULT;
> +	if (get_user(allow_busy_wait, &udata->allow_busy_wait))
> +		return -EFAULT;
> +	buf =3D diag204_allocate_buffer();
> +	if (!buf)
> +		return -ENOMEM;
> +	rc =3D diag204_store(buf, allow_busy, allow_busy_wait);

[Severity: Critical]
In diag_ioctl() -> diag204_buf() -> diag204_store(), user-controlled
allow_busy and allow_busy_wait values are passed directly into
diag204_store(). What happens if a caller passes allow_busy =3D=3D 0 and
allow_busy_wait =3D=3D 0 while another thread is concurrently updating the
cache (g_cache.updating is true)?

Looking at arch/s390/kernel/diag/diag204.c:diag204_store():

	if (!allow_busy && allow_busy_wait)
		return -EOPNOTSUPP;
	if (!buf)
		return -ENOMEM;
	rc =3D 0;
	do {
		mutex_lock(&diag204_mutex);
		/* Exit loop with lock taken if there is no concurrent update */
		if (!READ_ONCE(g_cache.updating))
			break;
		mutex_unlock(&diag204_mutex);
		if (allow_busy && !allow_busy_wait)
			return -EBUSY;
		if (signal_pending(current))
			return -ERESTARTSYS;
		schedule_timeout_interruptible(DIAG204_BUSY_WAIT);
	} while (allow_busy_wait);
	if (!diag204_is_cache_valid(DIAG204_CACHE_EXPIRY))
		rc =3D diag204_update_cache(allow_busy, allow_busy_wait);
	if (rc >=3D 0)
		memcpy(buf, READ_ONCE(g_cache.buf), diag204_get_buf_size());
	mutex_unlock(&diag204_mutex);

When g_cache.updating is true and both allow_busy and allow_busy_wait are
0, the loop unlocks diag204_mutex, sleeps in
schedule_timeout_interruptible(), and then terminates because
allow_busy_wait is 0.

Doesn't this leave diag204_mutex unlocked for the remainder of
diag204_store(), triggering lockdep assertions in diag204_is_cache_valid()
and diag204_update_cache(), racing with vfree() of g_cache.buf in
diag204_set_cache() and diag204_work_fn() during memcpy() (or reading a
null g_cache.buf if the first cache fill has not completed), and calling
mutex_unlock(&diag204_mutex) without holding the lock?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-diag204ioc=
tl-v2-0-7e5a9d1cd21a@linux.ibm.com?part=3D3
