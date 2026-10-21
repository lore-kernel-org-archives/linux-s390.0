Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792581223;
	b=D2ukYa5c+f+pGUMmNxlqPoR7G4o98QR4zZNIcopvNsi55lL1zag7JSHUYp6NyXvZVAZm
	 O3vZOaKg74klhGXgTnQww8ccPzV9z6TY6y6cMlPv3ZkXEBKWoejRHWAa0DwCy/c/CnI9Y
	 8dsEJrCAwI8eHgGDuJktdQR0iX8kugG/j7Kk6WsS4ncJ5kWkW2VbVZPdERbcS5Ka4Ezk7
	 y6K7pLDVxUkuhYx1XSfHdSnsf0EzmrE1GZ5VIOwGgAuk2ShGzDatdOYcqDtMijbogSDWe
	 Wef2MfrJ4dTvUg3n+BbNblW6ghADtH67TuH6QL8kYxg/uN5a3l0wk3xPEI9KfsfM3nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792581223;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+GG0uTAiLJHZX/Jg/52ztCWj0aJt17hgqxWFBgF4x/M=;
	b=K2fQTUpI6jUF31DYEBt9qPqT5HqW/qCmtGc4/AEC84T06bT/+qWjWcfSK91lTgQRQqsG
	 mE2we3RZ2PvNz4KqI6Ejf19QW5KALADttpBNbr4jcSwBwQ+2pm0AmXAzE6Jt6Y8gYZQW+
	 rqYR0B4+pBtx5HxN9lE7G0Ogsm3CrPAdkEfK14Cm5R2Es1uEdIFapdFa6C7q+kcs5gJy2
	 y+MLEAAfVSupNPBMQseJw6cDjZjWPZqyCgk5sQBDbA+87v74AD/spHmGIx9llME6M82n4
	 vajwpn1PPixzXKAUuZ+qf/mybpoJGVTs0ymABnphTfMIGl1Y8eS6vCH3Ttnvw1ugO6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ml7AKdLq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FB7606A31A
	for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2026 11:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ml7AKdLq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 681981F000C9;
	Wed, 21 Oct 2026 11:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792581222;
	bh=+GG0uTAiLJHZX/Jg/52ztCWj0aJt17hgqxWFBgF4x/M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ml7AKdLqDolwdEFBt/0imxhpmK/edwcoZwPPuxZ1ZTkDWm4XVfHve57K7MhcPoAp/
	 t/p4MdG6cTCTU2gTUCrIwJGuyTq+QmOtOsG7zeHO7ttCySJAb/wfL20ysHB35GAiNB
	 hc9R8jfaKJbjjpfh7RuG0utpZ24cZrXDeX43nblV1oCc3Xdg6NUUjkZNxnjv8SUdXQ
	 nXC+hRNHHNY/8oH+vn/FwW+kZA3REFtleumqCVt1YdBIcdAtBP1QrtyaLXsIKdTmvU
	 UiLoiselNfVU/2YpjnMlnZqS5LZ8q4Ty4VCm+DSRGymv6iox8hjqzJpedC8cZfK4AS
	 NjuRwr8iQPI8Q==
Message-ID: <sashiko-outbox-180156@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] s390/diag: Add diag204 IOCTL to diag misc device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mete Durlu" <meted@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261021-diag204ioctl-v1-3-25645b97bf4e@linux.ibm.com>
References: <20261021-diag204ioctl-v1-0-25645b97bf4e@linux.ibm.com>
 <20261021-diag204ioctl-v1-3-25645b97bf4e@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 11:13:42 +0000
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
- [Medium] s390/diag: broken copy_to_user() error check in diag204_buf()
--

commit bc2db0b15c4152f85ed3a637d54a7ba9099ebe1e
Author: Mete Durlu <meted@linux.ibm.com>

s390/diag: Add diag204 IOCTL to diag misc device

This commit adds the DIAG204_GET_LEN and DIAG204_GET_BUF ioctl commands
to the /dev/diag misc device to allow userspace with CAP_SYS_ADMIN to
query and retrieve diag204 data.

> diff --git a/arch/s390/kernel/diag/diag204.c b/arch/s390/kernel/diag/diag=
204.c
> index 8e1909e6caf90..967b6e0bc667a 100644
> --- a/arch/s390/kernel/diag/diag204.c
> +++ b/arch/s390/kernel/diag/diag204.c

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
> +	if (rc < 0) {
> +		diag204_free_buffer(buf);
> +		return rc;
> +	}
> +	rc =3D copy_to_user((void __user *)address, buf,
> +			  diag204_get_buf_size());
> +	if (rc < 0)
> +		rc =3D -EFAULT;

[Severity: Medium]
Since copy_to_user() returns the positive number of uncopied bytes on a
fault rather than a negative error code, will this check miss faults when
copying to address in diag204_buf() via diag_ioctl() (DIAG204_GET_BUF) and
return a positive byte count instead of -EFAULT?

Should this check if (rc) (or if (copy_to_user(...))) instead?

> +	diag204_free_buffer(buf);
> +	return rc;
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021-diag204ioc=
tl-v1-0-25645b97bf4e@linux.ibm.com?part=3D3
