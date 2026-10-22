Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685295;
	b=4o8l7DBk97kOFRyW+gxdugk0rxg0XDYd59MsUchxyUIRYQEDDdWuE9N7yTqJerYCcbC5
	 QbdEzko4hE4BMi+VsTH9thAkJuoSe7dge3uAQ4QY88eZWHiUrSuxetgKQBTk/ZmmrYlND
	 9OlXylbQghmfeQCSfFc13Vd3FMSIdv7JMpXZDB6zEbgQmuj6QoL8a7MmSqJXB9JfBR75B
	 wO8FvG1bIDzf0hDfwZUrCTyb/wiomjmgCuR0b3vy/WiFN7Sy4/YDKsphvRWt3HlQorIEn
	 nqmxNQAmWNXTRQfKRghE4X1TKTANW2Sn/+uB+jzispv1T6wbUvKpU3ujCQ2WlgW3OAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685295;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HdlvtlOw3bmSpNcBrSz3V1HTQeupADhcl9YZislGb00=;
	b=mq9bdeqyQXe8by3FiZ9hzxxI+GbHv9eRgpOcbY2Dh87Si206ufvAMXhx8Xkc0hOwYcsa
	 +qJrVBYFTVfk4EdjsSs0WO+OSQlRNun5DWkwtCRzg9EYuMGqxpz2HSm6Q0geQ7PxtUdJe
	 qf9lBgkX82/i59Ny5p7w/zLb9w2aFnk900Oo25DbQBkE6ScHKzIRBaR3FdYiWaoJVSiaF
	 rJbQHc+qb7pHLoX/XXkilbv7yJ+X+EdWXKf+ccqkjUosyMzCueyHATxJ/GN+fSm9UkCPi
	 xXz/iMnWXzm+SESmM6EK/DOcKEAkJP5yHy24Hw02NVOEUy8RNpSkuVbd6UvFsEtRiYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V9fiOTVm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971B4606A323
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 16:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V9fiOTVm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08DF01F01829;
	Thu, 22 Oct 2026 16:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792685295;
	bh=HdlvtlOw3bmSpNcBrSz3V1HTQeupADhcl9YZislGb00=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V9fiOTVmNW0vHGWHUfwcHd8pbdJr/Jxa8Zm0JYgcRWnk8hv55np0xkzd3NYwqJ/8s
	 5nTH4BeMxNM5diSd553JTOWEZDICohrz2e9GrXvivxL+xtu8RB0xDU+AlNI+/RTUCa
	 JDoKe2nDJ8A/dHQ+HBW0YalzBtqti2xMo74PjxxJeFB8dH00htq+be2OhGBC/Jd7z0
	 zx8ASO0FdCRaiSFjKXCNDKqz8WUTIvWBNANp1NqnV+h4q1gVld5yla9lGTTJO22LLb
	 IhMAOwEVtUAMfY/bRx8YZ0Ljonu2KRyTwUj01O/9XukDYTufbuOnYiSZJqCkMdQEG1
	 VrKMNeu7IFXWw==
Message-ID: <sashiko-outbox-181757@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] s390/diag: Add diag204 IOCTL to diag misc device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mete Durlu" <meted@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261022-diag204ioctl-v3-3-c25e7147736e@linux.ibm.com>
References: <20261022-diag204ioctl-v3-0-c25e7147736e@linux.ibm.com>
 <20261022-diag204ioctl-v3-3-c25e7147736e@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 16:08:14 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] s390/diag: diag204_store() fails with -EINVAL when BIF is unavai=
lable
--

commit 24db640b46c74f692d9871eb2b56c29382e3bc2f
Author: Mete Durlu <meted@linux.ibm.com>

s390/diag: Add diag204 IOCTL to diag misc device

This commit adds the DIAG204_GET_SUBCODE, DIAG204_GET_LEN, and
DIAG204_GET_BUF ioctls to the /dev/diag misc device to allow userspace to
retrieve diagnose 204 data.

> diff --git a/arch/s390/kernel/diag/diag204.c b/arch/s390/kernel/diag/diag=
204.c
> index f447bfaf756b4..237303aa44d6f 100644
> --- a/arch/s390/kernel/diag/diag204.c
> +++ b/arch/s390/kernel/diag/diag204.c
[ ... ]
> @@ -222,6 +224,54 @@ int diag204_store(void *buf, int allow_busy, int all=
ow_busy_wait)
>  	return rc;
>  }
> =20
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

[Severity: Medium]
What happens on systems where diagnose 204 is available, but the busy
indication facility (g_info.has_bif) is not supported, when a caller passes=
 a
non-zero allow_busy value?

In arch/s390/kernel/diag/diag204.c, diag204_update_cache() is written to fa=
ll
back to a regular diagnose 204 call when g_info.has_bif is false:

    subcode =3D g_info.type | g_info.subcode;
    if (g_info.has_bif && allow_busy)
            subcode |=3D DIAG204_BIF_BIT;

However, earlier in the series, diag204_store() in
arch/s390/kernel/diag/diag204.c rejects any call with allow_busy set when
g_info.has_bif is false:

    if (allow_busy && !g_info.has_bif)
            return -EINVAL;

Because arch/s390/include/uapi/asm/diag.h does not provide an ioctl for
userspace to query whether BIF is supported, a userspace caller invoking
ioctl(fd, DIAG204_GET_BUF, &req) -> diag_ioctl() -> diag204_buf() ->
diag204_store() with allow_busy set has no way to know upfront that it must
pass allow_busy =3D 0 on machines without BIF.

In addition, the in-kernel callers converted earlier in the series pass
allow_busy =3D 1 unconditionally when BIF is not supported:

- arch/s390/hypfs/hypfs_diag.c: dbfs_d204_create() calls
  diag204_store(d204->buf, 1, 1)
- arch/s390/hypfs/hypfs_diag_fs.c: hypfs_diag_create_files() calls
  diag204_store(buffer, 1, 1)
- arch/s390/kernel/sthyi.c: diag204_get_data() calls
  diag204_store(diag204_buf, diag204_allow_busy, 0) where
  diag204_allow_busy =3D is_diag204_cached(sctns) is true after the first c=
ache
  fill

Should diag204_store() allow allow_busy when !g_info.has_bif and let
diag204_update_cache() ignore it (or clamp allow_busy and allow_busy_wait t=
o 0
when !g_info.has_bif) instead of returning -EINVAL?

> +	if (rc < 0) {
> +		diag204_free_buffer(buf);
> +		return rc;
> +	}
> +	rc =3D copy_to_user((void __user *)address, buf,
> +			  diag204_get_buf_size());
> +	diag204_free_buffer(buf);
> +	return rc ? -EFAULT : 0;
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-diag204ioc=
tl-v3-0-c25e7147736e@linux.ibm.com?part=3D3
