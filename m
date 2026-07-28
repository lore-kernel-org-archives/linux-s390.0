Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65204217704;
	Tue, 28 Jul 2026 01:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785203644; cv=none; b=W6k/TPW9mlU1kyJiRzCBGgonpwSCG5Ao+Ptaaq1eHbBvvwO5rAlhG+0TnYq7EnG2DbP5zco4VPWC7vT4nh6Dfr+pH8TxvlI1gx5el9zlJk+5B06scPkdAaVBMT8fmQ7kopOwsptQ/fttscUOkYT6nu2twMf7PXs2hgXf6HBYXHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785203644; c=relaxed/simple;
	bh=YaWInlr5Ob+JdWqEwGkP9y1q7qiEGTEeAJTnGd2ZDeU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Uoc1h6BtRb36rd8CnBtxdcdZ3H3buioLBrQv+Cx9BgQsQ0zsOk9JSYTkTixCu0oZepXZZ2R7Vyo4r0p5UD1sdWpHyB4Ra6Ka2z4lK3CYOhCeWIH5oaLyBjz+x7vq45S7MPgDrxLT7+N91qMcR+OH3pGYQL3gjY8oMDi16gBzyUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnNTgvp+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnNTgvp+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836231F000E9;
	Tue, 28 Jul 2026 01:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785203643;
	bh=0EqX0BkZMsoU2kT3vd330EV1XFJ9iMsE6bYwmrjwzMI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LnNTgvp+K3JrHkuvOz8ayzKD32OjYQDv9K92woa/5tfYGtx9L71FIMOJULQyVB8+R
	 tZW4WvcQZwh2JNyi6nReEVSw26ChI4xgOw9FWKg0sKSF8RuCIf59VYl7NXEftUjjK3
	 BWVKs2pQ1bP/707KD5cpu/Q9OW6zjMz1jrM3DkpP4XY2aVSUD51sCJ8qleGeiECBRe
	 jVL0bGUa5yEhUCepj41WJF7IjbbbG6MTeuCMc8SgjfPP5q0d5swzIPIE/kooPruUhJ
	 XI1cv+QwPu8rQX4WPLk/QvfaHiIaPoRBsEPoueupjlfuZouWc1y/TuMMnLkW3n7m8g
	 AS6gU//aCOTMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 06/10] s390/vfio_ccw: ensure index for read/write
 regions are within range
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260728013509.1551753-7-farman@linux.ibm.com>
References: <20260728013509.1551753-1-farman@linux.ibm.com>
 <20260728013509.1551753-7-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 01:54:01 +0000
Message-Id: <20260728015402.836231F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent access to the `private->crw` list without locking can l=
ead to double-free and list corruption.
- [High] `private->io_work` and `private->crw_work` are not explicitly canc=
eled before the `private` structure is freed, leading to a Use-After-Free.
--

--- Patch [6]: [PATCH v8 06/10] s390/vfio_ccw: ensure index for read/write =
regions are within range ---
commit dd567bdeb9066b3fa10790bef4429b4c38a7df1f
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: ensure index for read/write regions are within range
   =20
The introduction of the capability chain rightly clamped the
region indexes to the range of the capabilities itself, but
neglected to do so for the existing read/write regions which
should also be enforced.

> diff --git a/drivers/s390/cio/vfio_ccw_chp.c b/drivers/s390/cio/vfio_ccw_=
chp.c
> index 38c176cf62957..f3015132d4b5f 100644
> --- a/drivers/s390/cio/vfio_ccw_chp.c
> +++ b/drivers/s390/cio/vfio_ccw_chp.c

[ ... ]

> @@ -97,6 +105,12 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_c=
cw_private *private,
>  		list_del(&crw->next);

[Severity: High]
This is a pre-existing issue, but does concurrent access to the private->crw
list without locking lead to double-free and list corruption here?

The private->crw list is modified by list_add_tail() in vfio_ccw_queue_crw()
(invoked by channel path hardware event contexts):

drivers/s390/cio/vfio_ccw_drv.c:vfio_ccw_queue_crw() {
	...
	list_add_tail(&crw->next, &private->crw);
	queue_work(vfio_ccw_work_q, &private->crw_work);
	...
}

If a hardware event fires while userspace is concurrently removing an eleme=
nt
locklessly via list_del() in vfio_ccw_crw_region_read(), will the overlappi=
ng
list modifications corrupt the list?

> =20
>  	mutex_lock(&private->io_mutex);
> +	if (i >=3D private->num_regions) {
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	i =3D array_index_nospec(i, private->num_regions);
>  	region =3D private->region[i].data;
> =20
>  	if (crw)

[ ... ]

> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_=
ops.c
> index 45ec722d25ea6..032a1cdf4df70 100644
> --- a/drivers/s390/cio/vfio_ccw_ops.c
> +++ b/drivers/s390/cio/vfio_ccw_ops.c

[Severity: High]
This is a pre-existing issue, but are private->io_work and private->crw_work
explicitly canceled before the private structure is freed, or can this lead
to a use-after-free?

During device teardown, vfio_ccw_mdev_release_dev() frees the private struc=
ture
without explicitly canceling io_work and crw_work using cancel_work_sync():

drivers/s390/cio/vfio_ccw_ops.c:vfio_ccw_mdev_release_dev() {
	struct vfio_ccw_private *private =3D
		container_of(vdev, struct vfio_ccw_private, vdev);
	...
	mutex_destroy(&private->io_mutex);
}

Although vfio_ccw_sch_quiesce() calls flush_workqueue(), it does so before
calling cio_disable_subchannel(). If an interrupt arrives after the flush b=
ut
before the hardware is disabled, it could re-queue the work. When private is
later freed, will the pending work execute on freed memory?

> @@ -243,6 +243,7 @@ static ssize_t vfio_ccw_mdev_read(struct vfio_device =
*vdev,
>  		return vfio_ccw_mdev_read_io_region(private, buf, count, ppos);
>  	default:
>  		index -=3D VFIO_CCW_NUM_REGIONS;
> +		index =3D array_index_nospec(index, private->num_regions);
>  		return private->region[index].ops->read(private, buf, count,
>  							ppos);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728013509.1551=
753-1-farman@linux.ibm.com?part=3D6
