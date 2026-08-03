Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A16361948;
	Mon,  3 Aug 2026 16:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785776072; cv=none; b=GlUjKeNPJ06G/1Fkm32/5LQbvnLC9kv+EAddnbQeZjKBPt8epQ+MmHwkfk+F8cAsJp0JlB8L8xY8XHRGtuIVfgCwBDY74eexBzGy0Dhbx+AwhZ2OdN6bw1b0fLZRMQLG3FY6s+F5ukJS2pz2ZQg3I0s4h5uQvslGTj8HrWpx8gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785776072; c=relaxed/simple;
	bh=naM15WPB02gHNFVZOgz8+wWa2XGuuPShyOcwY8D5vVs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=suGuud5nH5K8cNd5sPKZ5QKlukk6P2MyGlwNO0cZOHXoEKJyxAF/LNcY2JhZs/+DWrqfNOp2RRvht0HDWmTw5Y8EC+cHNBD0kR/83oTsijsfRe5WPB1wGD7tOOJyZobZOP/MPhrlzqwyD3jn2QVAs4lcb/hTGU9skSD1rb9R8bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k08G6HC8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k08G6HC8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 684181F000E9;
	Mon,  3 Aug 2026 16:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785776070;
	bh=Po4NA3pbMN3nO040zLmXZgjiPAp6wU3U16Ti98zzWnU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k08G6HC8nz0XBOvjix5PpmUN1jlHeLC09i/IiXjeBW9vHtAQi+wlV/oxH0aG3GcLq
	 rfLjMWlYyhbgYFMIOJVQEorf6ihfVswD6BuoDerBobJm/0H+42PXxKw78TNNxKrsR8
	 2Yy99AfL3BMusM92zP0y/aRAR76cCRFf2SkO0yGZhNROhnqz1QsWxQM5nDp2Pfk2c2
	 Fu3W8FQwFzuwgOTbc7X/lr+TLqpwsWODAqa8URDtmqex6Mgo1UQ75fDTuORQBmlqF2
	 Ivwn+LPcKkh6h/5naiNPQOf7pMKDzM+kRw1wTDg54Jc0/sem0yTlou7uu4mSYJUkyt
	 jo/Lo3lUfSWGA==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL v1 09/23] s390/vfio_ccw: Selectively expand io_mutex
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260803160924.236807-10-imbrenda@linux.ibm.com>
References: <20260803160924.236807-1-imbrenda@linux.ibm.com>
 <20260803160924.236807-10-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 16:54:29 +0000
Message-Id: <20260803165430.684181F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent modification of the `private->crw` linked list without =
proper synchronization, risking list corruption.
- [High] Missing synchronization between CSS callbacks and `vfio_ccw_mdev_r=
emove()` causes use-after-free of `private`.
- [Medium] Valid CRW events are permanently dropped and lost if userspace p=
rovides an invalid read offset.
--

--- Patch [9]: [GIT PULL v1 09/23] s390/vfio_ccw: Selectively expand io_mut=
ex ---
commit 0dffa46dd03162ef88bfa6bbfa42490f8f336394
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: Selectively expand io_mutex

The io_mutex was defined to serialize the io_regions, but then has
also sort of been associated with the I/O themselves because of
the close relationship they share. This patch expands the scope of
io_mutex to close these remaining windows.

Cc: stable@vger.kernel.org

> diff --git a/drivers/s390/cio/vfio_ccw_chp.c b/drivers/s390/cio/vfio_ccw_=
chp.c
> index f3015132d4b5f..9269b54f5cfd4 100644
> --- a/drivers/s390/cio/vfio_ccw_chp.c
> +++ b/drivers/s390/cio/vfio_ccw_chp.c
> @@ -98,13 +98,13 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_c=
cw_private *private,
>  	if (pos + count > sizeof(*region))
>  		return -EINVAL;
> =20
> +	mutex_lock(&private->io_mutex);
>  	crw =3D list_first_entry_or_null(&private->crw,
>  				       struct vfio_ccw_crw, next);
> =20
>  	if (crw)
>  		list_del(&crw->next);

[Severity: High]
This isn't a bug introduced by this patch, but does this list_del() lack
proper synchronization?

It appears vfio_ccw_crw_region_read() dequeues from private->crw while
only holding the sleepable io_mutex. If an atomic channel path event
triggers vfio_ccw_chp_event() concurrently, it will call
vfio_ccw_queue_crw(), which locklessly adds to private->crw using
list_add_tail().

Since io_mutex is ignored by the atomic queue path, can this concurrent
access corrupt the linked list if userspace aggressively reads the CRW
region while hardware events are generated?

> -	mutex_lock(&private->io_mutex);
>  	if (i >=3D private->num_regions) {
>  		ret =3D -EINVAL;
>  		goto out;
>  	}

[Severity: Medium]
This is a pre-existing issue, but are valid CRW events permanently dropped
if userspace provides an invalid read offset?

The bounds check for the region index occurs after the event has already
been dequeued from private->crw. If the offset is invalid, the event seems
to be discarded and later freed on failure without delivery.

Should state mutations happen after all arguments are validated to prevent
this resource loss?

[ ... ]
> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_=
drv.c
> index c197ad5ab5805..757ff5b2556e3 100644
> --- a/drivers/s390/cio/vfio_ccw_drv.c
> +++ b/drivers/s390/cio/vfio_ccw_drv.c
[ ... ]

[Severity: High]
This is a pre-existing issue, but is there a missing synchronization step
between CSS callbacks and vfio_ccw_mdev_remove() that causes a
use-after-free?

In drivers/s390/cio/vfio_ccw_ops.c, vfio_ccw_mdev_remove() clears drvdata
and drops the final reference to the device:

vfio_ccw_mdev_remove() {
    ...
    dev_set_drvdata(&parent->dev, NULL);
    vfio_put_device(&private->vdev);
}

If an administrator initiates an mdev removal concurrently with a hardware
event, vfio_ccw_sch_event() in drivers/s390/cio/vfio_ccw_drv.c reads the
private pointer locklessly via dev_get_drvdata():

vfio_ccw_sch_event() {
    ...
    struct vfio_ccw_private *private =3D dev_get_drvdata(&parent->dev);
}

If the CSS callback is delayed after reading the pointer, could it execute
vfio_ccw_fsm_event() on the freed private structure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803160924.2368=
07-1-imbrenda@linux.ibm.com?part=3D9
