Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676C8145A1F;
	Sun, 26 Jul 2026 04:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785039508; cv=none; b=SlFKWl4KZGZkHeefM5y+UrwZdJlzaM04qm0ov/HNVzwnnNiJpIZAw2s4mXaDQ31HicS/sLf5s7PZbwSqFZVwO20DgKKB65yslZgQSRPkjzzc9ZR9DIYCgKQc4Aa83tTxrp5Th1aRIODJd2zz4la+6/MvhjeiV1qYpGSrTs9vLL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785039508; c=relaxed/simple;
	bh=1sFHXWHolhCdNXFWn4KL1qz2PptZ93mrPkdjYvBWctA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jdcbYDPHdJr5ekWXBq20Pfp8hhi3X315N5jVo9mSCT0Je7DWrmyRKPKSIGiUExOcuz2v7VEAgotlPBK45a0qaD4FL72fbNWnRvt3ZXh9BrPMhkliwJ7lzMwZmL8DJV+vVJB81LDw/pvQG/N/+A0/s42QgItZskyrUsG8U13FxVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pt06nWK4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pt06nWK4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87CEE1F000E9;
	Sun, 26 Jul 2026 04:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785039506;
	bh=5XBgTWYe/u/1rToJLwX+oDlOCGTr5Gq9mXhkVljIeOA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pt06nWK4R/KTaTV37Dg9jc9wOLlPY7A+BpiSB8F1gWEpOcxAYXm7Rcwv7uiqVyDhX
	 O1ZJ+u6xXLS8Hg3go2vtlMqUy6JPNuPBJxWRxIvnR3k6H8mJw2qjXyoPKwAFzgeqz+
	 1h4+mqRemCPwPvut9qHCYnhw0YFFj/FNzRrNK8UQkSXSbjvsVRVdbdRz7z9Rm+aJgP
	 8a314DW9mhunrUpwIodN1iXragSfUarUlvTplmSWdFDQqZ3v5XLerLXolybLBSFCgY
	 51sxZHzu3ZrAXwwWzY2RvqgrnObDxMyisQWQJPJsKWs840yQHkSz1N/LFtqqSOY33E
	 y1NkyZ7+c7Xdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/10] s390/vfio_ccw: implement a channel program
 mutex
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260726040129.2946151-10-farman@linux.ibm.com>
References: <20260726040129.2946151-1-farman@linux.ibm.com>
 <20260726040129.2946151-10-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 04:18:26 +0000
Message-Id: <20260726041826.87CEE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Channel program resources are leaked if `notoper_work` is cancelle=
d during device release.

Pre-existing issues:
- [High] Unprotected access to `private->irb` could lead to data corruption=
 on concurrent interrupts.
--

--- Patch [9]: [PATCH v5 09/10] s390/vfio_ccw: implement a channel program =
mutex ---
commit cd6c396d349e5308a7574cecefee3c092057158e
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: implement a channel program mutex

This commit introduces a mutex to serialize the manipulation of the channel
program structure (private->cp). It also adjusts where the subchannel
spinlock is acquired and released so it coexists properly with the new
mutex.

> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_=
drv.c
> index c197ad5ab5805..4830f0dd9c3a3 100644
> --- a/drivers/s390/cio/vfio_ccw_drv.c
> +++ b/drivers/s390/cio/vfio_ccw_drv.c
> @@ -91,6 +91,8 @@ void vfio_ccw_sch_io_todo(struct work_struct *work)
> =20
>  	is_final =3D !(scsw_actl(&irb->scsw) &
>  		     (SCSW_ACTL_DEVACT | SCSW_ACTL_SCHACT));

[Severity: High]
This is a pre-existing issue, but does this code locklessly access the
shared irb structure?

In fsm_irq(), private->irb can be overwritten locklessly from hardirq
context:

fsm_irq()
    memcpy(&private->irb, irb, sizeof(*irb));

Concurrently, vfio_ccw_sch_io_todo() reads private->irb here and evaluates
its contents without acquiring a lock like sch->lock.

If a spurious or unsolicited hardware interrupt arrives while the workqueue
is processing a previous interrupt, could a torn or partially updated read
result in incorrect I/O completion status being passed to the guest?

> +
> +	mutex_lock(&private->cp_mutex);
>  	if (scsw_is_solicited(&irb->scsw)) {
>  		cp_update_scsw(&private->cp, &irb->scsw);

[ ... ]

> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_=
ops.c
> index 26c19f0e5e474..b8e702f36106c 100644
> --- a/drivers/s390/cio/vfio_ccw_ops.c
> +++ b/drivers/s390/cio/vfio_ccw_ops.c
> @@ -146,6 +153,7 @@ static void vfio_ccw_mdev_release_dev(struct vfio_dev=
ice *vdev)
>  	kmem_cache_free(vfio_ccw_cmd_region, private->cmd_region);
>  	kmem_cache_free(vfio_ccw_io_region, private->io_region);
>  	kfree(private->cp.guest_cp);
> +	mutex_destroy(&private->cp_mutex);

[Severity: High]
Can this leak channel program resources?

If fsm_close() fails, it triggers a VFIO_CCW_EVENT_NOT_OPER event, which
queues notoper_work to free the channel program.

If the device is subsequently released before the workqueue executes,
vfio_ccw_mdev_release_dev() cancels the work:

vfio_ccw_mdev_release_dev() {
    ...
    cancel_work_sync(&private->notoper_work);
    ...
}

Since cancel_work_sync() aborts the cleanup without a fallback, and
vfio_ccw_mdev_release_dev() does not explicitly call cp_free(), do the
channel program structures (ccwchain) and pinned guest pages remain
leaked indefinitely?

>  	mutex_destroy(&private->io_mutex);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726040129.2946=
151-1-farman@linux.ibm.com?part=3D9
