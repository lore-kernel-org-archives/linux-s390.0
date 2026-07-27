Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7EC3D3499;
	Mon, 27 Jul 2026 20:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785182630; cv=none; b=A85eVuZaNZkSrC0usi9jylbNgvu8Fefsy29YAVCaDKPCHxijj7mJphWzUDG62UUAfKIXiaueLx6O7yUx23Ym2UoDv3lkn0LiHpOMcuqVWhNomsRy1CXpZEY3DFOAkWWxczbz9BLqQdlU12ueizTJfRCZUu1+9KEgqlaZxMzFSro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785182630; c=relaxed/simple;
	bh=9T5YxTQK23Y6mmy/57FwAhONNL4BSaipIBvUnydnDcM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tR6sg9lEMw9fvMF3hQXjYVCAGpF1z2ea0tPY6Jcr36Go4FzTHgV1HYzppd4jGl3CHdWGfZL24x6Ri5U7LJiU67D04Lj3RPJhQZeFeIiEQTBNHRDlyln3u92Ks/uZ5HISAHV1LGuLt48ICu1aI/AdDzWu5zE4K/xZ22QfJLAeii8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNtXKpR5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNtXKpR5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4ED21F00A3A;
	Mon, 27 Jul 2026 20:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785182629;
	bh=wClLzNCwgAI0+TrvDl9iiRDFJFy8VZJ1bacbzzfBO3U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jNtXKpR5U9DJSXOQtnTNJs4Z2OuAVP+GmTlxJtVkgEX2sqQ3sPRt7p0Cn0txv0sPw
	 dF5gXwlvQTPfwjUiiIo4Z/E1xdb/ArS4YfWGNvD26qEw2mDqy9JQR8GxL6ZsIsQJz+
	 5Cm25Orrl5Sw/qr1DJys7q1Vqh88zBjPuClejDeF0GUQ9Ebmloys2PtpxGDpOby+hS
	 WlczsznO3DQ/54mFxyxnVEFoQBT6Aw1xKqDa4Md7KY5WgAGYUYR0NwXP2CIyB/9RU+
	 FOKVmLT8rb83t8Hm3ngVbkaU9RPm8xwAZ0omngFL2Vxm9gk5lLb+xzGnMkf4zFz1r7
	 kSePXnaO6bEew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 06/10] s390/vfio_ccw: ensure index for read/write
 regions are within range
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260727192230.2715207-7-farman@linux.ibm.com>
References: <20260727192230.2715207-1-farman@linux.ibm.com>
 <20260727192230.2715207-7-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 20:03:48 +0000
Message-Id: <20260727200348.A4ED21F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Concurrent lockless modification and usage of `private->*_trig=
ger` eventfd pointers can lead to use-after-free.
- [High] Concurrent lockless accesses and modifications to the `private->cr=
w` list lead to list corruption, infinite loops, and potential use-after-fr=
ee.
- [High] Work items `io_work` and `crw_work` are not unconditionally cancel=
led before freeing the device structure.
--

--- Patch [6]: [PATCH v7 06/10] s390/vfio_ccw: ensure index for read/write =
regions are within range ---
commit f8eafc3dc61a7fdadf00091fc10c59686336cf60
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: ensure index for read/write regions are within range

This patch adds bounds checking to the region indexes in the read/write pat=
hs.
The capability chain previously clamped the region indexes, but the existing
read/write regions lacked these checks, which are now enforced.

> diff --git a/drivers/s390/cio/vfio_ccw_chp.c b/drivers/s390/cio/vfio_ccw_=
chp.c
> index 38c176cf62957..f3015132d4b5f 100644
> --- a/drivers/s390/cio/vfio_ccw_chp.c
> +++ b/drivers/s390/cio/vfio_ccw_chp.c
[ ... ]
> @@ -97,6 +105,12 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_c=
cw_private *private,
>  		list_del(&crw->next);
> =20
>  	mutex_lock(&private->io_mutex);

[Severity: High]
This is a pre-existing issue, but is the private->crw list modified lockles=
sly
here?

If an asynchronous host event handler queues a CRW using list_add_tail():

drivers/s390/cio/vfio_ccw_drv.c:vfio_ccw_queue_crw() {
	...
	list_add_tail(&crw->next, &private->crw);
	queue_work(vfio_ccw_work_q, &private->crw_work);
	...
}

Could a concurrent read from userspace calling vfio_ccw_crw_region_read()
corrupt the list pointers when calling list_del() since neither operation
appears to hold a lock protecting private->crw?

> +	if (i >=3D private->num_regions) {
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	i =3D array_index_nospec(i, private->num_regions);
>  	region =3D private->region[i].data;
> =20
>  	if (crw)

> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_=
ops.c
> index 45ec722d25ea6..032a1cdf4df70 100644
> --- a/drivers/s390/cio/vfio_ccw_ops.c
> +++ b/drivers/s390/cio/vfio_ccw_ops.c
[ ... ]
> @@ -243,6 +243,7 @@ static ssize_t vfio_ccw_mdev_read(struct vfio_device =
*vdev,
>  		return vfio_ccw_mdev_read_io_region(private, buf, count, ppos);
>  	default:
>  		index -=3D VFIO_CCW_NUM_REGIONS;

[Severity: High]
This is a pre-existing issue, but are io_work and crw_work unconditionally
cancelled before freeing the device structure?

Looking at vfio_ccw_mdev_release_dev(), the private structure is freed:

drivers/s390/cio/vfio_ccw_ops.c:vfio_ccw_mdev_release_dev() {
	...
	kfree(private->cp.guest_cp);
	mutex_destroy(&private->io_mutex);
}

If a background event queues io_work or crw_work, and the work item is not
flushed before release, could vfio_ccw_crw_todo() dereference the freed
private pointer when accessing private->crw_trigger?

drivers/s390/cio/vfio_ccw_drv.c:vfio_ccw_crw_todo() {
	private =3D container_of(work, struct vfio_ccw_private, crw_work);

	if (!list_empty(&private->crw) && private->crw_trigger)
	...
}

[Severity: Critical]
This is another pre-existing issue, but can concurrent modification and usa=
ge
of the private->*_trigger eventfd pointers lead to a use-after-free?

The VFIO_DEVICE_SET_IRQS ioctl can locklessly drop the reference and clear =
the
eventfd pointer:

drivers/s390/cio/vfio_ccw_ops.c:vfio_ccw_mdev_set_irqs() {
	...
		if (fd =3D=3D -1) {
			if (*ctx)
				eventfd_ctx_put(*ctx);
			*ctx =3D NULL;
	...
}

If background work items like vfio_ccw_crw_todo() check the pointer and then
call eventfd_signal():

drivers/s390/cio/vfio_ccw_drv.c:vfio_ccw_crw_todo() {
	...
	if (!list_empty(&private->crw) && private->crw_trigger)
		eventfd_signal(private->crw_trigger);
	...
}

Could the eventfd context be freed between the check and the signal call,
resulting in a dereference of the freed context?

> +		index =3D array_index_nospec(index, private->num_regions);
>  		return private->region[index].ops->read(private, buf, count,
>  							ppos);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727192230.2715=
207-1-farman@linux.ibm.com?part=3D6
