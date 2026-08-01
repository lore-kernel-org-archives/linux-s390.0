Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2938A377A8E
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 11:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785584410; cv=none; b=mM9zusvYslzQii3+ovP1fwrfxca9FXVde5FmPNxzdew63lzvM2iNMTUN3axMNH4Rkg3h73x9+oaST9PfPliBhL3YBTLg94TO8Z7YtSFCsi3f5TMeUueFY6jkcPi+9maUkiy/EtKlmh07/Gx/YdbBC9RB6Nvm/JCLvsi5atrzKn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785584410; c=relaxed/simple;
	bh=lgR5c5TBY6vTctjqpkp+1kaan72eiodfWN98ZYF1uVg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tTE1rxCPcTmxi60VPyvPy/BXa8vthCVcUWKHPPPK3mrjbVTCDPAC4IfYs7VOWaX1ChffR1FX5RFYVZzngPV8JNw04BGhtyldDNzt+DWGmy1Pzb5Ec2LTfQUHBhBZCnPCoDaF51OHhC+QfO8UACIU0iWXU4OrQ40OH0TjiAXyXSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RaLxdnQd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RaLxdnQd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8089C1F00AC4;
	Sat,  1 Aug 2026 11:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785584408;
	bh=9q7tZIDRYsYhutx2BJD8e2mMhz5MB453M7B4qogIfh4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RaLxdnQdUs9c0UPRuiIvTWBEA30lZpv3LnNj1nr0Mon+LHHcITCl6nDzQOjJakXDG
	 0NMdyjfCZA/w6qtoMixwW4yBpXv2EuT9pwiGFNEn5vJNKn3tLOIK0cYlDOL18h2/pL
	 4WZK7rTJPU3j/XMEvv1DVPZbzjr3kggab48FvxLounnnS3k89SGxoWmQ0In4Qh4mhD
	 wuj8F/1iy/ZMYUUYXjqesjX0gb9Ak1KxMgR/hlB0sBKCLNnI3pbsrwFpaHs0q16es6
	 dIvyNlv4a2thc1Aheu1/G6fejGZ4G5YEnTY7ByfuxkA4nfyHTLYLU+1ia81No5Kt9n
	 pXT0h5lecxMhw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 03/18] s390/dasd: Guard sysfs discipline callbacks
 against unallocated private data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260801111008.3391031-4-sth@linux.ibm.com>
References: <20260801111008.3391031-1-sth@linux.ibm.com>
 <20260801111008.3391031-4-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 11:40:08 +0000
Message-Id: <20260801114008.8089C1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The patch fails to protect against a lockless Time-of-Check to=
 Time-of-Use (TOCTOU) race where `device->private` is freed on the error pa=
th of `discipline->check_device()`, leading to a Use-After-Free or NULL poi=
nter dereference.
- [High] The patch adds NULL checks for `device->private` in multiple sysfs=
-triggered callbacks but misses `dasd_eckd_pprc_enabled`, leaving a race co=
ndition that can panic the kernel.
- [High] The newly added `!private` checks are insufficient because callbac=
ks subsequently dereference `private->conf.ned` before it is initialized.
- [High] In `dasd_release_space()`, an incorrect logical AND (`&&`) causes =
a NULL pointer dereference for disciplines without an `is_ese` callback, an=
d silently bypasses the check for disciplines that have it.
- [High] The asynchronous attention interrupt handler path is vulnerable to=
 the same `device->private` NULL pointer dereference race condition that th=
e patch attempts to fix for sysfs.
--

--- Patch [3]: [PATCH v6 03/18] s390/dasd: Guard sysfs discipline callbacks=
 against unallocated private data ---
commit 698838157896167de2e3f1afbbb4fdad63518bec
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Guard sysfs discipline callbacks against unallocated private data

This patch adds NULL checks for device->private in several sysfs
show/store handlers inside dasd_eckd.c. It aims to fix a panic caused by
an unprivileged read of a sysfs attribute during the window between
discipline assignment and device->private allocation.

Cc: stable@vger.kernel.org

> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> index 74fe73b5738ab..6e2fd445688cb 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c

[ ... ]

> @@ -1646,6 +1648,9 @@ static int dasd_eckd_is_ese(struct dasd_device *dev=
ice)
>  {
>  	struct dasd_eckd_private *private =3D device->private;
> =20
> +	if (!private)
> +		return 0;
> +
>  	return private->vsq.vol_info.ese;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does this pattern leave the
code vulnerable to a Time-of-Check to Time-of-Use race?

If a sysfs read calls dasd_eckd_is_ese() during dasd_generic_set_online(),
it can pass the new !private check. If the dasd_eckd_check_characteristics()
error path simultaneously frees device->private locklessly:

drivers/s390/block/dasd_eckd.c:dasd_eckd_check_characteristics() {
    ...
out_err1:
    kfree(device->private);
    device->private =3D NULL;
    ...
}

Could the sysfs handler then resume and dereference the freed memory when
accessing private->vsq.vol_info.ese?

[Severity: High]
This is a pre-existing issue, but while looking at the is_ese callback,
does dasd_release_space() in drivers/s390/block/dasd_ioctl.c have an issue
with its short-circuit logic?

drivers/s390/block/dasd_ioctl.c:dasd_release_space() {
    ...
    if (!device->discipline->is_ese && !device->discipline->is_ese(device))
    ...
}

If the discipline does not implement is_ese (like FBA devices), wouldn't
the left operand evaluate to true, forcing evaluation of the right operand
and causing a NULL pointer dereference? And if it does implement is_ese,
wouldn't the left operand evaluate to false, bypassing the check entirely?

[ ... ]

> @@ -5935,8 +5965,11 @@ static int dasd_eckd_query_host_access(struct dasd=
_device *device,
>  	struct ccw1 *ccw;
>  	int rc;
> =20
> +	if (!private)
> +		return -ENODEV;
> +
>  	/* not available for HYPER PAV alias devices */
> -	if (!device->block && private->lcu->pav =3D=3D HYPER_PAV)
> +	if (!device->block && private->lcu && private->lcu->pav =3D=3D HYPER_PA=
V)
>  		return -EOPNOTSUPP;

[Severity: High]
This isn't a bug introduced by this patch, but is this check sufficient to
prevent dereferencing uninitialized pointers later in the function?

Inside dasd_eckd_check_characteristics(), device->private is allocated
immediately, but private->conf.ned is not populated until
dasd_eckd_read_conf() succeeds. If this sysfs handler executes during that
window, the !private check passes, but further down in
dasd_eckd_query_host_access() (and similarly in dasd_eckd_read_vol_info()),
the code performs:

    prssdp->lss =3D private->conf.ned->ID;
    prssdp->volume =3D private->conf.ned->unit_addr;

Since private->conf.ned would still be NULL during this window, can this
cause a NULL pointer dereference?

[ ... ]

> @@ -6801,6 +6834,9 @@ static int dasd_eckd_hpf_enabled(struct dasd_device=
 *device)
>  {
>  	struct dasd_eckd_private *private =3D device->private;
> =20
> +	if (!private)
> +		return 0;
> +
>  	return private->fcx_max_data ? 1 : 0;
>  }

[Severity: High]
This is a pre-existing issue, but does dasd_eckd_pprc_enabled() also need
this NULL check?

If a user writes to the copy_pair sysfs attribute during device
initialization, dasd_copy_pair_store() locklessly calls the discipline
callback:

drivers/s390/block/dasd_devmap.c:dasd_copy_pair_store() {
    ...
    pprc_enabled =3D device->discipline->pprc_enabled(device);
    ...
}

Inside dasd_eckd_pprc_enabled(), device->private is unconditionally
dereferenced:

drivers/s390/block/dasd_eckd.c:dasd_eckd_pprc_enabled() {
    ...
    return private->rdc_data.facilities.PPRC_enabled;
}

Could this trigger a NULL pointer dereference if hit during the same
initialization window?

[Severity: High]
This is a pre-existing issue, but is the asynchronous attention interrupt
handler path vulnerable to this same race condition?

Since the subchannel is enabled during probe, a hardware attention interrupt
could arrive during the same device initialization window.
dasd_int_handler() locklessly calls device->discipline->check_attention(),
which schedules dasd_eckd_check_attention_work():

drivers/s390/block/dasd_eckd.c:dasd_eckd_check_attention() {
    ...
    INIT_WORK(&data->worker, dasd_eckd_check_attention_work);
    schedule_work(&data->worker);
    ...
}

This asynchronous work eventually calls dasd_eckd_cuir_quiesce() which
unconditionally dereferences private->lcu:

drivers/s390/block/dasd_eckd.c:dasd_eckd_cuir_quiesce() {
    ...
    list_for_each_entry_safe(dev, n, &private->lcu->active_devices,
                             alias_list) {
    ...
}

If device->private is not yet allocated, does this cause a NULL pointer
dereference?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801111008.3391=
031-1-sth@linux.ibm.com?part=3D3
