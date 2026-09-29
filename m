Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CDA3E411C;
	Tue, 29 Sep 2026 12:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790684731; cv=none; b=S7mv9GGRSB9k+inV9tj32KytIXWa5qRji2TCK67wrIaI3a87IK+YST7GbQjpVY637wnPJsUd9ITMayLH8QLZjnU3AF5loV6h0Mag/o8+zQ6ZS1Z5ye6XHIfE/kK7o5MGQt7kYWj2PHDdWnjECFGi811tBARkHTecdRbX5VWgOmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790684731; c=relaxed/simple;
	bh=QVqWfMAcrX5tW+O/SPIV/JcIFu4iO+14hRAV/mBbqWs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Gc+gRIV3eIsCC7W+UEzY2+Fe2er8AVHWdhi7qo+frPWlSz6wAqCE0QLH/1lxj5zcJL1IgOKfqX3uRb6bClUq3opHG0NC+1NtZ++jJ9u5Vkdaa0fsq3YhxQaY6Dz2SYqrgMrmidVtEB3l5JHhKoGS6uPW88WB0qZsu6CRn08T97s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3CHg4ti; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3CHg4ti"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E965B1F000FF;
	Tue, 29 Sep 2026 12:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790684730;
	bh=kU1ZeKc/q9ZOKW8ZTLdcEywEh3+KPyMJndMJ7Abszr8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L3CHg4tiy+yWz25NR30hia9EyyMyHAlYk7VXRQtxxpJ+Zm3a7dT+ddiyu6WLM6GV9
	 taSyjp6hnIiSupZL0mC+1SSiqgG71ZWgKA8Jk3QFQlNgR41hD88z69ZxXjIwpjo2tW
	 +V6yYD32HibOlMYMzjM/EyWDOpF34KbOecYaT+2tgTIYSrm3pyZCdkiyN9knmeKd7T
	 0Um8qoPEH4kpM2YlGwko89BqoycpeRmPQ9A13mn3uUm9YUDdGcx78OpJfN6+iA+QVR
	 yiOfyOj2fDgZVw0L9ghCOkeK84zP5intOsP1Yxdean9OPB+ILkop/arESmecwlrKNp
	 hLx+LQsetvI6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/6] s390/vfio-ap: Fix failure to release IRQ
 notification eventfd contexts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260929121837.2715710-3-akrowiak@linux.ibm.com>
References: <20260929121837.2715710-1-akrowiak@linux.ibm.com>
 <20260929121837.2715710-3-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 12:25:29 +0000
Message-Id: <20260929122529.E965B1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929121837.2715=
710-1-akrowiak@linux.ibm.com?part=3D2

