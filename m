Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A52367F41;
	Sat,  5 Sep 2026 15:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788622516; cv=none; b=LguWgMcFR9Ke+KvsGoR4nsM62vnGbKEuLCOAL8ZnzHL8F040oL+dUbqS3pDUFPAS0mbSp3UsS6OjIqr6ImowS5ZYGpTYej5/GCzp+8UElgNZkS4eP2w3xq+iKCm+93qQa/rTR7w1Catmk0cERCK6+F0vSkMjcuU7WAdh3ni4qfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788622516; c=relaxed/simple;
	bh=UCLkGvz9bphD5D3pPmnqVrfV8k026Dz+wUyOxDff/to=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X4BTwcTJ8Wb6oIsY9KWlZ9+c43QeGWWBXiFdGXaIS+CCN5QYbigdQGVpIzRuLZ8NtzG/PEIBx5xJCH1QBtHAylBO6sYCIn1S8Viid0C9xCOVqmDnGR+t3OAknnXQrH02I0glmqCx/Nr4mNJWy0mm8UgqozUr/aOrZeON5M1iXEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FtVuq9ZY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtVuq9ZY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55561F00A3A;
	Sat,  5 Sep 2026 15:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788622515;
	bh=JveotNKSAhk51QThDvAuc/jnLFTAkyLioUsLXMfvDKs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FtVuq9ZYgLDKcUrBKIwIEI/PHyW7Z1T5gCkOuKp/E3t36n0fNXZ2ygWrbdwsyMlm+
	 fKdk0GjGct9cyVVf5WtFOIdHBq9qKwj2WvYf5+EFd5NyqaWVi++bz1E7qUkXbce+b7
	 qUK1WQR9kiTJQ7NeXi4wHnEz+U5WC45xWI00ZhzOIntCTdb+7Wupl9Pl7paSWZBUTt
	 Nh2Fo2Z29pSThkHeFe4YUcR3D8wZcTFIgCQB4VJs/wNpivAyT1eSR/PrPzvLgfJt0a
	 TnYb9med3nIxpa5Lq0Yi1wx0vqR3wP2Cmstmtkz/aNz7o1wUa8RjoSfUofAu2wj+kh
	 nxE4JCWF9MWGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] virtio: implement synchronize_cbs for remaining
 transports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260905152059.89560-4-kmehltretter@gmail.com>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
 <20260905152059.89560-4-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 15:35:14 +0000
Message-Id: <20260905153514.B55561F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] `virtio_vdpa_synchronize_cbs` fails to synchronize with the conf=
iguration callback, bypassing the synchronization mechanism entirely.

Pre-existing issues:
- [High] In remoteproc, virtqueues are freed without waiting for concurrent=
 SRCU readers to finish, violating RCU-001 and leading to a Use-After-Free.=
 Additionally, a TOCTOU vulnerability in `rproc_vq_interrupt` allows a NULL=
 pointer dereference.
- [High] In TmFIFO, virtqueues are freed concurrently with an active backgr=
ound workqueue, leading to Use-After-Free. The synchronization added is inh=
erently flawed and fails to wait for the workqueue.
--

commit 9ddf2954e77ee0736af8a3f1e37367f20723435b
Author: Karl Mehltretter <kmehltretter@gmail.com>

virtio: implement synchronize_cbs for remaining transports

virtio_reset_device() now calls synchronize_cbs to wait for running
callbacks. Its synchronize_rcu() fallback does not cover workqueue or
sleepable callbacks.

> diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/=
mellanox/mlxbf-tmfifo.c
> index 3c6408581373b..c260e3a1544ea 100644
> --- a/drivers/platform/mellanox/mlxbf-tmfifo.c
> +++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
[ ... ]
> @@ -1135,6 +1135,19 @@ static void mlxbf_tmfifo_virtio_reset(struct virti=
o_device *vdev)
>  	tm_vdev->status =3D 0;
>  }
> =20
> +static void mlxbf_tmfifo_virtio_synchronize_cbs(struct virtio_device *vd=
ev)
> +{
> +	struct mlxbf_tmfifo_vdev *tm_vdev =3D mlxbf_vdev_to_tmfifo(vdev);
> +	struct mlxbf_tmfifo *fifo =3D tm_vdev->vrings[0].fifo;
> +	unsigned long flags;
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(fifo->spin_lock); i++) {
> +		spin_lock_irqsave(&fifo->spin_lock[i], flags);
> +		spin_unlock_irqrestore(&fifo->spin_lock[i], flags);
> +	}
> +}

[Severity: High]
This is a pre-existing issue, but does this sequential locking actually
synchronize anything?  Acquiring and releasing locks one by one creates a r=
ace
window where callbacks can evade synchronization.

Additionally, does this fail to synchronize with the background workqueue
(fifo->work)?  The workqueue function mlxbf_tmfifo_rxtx_one_desc()
dereferences vring->vq outside of the spinlocks.

When mlxbf_tmfifo_virtio_del_vqs() clears and frees the virtqueue, there is
a use-after-free risk because we haven't flushed the workqueue or properly
synchronized here.

[ ... ]
> diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/=
remoteproc_virtio.c
> index d5e9ff045a28a..ecc022e354db1 100644
> --- a/drivers/remoteproc/remoteproc_virtio.c
> +++ b/drivers/remoteproc/remoteproc_virtio.c
[ ... ]
> @@ -89,14 +90,19 @@ static bool rproc_virtio_notify(struct virtqueue *vq)
>  irqreturn_t rproc_vq_interrupt(struct rproc *rproc, int notifyid)
>  {
>  	struct rproc_vring *rvring;
> +	int srcu_idx;
> +	irqreturn_t ret;
> +
> +	srcu_idx =3D srcu_read_lock(&rproc->vq_srcu);
> =20
>  	dev_dbg(&rproc->dev, "vq index %d is interrupted\n", notifyid);
> =20
>  	rvring =3D idr_find(&rproc->notifyids, notifyid);
> -	if (!rvring || !rvring->vq)
> -		return IRQ_NONE;
> +	ret =3D rvring && rvring->vq ? vring_interrupt(0, rvring->vq) : IRQ_NON=
E;

[Severity: High]
This is a pre-existing issue, but doesn't this double evaluation of
rvring->vq introduce a Time-of-Check to Time-of-Use (TOCTOU) vulnerability?

Because READ_ONCE() is not used, the compiler could reload a NULL pointer if
__rproc_virtio_del_vqs() clears rvring->vq concurrently, leading to a NULL
pointer dereference when calling vring_interrupt().

> +
> +	srcu_read_unlock(&rproc->vq_srcu, srcu_idx);
> =20
> -	return vring_interrupt(0, rvring->vq);
> +	return ret;
>  }
>  EXPORT_SYMBOL(rproc_vq_interrupt);
> =20
[ ... ]
> @@ -242,6 +248,13 @@ static void rproc_virtio_reset(struct virtio_device =
*vdev)
>  	dev_dbg(&vdev->dev, "reset !\n");
>  }
> =20
> +static void rproc_virtio_synchronize_cbs(struct virtio_device *vdev)
> +{
> +	struct rproc *rproc =3D vdev_to_rproc(vdev);
> +
> +	synchronize_srcu(&rproc->vq_srcu);
> +}

[Severity: High]
This is a pre-existing issue, but virtqueues are freed without waiting for
concurrent SRCU readers to finish, violating the RCU-001 rule (Remove Before
Reclaim).

synchronize_srcu() is called here during device reset, but not during
teardown.  In __rproc_virtio_del_vqs(), the virtqueue is removed and
immediately freed via vring_del_virtqueue() without a grace period.

Since the interrupt handler runs in an SRCU read-side critical section, can
this cause a use-after-free if vring_interrupt() executes on freed memory?

[ ... ]
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index de2af696de6ca..4f9e70c1332ef 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
[ ... ]
> @@ -123,8 +124,24 @@ static irqreturn_t virtio_vdpa_config_cb(void *priva=
te)
>  static irqreturn_t virtio_vdpa_virtqueue_cb(void *private)
>  {
>  	struct virtqueue *vq =3D private;
> +	struct virtio_vdpa_device *vd_dev;
> +	unsigned long flags;
> +	irqreturn_t ret;
> =20
> -	return vring_interrupt(0, vq);
> +	vd_dev =3D to_virtio_vdpa_device(vq->vdev);
> +	read_lock_irqsave(&vd_dev->callback_lock, flags);
> +	ret =3D vring_interrupt(0, vq);
> +	read_unlock_irqrestore(&vd_dev->callback_lock, flags);
> +
> +	return ret;
> +}

[Severity: Medium]
While virtio_vdpa_virtqueue_cb() was updated to acquire callback_lock,
virtio_vdpa_config_cb() (just above this context in the file) was not.

Doesn't this mean virtio_vdpa_synchronize_cbs() fails to synchronize with
configuration changes, bypassing the synchronization mechanism if a config
change occurs concurrently with device reset or teardown?

> +
> +static void virtio_vdpa_synchronize_cbs(struct virtio_device *vdev)
> +{
> +	struct virtio_vdpa_device *vd_dev =3D to_virtio_vdpa_device(vdev);
> +
> +	write_lock_irq(&vd_dev->callback_lock);
> +	write_unlock_irq(&vd_dev->callback_lock);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905152059.8956=
0-1-kmehltretter@gmail.com?part=3D3
