Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732B5397935;
	Fri, 28 Aug 2026 21:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787954054; cv=none; b=rlf5NOjkpl2FbH21oXVCEBhHgOtgFZPv6B2f4+QAV9cr8JlDDym/V83lT9CG3Q+Px6Qmri8xju7fLVvCfUg50k1VQQ32DNTvo9RWG4UdTI8qNRBAACujN31JpQMwzpN+VcpSAgHEwTyewNRGXSuAIldN3AqswK6OEXGcQIeBetg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787954054; c=relaxed/simple;
	bh=OKnqbNfQNaoEj5LIcWqM2WVEKFmW0JlcAcL9oNh8Exk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mN7eFTn+uclYKWgXHpyH94UTC9Wd1ywg1d2z8nGPdD2tfL8x7XaFkeUQ1thqpFaSlfSS91SSeYAPm813tVYG0zTvBq5SXnsbM7kLnITQmtM+loZ8U4WYxu0MP1N0zg6e1o5Urols3EcKoOoQEMLoBd8mThfTVr0EYrgY+Qfl2NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZqf9abU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZqf9abU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A88301F000E9;
	Fri, 28 Aug 2026 21:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787954053;
	bh=zuJt1JS5J1gxTJ8N1BajuWdnrSWjQcS8O7sxIqCQ11U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TZqf9abUzLi2A2IuLScBm6daUqp3avFK+3d2fKe7b1SnRGBxA91FKJhMqoFFp7NjK
	 QyQZUZx9t14DhTOaf8/QQSnLl9sF4nWEtYVfxcopbkEh162F5zw2dmZyk5XBGWkMPn
	 CMrQp5PXRQq651S2YzoZzXvCYKsAW/T+T2aeKfyr5iODCEm7NtD6N8z6uPMhl/m7bp
	 +SOYZ+/b8dzvBoXoRDPzoXMXpg5JSYGvK0y8dLPm6QGaienXrXeLqwIBvfZ8GdCMD7
	 O1ulHDM+P/8fj/28EhhsuHKBPu6b4hpRZcbJqjKUs3LJt2YqZfISP58ZaddzN4Fe/T
	 rd2d677XTrxLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/4] s390/vfio-ap: Fix failure to release IRQ
 notification eventfd contexts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260828214653.1087009-3-akrowiak@linux.ibm.com>
References: <20260828214653.1087009-1-akrowiak@linux.ibm.com>
 <20260828214653.1087009-3-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 21:54:12 +0000
Message-Id: <20260828215412.A88301F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828214653.1087=
009-1-akrowiak@linux.ibm.com?part=3D2

