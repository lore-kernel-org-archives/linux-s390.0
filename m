Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C6630C618;
	Tue, 28 Jul 2026 04:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785211327; cv=none; b=AsGYERHZ/Vy/p9z58JCSUtZsfCvD0LF006Hh2OVKK8FCJfk4QcDuT7KpDcRCWpWsUmupB6BcyKeyyRcDuRkqerCRE9xblCdB5RvsddcxZXkDK+Rbt9o5kgZv54Rh5nsB+JAH8P4mRmEvuj+tvknnaIXlAW3mITRwdfkrl/Z5M9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785211327; c=relaxed/simple;
	bh=TDjDWMK50GnLfma4cmm8c6RjKyRZdKHab+Naoyh3tdw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QDb0OMWMbrhGd2R++T0bvH6FsOOx46b5CjpXYxPoptKWoOGt6hxZl3cI+D+774eJk6kVXEePSnqzf6v5zGZ3jdIYwRdrQcyHhHHhYBj1bUbRMpS0JKzMDb+RvRrqUWO2NzosLLciZ9OK/+vbFa53apEa+X0gk9q1lEgW9/L/vMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSVm5gtv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSVm5gtv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B50EB1F000E9;
	Tue, 28 Jul 2026 04:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785211326;
	bh=WLQKGNU6n9WsQBNJUGCXMD8FR0c/KNrTLDbM7d415QM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mSVm5gtvzriHtbKUeIZN6zUHLnPAZ0KKF24UUNjQ0JvqOa9TzxCbDbPHgJShchWq8
	 FVkaYzIoTm1QZndniBmKpEJN9t0YIgG8tGfTknmwOG5OB9UQKpNSkjzwAg3oAwaQ9d
	 RMRKTMQYYi/mqIsJ8Q5UZzIlUUqELEpVtiE/Z49QcHEvl4KOrob/AVxRn+yNKxe0SE
	 AoYpOn7iXwwat4dWS5XqAUEinFInT9M57hR4e6t4AO7cXb0Sisjg9jHBk5wWwQ0NDL
	 p8Ii9vMQGMAj4VIE2hxiFAEJQeNGM4WJCRjfyEY5x6adkpK26C+T64O+9s8YjHtyiU
	 rY+HbgXk0mmwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 06/10] s390/vfio_ccw: ensure index for read/write
 regions are within range
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org
In-Reply-To: <20260728033022.2658232-7-farman@linux.ibm.com>
References: <20260728033022.2658232-1-farman@linux.ibm.com>
 <20260728033022.2658232-7-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 04:02:05 +0000
Message-Id: <20260728040205.B50EB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Race condition causing linked list corruption on `private->crw=
`.
- [Critical] Missing background work cancellation leading to Use-After-Free.
--

--- Patch [6]: [PATCH v9 06/10] s390/vfio_ccw: ensure index for read/write =
regions are within range ---
commit a96682323321d1f6bd6354e74ae1c8c0bbb835a1
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: ensure index for read/write regions are within range

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

[Severity: Critical]
This is a pre-existing issue, but is it safe to dequeue from private->crw
locklessly here?

In drivers/s390/cio/vfio_ccw_drv.c:vfio_ccw_queue_crw(), the hardware event
path appends to this list without locks:

    list_add_tail(&crw->next, &private->crw);

Could a concurrent userspace read on the CRW region race with a hardware
event and corrupt the linked list pointers?

> =20
>  	mutex_lock(&private->io_mutex);
> +	if (i >=3D private->num_regions) {
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	i =3D array_index_nospec(i, private->num_regions);
>  	region =3D private->region[i].data;


[Severity: Critical]
This is another pre-existing issue, but does vfio_ccw_mdev_release_dev()
need to cancel the background work queues during teardown?

drivers/s390/cio/vfio_ccw_ops.c:vfio_ccw_mdev_release_dev() {
    struct vfio_ccw_private *private =3D
        container_of(vdev, struct vfio_ccw_private, vdev);
    ...
}

During device release, if fsm_close() disables the subchannel immediately
and skips vfio_ccw_sch_quiesce(), could private->crw_work and
private->io_work still be queued?

Since vfio_ccw_mdev_release_dev() lacks cancel_work_sync() calls, would any
pending work items execute after the private struct has been freed by the
VFIO core, leading to a use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728033022.2658=
232-1-farman@linux.ibm.com?part=3D6
