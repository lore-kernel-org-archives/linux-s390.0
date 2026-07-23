Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AF04BC00E
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 14:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784817352; cv=none; b=Pb/OBmXwi1VohnkUVY7Lttv9PapdonoViwpTkh3V5gw3YN3jxzPZB0pM6MwjVY4h1Bw+hbd2FLTWPFYphlFTwAPJkQmdWGbV7MlEBuzWcIBxSxd4IN0SdykjlYrI0ys3UA8rw4HQ6IAbWo3K9abvWj5Cn639c8oWiGkcKm4Yezk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784817352; c=relaxed/simple;
	bh=JD3vY5YUO1uZX2QXBspeF9SMkATnC+5/Zu0NOhvJRMc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UiibXpIQ2PKATrHyNpEFkPNoq9a7kc/xaC1mfchq0jor9BKw1XS4CuxlzTVQnohcbeyDCMEdo18DA8wXgAjeIIFQ10rdiBc/blhwk/wGwvUzQWAQdr5w0Hc2sRjh0UdmBNDr+MomtpNfHAElCU88MtTk4eZ6i1rTVUkK9zSn/bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMZoyFQE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMZoyFQE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF6801F000E9;
	Thu, 23 Jul 2026 14:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784817348;
	bh=fuSjRbRWMfZTCz/qhotT2no1We4ZizNGfsf8mre2pms=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fMZoyFQEAFojn7+FeDSke7/dbE02dGwrr9FHFBYziJ+4VVe6KYl2Toovq1IOfFtw9
	 arJlTzfOb3p/vgdZgpfR3y/N5wy1fWjf7baGeoTJXVkXXQUcf+6+AMVNpkxQ7GdkHs
	 akeB6b0L9MrlIUtRDG3BcykGNRfg7iMKvL14e98m1DdhWooeznWwL+NtsQbtyqlXb9
	 b++wBzwMv3qZXfioTiuORUe/jrjmqjLYZGOF0CHJfQ9PHiQ1tqR/0ayYL7Fn3NTJH0
	 bun4x1oQMiBdrcrRBQIDMTeQ9LKFhhQZxdTUqzhqQmqctEOrrH7MofhY4O0NRPvKYv
	 WysTQgro6GXuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/13] s390/dasd: Read cached unit address and LSS in
 the CCW build path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260723134743.672413-14-sth@linux.ibm.com>
References: <20260723134743.672413-1-sth@linux.ibm.com>
 <20260723134743.672413-14-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 14:35:47 +0000
Message-Id: <20260723143547.DF6801F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Lockless reads of `uid.real_unit_addr` in I/O submission paths can=
 observe transient zeros due to `memset()` in `create_uid()`, causing CCWs =
to misdirect I/O to unit 0.

Pre-existing issues:
- [High] Concurrent device reconfiguration can set `conf.ned` to NULL after=
 it is validated, leading to a NULL pointer dereference in `create_uid()`.
--

--- Patch [13]: [PATCH v3 13/13] s390/dasd: Read cached unit address and LS=
S in the CCW build path ---
commit 9a16f7344a5a15020b53dfe98bcf28e857e3119a
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Read cached unit address and LSS in the CCW build path

This commit updates the CCW build path to read the cached unit address
and LSS instead of the configuration data directly, to avoid a
use-after-free when conf.ned is reallocated concurrently.

> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> index 571a693a33a3c..1a7d40e45d963 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c
> @@ -587,8 +587,9 @@ static int prefix_LRE(struct ccw1 *ccw, struct PFX_ec=
kd_data *pfxdata,
>  		return -EINVAL;
>  	}
>  	pfxdata->format =3D format;
> -	pfxdata->base_address =3D basepriv->conf.ned->unit_addr;
> -	pfxdata->base_lss =3D basepriv->conf.ned->ID;
> +	/* cached copies - conf.ned may be freed under us by the reload worker =
*/
> +	pfxdata->base_address =3D basepriv->uid.real_unit_addr;

[Severity: High]
Can this lockless read observe transient zeros and misdirect I/O to unit 0?

When building a CCW for a PAV alias device, this executes under the alias
device's lock, leaving the base device lock unacquired. Concurrently, a
configuration reload on the base device triggers dasd_eckd_generate_uid(),
which takes the base device's lock and calls create_uid().

Looking at create_uid(), it zeroes the entire structure in-place:

drivers/s390/block/dasd_eckd.c:create_uid() {
	memset(uid, 0, sizeof(struct dasd_uid));
	...
}

Since this CCW build path operates locklessly with respect to the base
device, won't it read a transient zero for real_unit_addr, leading to
silent data corruption on volume 0 and missing data on the intended volume?

> +	pfxdata->base_lss =3D basepriv->ned_lss;
>  	pfxdata->validity.define_extent =3D 1;
> =20
>  	/* private uid is kept up to date, conf_data may be outdated */

[ ... ]

> @@ -805,6 +806,8 @@ static int dasd_eckd_generate_uid(struct dasd_device =
*device)
>  		return -ENODEV;
>  	spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
>  	create_uid(&private->conf, &private->uid);

[Severity: High]
This is a pre-existing issue, but does this sequence introduce a TOCTOU race
leading to a NULL pointer dereference?

dasd_eckd_generate_uid() locklessly checks private->conf.ned right before
acquiring the ccwdev_lock to call create_uid() here.

Concurrently, path verification without locks can clear conf->ned:

do_pe_handler_work()
  -> rebuild_device_uid()
    -> dasd_eckd_identify_conf_parts()
         conf->ned =3D NULL;

If a thread context switches between the lockless check and lock acquisition
here, won't create_uid() dereference the NULL conf->ned pointer?

drivers/s390/block/dasd_eckd.c:create_uid() {
	...
	memcpy(uid->vendor, conf->ned->HDA_manufacturer, ...);
	...
}

> +	/* cache the LSS for the lockless CCW-build path (see ned_lss) */
> +	private->ned_lss =3D private->conf.ned->ID;
>  	spin_unlock_irqrestore(get_ccwdev_lock(device->cdev), flags);
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723134743.6724=
13-1-sth@linux.ibm.com?part=3D13
