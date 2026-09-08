Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2C2346769;
	Tue,  8 Sep 2026 05:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788846851; cv=none; b=aKigLCupQZX3cGteGK9LxWzHAduGxkgbCcf4KYPUF9/rWnMPSeia+x4S+Jpx4PN6gCtnsY5pIz2/Vg2eSSb1UO3v0e0R15BmJvMZ2KaZJU1TxsOkSgJ5tit2J+COnxiiJrYHzyFKU0DtHjOuMgY+Jpk7R8eslbG4m1z8GuL6w5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788846851; c=relaxed/simple;
	bh=mT/BEDZCvFFw/WyZ8gxw9ZabNkjnVcffpanyF5fNEK0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Hogj3p2dhgXS+Etp/a247OmH6TFqe893OebfSAOk4ChFsk1peU9TtQ9uRZlbk6NbUQEXQzYhp5i/T5jdEM1W/vIeJvggaXJ6DilMtIVyNyo07fbP0kOndz3/MCGTL40kCjV9YmdVjVZAZPPv31kMevcw9EX1drr5VNvoZ1fDLmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XD1dYi+J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XD1dYi+J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70ED01F00A3A;
	Tue,  8 Sep 2026 05:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788846849;
	bh=7kYSFIpqDcpAolN1ELPGHHQRorQFLdu+TzF/k20bpNQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XD1dYi+Jf094qk+BzihvCKhdIqUGgwyoJrjuMTSPIWblmfNk7J5wseh9K4h7ZXrl3
	 2ZZ2S6GQgCPiwJhdWgQC9IM/hDDjt0vwzB+D229W1F5uwq6roVp4J8EE+6/HUtJ8E3
	 J9pT2meGjgJayx/XVi3pvzjj+OWO2PF3GtgrmqyuxTBJE6hQFj4kS8DYQpAnMJpKUK
	 zSp2YKHuX5HWYVZs0L7ZgaDiqgXhy1uPi/T1n2yiK2fQyrG6cP8zvvOaKbGVA02VIM
	 9NBlt0WUps+qszgopp0dK/4OfZDLSNM0HTi4JkoYz1iX9w6rowqC8/oLCvkvauue1n
	 k0+soPWl+4bJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/6] remoteproc: implement synchronize_cbs() for
 virtio devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, dmitry.torokhov@gmail.com, linux-s390@vger.kernel.org, linux-input@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260908053817.26065-4-kmehltretter@gmail.com>
References: <20260908053817.26065-1-kmehltretter@gmail.com>
 <20260908053817.26065-4-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 05:54:08 +0000
Message-Id: <20260908055408.70ED01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [High] idr_find() is called without rcu_read_lock() in preemptible contex=
ts, leading to potential use-after-free of radix tree nodes.
- [High] The virtqueue pointer is published before its initialization is co=
mplete and without necessary memory barriers, exposing uninitialized memory=
 to concurrent readers.
- [High] The added SRCU synchronization leaves the rvring structure vulnera=
ble to Use-After-Free during device teardown.
- [High] Error path in rp_find_vq() erroneously removes the vring IDR entry=
 without clearing it, permanently breaking the vring and causing a double-f=
ree on teardown.
- [High] rproc_add() error path causes a use-after-free and a double-free o=
f the rproc structure.
- [High] Missing cancel_work_sync() for the crash handler work item before =
freeing the rproc struct.
--

commit c12071a358959f8d763c10c9e9b78779109dae3f
Author: Karl Mehltretter <kmehltretter@gmail.com>

remoteproc: implement synchronize_cbs() for virtio devices

Platform drivers invoke rproc_vq_interrupt() from hard-IRQ handlers,
threaded handlers, and work items. Because rpmsg callbacks may sleep,
the virtio core's synchronize_rcu() fallback does not synchronize with
callbacks across all these contexts. A device reset can therefore
complete while a callback is still running.

> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/re=
moteproc_core.c
> index f003be006b1bf..6756f2fe4ec50 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -2367,6 +2367,7 @@ static void rproc_type_release(struct device *dev)
> =20
>  	dev_info(&rproc->dev, "releasing %s\n", rproc->name);
> =20
> +	cleanup_srcu_struct(&rproc->vq_srcu);

[Severity: High]
This isn't a bug introduced by this patch, but is there a risk of a
use-after-free here if the crash handler work item is still pending?

rproc_alloc() initializes the rproc->crash_handler work item. If the remote
processor is deleted and freed, neither rproc_del() nor rproc_type_release()
calls cancel_work_sync(&rproc->crash_handler). If the work executes after t=
his
structure is freed, the thread will dereference freed memory.

[Severity: High]
This is a pre-existing issue, but can the error path in rproc_add() cause a
use-after-free and a subsequent double-free?

If device_add(dev) fails, the error path erroneously calls put_device(dev):

drivers/remoteproc/remoteproc_core.c:rproc_add() {
    ...
    ret =3D device_add(dev);
    if (ret < 0) {
        put_device(dev);
        goto rproc_remove_cdev;
    }
    ...
rproc_remove_cdev:
    rproc_char_device_remove(rproc);
    return ret;
}

Since the initial refcount is 1, put_device() drops it to 0, immediately
freeing the rproc structure. Calling rproc_char_device_remove(rproc) then
accesses the cdev within the already freed memory. Returning the error to t=
he
caller typically results in rproc_free() being called, causing a double-fre=
e.

>  	idr_destroy(&rproc->notifyids);
> =20
>  	if (rproc->index >=3D 0)
[ ... ]
> diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/=
remoteproc_virtio.c
> index d5e9ff045a28a..7fefb4bd7adcb 100644
> --- a/drivers/remoteproc/remoteproc_virtio.c
> +++ b/drivers/remoteproc/remoteproc_virtio.c
[ ... ]
> @@ -88,15 +89,23 @@ static bool rproc_virtio_notify(struct virtqueue *vq)
>   */
>  irqreturn_t rproc_vq_interrupt(struct rproc *rproc, int notifyid)
>  {
> +	irqreturn_t ret =3D IRQ_NONE;
>  	struct rproc_vring *rvring;
> +	struct virtqueue *vq;
> +	int idx;
> =20
>  	dev_dbg(&rproc->dev, "vq index %d is interrupted\n", notifyid);
> =20
> +	idx =3D srcu_read_lock(&rproc->vq_srcu);
> +
>  	rvring =3D idr_find(&rproc->notifyids, notifyid);

[Severity: High]
This is a pre-existing issue, but might calling idr_find() here without
standard RCU read-side protection risk a use-after-free of internal radix t=
ree
nodes?

This function runs in a preemptible context (threaded IRQ handler). idr_fin=
d()
relies on rcu_read_lock() for safe lockless traversal. While this patch wra=
ps
it in srcu_read_lock(), SRCU does not block standard RCU grace periods.

If a concurrent idr_remove() runs (e.g., during device teardown) and a stan=
dard
RCU grace period completes while the thread is preempted inside idr_find(),=
 the
internal nodes could be freed and then dereferenced when the thread resumes.

> -	if (!rvring || !rvring->vq)
> -		return IRQ_NONE;
> +	vq =3D rvring ? READ_ONCE(rvring->vq) : NULL;

[Severity: High]
This isn't a bug introduced by this patch, but does the added SRCU
synchronization leave the rvring structure vulnerable to a use-after-free
during device teardown?

While rproc_vq_interrupt() is now protected by an SRCU critical section, th=
ere
does not appear to be a corresponding synchronize_srcu() in the platform de=
vice
teardown path:

drivers/remoteproc/remoteproc_virtio.c:rproc_virtio_remove() {
    ...
    for (id =3D 0; id < ARRAY_SIZE(rvdev->vring); id++) {
        rvring =3D &rvdev->vring[id];
        rproc_free_vring(rvring);
    }
    ...
}

The IDR entries are removed, but the function returns without waiting for S=
RCU
readers. The core driver then cleans up devres, instantly freeing the rvdev
(which embeds rvring). If rproc_vq_interrupt() is preempted after locating
rvring but before accessing rvring->vq, it will dereference freed memory up=
on
resumption.

> +	if (vq)
> +		ret =3D vring_interrupt(0, vq);
> =20
> -	return vring_interrupt(0, rvring->vq);
> +	srcu_read_unlock(&rproc->vq_srcu, idx);
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL(rproc_vq_interrupt);
> =20
> @@ -153,7 +162,7 @@ static struct virtqueue *rp_find_vq(struct virtio_dev=
ice *vdev,
> =20
>  	vq->num_max =3D num;
> =20
> -	rvring->vq =3D vq;
> +	WRITE_ONCE(rvring->vq, vq);
>  	vq->priv =3D rvring;

[Severity: High]
This isn't a bug introduced by this patch, but would publishing the virtque=
ue
pointer here without a release barrier expose uninitialized memory to
concurrent readers?

In vring_new_virtqueue(), vq is allocated and initialized, but vq->priv is =
not
set. The pointer is then published to concurrent readers via WRITE_ONCE.

Since WRITE_ONCE does not provide release semantics on weakly ordered
architectures, a concurrent rproc_vq_interrupt() could observe a non-NULL vq
before vq->priv is set or before the internal state of vq is visible. The
handler would then call vring_interrupt(0, vq) on an improperly initialized
structure.

[Severity: High]
This is a pre-existing issue, but could the error path in rp_find_vq()
permanently break the vring and cause a double-free on teardown?

If vring_new_virtqueue() fails, the error path calls rproc_free_vring(rvrin=
g),
which executes idr_remove(), but it does not reset rvring->notifyid:

drivers/remoteproc/remoteproc_virtio.c:rp_find_vq() {
    ...
    vq =3D vring_new_virtqueue(...);
    if (!vq) {
        dev_err(dev, "vring_new_virtqueue %s failed\n", name);
        rproc_free_vring(rvring);
        return ERR_PTR(-ENOMEM);
    }
    ...
}

If the driver successfully binds later, rp_find_vq() might succeed, but the
notifyid is no longer in the IDR, silently breaking interrupts. Furthermore,
when the device is unbound, rproc_virtio_remove() loops over all vrings and
calls rproc_free_vring() again, executing a second idr_remove() for the same
notifyid. If the ID was reused by another vring, its entry will be erroneou=
sly
deleted.

> =20
>  	/* Update vring in resource table */
> @@ -165,14 +174,20 @@ static struct virtqueue *rp_find_vq(struct virtio_d=
evice *vdev,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908053817.2606=
5-1-kmehltretter@gmail.com?part=3D3
