Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077A1DDCD
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 11:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785584952; cv=none; b=HXisoI9WdpkqznPtSuERyzqD02goIzD0rgO4uanrQwhBN5boRS0HmUyRwbBDW1jpe5hYX09b+aHr7ZhHA4c6ka8wivIaObM7XdZx2Gf3BUc2GrAGvaMV64HTJ5Wjs8L7A2SRyvjTb6x7GKs1pLnO2jUpmKh4aQLYKRzyDdRZq6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785584952; c=relaxed/simple;
	bh=e94UuDpR4kjbnJGHrEEe18nno4JzLLBIelAl1N7uxFs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mSbzPmrT5bv1jHk1NV7RALnWrviUSgDlLj219qj+LiuJOEP6Ug+Wy3uS/C6hDW9J8qt6FV4pJ7xZZxhgBGA0H+rI4kGGAkGAO2jIXOUTwYA+6cOdZk+8GDdRmiqY0IbRTl36t/ul9QAZcHPMiqb3lKli6EAbARgF+A7vy5OI81A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBtpw8TH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBtpw8TH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5849F1F00AC4;
	Sat,  1 Aug 2026 11:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785584950;
	bh=oi/KFX1Cc+q0JWaSfXwmQUNLmfuWg2tEWc1v8hvvt2U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fBtpw8THyZOLUi40R0Xe+HfH0WriDdkS3IoVHoCvP9q60Rc1UEuurZHyEinPyy+H4
	 VisAJfjPd5vjQcYR8OvelkxFSXs1WDnD2wCTLAVHoFOfmxNqp4Lg7+FPOIiYIIrpPE
	 AK/1e5AA9TklFD+lAfIZH0mw/2xAGE7LyucuhC7db478i/qn6BIT9sWXICT50SQ0sR
	 z9x6kU5UIACrCkfctCQYWvII/XeFUz7rzG0K/I6yKOrUnashHypyK81XmISlrQx5DA
	 xrrlZcdeG9VYeEacMk7XRxqPuHWHMy7W1NlJ6ouGKgmcMLK6nZ1BWeFfv7UHNZ9tnz
	 qJqzvXPBVH1AA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 18/18] s390/dasd: Read cached unit address and LSS in
 the CCW build path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260801111008.3391031-19-sth@linux.ibm.com>
References: <20260801111008.3391031-1-sth@linux.ibm.com>
 <20260801111008.3391031-19-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 11:49:09 +0000
Message-Id: <20260801114910.5849F1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Low] Missing READ_ONCE()/WRITE_ONCE() annotations for locklessly accesse=
d cached variables.

Pre-existing issues:
- [High] Lockless CCW build paths read `uid.type` which is subject to a tra=
nsient zero during configuration reload, resulting in malformed commands.
- [High] Race condition in `dasd_eckd_generate_uid` and `rebuild_device_uid=
` against configuration reload workers allowing Use-After-Free and kernel h=
eap corruption.
- [High] Lockless access to `private->conf.data` in `dasd_eckd_fill_info` c=
an lead to a Use-After-Free and leak freed kernel memory to userspace.
--

--- Patch [18]: [PATCH v6 18/18] s390/dasd: Read cached unit address and LS=
S in the CCW build path ---
commit db725aecd487c6d786378910088d76a932cca049
Author: Stefan Haberland <sth@linux.ibm.com>
Date:   Sat Aug 1 11:10:08 2026 +0000

    s390/dasd: Read cached unit address and LSS in the CCW build path
   =20
    The CCW build path (prefix_LRE, the full-track prefix and dso_ras) read=
 the
    base address and LSS straight from conf.ned. That buffer is freed and
    reallocated by the reload worker (do_reload_device - dasd_eckd_read_con=
f -
    dasd_eckd_clear_conf_data), so a configuration change concurrent with I=
/O
    can free conf.ned while a request is being built.
    Use-after-free reported by KASAN in prefix_LRE.
   =20
    Read the cached copies instead.
    The unit address is already kept in uid.real_unit_addr, and the LSS is =
now
    cached in ned_lss. Both are refreshed under the ccwdev lock in
    dasd_eckd_generate_uid whenever the configuration is (re)read.
    Also fix for prepare for read subsystem data (prssd) users.
   =20
    Reviewed-by: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
    Signed-off-by: Stefan Haberland <sth@linux.ibm.com>

> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> index 09ef6d11f0ce7..816ea66fb2fe4 100644
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

[Severity: Low]
Are READ_ONCE() and WRITE_ONCE() annotations needed for these cached
variables?

The variables private->ned_lss and private->ned_ua are updated in
dasd_eckd_generate_uid() under the ccwdev_lock, but are intentionally read
locklessly here in prefix_LRE().

The Linux kernel memory model typically requires READ_ONCE() and WRITE_ONCE=
()
for concurrent lockless accesses to prevent compiler optimizations like load
fusing and to document the intentional data race, which avoids KCSAN
warnings.

>  	pfxdata->validity.define_extent =3D 1;
> =20
>  	/* private uid is kept up to date, conf_data may be outdated */

[Severity: High]
This is a pre-existing issue, but does this lockless read of
startpriv->uid.type risk seeing a transient zero?

Just after this comment, prefix_LRE() and prepare_itcw() locklessly read
startpriv->uid.type. When a reload worker concurrently calls create_uid(),
it memsets the entire uid structure to zero:

drivers/s390/block/dasd_eckd.c:create_uid() {
    ...
    memset(uid, 0, sizeof(struct dasd_uid));
    ...
}

If prefix_LRE() or prepare_itcw() reads startpriv->uid.type while it is
transiently zeroed, the reader may observe the type as 0 (UA_BASE_DEVICE)
instead of UA_BASE_PAV_ALIAS or UA_HYPER_PAV_ALIAS.

Consequently, the driver will silently fail to set the verify_base and
hyper_pav flags in the PFX hardware command, which could lead to malformed
storage requests, rejected I/Os, or potential data corruption.

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
This is a pre-existing issue, but is there a use-after-free risk involving
private->conf.ned in this function?

Just before the lock is acquired, dasd_eckd_generate_uid() locklessly check=
s:

drivers/s390/block/dasd_eckd.c:dasd_eckd_generate_uid() {
    ...
    if (!private->conf.ned || !private->conf.gneq)
        return -ENODEV;
    spin_lock_irqsave(...)
    ...
}

Concurrently, a reload worker executing dasd_eckd_read_conf() calls
dasd_eckd_clear_conf_data(), which frees the underlying conf.data memory
without acquiring ccwdev_lock.

Since conf.ned points inside the freed conf.data allocation,
dasd_eckd_generate_uid() can pass the lockless check but dereference freed
memory once inside the lock.

Additionally, rebuild_device_uid() writes directly to private->conf.data
using memcpy() without locking. If the reload worker frees conf.data
concurrently, rebuild_device_uid() might overwrite freed slab memory, causi=
ng
kernel heap corruption.

[Severity: High]
This is a pre-existing issue, but does dasd_eckd_fill_info() also risk a
use-after-free that could leak freed memory to userspace?

The BIODASDINFO ioctl path calls dasd_ioctl_information(), which invokes
dasd_eckd_fill_info() without acquiring any device locks:

drivers/s390/block/dasd_eckd.c:dasd_eckd_fill_info() {
    ...
    memcpy(info->configuration_data, private->conf.data, info->confdata_siz=
e);
    ...
}

Concurrently, a reload worker executing dasd_eckd_reload_device() calls
dasd_eckd_clear_conf_data(), setting private->conf.data to NULL and freeing
the underlying memory:

drivers/s390/block/dasd_eckd.c:dasd_eckd_clear_conf_data() {
    ...
    private->conf.data =3D NULL;
    ...
    kfree(device->path[i].conf_data);
}

If the ioctl thread reads the private->conf.data pointer just before the
reload worker frees it, the memcpy() will read from freed slab memory, leak=
ing
potentially sensitive kernel data to userspace. If it reads NULL, it will
cause a kernel panic.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801111008.3391=
031-1-sth@linux.ibm.com?part=3D18
