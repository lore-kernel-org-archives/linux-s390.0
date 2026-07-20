Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5C525742F;
	Mon, 20 Jul 2026 20:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784579983; cv=none; b=aOBIBgqEv8p17oUqmA3fedr3IeHf7Wiz63/11SHS8KDHhtD1QNpDA+gpiJ2cu62PH9oLmXAbeUkDmUgx+/nRWYwhSKIPtMk3pMcpKqmqW5qAY+QInoIfgDnWjQz6SwgKuu6XM7h/c3rr5JmaJB42WOI8/ViXqte9FpACowa3w4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784579983; c=relaxed/simple;
	bh=dmNZjmCDG/aaPSXRnqtycOTx0rMveFMt5K00B3e8Uqc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Gzy4E/iWa19siuxAIzypx08V1k2gKdvo6m5flWQGLUNnpevqVuy9flbaG802RFT6V1IHlDW/92nLk4aY5Z77AvyQSYY1F2OzTa705CbyiVE3MzlxUSeUOJJ/M3vUuvcgk0MQOaX8YfE4tnTFUOrzgCrOC7HEuS9/AYzf80ggal4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqQQ6B8I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqQQ6B8I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7201F000E9;
	Mon, 20 Jul 2026 20:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784579982;
	bh=H4iJBTSbwS1KF9aOrC1/DytakzylbuLsU2Yqm3qTe50=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DqQQ6B8IvwrQs7syhUuZN1kBMflc6t9NrO8qHKfjthVqP6+dRIZc8WWyD7THLNH1z
	 4hHr4+B8KuI94cBaiXt0Z4uYiDnn0YWxdEXYritXvX9HgBBpBCMQNa4ZLoRmmUw+jx
	 TFXilH+lba9nD0PedF7WnxEYKW91LS1LyOSmeN2jPbBS9Pmg31tFGT0h46YPfc6mrj
	 +qN2D5m+FS2EGu10ryyXi+bEsMNfy/9uDXOTF94Dj8v6/u6fQyVoyawVsQWCwnC1ZO
	 IMriCaHbDcsBWlEaPi/CK49hynTtsbVs1PHbB4soM9n5QmO/uYuSAnGdxKddiCvZxY
	 X+K0mBlbWRG7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/7] s390/vfio_ccw: implement a channel program lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260720201931.976660-7-farman@linux.ibm.com>
References: <20260720201931.976660-1-farman@linux.ibm.com>
 <20260720201931.976660-7-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 20:39:41 +0000
Message-Id: <20260720203941.9E7201F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The newly introduced `cp_lock` spinlock is held while executing op=
erations that acquire sleeping locks, leading to a guaranteed 'scheduling w=
hile atomic' kernel BUG.

Pre-existing issues:
- [High] Incomplete locking allows a data race between channel program init=
ialization and `vfio_ccw_dma_unmap()`, leading to a NULL pointer dereferenc=
e.
- [High] The background work items `crw_work` and `io_work` are not explici=
tly cancelled before the driver frees the device's private memory.
--

--- Patch [6]: [PATCH v2 6/7] s390/vfio_ccw: implement a channel program lo=
ck ---
commit fcac9cc035321189b03cc15ccc7af0d3409a1018
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: implement a channel program lock

The channel_program struct is manipulated without a serialization
mechanism to ensure consistent behavior. This patch introduces a spin
lock to guard the entire structure, which can be acquired with or
without the mutex guarding the I/O regions.

> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_c=
p.c
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -810,6 +810,17 @@ void cp_free(struct channel_program *cp)
>  	}
>  }
> =20
> +void cp_free(struct channel_program *cp)
> +{
> +	struct vfio_ccw_private *private =3D
> +		container_of(cp, struct vfio_ccw_private, cp);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&private->cp_lock, flags);
> +	cp_free_locked(cp);

[Severity: High]
Does holding the cp_lock spinlock here lead to a scheduling while atomic bu=
g?

When cp_free_locked() cascades into the unpinning logic:

cp_free_locked()
  page_array_unpin_free()
    vfio_unpin_pages()
      vfio_iommu_type1_unpin_pages()
        mutex_lock(&iommu->lock);

The IOMMU backend unconditionally acquires a sleeping lock while the
thread is in atomic context from the spin_lock_irqsave(). Can this crash
the kernel when I/O request cleanup executes?

> +	spin_unlock_irqrestore(&private->cp_lock, flags);
> +}
> +

[ ... ]

> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_=
ops.c
> --- a/drivers/s390/cio/vfio_ccw_ops.c
> +++ b/drivers/s390/cio/vfio_ccw_ops.c
> @@ -36,10 +36,15 @@ static void vfio_ccw_dma_unmap(struct vfio_device *vd=
ev, u64 iova, u64 length)
>  {
>  	struct vfio_ccw_private *private =3D
>  		container_of(vdev, struct vfio_ccw_private, vdev);
> +	unsigned long flags;
> =20
>  	/* Drivers MUST unpin pages in response to an invalidation. */
> -	if (!cp_iova_pinned(&private->cp, iova, length))
> +	spin_lock_irqsave(&private->cp_lock, flags);
> +	if (!cp_iova_pinned(&private->cp, iova, length)) {

[Severity: High]
This is a pre-existing issue, but does adding the lock here expose a NULL
pointer dereference due to incomplete locking elsewhere?

In fsm_io_request(), cp_init() and cp_prefetch() are called without
holding the new cp_lock. cp_init() sets cp->initialized =3D true. Then
cp_prefetch() calls page_array_alloc(), which does:

page_array_alloc()
  pa->pa_nr =3D len;
  pa->pa_iova =3D kzalloc_objs(*pa->pa_iova, len);

If a concurrent unmap enters vfio_ccw_dma_unmap(), acquires cp_lock, and
iterates the channel program because initialized is true, can it
dereference the still-NULL pa->pa_iova array since the initializing
thread hasn't allocated it yet?

> +		spin_unlock_irqrestore(&private->cp_lock, flags);
>  		return;
> +	}
> +	spin_unlock_irqrestore(&private->cp_lock, flags);
> =20
>  	vfio_ccw_mdev_reset(private);
>  }

[ ... ]

> @@ -54,6 +59,7 @@ static int vfio_ccw_mdev_init_dev(struct vfio_device *v=
dev)
>  	INIT_LIST_HEAD(&private->crw);
>  	INIT_WORK(&private->io_work, vfio_ccw_sch_io_todo);
>  	INIT_WORK(&private->crw_work, vfio_ccw_crw_todo);
> +	spin_lock_init(&private->cp_lock);

[Severity: High]
This isn't a bug introduced by this patch, but do these work items leak
and cause a use-after-free on device teardown?

According to the subsystem guidelines, once queue_work() is called,
flush_work() and other workqueue shutdown methods prevent us from leaking
the work struct on shutdown.

If an asynchronous subchannel event fires and queues crw_work, and the
user concurrently removes the mdev device, vfio_ccw_mdev_release_dev()
frees the private structure:

vfio_ccw_mdev_release_dev()
  kfree(private->cp.guest_cp);
  mutex_destroy(&private->io_mutex);

Will the workqueue scheduler eventually execute the pending crw_work and
access the already-freed private structure, since the removal function
drops references without explicitly cancelling background work?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720201931.9766=
60-1-farman@linux.ibm.com?part=3D6
