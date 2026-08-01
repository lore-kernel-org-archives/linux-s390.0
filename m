Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2701A3AB0
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 18:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785608273; cv=none; b=TdjCHhS1f72AULpM/YLsomJZpNd7rz8KHbfBrf/IFHlvAE/9K+E70DYFnUiQRN2wvE8P/MVoanQl1ueQv4aMidi5VE1y2FMfSQ/Ib10kYtqojNWoOYo4RZ9T4+kYve+Gj8AYbBsQgtaf2NzTp6xZ0OWRrOwFJksP1FkrS+Zhq9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785608273; c=relaxed/simple;
	bh=Nb9rz2sUFrrM4c9XUDIx8U6iR57PR4nYW0/WQpUGlS8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AnwOPx8HYsOd/Poc0ob9WXUT7hEu93UjAMsJDTaSNz3m8tdrEl114RP0g35vkdL+/ncAOoL/esErkxzFat89kyD1hRaJf3inrudQx/37CWuXyH3DNPedUiFwb5XjhRD6eXOCZXTCCcUSer3b4YFglVZkgaryDzZZc7BxiPKAOv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OS+XtLA2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OS+XtLA2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA881F00AC4;
	Sat,  1 Aug 2026 18:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785608272;
	bh=jYsrUb/vgRXdf/2vvFXv1Lzqj9jcgnL7hBvtThXxxnA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OS+XtLA2zkbTQZSOIsANtnmisoM9rpbVFZO/ROVZeLYNLAuKVkd1INw2Zs5XzfuNE
	 qaWr6efEnoZAtRU1Icfu/i5jvb3i3ac8pIq0HhY5rtbK1AteFyzd9R/WAtX5wZsLZH
	 Z7OuekIeVA5ZiELlMq0VivXqS309OAZ1s3YEHQubyCiIC+p/g6FyG47/S39dDYXxfQ
	 kXLdYK7/8pVFB0ZBmJais6f05CVSXSDgTEYOfM2w4uVrKQPq3cAX6tBTgmYZEuRCY8
	 51erDJD5VzTicofcvGPMj1aSD6AYJarNr1CQM8Oa6eoKxS7HQK8jH25+I0jqH4UNYS
	 GIMDqLPaT/RFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 14/19] s390/dasd: Derive adaptive ESE fulltrack
 heuristic from ft_bias
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260801180033.3679412-15-sth@linux.ibm.com>
References: <20260801180033.3679412-1-sth@linux.ibm.com>
 <20260801180033.3679412-15-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 18:17:51 +0000
Message-Id: <20260801181752.4AA881F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] sysfs attribute `ese_heuristic_state` incorrectly reports 'fullt=
rack active' for non-ESE devices.
- [Medium] Flawed lockless synchronization in `dasd_ese_heuristic_tick` all=
ows multiple threads to bypass the early return, resulting in spurious stat=
e transitions based on tiny probe windows.
--

--- Patch [14]: [PATCH v7 14/19] s390/dasd: Derive adaptive ESE fulltrack h=
euristic from ft_bias ---
commit e1b43c6c6e91c681aa16c723f5cbd3e86ae30516
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Derive adaptive ESE fulltrack heuristic from ft_bias

Turn the middle of the ft_bias range (1..99) into an adaptive heuristic
that switches between fulltrack write (ft1) and plain write ft0 depending
on how sparse the device still is.

A sparse device benefits from fulltrack writes (it avoids the format/retry
cycle); once enough tracks are formatted the per-write overhead of
ft1 outweighs that. An state machine  measures the NRF rate in short ft0
probe windows and flips back to ft1 when it is high
(FT1_ACTIVE -> PROBING -> FT0_STABLE, with a backing-off reprobe interval).

> diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_d=
evmap.c
> index 035c022255b68..50301e545bbe8 100644
> --- a/drivers/s390/block/dasd_devmap.c
> +++ b/drivers/s390/block/dasd_devmap.c

[ ... ]

> @@ -1668,6 +1674,41 @@ static ssize_t full_track_bias_store(struct device=
 *dev,
> =20
>  static DEVICE_ATTR_RW(full_track_bias);
> =20
> +static const char * const dasd_ese_heu_state_names[] =3D {
> +	[DASD_ESE_HEU_FT1_ACTIVE] =3D "fulltrack active",
> +	[DASD_ESE_HEU_PROBING]    =3D "probing",
> +	[DASD_ESE_HEU_FT0_STABLE] =3D "fulltrack inactive",
> +};
> +
> +/* read-only: current full-track mode / adaptive FSM state, for observab=
ility */
> +static ssize_t
> +ese_heuristic_state_show(struct device *dev, struct device_attribute *at=
tr,
> +			 char *buf)
> +{
> +	struct dasd_device *device;
> +	unsigned int state;
> +	int len;
> +
> +	device =3D dasd_device_from_cdev(to_ccwdev(dev));
> +	if (IS_ERR(device))
> +		return -ENODEV;
> +	if (device->ft_bias =3D=3D 0) {
> +		len =3D sysfs_emit(buf, "fulltrack deactivated\n");
> +	} else if (device->ft_bias >=3D DASD_FT_BIAS_MAX) {
> +		len =3D sysfs_emit(buf, "fulltrack permanent active\n");
> +	} else {
> +		state =3D device->ese_probe_state;
> +		if (state < ARRAY_SIZE(dasd_ese_heu_state_names))
> +			len =3D sysfs_emit(buf, "%s\n", dasd_ese_heu_state_names[state]);
> +		else
> +			len =3D sysfs_emit(buf, "unknown\n");
> +	}

[Severity: Medium]
Will this incorrectly report "fulltrack active" for non-ESE devices?

If ft_bias is set in the adaptive range (which defaults to 50), this falls
into the else block and reads ese_probe_state. For standard non-ESE
devices, dasd_ft_bias_apply() initializes this state to
DASD_ESE_HEU_FT1_ACTIVE (0).=20

Should this check dasd_ese_adaptive(device) before printing the state to
avoid exposing misleading observability statistics to user space?

> +	dasd_put_device(device);
> +	return len;
> +}
> +
> +static DEVICE_ATTR_RO(ese_heuristic_state);

[ ... ]

> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> index 0247e9a6d7929..dc30c4395b0cc 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c

[ ... ]

> @@ -3230,6 +3239,69 @@ static void clear_format_track(struct dasd_format_=
entry *format,
>  	spin_unlock_irqrestore(&block->format_lock, flags);
>  }
> =20
> +/*
> + * Adaptive ft_bias heuristic, called once per IO from dasd_eckd_build_c=
p().
> + * Probes the device formatting state by briefly switching to ft0 and me=
asuring
> + * the NRF rate; parameters are derived from ft_bias.
> + */
> +static void dasd_ese_heuristic_tick(struct dasd_device *basedev)
> +{
> +	int ios, nrf, rate;
> +
> +	if (atomic_inc_return(&basedev->ese_io_cnt) < (int)basedev->ese_probe_i=
nterval)
> +		return;
> +
> +	/*
> +	 * One wins the race to evaluate, the rest see ios =3D=3D 0 after the
> +	 * xchg and return early, preventing redundant state transitions.
> +	 */
> +	ios =3D atomic_xchg(&basedev->ese_io_cnt, 0);
> +	if (ios <=3D 0)
> +		return;

[Severity: Medium]
Is it possible for multiple threads to bypass the early return and cause
spurious state transitions?

If multiple threads concurrently evaluate
atomic_inc_return(&basedev->ese_io_cnt) < interval and see a value >=3D int=
erval,
they both proceed. The first thread zeroes the counter via atomic_xchg.

If another I/O increments the counter to 1 before the second thread performs
its atomic_xchg, the second thread will read 1, bypass the ios <=3D 0 check,
and evaluate the heuristic using ios =3D 1.

Could this lead to the ESE heuristic state machine evaluating on tiny probe
windows, causing thrashing between FT0 and FT1 under concurrent I/O submiss=
ion?

> +
> +	switch (basedev->ese_probe_state) {
> +	case DASD_ESE_HEU_FT1_ACTIVE:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801180033.3679=
412-1-sth@linux.ibm.com?part=3D14
