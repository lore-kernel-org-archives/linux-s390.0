Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185192BE043;
	Fri,  4 Sep 2026 22:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788562146; cv=none; b=uGgtJcMsQ9esDC/uzeOcgMOvyYQwxcG4Y88dJe4LEgNIdouqk4+uMjaTV5j7zLuuv9qLHplpMkEI8bMwGgj2S/zkgjyafA872JppvcuSPQzsA2V3p+JzLf1Nx1dU/MT5Z02RcPA2ljEderyPUvbWXWyqbatdBnI2wtvuoX80jGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788562146; c=relaxed/simple;
	bh=gH89P/KW6SGiQ7g1/j3jNLcNGCRTpIyP8Z7mcJxjuOQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uLHjq+isKxpG21q9XiSLJijwTX2ZQVOxL/QBnPD1gvv1FOvEHqr/FmlwsysZHvc9QurUwiPxXcUoDROXbINmX/hUNG5+86L/YJPBotymtkF4qjDpQ+aQ+GU9wBEZthAiV1a+tLB7U9ArXrItWN69pdr8W+KSGegeyzW6yo+05YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1RUkLKN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1RUkLKN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8DE31F00A3D;
	Fri,  4 Sep 2026 22:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788562145;
	bh=/QKATbr+V24OQDUoO5lskEFnVMLTSlCe2NmBqns3PsQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A1RUkLKNGkSBLa9/cNE6Dj7PMLYwi5fwHBU/35ixitvJLUOVbJ+pYMfH6rC8Dtrvh
	 DVl949T1ETWqz5cgo5G68nG/2IYmaso/L8VUw7Y1LH+2ghuyBiNsG/W0RJAH7adklX
	 twHwWL+6mIGnxLzow7Py2dKf1kSkPf+mtCpy1bbcGJZBKnq/XFQ+pWvdGqXcnsGSik
	 2DPq50GuWrzbdwesSU6DCJaGd+I5hRNuEyo/CYdivhTQ2JzLSWH3mlQIMVdZpSXBFn
	 zoEcnWpkRXUaX0B+IFzbeJRV5b+Va26aoA8m1fuWlkKYBH42HKvCI0SQAdWZs4eLzG
	 lqbP8OdoxoMuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/6] s390/vfio-ap: Fix failure to release IRQ
 notification eventfd contexts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260904223531.1611088-3-akrowiak@linux.ibm.com>
References: <20260904223531.1611088-1-akrowiak@linux.ibm.com>
 <20260904223531.1611088-3-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 22:49:04 +0000
Message-Id: <20260904224904.A8DE31F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Out-of-bounds read of user memory and logic error in `vfio_ap_set_=
request_irq` and `vfio_ap_set_cfg_change_irq`.
--

commit 771c755d8bf563861fa80183f68a6dbe8966844c
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

    s390/vfio-ap: Fix failure to release IRQ notification eventfd contexts
   =20
    When userspace registers IRQ notification eventfds via the
    VFIO_DEVICE_SET_IRQS ioctl, vfio_ap_set_request_irq() and
    vfio_ap_set_cfg_change_irq() each call eventfd_ctx_fdget(), which
    takes a reference on the eventfd_ctx and stores it. These references
    are dropped only when userspace explicitly replaces or clears them,
    causing a leak if the device is closed without explicit teardown. This
    commit fixes the leak by introducing vfio_ap_mdev_release_eventfds()
    to clean up the references during close_device().

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index 9d4f5b9e3301f..4a31454d725a9 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c

[ ... ]

This isn't a bug introduced by this patch, but I noticed a pre-existing iss=
ue
in vfio_ap_set_request_irq() and vfio_ap_set_cfg_change_irq().

If a userspace process issues the VFIO_DEVICE_SET_IRQS ioctl with count =3D=
=3D 0
and DATA_EVENTFD to clear the IRQ, could this unconditionally read out of
bounds?

drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_set_request_irq() {
	s32 fd;
	void __user *data;
	unsigned long minsz;
...
	minsz =3D offsetofend(struct vfio_irq_set, count);
	data =3D (void __user *)(arg + minsz);

	if (get_user(fd, (s32 __user *)data))
		return -EFAULT;
...
}

[Severity: High]
Does this code read past the user-provided struct vfio_irq_set buffer if
count is 0?

Because there is no check for count > 0 before doing get_user(), it appears
this reads 4 bytes past the user-provided buffer and interprets the
uninitialized data as a file descriptor instead of safely disabling the
interrupt.

The same pattern appears in vfio_ap_set_cfg_change_irq():

drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_set_cfg_change_irq() {
	s32 fd;
	void __user *data;
	unsigned long minsz;
...
	minsz =3D offsetofend(struct vfio_irq_set, count);
	data =3D (void __user *)(arg + minsz);

	if (get_user(fd, (s32 __user *)data))
		return -EFAULT;
...
}

[Severity: High]
Does this code also have the same out-of-bounds read issue when count is 0?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904223531.1611=
088-1-akrowiak@linux.ibm.com?part=3D2
