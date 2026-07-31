Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D130740A953
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 16:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785517125; cv=none; b=usJgTEKYa5/A/f/EJgfSGMvCp4lAgSmVdYl5Zv3lOqCHH7xZj9I0/HMeqxXLHUUSlK+taw6J0Lu2GqPp7KOdfdi+i2FRx/Qp+EEmi8tiaXgWJgAQGrweLchp52ajGK9vzjw1hmBNQcadB0kAPyLBwvib/IHxViGKKIyK7ZdNdt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785517125; c=relaxed/simple;
	bh=woo2M6lUXi1mBUe2HcWv5zH8zqMEQpGOUixK9oGTzbU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WoWdmfNgaDIn9Jp8boyBNBO2doA8AOz25+4GsCoEcesSqbjCgCTyWjXcQYCAPz6wKKzeCgC7xbSeRD5JEdMXF3Lsj4f4wU9hRSlCPk46ZSm989v2nkQ4rv9mIVKquznBl+OdFgKDK7ydXV8QssxCZoajuKgI/xKe/Rw1EZSQ+lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nxe1es3K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nxe1es3K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D3361F00AC4;
	Fri, 31 Jul 2026 16:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785517123;
	bh=H0PcjSQeBh1cHnW4uc94Zf/sahHVCyQv4Dcc6nIbRrs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Nxe1es3KrA9oP+ny4a3bfH5Cd5/Y68oueJUdZHN8Aw1hLg9Gbm/OrbgpHH80o4+5w
	 eHfxxJnC4GTfuw2EUV7SIKmGemyCU9LNm9wXwwc6wrJ/3GpFl5+ocvsrOZM92LmvA2
	 o6RZeIGFE3Ar9jI3uYL7KHoeQZ4NwA+OmbEaWO9h9smuVwO9zlWT1uDl9s6xU+2m2L
	 t8tK23+IvoAz7dBfbghk96YaXV/jmwhzqiQTs0m1IIA70cKS+Etzsi8or6PyEQQzjk
	 8Oms1Fe4e11YgllHF1aa5IJDAuQmKh/H48S/kiSIIBukZ9qG480kgITpsMxHwPjhEA
	 QzMYFI6T3T/9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 17/17] s390/dasd: Read cached unit address and LSS in
 the CCW build path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260731153842.1729627-18-sth@linux.ibm.com>
References: <20260731153842.1729627-1-sth@linux.ibm.com>
 <20260731153842.1729627-18-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 16:58:43 +0000
Message-Id: <20260731165843.6D3361F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Transient zeroing of `uid.type` disables alias device verification=
 in lockless CCW-build paths.
- [High] Concurrent sysfs write to `path_reset` triggers a Use-After-Free o=
r NULL pointer dereference on `conf.gneq`.
- [High] Concurrent `BIODASDINFO` / `BIODASDINFO2` ioctl triggers a Use-Aft=
er-Free or NULL pointer dereference on `conf.data`.
- [High] Concurrent execution of path event handlers and configuration relo=
ad causes memory corruption and UAF on `conf.data` and `conf.ned`.
- [High] TOCTOU NULL pointer dereference in `dasd_eckd_generate_uid`.
--

--- Patch [17]: [PATCH v5 17/17] s390/dasd: Read cached unit address and LS=
S in the CCW build path ---
commit 962f258b40a4684c7ad8e7e9f2ae8c0f71efe3ff
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Read cached unit address and LSS in the CCW build path

This commit resolves a use-after-free in the CCW build paths by caching
the unit address and LSS from conf.ned into the private device data. This
prevents a race condition where the reload worker frees conf.ned while
I/O requests are being built.

> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> index eb2a2f8fac644..6548ee0c01d90 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c
> @@ -588,8 +588,9 @@ static int prefix_LRE(struct ccw1 *ccw, struct PFX_ec=
kd_data *pfxdata,
>  		return -EINVAL;
>  	}
>  	pfxdata->format =3D format;
> -	pfxdata->base_address =3D basepriv->conf.ned->unit_addr;
> -	pfxdata->base_lss =3D basepriv->conf.ned->ID;
> +	/* cached copies - conf.ned may be freed under us by the reload worker =
*/
> +	pfxdata->base_address =3D basepriv->ned_ua;
> +	pfxdata->base_lss =3D basepriv->ned_lss;
>  	pfxdata->validity.define_extent =3D 1;
> =20
>  	/* private uid is kept up to date, conf_data may be outdated */

[Severity: High]
This is a pre-existing issue, but since this patch fixes lockless access
to ned_lss and ned_ua, could a similar problem occur with uid.type?

In drivers/s390/block/dasd_eckd.c, both prefix_LRE() and prepare_itcw()
read startpriv->uid.type locklessly during I/O submission:

    if (startpriv->uid.type =3D=3D UA_BASE_PAV_ALIAS)
        pfxdata->validity.verify_base =3D 1;

Concurrently, a configuration reload calls create_uid() under ccwdev_lock,
which executes memset(uid, 0, sizeof(struct dasd_uid)).

Could this transient zeroing of the uid structure disable alias device
verification during these CCW-build paths?

[ ... ]

> @@ -806,6 +807,9 @@ static int dasd_eckd_generate_uid(struct dasd_device =
*device)
>  		return -ENODEV;
>  	spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
>  	create_uid(&private->conf, &private->uid);
> +	/* cache LSS and unit address for the lockless CCW-build path */
> +	private->ned_lss =3D private->conf.ned->ID;
> +	private->ned_ua =3D private->conf.ned->unit_addr;
>  	spin_unlock_irqrestore(get_ccwdev_lock(device->cdev), flags);
>  	return 0;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but looking at the earlier checks
in dasd_eckd_generate_uid() in drivers/s390/block/dasd_eckd.c, there appears
to be a potential Time-of-Check to Time-of-Use race:

    if (!private->conf.ned || !private->conf.gneq)
        return -ENODEV;
    spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
    create_uid(&private->conf, &private->uid);
    /* cache LSS and unit address for the lockless CCW-build path */
    private->ned_lss =3D private->conf.ned->ID;

Since the NULL check for private->conf.ned happens outside the ccwdev_lock,
could a concurrent reconfiguration (like in dasd_eckd_identify_conf_parts())
locklessly set conf->ned to NULL? If so, would this result in a NULL pointer
dereference when it is subsequently used inside create_uid() or when caching
private->ned_lss?

[ ... ]

While reviewing the fixes for conf.ned, I noticed a few other pre-existing
synchronization issues related to configuration reloads and path events in
drivers/s390/block/dasd_eckd.c.

[Severity: High]
This is a pre-existing issue, but is there a potential use-after-free
in get_fcx_max_data() during a concurrent sysfs path_reset?

When dasd_eckd_clear_conf_data() frees device->path[i].conf_data, it
appears to leave private->conf.gneq pointing to the freed memory. Could
a concurrent sysfs write to path_reset call get_fcx_max_data() and
locklessly read private->conf.gneq->reserved2[7], dereferencing the
dangling pointer?

[Severity: High]
This isn't a bug introduced by this patch, but does the BIODASDINFO ioctl
have a similar race with device reloads?

Looking at dasd_eckd_fill_info(), it locklessly reads private->conf.len
and performs a memcpy() from private->conf.data. If the reload worker
calls dasd_eckd_clear_conf_data() concurrently, it frees the underlying
buffer and sets conf.data =3D NULL. Could the ioctl thread read a non-zero
length but execute the memcpy() after the buffer is freed or NULLed,
leading to a crash or a memory leak to userspace?

[Severity: High]
This is a pre-existing issue, but is there a lack of mutual exclusion
between path event handlers and configuration reloads?

The do_pe_handler_work() and do_reload_device() workers might execute
concurrently. If do_reload_device() calls dasd_eckd_clear_conf_data(),
could rebuild_device_uid() in the PE handler concurrently execute a
lockless memcpy() into the freed private->conf.data? Would it then call
dasd_eckd_generate_uid(), which dereferences the dangling conf.ned pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731153842.1729=
627-1-sth@linux.ibm.com?part=3D17
