Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE12D2E737E
	for <linux-s390@vger.kernel.org>; Wed,  5 Aug 2026 20:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785961916; cv=none; b=TTOoRUwGZdQr9LBDuxnO3N76RyTzwVgQaPgBBaHQhyN9RN6eSwXRys9YsjiDBer2Lw8iWCmcMB9za6SZ43c/MBmCjx6aGn5E3EqoOdPfohFZ4sCjbNyIqnGe5v5NuU+aKNPBGG4uUkBYhIrB0DzDTtvtIHZOU5vZoqQLDtPdk0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785961916; c=relaxed/simple;
	bh=SVYG8iNvBdKqGbaRRPjzPi6hqNHrRpFAMexp5tx3YBM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MgIPBhBUdulprYvyZnfRjyh0xuta0r+Lou7lDysqJmpPi6tGBmTOya9TD7wv30wDiwWVWd49+W8C2i5+8L3QLSM/GdkdxliR73QzECEDbfrD6Gvod15znbOUfUj774BMT8HYyepU6bM+ANKNnxZXw7RgQB3nvOQ3oIyBbYbq7oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbKvfas3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbKvfas3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09731F000E9;
	Wed,  5 Aug 2026 20:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785961915;
	bh=CY/IQmaoGKhtzeoT+D04RfLnn50yh8qLD4usP14P9TI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dbKvfas3HyZ7whX0r2KXcM/64auZRKdkUiSV2gdpP2fiOBDDw+mZODFaMMlf748ai
	 AEqusn4qjFn65WpNhA539P9bmjkDfaM+SA/zn260x2QBcqWXJrONiIjF7E2Qj0fieB
	 kkj5Ht/BydaueJmmFZqzkKWo0g8bjvhdxJ7jNKLZ1wJNJZ2eM0qtoTqUWiUo0HapT+
	 dV+76ZueHF6340lxxJEm4+h96x3cs5DUXfNofTixrbdqKdgxqUT6AkDRwy9xHzp5F/
	 rQcmCTOWFxDi8Fh03f+1Uh8xIdsgb1tMzK6YJ5SwTsbsZPztlw12hb0yZ6XOwZquBh
	 JOQd1TVMMv1Xg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 19/19] s390/dasd: Read cached unit address and LSS in
 the CCW build path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260805111612.1285190-20-sth@linux.ibm.com>
References: <20260805111612.1285190-1-sth@linux.ibm.com>
 <20260805111612.1285190-20-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 20:31:54 +0000
Message-Id: <20260805203154.C09731F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Lockless readers can observe a mismatched, torn state of `ned_lss`=
 and `ned_ua` due to sequential 8-bit reads and writes.

Pre-existing issues:
- [Critical] Concurrent execution of path event handler and device reload l=
eads to unlocked `memcpy` into freed `private->conf.data`.
- [High] sysfs `path_reset` attribute accesses `private->conf.gneq` without=
 locks, racing with configuration data reallocation.
- [High] Concurrent execution of `dasd_eckd_generate_uid` and `dasd_eckd_re=
ad_conf` results in a Use-After-Free read of the dangling `private->conf.ne=
d` pointer.
--

--- Patch [19]: [PATCH 19/19] s390/dasd: Read cached unit address and LSS i=
n the CCW build path ---
commit 27a80ff5ec151de5f38d959cec701e81aa17aed0
Author: Stefan Haberland <sth@linux.ibm.com>
s390/dasd: Read cached unit address and LSS in the CCW build path

The CCW build path read the base address and LSS straight from conf.ned,
which could be freed by the reload worker. This patch caches unit address
and LSS in the private structure and reads the cached copies to prevent
use-after-free.

>     The CCW build path (prefix_LRE, the full-track prefix and dso_ras) re=
ad the
>     base address and LSS straight from conf.ned. That buffer is freed and
>     reallocated by the reload worker (do_reload_device - dasd_eckd_read_c=
onf -
>     dasd_eckd_clear_conf_data), so a configuration change concurrent with=
 I/O
>     can free conf.ned while a request is being built.

[Severity: Critical]
This is a pre-existing issue, but does concurrent execution of the path eve=
nt
handler and device reload lead to an unlocked memcpy into freed memory?

The path event worker do_pe_handler_work() calls rebuild_device_uid(), which
copies configuration data using:

memcpy(private->conf.data, data->rcd_buffer, DASD_ECKD_RCD_DATA_SIZE);

Concurrently, do_reload_device() calls dasd_eckd_clear_conf_data(), which
explicitly sets private->conf.data =3D NULL and frees the buffer.

Neither path acquires ccwdev_lock or state_mutex. Can this cause the memcpy
to write into freed heap memory or dereference a NULL destination pointer?

[Severity: High]
This is another pre-existing issue, but does the sysfs path_reset attribute
access private->conf.gneq without locks, racing with configuration data
reallocation?

The sysfs store function dasd_path_reset_store() calls dasd_eckd_reset_path=
(),
which calls get_fcx_max_data(). This function reads
private->conf.gneq->reserved2[7] without acquiring any locks.

Since do_reload_device() can concurrently execute dasd_eckd_clear_conf_data=
()
and free the memory block that conf.gneq points into, while failing to set
conf.gneq to NULL, can get_fcx_max_data() dereference a dangling pointer and
cause a use-after-free read?

> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> index 5c1f328b7c8d7..fd23ac25a7da9 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c
> @@ -589,8 +589,9 @@ static int prefix_LRE(struct ccw1 *ccw, struct PFX_ec=
kd_data *pfxdata,
>  		return -EINVAL;
>  	}
>  	pfxdata->format =3D format;
> -	pfxdata->base_address =3D basepriv->conf.ned->unit_addr;
> -	pfxdata->base_lss =3D basepriv->conf.ned->ID;
> +	/* cached copies - conf.ned may be freed under us by the reload worker =
*/
> +	pfxdata->base_address =3D READ_ONCE(basepriv->ned_ua);
> +	pfxdata->base_lss =3D READ_ONCE(basepriv->ned_lss);

[Severity: High]
Can lockless readers observe a mismatched, torn state of ned_lss and ned_ua=
 due
to sequential 8-bit reads?

Since ned_lss and ned_ua are separate 8-bit variables, they are read
sequentially here.

If a concurrent configuration change updates both variables, could a lockle=
ss
reader be preempted between the two reads and observe a torn state, such as
the old LSS but the new unit address?

[ ... ]

> @@ -807,6 +808,9 @@ static int dasd_eckd_generate_uid(struct dasd_device =
*device)
>  		return -ENODEV;
>  	spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
>  	create_uid(&private->conf, &private->uid);
> +	/* cache LSS and unit address for the lockless CCW-build path */
> +	WRITE_ONCE(private->ned_lss, private->conf.ned->ID);
> +	WRITE_ONCE(private->ned_ua, private->conf.ned->unit_addr);

[Severity: High]
This is a pre-existing issue, but does concurrent execution of
dasd_eckd_generate_uid() and dasd_eckd_read_conf() result in a use-after-fr=
ee
read of the dangling private->conf.ned pointer here?

Since dasd_eckd_clear_conf_data() frees the configuration data buffer but
fails to nullify the derived private->conf.ned and private->conf.gneq point=
ers,
the lockless check for !private->conf.ned at the start of this function pas=
ses
because the pointer is dangling rather than NULL.

Does this cause the code to acquire ccwdev_lock and access freed memory ins=
ide
create_uid() and these newly added WRITE_ONCE() statements?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805111612.1285=
190-1-sth@linux.ibm.com?part=3D19
