Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA86323392C
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 18:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785608994; cv=none; b=femuulULJ+33n8Dt5x04+rypWv1/wwcNC/QNwlO/PoPugxBnUp0xhpHrjLqDYdI9l1JHLmSEXgxtmG6OQh0PsFmW6N4mTUA4Zo/u2gmwAkCRzwRT12Hlnlx8MrNM+bowSdKg4OQzyq/jY3/55ZzJAd7WqBU+KKqlVBIyrEWtabk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785608994; c=relaxed/simple;
	bh=qyXOLvGWOabvKObuoafOfHEglIi6BaIocONKY1xVd+s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B+2zX1tew0q8MwRw7IiIj00+gFJS4L2/OH1dFf4RX/qKZ8BctmBLQPbwVjSZVsjEBatA7wF7pnsqKIRsd/SxKtfAB7gsGHQY2v89mm0bItl2wury2tWnSl1h/5j82DW9syXm13eFTFjuXJAAGOBcFsVbnoZQk+gCDTUp/SpUKNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgmk7BZ4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgmk7BZ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EAE51F00AC4;
	Sat,  1 Aug 2026 18:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785608992;
	bh=5C4yUtDBAlQww2avB8+8XCX7ihyOCOBhd5zQTXkeyMQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fgmk7BZ4d2YR+XPkr0TSzxzctNLFsCwUz4lMZ2SIirwcOGk0J/cFi6OBLgh3Bf5ce
	 4mGUUNpRr8ewdQ9o4RnupkxxwzghXS2MaZToj9wjW3924X4JotOAIT6jDz2hGmg7Ze
	 4IRZudLWgh9iDBRGTLsaYiEdt+kHasxz/0EJPtrwSNH2RgkxuikxjO2xmF5Nn5Pu8o
	 6cs/rlSYyhbV/tyuoCMM6LXZ2nDaGdvTUu+MOBRsNEd+0f1K50tjOB/OEYnBSsX2dJ
	 7sp5+R9jdrGisWJxu4ffJ0QxSnsWYTCuY4T/gpz+O3J+AJWPaEXhmJ6XSiZ+AtdeBL
	 O8OWEavfIyFLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 03/19] s390/dasd: Guard sysfs discipline callbacks
 against unallocated private data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260801180033.3679412-4-sth@linux.ibm.com>
References: <20260801180033.3679412-1-sth@linux.ibm.com>
 <20260801180033.3679412-4-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 18:29:51 +0000
Message-Id: <20260801182952.2EAE51F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Medium] Lockless reads of `device->private` lack `READ_ONCE()`, leaving =
them vulnerable to compiler reloading and TOCTOU races.
- [Low] A race condition between reading `private->lcu` and `private->featu=
res` allows unsupported I/O on HYPER PAV alias devices.

Pre-existing issues:
- [High] The patch misses a NULL pointer dereference in `dasd_eckd_pprc_ena=
bled()` reachable via the `copy_pair` sysfs attribute.
- [High] Asynchronous path event handlers unconditionally dereference `devi=
ce->private` and are not canceled on initialization failure.
- [High] Lockless access to `device->private` in sysfs handlers allows a us=
e-after-free if device initialization fails.
--

--- Patch [3]: [PATCH v7 03/19] s390/dasd: Guard sysfs discipline callbacks=
 against unallocated private data ---
commit ef202481581d23c8dd03c5042f532b8675ad8998
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Guard sysfs discipline callbacks against unallocated private data

This commit guards several sysfs show/store handlers against unallocated
device->private pointers during device initialization.

Fixes: c729696bcf8b ("s390/dasd: Recognise data for ESE volumes")
Cc: stable@vger.kernel.org

> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> index 74fe73b5738ab..6e2fd445688cb 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c

[Severity: High]
This is a pre-existing issue, but does this patch miss guarding
dasd_eckd_pprc_enabled()?

When a device is set online, device->discipline is assigned before
check_device() allocates device->private. If the copy_pair sysfs attribute
is written during this window, dasd_copy_pair_store() locklessly invokes
device->discipline->pprc_enabled(device):

    if (device->discipline->pprc_enabled) {
        pprc_enabled =3D device->discipline->pprc_enabled(device);

The callback unconditionally dereferences
private->rdc_data.facilities.PPRC_enabled, which seems like it could still
cause a NULL pointer dereference.

[Severity: High]
This is also a pre-existing issue, but are asynchronous path event handlers
safe from this same NULL pointer dereference?

If a path event occurs while device->private is unallocated, the CIO layer
triggers dasd_eckd_pe_handler() which schedules do_pe_handler_work().
Functions like dasd_eckd_read_fc_security() then unconditionally dereference
private:

    rc =3D chsc_scud(private->uid.ssid, (u64 *)esm, &esm_valid);

Additionally, if dasd_eckd_check_characteristics() encounters an error, its
out_err1 path frees device->private but does not appear to cancel the pendi=
ng
pe_handler_worker workqueue, which could lead to a panic later.

[Severity: High]
This is another pre-existing issue, but is the lockless access to
device->private safe from use-after-free if device initialization fails?

While the new guards prevent NULL pointer dereferences, device->private is
accessed locklessly in these handlers. If dasd_eckd_check_characteristics()
encounters an error, it calls kfree(device->private). If a concurrent sysfs
reader has just passed the if (!private) check, could it proceed to
dereference the freed memory?

[ ... ]

> @@ -1831,7 +1848,11 @@ static int dasd_eckd_read_ext_pool_info(struct das=
d_device *device)
>  static int dasd_eckd_ext_size(struct dasd_device *device)
>  {
>  	struct dasd_eckd_private *private =3D device->private;
> -	struct dasd_ext_pool_sum eps =3D private->eps;
> +	struct dasd_ext_pool_sum eps;
> +
> +	if (!private)
> +		return 0;
> +	eps =3D private->eps;

[Severity: Medium]
Should we use READ_ONCE() when assigning private from device->private?

Because device->private is accessed locklessly and can be set to NULL
concurrently by the error path, could the compiler optimize this by
reloading the pointer from device->private after the NULL check? This might
allow a TOCTOU NULL pointer dereference if it gets set to NULL between the
check and the reload.

> =20
>  	if (!eps.flags.extent_size_valid)
>  		return 0;

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

[Severity: Low]
Could checking private->lcu here introduce a race with the subsequent
private->features check?

A sysfs reader thread could read private->lcu as NULL before it is populated
and bypass this abort. If preempted, check_device() could finish populating
both lcu and features. When the reader resumes, it could evaluate the newly
initialized features and proceed to issue the PSF command. Would this allow
an unsupported command on HYPER PAV aliases?

>  		return -EOPNOTSUPP;
> =20
>  	/* may not be supported by the storage server */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801180033.3679=
412-1-sth@linux.ibm.com?part=3D3
