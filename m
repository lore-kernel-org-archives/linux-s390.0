Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6208F31F98A;
	Mon, 24 Aug 2026 14:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787580560; cv=none; b=mnsUPotr4Tu+I0sorc3bOcmpDWzRNevaRvJMWfrH/GXKGRzwKxrldKvunNxNd0IhNbeS6LHgy8S3PjmB3kAT2QtX1O89jlpWLfr2tr30/2Rqe6WfDGiURLYXLrZti1iF6olpNJlpaXMPY0KsWrbZxBTsUPW5Fs5/xmtWdnk+mEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787580560; c=relaxed/simple;
	bh=jtIYIYekmgbcmbY4EDH5+L9GrVLl0uau1JL10jmNV2I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eKfzxabjAvZGjwdcbwyiDvgLbh7TwPrHsrIPKUNc8quOzd2JG/7Mo/2S2Gsu/86CGu0ol5aXfErFrcmR3ru5lPYV2MbIJerTYUElE81VPfn1I1530VkcC/MDwFfJJG+bvDvzZJdWuPNHX4DaHtjdxis7Cv2bLSWd8W9aFuabAdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6yGEAU7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6yGEAU7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20CA1F000E9;
	Mon, 24 Aug 2026 14:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787580559;
	bh=/j90z4ZMjcqkw+7dwX/IPG4/jd3v3Ftki/OxTnKuLRg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q6yGEAU7HsMbRoT+F0Sh0Sb3N7x2RiFpkCJinOHRclmpqPtUEbsW3QD0M8pMfUbWX
	 8V5u8EKdffR52qqwoBs6lwDpuKFXzXZxcJZ8350WCfv7WRg5TYSIW4L9EScb3GCiNw
	 HSsXzCvlQt5nmbPBGfX7+HsUC8cXBlDSAKFv9zXlORfn8IrQByAPttLbPKW7K1T8tV
	 asoz1g0FDW6npz4ygcP0HdOpxhW8Iqo9s2F1on1fBE6NQYUQWI70UVGQJ/UuFtDg2L
	 EkxdsX+yBSAD2K/DoGL7wG58o0/lsAOsFnuw/dS3IyGaGm0RmnYpTeAcmoFPemONv2
	 Gb74UL7wRuV/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] s390/vfio-ap: Fix failure to release IRQ
 notification eventfd contexts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260824135850.503728-3-akrowiak@linux.ibm.com>
References: <20260824135850.503728-1-akrowiak@linux.ibm.com>
 <20260824135850.503728-3-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 14:09:18 +0000
Message-Id: <20260824140918.A20CA1F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824135850.5037=
28-1-akrowiak@linux.ibm.com?part=3D2

