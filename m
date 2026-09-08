Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D7D37A846;
	Tue,  8 Sep 2026 05:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788846778; cv=none; b=PxBX1m0ML3TzJRXy6/RdyZIAc6ae58Gm5zbEsRHdHPzvfMYzB+FCXDb6VPGJRFerkXXPezQgKyMRFb9aIGsZQrijcr+M3Bq0Yw8lp/50J3VSF51irAqtbURjeOVCkIms3/nqSiNybZaVAQIhk8OwEOnFdPJ0Pq1sWT+XXPd+OHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788846778; c=relaxed/simple;
	bh=xpdSo1r1q71T0JQQ+xUC0S9KL2Z3bgZzqz9irG9pg2E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=njT66o5m9Ebd3Ul5k4esQ6KuXABJa47UkTJKjGAfFGRzBKmvwggROkAtx2uGEDiuyzts4wkaR8qmEzvZM5QTJ3k+3j7LNg78j3cxDIXaBaB1vvkzlLTemE4fDvnTvJoH1acUdKCmpx4fiVWa1NofYbIjMSNUIsi5JSuS+AAdDKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6/EIp88; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6/EIp88"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC9D1F00A3D;
	Tue,  8 Sep 2026 05:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788846776;
	bh=owdXL4v/MGg+2bTNIXt/Ipf/6QSRvFgh+HxrHRSpT4c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i6/EIp88aeV+avvTJex+Ou7SBNeR06ATLyCLbDY5srqzC83NrVtB3ljM/u0qyQsze
	 YXdo2YoSK2R3Z7rb5hZ5z/FClmqhfF3/gOo8+I0ycHYIKHiau42GB98/ITz8KaJb1G
	 yfsAujIUH+akV0+DEdx3Rq9MGWAgZZUq9rT9uKSFgjKQxGJ4y64bpGWGTXFawYGtmU
	 QFR9q/nwyMHYx+2F/SUpnqm9yqYrzCN/w3UBnVoPP0S2r1AcZW0JhxBkkVuKyxBoXm
	 /zKNjlOUt39Q8lnqP4ZduRBB0c5siXIbygnhokR5rBY44wqFCidW6ZTX3vuLuEit+i
	 s/MebGrz2viiA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/6] platform/mellanox: mlxbf-tmfifo: implement
 synchronize_cbs()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, linux-input@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, dmitry.torokhov@gmail.com, linux-s390@vger.kernel.org
In-Reply-To: <20260908053817.26065-6-kmehltretter@gmail.com>
References: <20260908053817.26065-1-kmehltretter@gmail.com>
 <20260908053817.26065-6-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 05:52:55 +0000
Message-Id: <20260908055256.2AC9D1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Device reset and `synchronize_cbs()` fail to stop the backgrou=
nd work handler, leading to a race condition and Use-After-Free during virt=
queue removal.
--

commit 7ff4c967b176976015826d77ef33286ed4bdfbba
Author: Karl Mehltretter <kmehltretter@gmail.com>

platform/mellanox: mlxbf-tmfifo: implement synchronize_cbs()

This commit implements synchronize_cbs() for the mlxbf-tmfifo driver. It us=
es
the existing per-direction spinlocks to synchronize with virtqueue callbacks
running in the FIFO work item instead of relying on synchronize_rcu().

> diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/=
mellanox/mlxbf-tmfifo.c
> index 3c6408581373b..664bec20a7aeb 100644
> --- a/drivers/platform/mellanox/mlxbf-tmfifo.c
> +++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
> @@ -1135,6 +1135,20 @@ static void mlxbf_tmfifo_virtio_reset(struct virti=
o_device *vdev)
>  	tm_vdev->status =3D 0;
>  }
> =20
> +/* Synchronize with callbacks running in the FIFO work item. */
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

[Severity: Critical]
This is a pre-existing issue, but does toggling the spinlocks here actually
guarantee that the work handler has finished and won't execute again?

If a privileged user unbinds the virtio device via sysfs while traffic is
actively processing, the driver core calls virtio_reset_device(), which
invokes mlxbf_tmfifo_virtio_reset() and mlxbf_tmfifo_virtio_synchronize_cbs=
().

Because mlxbf_tmfifo_virtio_reset() fails to halt or cancel the background
work item, the core proceeds to free the virtqueues in
mlxbf_tmfifo_virtio_del_vqs().

The concurrently running work handler (mlxbf_tmfifo_work_rxtx()) can then
check the virtqueue pointer outside the spinlocks and proceed to use it:

drivers/platform/mellanox/mlxbf-tmfifo.c:mlxbf_tmfifo_work_rxtx() {
...
	vring =3D &tm_vdev->vrings[queue_id];
	if (vring->vq)
		mlxbf_tmfifo_rxtx(vring, is_rx);
...
}

And finally dereference the freed virtqueue in mlxbf_tmfifo_rxtx(), causing=
 a
use-after-free:

drivers/platform/mellanox/mlxbf-tmfifo.c:mlxbf_tmfifo_rxtx() {
...
	/* Notify upper layer that packet is done. */
	spin_lock_irqsave(&fifo->spin_lock[is_rx], flags);
	vring_interrupt(0, vring->vq);
	spin_unlock_irqrestore(&fifo->spin_lock[is_rx], flags);
...
}

This issue wasn't introduced by this patch, as the former synchronize_rcu()
fallback also failed to protect the non-RCU work handler, but this patch fa=
ils
to correct the vulnerability.

Should the background work item be canceled during reset to prevent this?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908053817.2606=
5-1-kmehltretter@gmail.com?part=3D5
