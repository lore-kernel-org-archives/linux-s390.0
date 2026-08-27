Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662AF46EF64;
	Thu, 27 Aug 2026 13:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787837538; cv=none; b=nmGuYlnNa4iITjybCRishzUVjk7gPqPty+lXaVnamzd5PAgYCpO/zJe9T04JSYOYpaMD6fVeu6kIa1sUIi2SNtjS1DSu+RmvPqHqvPKwtOKaqOasUw4qb3LOhn1BmoBCkljDZuOftfZPySOLP6lU9jPvTzYI0suAxaHK+IoyzRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787837538; c=relaxed/simple;
	bh=wKZXKSc1lMlhJ5A6GBmvvzJAVRhXqfB0H5ozL29O/wA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eLZWebwzByWuOGNlx4Qx8Qc179qaUGwky+0V9KeDJ7/bpOWLBxKevCtEoEW4EzOxbuAPgIWHuik5pK/194VkNxCVxOB4iC8LYudgfTxh9zLzoXIF8eT/IiSJP44XQ/Ld7PG5FO6/Gqil0thdS3FvXQFoExU41TFFIVjTOvJ0hsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A463rkKi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A463rkKi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206811F000E9;
	Thu, 27 Aug 2026 13:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787837524;
	bh=94zpxRJpfwtmbPn7BslwBtpLPzeE344rmBNAevozxkw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A463rkKi2dEdQhQr7ZGTM3ZSTScmm6u2SQ3l6qsY8iqukXGBVsvTszDYpIwRjvhg0
	 aXePkzqQcsuiaK2RqDGSn08UvYs8RADyaoS6jg9Wc3cBtutywwYa+ifDBjQQM/Rm4l
	 w69/Y6XZhwGgSdnkbODn//SuqmrYYU8cJgt6efxoNvJMEN88B3C1+9zPx7/tUy+5+l
	 Vs0HgcIzKUDlV9mh6Kyyr3TCvk/YDV5bPpk8LvqcylNbDWt/ewp6Bss0JfjMOaRgzE
	 l6cqMNRTP22S/Y1whSoQVuVsFCzA7oIUPJ4BCKDy5xabk+OTyd1FsI28wuVCEhu9uy
	 ZDJ4xcx4nLX6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] s390/vfio-ap: Fix failure to release IRQ
 notification eventfd contexts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260827132441.555866-3-akrowiak@linux.ibm.com>
References: <20260827132441.555866-1-akrowiak@linux.ibm.com>
 <20260827132441.555866-3-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 13:32:03 +0000
Message-Id: <20260827133204.206811F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827132441.5558=
66-1-akrowiak@linux.ibm.com?part=3D2

