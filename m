Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73376301493
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785513579; cv=none; b=RRuwJpM6udEnYEqBQxCf4cxxQHKdlGr0kCQUzf+RAg7P9xxyDXtTy6/TaYp60LjUeJIRlA1QuqDR3K6TdvlBziKOriaKyMoqREwEefHvlfwckBvGWPwlfihVqHepVikvOhopwYJ7hOd6mXLdelZzqV4A3vYdYIvaoDYWEx7lRoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785513579; c=relaxed/simple;
	bh=wh2AlTfNAhBecXUtsPTyDCsdq8g5RQte2K4Nctjs9WY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rjvcKdyLZANBSC7gdFE4gQNtIec32eShgb4RZ4OJysla78iHXhl9RhnNVT+IpO4AV8fstEHU3faNXTz/5Qd/VGQe2aL/UFfNLhJSofzYxwIpRriD8InQtrukH/VRMpBT1m3H2NksAj2PYaSx2ny4gSpG+K28clQcmbXe6gcSaPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7JA0ip5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7JA0ip5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA9C1F00AC4;
	Fri, 31 Jul 2026 15:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785513578;
	bh=Oi7T6/LCUa+uFmOS9wHwC98DrqlRnWjEFAu3/+FzEYk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P7JA0ip526to9cfW20mw1BNBcVdxHuVnWEvCAlH71Y1tjh0vlP35ly8DURoxeEoWY
	 jzUfQQCHP64dNyBtcLgxBjdyBMLV1mygV9lJj6J8gcFBaG5vr4IZJ//AQa/Oj0JOSE
	 gmfILchTz4LxZ15kDTgnv6fiSFAPlN8F6nsAs44CFroZ0dkWiVGOnPWRwupJc7D4s0
	 89qBthf3CsDVCg0c778YSMLtEkBkeaI3AB35/HdqONkLq59BfbOtALcjaRNof7afdo
	 jwWZ4YjHfmeL4PPXy8fHSTN/KNMeNKUxm87wGUtY27j1NduHtX0TFTv1xpBBYYF9JA
	 RIRemjtrZ8POg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/17] s390/dasd: Guard sysfs discipline callbacks
 against unallocated private data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260731153842.1729627-3-sth@linux.ibm.com>
References: <20260731153842.1729627-1-sth@linux.ibm.com>
 <20260731153842.1729627-3-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 15:59:37 +0000
Message-Id: <20260731155937.AAA9C1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The patch fails to fully resolve the initialization race for t=
he `host_access_count` sysfs attribute, resulting in a NULL pointer derefer=
ence. While it adds a `!private` check to `dasd_eckd_query_host_access()`, =
it overlooks that `private->lcu` remains NULL until populated later by `das=
d_alias_make_device_known_to_lcu()`. An unprivileged sysfs read during this=
 window will bypass the `!private` check and unconditionally dereference `p=
rivate->lcu->pav`, causing a kernel panic.
- [Critical] The `if (!private)` checks added by the patch fail to protect =
against concurrent freeing of `device->private` during device initializatio=
n errors, leading to a Use-After-Free and memory corruption. If `dasd_eckd_=
check_characteristics` fails, its error path frees `device->private`. A con=
current unprivileged sysfs read can fetch the non-NULL pointer just before =
it is freed, bypass the check, and subsequently dereference or write to the=
 freed memory.
- [High] Missing NULL pointer checks in `dasd_copy_pair_store` and `dasd_ec=
kd_pprc_enabled` allow a kernel panic when configuring copy pairs via sysfs=
 during device initialization. The sysfs store handler `dasd_copy_pair_stor=
e` does not verify if `device->discipline` is allocated before dereferencin=
g `device->discipline->pprc_enabled`. Furthermore, if `device->discipline` =
is assigned but `device->private` is not yet allocated, `dasd_eckd_pprc_ena=
bled` unconditionally dereferences `device->private`, resulting in a kernel=
 panic.
- [High] Missing NULL pointer check for `device->private` in `dasd_eckd_rea=
d_fc_security()`, leading to a kernel panic triggered by asynchronous path =
events during initialization. If a hardware path event occurs after `device=
->discipline` is assigned but before `device->private` is allocated, `do_pe=
_handler_work()` executes and calls `dasd_eckd_read_fc_security()`, which u=
nconditionally dereferences `private`.
--

--- Patch [2]: [PATCH v5 02/17] s390/dasd: Guard sysfs discipline callbacks=
 against unallocated private data ---
commit d022f6e90af16afe7ae1766d9ba490832f14cca6
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Guard sysfs discipline callbacks against unallocated private data
   =20
Several sysfs show/store handlers call a discipline callback that
dereferences device->private, either directly or through the
DASD_DEFINE_ATTR() macro. During dasd_generic_set_online() the discipline
is assigned before check_device() allocates device->private, so an
unprivileged read of one of these world-readable attributes in that window
dereferences a NULL pointer and panics.

> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> index 74fe73b5738ab..a820d68122d93 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c
[ ... ]
> @@ -1666,6 +1674,9 @@ static int dasd_eckd_space_configured(struct dasd_d=
evice *device)
>  	struct dasd_eckd_private *private =3D device->private;
>  	int rc;
> =20
> +	if (!private)
> +		return 0;
> +

[Severity: Critical]
This is a pre-existing issue, but does this check protect against concurrent
freeing of device->private during device initialization errors?

If dasd_eckd_check_characteristics() fails, its error path frees
device->private without synchronization against concurrent lockless sysfs
readers:

    kfree(device->private);
    device->private =3D NULL;

Could a concurrent unprivileged sysfs read fetch the non-NULL pointer, pass
this check, and then perform a Use-After-Free when dasd_eckd_read_vol_info()
copies data into the freed private->vsq buffer?

>  	rc =3D dasd_eckd_read_vol_info(device);
[ ... ]
> @@ -5935,6 +5965,9 @@ static int dasd_eckd_query_host_access(struct dasd_=
device *device,
>  	struct ccw1 *ccw;
>  	int rc;
> =20
> +	if (!private)
> +		return -ENODEV;
> +
>  	/* not available for HYPER PAV alias devices */
>  	if (!device->block && private->lcu->pav =3D=3D HYPER_PAV)

[Severity: Critical]
This is a pre-existing issue, but could this still lead to a NULL pointer
dereference?

While this check ensures private is not NULL, private->lcu can remain NULL
until it is populated later by dasd_alias_make_device_known_to_lcu().

If an unprivileged sysfs read triggers dasd_eckd_host_access_count() which
calls dasd_eckd_query_host_access() during this window, wouldn't it bypass
the !private check and unconditionally dereference private->lcu->pav?

>  		return -EOPNOTSUPP;

[Severity: High]
This is a pre-existing issue, but I noticed a couple of other places that
might need similar NULL pointer checks.

In dasd_copy_pair_store() in drivers/s390/block/dasd_devmap.c, could
device->discipline be dereferenced while it is NULL when a user writes to
the copy_pair sysfs attribute during device initialization?

    if (device->discipline->pprc_enabled) {

Additionally, if device->discipline is set but device->private is not yet
allocated, could dasd_eckd_pprc_enabled() in drivers/s390/block/dasd_eckd.c
unconditionally dereference device->private?

    return private->rdc_data.facilities.PPRC_enabled;

[Severity: High]
This is also a pre-existing issue, but is a NULL check for device->private
needed in dasd_eckd_read_fc_security() as well?

If a hardware path event occurs after device->discipline is assigned but
before device->private is allocated, do_pe_handler_work() executes and calls
dasd_eckd_read_fc_security().

Could this unconditionally dereference private?

    rc =3D chsc_scud(private->uid.ssid, (u64 *)esm, &esm_valid);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731153842.1729=
627-1-sth@linux.ibm.com?part=3D2
