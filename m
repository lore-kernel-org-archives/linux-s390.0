Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B02E471D0B;
	Fri, 25 Sep 2026 12:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790340824; cv=none; b=fq6ciz+KCjU/t5eDJ/ptZnmnWYjAtZmzpvpT0GW9hokkHqZvxfBUgxvVMTe5rTlonHq8ufvA+vKO3rV4ZS+bMfnNR1yxzS6eaKyWfv9QycGyXBkMETlZJkqKSYRImxmflT9LpdzcYbnlNZq/tjNe4yoDZ2Z9/VMmHjZmRgGHdv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790340824; c=relaxed/simple;
	bh=WJVrAZsN0mdI8FfM3XKl/nxd8X0RYNHzkvNSlkff6r4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W6cv1rkZZBTiOj/a0e4mWnlqbPVOYONmP3IpKZ4z3MdouKS8FTRiuIeyGjZnNPmTDVzby81tDvQVOgMFtyjgns/C3LRquk3pW0TQgc+9ZjSRsVNXZH7iwaUv5l2DD7jLiYNaesoec1rbZ8Cop+HmYXHdb6oBlDLP2j5B9BsvHE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMfOrAPv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMfOrAPv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F941F000FF;
	Fri, 25 Sep 2026 12:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790340822;
	bh=K0kUmZYzcZT3eSMGd6/tR4mVdxhrNtwAjfGgC20VmhI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NMfOrAPv10AeQxFbBDA8yKQWaZvOtcMJtaVwqGQrnjNS39YHBDKPld8YdKQGlQMo/
	 wbRAUc4m2QMI1FllGUuTwY291H7JsB881yL9n9/kSBsNMOQpFW14/HF21nN/bMtaL2
	 jm9pH3fty1ITO3RIahKoYo1Y8oBoHj45N7zKWrlEZNyABQ5pRo565MWiMA0PCTRFmy
	 2V7FgVrdFYQiq7UgvH8/7YNcV7NDvoNTxph4UB+jxRQWGn53i49N2jDhPGY2APCXZT
	 uPyMWNxwxBNDyguISyGpuj8HnxB/F7lN3azZ8riEWEQQ7vddoVfwAw8ZpFwDk+rvL3
	 7oRI2JmBkmIvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/6] s390/vfio-ap: Fix failure to release IRQ
 notification eventfd contexts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260925124551.665448-3-akrowiak@linux.ibm.com>
References: <20260925124551.665448-1-akrowiak@linux.ibm.com>
 <20260925124551.665448-3-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 12:53:42 +0000
Message-Id: <20260925125342.76F941F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> When userspace registers IRQ notification eventfds via the
> VFIO_DEVICE_SET_IRQS ioctl, vfio_ap_set_request_irq() and
> vfio_ap_set_cfg_change_irq() each call eventfd_ctx_fdget(), which
> takes a reference on the eventfd_ctx and stores it in
> matrix_mdev->req_trigger and matrix_mdev->cfg_chg_trigger
> respectively.
>=20
> These references are dropped only when userspace explicitly replaces
> or clears them via a subsequent SET_IRQS call.  If the device is
> closed without that explicit teardown - because the guest exits,
> the VM process crashes, or the device file is simply closed -
> neither vfio_ap_mdev_close_device() nor the remove path releases
> these references.  The eventfd_ctx backing objects and their
> associated file references therefore leak for the lifetime of the
> kernel.
> [ ... ]
> releasing the device file before invoking close_device().
>=20
> Fixes: bf48961f6f48e ("s390/vfio-ap: realize the VFIO_DEVICE_SET_IRQS ioc=
tl")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925124551.6654=
48-1-akrowiak@linux.ibm.com?part=3D2

