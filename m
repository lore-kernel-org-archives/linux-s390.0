Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF28E25F984
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 14:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784816381; cv=none; b=g/zZnOd1Qej9j4melLQReqGNvhgSvbPLLtOUJMf824EX50N8tiFoQ4CPqXbnY766nx83sE39ZFh70pJIxw4AsQZ+GtuZvoz4PbIBymWz8oXfyn87kfFAcuEVrPzz56LPgw9/I2adhP+b6ESkzwaxgSVgGLpYyW4BjnjspgBwo1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784816381; c=relaxed/simple;
	bh=vjl/8Eh/AzaC2l6bW7F/g1WKJ6NYrqGCd0Sh6veEuyE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aRAPCwJBX/XXzL+p9Wily0OMA8iPVzbudLaSn2tWzE0GZnHO6m+fWQD1fW0E3siN8bW4izE05oiEadTD8D4XYSyQaWL4B/vIr2GPpc+ZXzGeGrEpoUeJAYgEQ1Sn3raxIFvMIjKLNSRDuWo+9oFw0IJPgPk17ZTHNv6Ui/bRhhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3zyVZec; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3zyVZec"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 625611F00A3E;
	Thu, 23 Jul 2026 14:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784816375;
	bh=VsJyhBCApb0oJUh3BjN6QKx/u/ooTOi1LuJJPszQkuo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O3zyVZecwIxcEWXpKLim71sUxi5cFJCBD1HtND0fFp79nWoIU7yd0n0QlDxVquDWA
	 rWMqSyN508DogbgFeSUdy5nY4v766dFyWteEc7AmWHoAruKNRdCUk6CSK2XBjaepAN
	 4veCj1T1o+Q3l6gzA/51+2ia/WTvOl3qBJneknRqRrDgcfHMM4IaJkEVrp8M4ZhFhn
	 G6uM0CbXvS5tO9mI00+ZP8tonG3MBor6Lkj8hiraJ+LKzUB+Vcp2FS9FsHyu4VUQL/
	 RoBMyAFyhmlbngnSa0XUYX1nc5+r64A+OcgpCrIWDff99jmjEouX9rZMvYgAQpeKpc
	 gJpBpz0UINFoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/13] s390/dasd: Detect ESE volumes from the on-disk
 format label
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260723134743.672413-11-sth@linux.ibm.com>
References: <20260723134743.672413-1-sth@linux.ibm.com>
 <20260723134743.672413-11-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 14:19:32 +0000
Message-Id: <20260723141935.625611F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Medium] Speculative format label cache update is not rolled back on form=
at I/O failure.
- [Medium] Incoherent ESE fulltrack heuristic state due to premature applic=
ation using pre-format `is_ese()` state.
- [Medium] Unlocked data race on `private->ese_label` copy exposes read tea=
ring to sysfs readers.

Pre-existing issues:
- [High] Unprivileged userspace can trigger a kernel panic by reading sysfs=
 attributes during device bring-up (NULL pointer dereference).
- [High] Pre-existing logic error in `dasd_release_space()` causes a kernel=
 panic on FBA/DIAG devices and bypasses ESE validation on ECKD.
--

--- Patch [10]: [PATCH v3 10/13] s390/dasd: Detect ESE volumes from the on-=
disk format label ---
commit 6e2aa2c452098583cebc915d1bb76216c96eecf8
Author: Stefan Haberland <sth@linux.ibm.com>
Subject: s390/dasd: Detect ESE volumes from the on-disk format label

This commit reads the format label from track 0 record 4 at device
bring-up and caches it. When a valid label is present, is_ese() is
derived from it instead of the hardware volume field. The cache is
refreshed after a format so the state stays coherent.

> diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_d=
evmap.c
> --- a/drivers/s390/block/dasd_devmap.c
> +++ b/drivers/s390/block/dasd_devmap.c
> @@ -2473,9 +2473,10 @@ static ssize_t dasd_##_name##_show(struct device *=
dev,			\
>  									\
>  	return sysfs_emit(buf, "%d\n", val);			\
>  }									\
> -static DEVICE_ATTR(_name, 0444, dasd_##_name##_show, NULL);		\
> +static DEVICE_ATTR(_name, 0444, dasd_##_name##_show, NULL);
> =20
> -DASD_DEFINE_ATTR(ese, device->discipline->is_ese);
> +DASD_DEFINE_ATTR(ese, device->discipline->ese_capable);
> +DASD_DEFINE_ATTR(on_demand_formatting, device->discipline->on_demand_for=
mat);

[Severity: High]
This is a pre-existing issue, but I noticed that unprivileged userspace
can trigger a kernel panic by reading these sysfs attributes during device
bring-up.=20

In the dasd_##_name##_show macro, it checks device->discipline but fails to
verify that device->private is allocated. During dasd_generic_set_online(),
device->discipline is assigned before discipline->check_device() allocates
device->private. This creates a race window where dasd_eckd_ese_capable()
or dasd_eckd_on_demand_format() will unconditionally dereference a NULL
private pointer.

Is there a way to add a check for device->private in the sysfs macro or
defer attribute registration until initialization completes?

> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c

[ ... ]

> @@ -1673,13 +1673,53 @@ static int dasd_eckd_read_vol_info(struct dasd_de=
vice *device)
>  	return rc;
>  }
> =20
> -static int dasd_eckd_is_ese(struct dasd_device *device)
> +/* Hardware/volume ESE capability, from the Volume Storage Query. */
> +static int dasd_eckd_ese_capable(struct dasd_device *device)
> +{
> +	struct dasd_eckd_private *private =3D device->private;
> +
> +	return private->vsq.vol_info.ese;
> +}
> +
> +/*
> + * Whether the volume is to be handled as ESE (thin).
> + */
> +static int dasd_eckd_is_ese(struct dasd_device *device)
> +{
> +	struct dasd_eckd_private *private =3D device->private;
> +
> +	if (private->ese_label_valid)
> +		return !!(private->ese_label.flags & DASD_ESE_LABEL_F_ESE);

[Severity: Medium]
Is this state exposed to read tearing when sysfs attributes are accessed
concurrently with a format operation?

In dasd_eckd_fill_format_label(), the 512-byte dasd_format_label structure
is copied via struct assignment without holding any locks. Concurrently,
sysfs handlers call dasd_eckd_is_ese() which reads private->ese_label.flags
without synchronization. Could this unprotected copy allow a concurrent
sysfs read to fetch an intermediate or torn state?

[Severity: High]
This isn't a bug introduced by this patch, but while looking at is_ese,
I noticed a pre-existing logic error in dasd_release_space() in
drivers/s390/block/dasd_ioctl.c that causes a kernel panic on FBA/DIAG
devices.

The check there evaluates:
if (!device->discipline->is_ese && !device->discipline->is_ese(device))

Since it uses a logical AND, if is_ese is NULL (true for !NULL), it will
evaluate the right side and attempt to call a NULL function pointer.
Conversely, for ECKD, !is_ese is false, short-circuiting the check and
bypassing the intended validation altogether.

Could this check be changed to use a logical OR instead?

[ ... ]

> @@ -2709,6 +2823,13 @@ static void dasd_eckd_fill_format_label(struct das=
d_device *device, void *data,
>  	label->format_tod =3D get_tod_clock();
>  	strscpy(label->driver_ver, DASD_ESE_LABEL_DRIVER,
>  		sizeof(label->driver_ver));
> +
> +	/*
> +	 * Populate the cache directly from the bytes just computed instead of
> +	 * synchronously reading them back from disk after the write lands.
> +	 */
> +	private->ese_label =3D *label;
> +	private->ese_label_valid =3D true;
>  }

[Severity: Medium]
Does this speculative cache update get rolled back if the format I/O fails?

The format process updates the in-memory cache private->ese_label and sets
private->ese_label_valid =3D true here during CCW request construction.
However, if the subsequent I/O submission fails in
dasd_eckd_format_process_data(), it propagates -EIO but does not appear
to revert this cache update.

Could this leave the sysfs attributes and the driver's internal state
permanently desynchronized with the actual on-disk label after a failure?

[ ... ]

> @@ -3208,7 +3329,7 @@ static int dasd_eckd_format_device(struct dasd_devi=
ce *base,
>  	 * track 0; clear it so a later format that is not preceded by a full
>  	 * space release is recorded as a full format.
>  	 */
> -	if (fdata->start_unit =3D=3D 0)
> +	if (fdata->start_unit =3D=3D 0 && !rc)
>  		private->ese_format_quick =3D 0;
> =20
>  	return rc;

[Severity: Medium]
In dasd_eckd_format_device(), dasd_ft_bias_apply() is called prior to the
format process. Since it evaluates the heuristic based on the old is_ese()
state, will this lead to an incoherent ESE fulltrack heuristic state?

For example, if a volume is copied from ESE to non-ESE hardware and is
fully reformatted (clearing the F_ESE label), dasd_ft_bias_apply() might
configure the heuristic based on the pre-existing label. After the format
completes and updates the cache, is_ese() may become false, but the
heuristic state machine would remain inappropriately active.

Should dasd_ft_bias_apply() be evaluated after the format completes and the
new label is committed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723134743.6724=
13-1-sth@linux.ibm.com?part=3D10
