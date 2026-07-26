Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32901946BC;
	Sun, 26 Jul 2026 04:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785039249; cv=none; b=ELT05TW7+Y+wnaDW5OdyekZSV6GE4atVqVJWYPEyWjWPiKrRoiGtuE1MqoL+ukHMdohGSu4uz/YQsuKugEAQzz0hFCoqcbmFTaRJmJPuixt0Z4v+6+tucQ4vh+wckjkg4vohXcrBANNejG/2Lh4m9PtstFGR4HTQC3hjBXQTqJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785039249; c=relaxed/simple;
	bh=1eOg2W0KJ3qBuLM7Ah9nS6ZQniljZ13dMEQls+8RNAw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lbZFAwPl6jl8SbRa1K4xT2LhgJilc7DtAo0EtyUzou7IHWzteURbniI6V8a1X45aXuTiI7o3qOd89Up0A0FvFDSW7GNYvtqnnXdVmP7vW7k5IRMRSVTD2KpDNpOzzwwM6s7VMp1Pqih8UqWSzhW7hWBsC490q0fpmMCnwhunCAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOmqa2zl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOmqa2zl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C431F000E9;
	Sun, 26 Jul 2026 04:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785039247;
	bh=L7Hpcxc5PatqiDVdrF60T3OZznv1NOZTqruJVYtxKgM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AOmqa2zlbeddQQTEtG15hgRH36iEQsMC7bPd1c02RXviNkk/gq08kh1/vAjVnzrlt
	 Qdc/QIdWKwt3L4mh4sM/lVN5g8aVGPnLhKAZ923umZLfhN2hw+gDcXWqOfHNZxfpmE
	 fSlAH3vIPwDf1VyYW8c1+NI9t7RKx/P0TOJDvRxeIrIUaS0nqImnGE76L+O/i7fpbs
	 2BSFNaU0ZJL7fiz3aKWjgW/EHjCrf5WRq6T1ohAOqQ/L4PFLcumUoiJaldea1REhOP
	 6XBfNdHdpZNhiSw2Pq9OllWVHACroKT5iEa6t5cAvSIZ1uwdOe9GIFfKV44W+0bqEF
	 JC4CDiu8YUgaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/10] s390/vfio_ccw: move cp cleanup out of not
 operational
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260726040129.2946151-9-farman@linux.ibm.com>
References: <20260726040129.2946151-1-farman@linux.ibm.com>
 <20260726040129.2946151-9-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 04:14:06 +0000
Message-Id: <20260726041407.06C431F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Canceling `notoper_work` during device release can silently skip t=
he cleanup of channel program resources, causing a memory leak of pinned pa=
ges and ccwchains.

Pre-existing issues:
- [High] Asynchronous execution of `cp_free` in `vfio_ccw_notoper_todo` wit=
hout locks races with other accesses to `private->cp`, leading to data corr=
uption, double-frees, or use-after-free.
--

--- Patch [8]: [PATCH v5 08/10] s390/vfio_ccw: move cp cleanup out of not o=
perational ---
commit a24ecbe23bcd8a2b9448d2b68fd0bbf55921f7a3
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: move cp cleanup out of not operational

The fsm_notoper() routine is called when the device has been
lost, and is (by definition) no longer operational. Since this
can happen asynchronously from the normal behavior of the
driver, the cleanup may happen when holding other locks
in the calling sequence (notably, the cio subchannel lock).

Push the cleanup of the private->cp resources to a workqueue,
where it can be done out from under that lock sequence and
(soon) under its own serialization mechanism.

Fixes: 204b394a23ad ("vfio/ccw: Move FSM open/close to MDEV open/close")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Farman <farman@linux.ibm.com>

> diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_=
drv.c
> index 1a095085bc728..c197ad5ab5805 100644
> --- a/drivers/s390/cio/vfio_ccw_drv.c
> +++ b/drivers/s390/cio/vfio_ccw_drv.c

[ ... ]

> @@ -125,6 +125,15 @@ void vfio_ccw_crw_todo(struct work_struct *work)
>  		eventfd_signal(private->crw_trigger);
>  }
> =20
> +void vfio_ccw_notoper_todo(struct work_struct *work)
> +{
> +	struct vfio_ccw_private *private;
> +
> +	private =3D container_of(work, struct vfio_ccw_private, notoper_work);
> +
> +	cp_free(&private->cp);

[Severity: High]
This is a pre-existing issue, but moving the cleanup to an asynchronous
workqueue exposes a race condition.

Does calling cp_free() here asynchronously without holding locks race with
other FSM callbacks?

For example, if fsm_close() is triggered concurrently, it calls cp_free()
synchronously outside of sch->lock. Since the cp->initialized check in
cp_free() is non-atomic:

drivers/s390/cio/vfio_ccw_cp.c:cp_free() {
    if (!cp->initialized)
        return;
    cp->initialized =3D false;
    ...
}

Could multiple threads bypass this check concurrently, leading to double-fr=
ees
of the ccwchain_list and use-after-free conditions?

> +}
> +
>  /*
>   * Css driver callbacks
>   */

[ ... ]

> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_=
ops.c
> index 9048c1e6e7f0c..26c19f0e5e474 100644
> --- a/drivers/s390/cio/vfio_ccw_ops.c
> +++ b/drivers/s390/cio/vfio_ccw_ops.c

[ ... ]

> @@ -138,6 +139,7 @@ static void vfio_ccw_mdev_release_dev(struct vfio_dev=
ice *vdev)
> =20
>  	cancel_work_sync(&private->io_work);
>  	cancel_work_sync(&private->crw_work);
> +	cancel_work_sync(&private->notoper_work);

[Severity: High]
If the device is closed or unbound before the workqueue has a chance to
execute, does canceling notoper_work here silently skip the cleanup of
the channel program resources?

Since fsm_notoper() changes the state to VFIO_CCW_STATE_NOT_OPER when
queuing this work, standard close handlers like fsm_close() bypass
cp_free().

Without a fallback call to cp_free() to reclaim resources if the work
execution was skipped by cancel_work_sync(), will this result in a
permanent memory leak of pinned guest pages and ccwchain structures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726040129.2946=
151-1-farman@linux.ibm.com?part=3D8
