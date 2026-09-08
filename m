Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20DF37F8C3;
	Tue,  8 Sep 2026 05:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788846711; cv=none; b=u98tFt7GfWAv6pOvn70DgRuYcHV4UfgTdsjm2nmSBF9N/WsfYcpJAEFfEznPrPtez/j3NVtz7tHrCxdPG6nNkTGHBOd4Zzh3FPnyDxu4oC/U0Q0CT2TEAO9tkgsouSshAYfDnHBz/lplItRwZfpGeeaAv9fW/PAZPsoYtRhCY3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788846711; c=relaxed/simple;
	bh=OwB/eT4bbpJG64S+bIEyw2qbVoQ3OzIelzPB6ZVRSr0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KTv2PKR4qUK1ajvSqCN+RKwLBkK/5eoqfsQbR20eXuX7hcS0TESQ9yRTC1R8BioPrJxGZa2lV+oZWTLX87uAG4HPCC6FYsgQoxl0KgoILW8NWKyaMW4oPDoIiQFgyC4Yf8UOJCyRl4bGKaIQ1nfMavs2dl97+5f4CBGsQ4Sx2es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n06WYkQj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n06WYkQj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B600D1F00A3F;
	Tue,  8 Sep 2026 05:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788846709;
	bh=ly+qtwtWNEfXvsOk8yhjt5DKACS0dSQy5XKEW5+XSe8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n06WYkQjJq1zJKJaLlf26u9qp8zXbMknl61OsfEirEPCOvHwOKs32L3oTaZt+/2S+
	 Ge0UbG85ne+mh3/inRL4fSfx3wxFMOmyH/jGSeQpkAxKFIAyBYRMBiKoQmxWpvSRUQ
	 9eHwyFn7A+gSBqfhtLVV6MTg4eFPMvf7/zKOuqQaNXXrGRMgGsOVLLg9u24QitIEPI
	 33aR6TWX09TLArBQqby+B+aGs81oMNEAeDdZJNSngFAorkRpJjm3YhmVrUfHfaig1K
	 dS/LWhPt5voIFYE0yDRv0NGS6fP86yv8j1CmSWVuq6Xahf5fEE0CrOhz0Atqt8l83o
	 WRywK84fZGaSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/6] virtio_ccw: always take irq_lock in the classic
 interrupt handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: dmitry.torokhov@gmail.com, "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20260908053817.26065-3-kmehltretter@gmail.com>
References: <20260908053817.26065-1-kmehltretter@gmail.com>
 <20260908053817.26065-3-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 05:51:48 +0000
Message-Id: <20260908055148.B600D1F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The virtio interrupt handlers pass retrieved virtqueue pointers di=
rectly to `vring_interrupt()` without a NULL check. A malicious or buggy ho=
st can trigger a kernel panic by providing an invalid indicator or interrup=
t vector.
- [High] Lost configuration change notifications due to clearing the indica=
tor bit after processing.
--

commit 40545ed73d4381a07a7934fddf3ac60ecd1f90d7
Author: Karl Mehltretter <kmehltretter@gmail.com>
Subject: virtio_ccw: always take irq_lock in the classic interrupt handler

This commit unconditionally takes the read lock on vcdev->irq_lock in=20
virtio_ccw_int_handler() so the write side can properly synchronize with
the callbacks even when notification hardening is disabled.

> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virti=
o_ccw.c
> index b90299205698b..552d779980129 100644
> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -1204,13 +1204,11 @@ static void virtio_ccw_int_handler(struct ccw_dev=
ice *cdev,

[ ... ]

>  	for_each_set_bit(i, indicators(vcdev),
>  			 sizeof(*indicators(vcdev)) * BITS_PER_BYTE) {
>  		/* The bit clear must happen before the vring kick. */
> @@ -1219,9 +1217,7 @@ static void virtio_ccw_int_handler(struct ccw_devic=
e *cdev,
>  		vq =3D virtio_ccw_vq_by_ind(vcdev, i);
>  		vring_interrupt(0, vq);

[Severity: High]
This is a pre-existing issue, but is it possible for virtio_ccw_vq_by_ind()
to return a NULL virtqueue pointer if a malicious or buggy host provides an
invalid indicator?

Passing an unvalidated NULL pointer directly to vring_interrupt() can cause=
 a
kernel panic when it is dereferenced inside more_used():

drivers/virtio/virtio_ring.c:vring_interrupt() {
    ...
    if (!more_used(vq)) {
        pr_debug("virtqueue interrupt with no work for %p\n", vq);
    ...
}

Similarly, in virtio_airq_handler(), airq_iv_get_ptr() can return NULL which
is unconditionally passed to vring_interrupt().

Could we add a NULL check before calling the interrupt handler?

>  	}
> -#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
>  	read_unlock(&vcdev->irq_lock);
> -#endif
>  	if (test_bit(0, indicators2(vcdev))) {
>  		virtio_config_changed(&vcdev->vdev);
>  		clear_bit(0, indicators2(vcdev));
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but could this sequence lead to
lost configuration change notifications?

Because indicators2 is shared DMA memory updated by the host, if the host
triggers another configuration change in the window between test_bit() and
clear_bit(), it sets the bit in memory and raises a new interrupt.

However, the guest will then blindly execute clear_bit() and wipe out the
newly set notification flag. When the newly queued interrupt handler runs,
it will find the bit cleared and do nothing, permanently losing the event.

Would using test_and_clear_bit() before calling virtio_config_changed()
close this race window?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908053817.2606=
5-1-kmehltretter@gmail.com?part=3D2
