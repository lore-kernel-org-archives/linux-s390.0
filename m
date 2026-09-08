Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D7B3806C2;
	Tue,  8 Sep 2026 05:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788846721; cv=none; b=O2Mvux+4hkR4crhGVTeNfD+gPZOzdOhobSvIlT+HKOY8Jx7m9Gyr8nQTihJxApONx3o5n74SBy4d7z/szQWJgVMp97go9tMHEHPV2fpAc1BaBuyNF6rDmickwoAJ9sZqqR6dzf4+E6FKYNbhO1h0YxblplHm/8R9Tzuh5dgQ/T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788846721; c=relaxed/simple;
	bh=IQY618A+x2/mtzibgqxPgCZjSbsB2PlQ+GltbeJBgx8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I/VojavZN+DmH4/lawIe0/iMjGNg9rNYr39c6klIzDmixC9jjAH86g6v/1aYgodHqLJAZOltS/YH69XAQFyf2kw3XjgNA5V5st8biJWB+7Z+ySFBj+fCXudGBzwazlMB/pcsFTxVPq3Sp+VnlOgKbYlAhJA5yYN8eJGmSj2RwPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhTRDwyG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhTRDwyG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E49DF1F00A3A;
	Tue,  8 Sep 2026 05:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788846720;
	bh=EbNNWxYRveX7ae0z/qAwKZmp5cu2H1GROL1unsbWTH0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bhTRDwyGHKtnWrPiuZOZpDs+VPz5PKXpyBOqjzADjiiDXeD1N/r6XGgOC8OpdkTNB
	 UykZq+eQ/RnsBAhGo5FKqSZNsxvc+Ef5WNKcJ5s3KcOIqFBlTMrDkSv5R9U9m/1luv
	 nkb14al8avBklALmO/95neErDaNgQifJts7n7jPAHHTTY+vLUy4CWSVEUrY/AYDl7+
	 NPsiMAAuK+hvyS8E17UKZivVFfI5NtacBawG3zIhncd5tVRcRR3hPpOiCm19isRExm
	 eNPKEH7haHh9lcRIKBB+7IJhllMB7PUZNbIjEni3G3gxMpIr9EhrRiBDDJqJrINw3Q
	 budfO4lZm5LYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/6] virtio_vdpa: implement synchronize_cbs()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260908053817.26065-7-kmehltretter@gmail.com>
References: <20260908053817.26065-1-kmehltretter@gmail.com>
 <20260908053817.26065-7-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 05:51:59 +0000
Message-Id: <20260908055159.E49DF1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Possible Use-After-Free of virtqueue memory in callback during fin=
d_vqs error handling
--

commit 05a7e5947030bc4c942e05c96bf1d657ed426d56
Author: Karl Mehltretter <kmehltretter@gmail.com>

virtio_vdpa: implement synchronize_cbs()

virtio_vdpa relies on the core's synchronize_rcu() fallback for callback
synchronization. This commit adds an SRCU domain per device and implements
synchronize_cbs() with synchronize_srcu() to cover the callbacks regardless
of the calling context.

> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index 6bcf4567a9292..f9559b6b2e0b6 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
[ ... ]
> @@ -123,8 +128,22 @@ static irqreturn_t virtio_vdpa_config_cb(void *priva=
te)
>  static irqreturn_t virtio_vdpa_virtqueue_cb(void *private)
>  {
>  	struct virtqueue *vq =3D private;
> +	struct virtio_vdpa_device *vd_dev =3D to_virtio_vdpa_device(vq->vdev);

[Severity: High]
This is a pre-existing issue, but could this callback be invoked
concurrently on a freed vq, leading to a use-after-free when
dereferencing vq->vdev?

During driver probe, if virtio_vdpa_find_vqs() successfully creates some
virtqueues but fails on a subsequent one, it jumps to err_setup_vq and
calls virtio_vdpa_del_vqs():

drivers/virtio/virtio_vdpa.c:virtio_vdpa_find_vqs() {
    ...
err_setup_vq:
	virtio_vdpa_del_vqs(vdev);
    ...
}

This tears down the previously created virtqueues. However, the callback is
not cleared with set_vq_cb(..., NULL), nor does it synchronize with pending
or concurrently running interrupt handlers (such as vp_vdpa_vq_handler).

Could a spurious or device-initiated interrupt occurring right before or
during vring_del_virtqueue(vq) race and cause virtio_vdpa_virtqueue_cb()
to dereference the freed vq structure when accessing vq->vdev?

> +	irqreturn_t ret;
> +	int idx;
> +
> +	idx =3D srcu_read_lock(&vd_dev->cb_srcu);
> +	ret =3D vring_interrupt(0, vq);
> +	srcu_read_unlock(&vd_dev->cb_srcu, idx);
> +
> +	return ret;
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908053817.2606=
5-1-kmehltretter@gmail.com?part=3D6
