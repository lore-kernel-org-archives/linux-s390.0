Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F0138398F
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 14:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784815780; cv=none; b=jKLMqe5G8nBfRp/MX71GphuKiowXO3M8jn3O6HLcHEMe1Amy++Fv8KNB2UpUSEi4JDC3hjSG69olTCm1LkphBQAXN6HTGf1JLI0+VGEDrKjZyZL99hFpE/ZT9iZAKRGgwEtBvdBOOTZAshA1Aq4M/kzW4ahJUv6JcQVrlux1B84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784815780; c=relaxed/simple;
	bh=fZuUiig0CVRBlIpkscGi+9TcipmMdt6pZbwyxvsz5aQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QR6pTu/p9yk2wn3lH/r1LO7NnTmzHsbYDc79uEAJBmuqPDOKY8Bejx1cXDjOGCvL6By5rWG9NR73Y+6vJ2rdPAaBNfomZor51Ksg4L5jFmc9czPtiMxSDMp2ExqM2AvH+CuA7IUV3yYjIGaM9IdTZA5SXwxWIm8vwWXHbzTcy40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WhcGPILG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhcGPILG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3011F000E9;
	Thu, 23 Jul 2026 14:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784815778;
	bh=jsZ71JHYz8aH4mvPfX4YpXy3im3A9aHB60sAmifojac=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WhcGPILGhObAVHg/ZekLoA9CX/aK23TeQL5ZXC92z+lwCmhSBUTpeFpGDJyP7hPDv
	 pK3FFHW7sMHIC54HvqDTfP56JRcj1yNG7Lg7nnCxMlI/YNwyk6gI0R8iNwFTy1YkBd
	 ryqhKEmJnSuENAhJNfinbB910JK/7b1cp/DK3QFWRN3myHV6FHL0OsfSCbO1km9j3y
	 CrU8ou6fY6H4xjKuBfmPI/ANCb2xFx86ri2gf4H/KR3XR6yoMEf14yylcGf55RFLq3
	 iou1HevyTFjIDWLjbIyDcjR377OqGdoZSOFwzSLyJqHzMV6rMlmSu1HGl+yM2SflAv
	 iA5Y9FGgBWfPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/13] s390/dasd: Derive adaptive ESE fulltrack
 heuristic from ft_bias
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260723134743.672413-9-sth@linux.ibm.com>
References: <20260723134743.672413-1-sth@linux.ibm.com>
 <20260723134743.672413-9-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 14:09:37 +0000
Message-Id: <20260723140937.CE3011F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Writing to the `full_track_bias` sysfs attribute triggers a NULL p=
ointer dereference if the DASD device is offline or has no discipline assig=
ned.
- [High] The adaptive heuristic FSM state and configuration variables are m=
odified concurrently without synchronization, leading to permanent state co=
rruption.

Pre-existing issues:
- [High] The condition in `dasd_release_space()` incorrectly uses `&&` inst=
ead of `||`, breaking validation and evaluating a NULL function pointer for=
 non-ESE disciplines.
--

--- Patch [8]: [PATCH v3 08/13] s390/dasd: Derive adaptive ESE fulltrack he=
uristic from ft_bias ---
commit 6212107d38eb431780604d50fae290b46a53ceff
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Derive adaptive ESE fulltrack heuristic from ft_bias

Turn the middle of the ft_bias range (1..99) into an adaptive heuristic
that switches between fulltrack write (ft1) and plain write ft0 depending
on how sparse the device still is. A state machine measures the NRF rate
in short ft0 probe windows and flips back to ft1 when it is high.

> diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_d=
evmap.c
> index 035c022255b68..c587817f5cf9e 100644
> --- a/drivers/s390/block/dasd_devmap.c
> +++ b/drivers/s390/block/dasd_devmap.c
[ ... ]
> @@ -1660,7 +1660,7 @@ static ssize_t full_track_bias_store(struct device =
*dev,
>  		return -ENODEV;
> =20
>  	device->ft_bias =3D val;
> -	device->fulltrack =3D val ? 1 : 0;
> +	dasd_ft_bias_apply(device);

[Severity: High]
Is it possible for device->discipline to be NULL when the device is offline?

If a user writes to the full_track_bias sysfs attribute while the device is
offline, dasd_ft_bias_apply() calls dasd_ese_adaptive(device) which directly
dereferences device->discipline->is_ese:

drivers/s390/block/dasd_int.h:dasd_ese_adaptive() {
    return device->discipline->is_ese &&
           device->discipline->is_ese(device) && ...
}

Could this result in a NULL pointer dereference during the sysfs write?

> =20
>  	dasd_put_device(device);
>  	return count;
[ ... ]
> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> index c10fe20e7d3ff..8b5f592b04d95 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c
[ ... ]
> @@ -3201,6 +3208,65 @@ static void clear_format_track(struct dasd_format_=
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
> +
> +	switch (basedev->ese_probe_state) {
> +	case DASD_ESE_HEU_FT1_ACTIVE:
> +		/* Start ft0 probe window, reset NRF counter for clean measurement */
> +		basedev->fulltrack          =3D 0;
> +		basedev->ese_probe_state    =3D DASD_ESE_HEU_PROBING;

[Severity: High]
Is there a race condition here between this state update and a concurrent
sysfs write to full_track_bias?

If a sysfs write occurs concurrently with a block I/O request executing
dasd_ese_heuristic_tick(), the I/O thread might read DASD_ESE_HEU_FT1_ACTIV=
E.

If the sysfs thread then updates ft_bias (for example, to 100) and forces
fulltrack =3D 1 via dasd_ft_bias_apply(), the I/O thread could subsequently
overwrite fulltrack =3D 0 and change the FSM state.=20

Since ft_bias is now 100, dasd_ese_adaptive() will evaluate to false for
future I/Os, meaning the heuristic tick is never called again and fulltrack
remains stuck at 0. Does this need synchronization to prevent permanently
locking the heuristic in the wrong state?

> +		basedev->ese_probe_interval =3D basedev->ese_heu_probe_window;
> +		atomic_set(&basedev->ese_nrf_window, 0);
> +		break;

[Severity: High]
This is a pre-existing issue, but looking at dasd_release_space() in
drivers/s390/block/dasd_ioctl.c:

    if (!device->discipline->is_ese && !device->discipline->is_ese(device))
        return -ENOTSUPP;

Does this condition incorrectly use && instead of ||?=20

If the discipline does not define the is_ese callback (such as for FBA
devices), the first half evaluates to true. Because of the &&, it then
evaluates the second half, which calls the NULL function pointer. Could an
ioctl invoking dasd_release_space() on such a device cause a kernel panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723134743.6724=
13-1-sth@linux.ibm.com?part=3D8
