Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792536418;
	b=Qj/0uMRUGYo3h8/X7MMt2v48KrsybWFkZqsXOuZ6PRNmoVzXZ8Ckbj44M/RQOa7LQiSc
	 8QxBVm/MDo/XLtbyQNjFFGeAnS3hGC4zTchmkwn7s2lav46ksC2uSKQJHsWqa1DARZ4rC
	 hd+/fxAC0EljTvG65bJy7wnITc7z/Mwt4ZbEK0W5+RiAvFGJt+xzGvR9blagPdM/e/pPa
	 MOHzN0EIVFywvFozqJ7mrypp9O3X4NotpPKfRv8wF/XyfvGdJB0U1mNvOx1jOWJbkgaM7
	 MAoASMDa+M0PVPfE7NyJ69dDhea/EHQQIvXla0wwT0YYC6/LsF5RQzrmjn6hTO8WkJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792536418;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zxHs59P1gbybGxardxgBvtk/wDjqFacF82sw/rA8moQ=;
	b=ZVOLumF6YFfJd0p1oLjF/LfH95GMtJedbkMwu7t+JstmnkCA38hGfLF4v/1aWABDPiU9
	 QvFgQd2THZeoUBx2p8RNKGI6HOfQy2NCtIrbi47bBqdW0NcfOOBDmCXFjmKAeX7ta/ZSm
	 LLXmKzzjLXwP95PrNLHFCAi9Y7JZ2UxlSjnj86or3B+zOu7TtlgIDonsr7WXKF2fcx35b
	 gvwZX3QiWNYW744utBpGXKNNs8fJhZs3yLG8trW/ocqPJoRUQG1f4WQoy9U36lzojfrBB
	 wm+xDJbvHtTMwNinpl0OfNGR441f2aRA4WBlCSseHy/atvcpaOL5L/9ybI0gaTqJ/7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XX3C5AL0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F08606A319;
	Tue, 20 Oct 2026 22:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XX3C5AL0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 829331F000C9;
	Tue, 20 Oct 2026 22:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792536417;
	bh=zxHs59P1gbybGxardxgBvtk/wDjqFacF82sw/rA8moQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XX3C5AL0lSd56uyM3sJk37l9Yeq1fv9qPJ6/xUYILKlL0fnLJi9/fmQ94D2y0cwGs
	 P0OljeWYusEnYr98LegK0WxD/2Ytl+tCKt0JqzNGx3vZCeGOVaxGPmKrhJrKfoASp0
	 MAj0ZLbNeaOkn4qDrocD8J5vCi2U4vGwzpNIa/Q1G1NbbbM5Q4oMJcKgCYy0Y+CvWS
	 6vlir436Uz1ZUyEO/HKY1tvO1rpk60ziZ9J+bytNY6q02xPuUjiZiUVkr0JaTqDac5
	 e89KB1QYzzaf5KXLBeqPeTph3tOA5JLQwxOJFZOFwAY9TuzTcKDlsr3CtlQ/eBWMo9
	 QbG0GGy8yLX4Q==
Message-ID: <sashiko-outbox-179575@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 5/5] vfio-pci/zdev: Add VFIO FMB device features
Reply-To: sashiko-reviews@lists.linux.dev
To: "Omar Elghoul" <oelghoul@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261020212427.2561-6-oelghoul@linux.ibm.com>
References: <20261020212427.2561-1-oelghoul@linux.ibm.com>
 <20261020212427.2561-6-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 22:46:57 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] vfio-pci/zdev: race with firmware FMB update on nested enable in=
 zpci_fmb_enable()
--

commit 9b8c0a84d66e0a84f5421ca2e3d89abbb0e740d4
Author: Omar Elghoul <oelghoul@linux.ibm.com>

vfio-pci/zdev: Add VFIO FMB device features

This commit introduces the VFIO_DEVICE_FEATURE_ZPCI_FMB_ENABLE and
VFIO_DEVICE_FEATURE_ZPCI_FMB_READ device features to allow userspace to
enable, disable, and read the Function Measurement Block (FMB) on s390 zPCI
devices.

> diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci=
_zdev.c
> index f47f36314a1cc..c2afe60111d73 100644
> --- a/drivers/vfio/pci/vfio_pci_zdev.c
> +++ b/drivers/vfio/pci/vfio_pci_zdev.c
> @@ -219,3 +219,63 @@ void vfio_pci_zdev_close_device(struct vfio_pci_core=
_device *vdev)
>  	if (zpci_kvm_hook.kvm_unregister)
>  		zpci_kvm_hook.kvm_unregister(zdev);
>  }
> +
> +int vfio_pci_zdev_feature_fmb_enable(struct vfio_pci_core_device *vdev, =
u32 flags,
> +				     void __user *arg, size_t argsz)
> +{
> +	struct zpci_dev *zdev;
> +	struct vfio_device_feature_zpci_fmb_enable fmb_enable;
> +	int ret;
> +
> +	ret =3D vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET, sizeo=
f(fmb_enable));
> +	if (ret !=3D 1)
> +		return ret;
> +
> +	zdev =3D to_zpci(vdev->pdev);
> +	if (!zdev)
> +		return -ENODEV;
> +
> +	if (copy_from_user(&fmb_enable, arg, sizeof(fmb_enable)))
> +		return -EFAULT;
> +
> +	guard(mutex)(&zdev->fmb_lock);
> +
> +	if (fmb_enable.enabled) {
> +		zdev->statistics_on =3D true;
> +		return zpci_fmb_enable(zdev);
> +	}

[Severity: Medium]
When VFIO_DEVICE_FEATURE_ZPCI_FMB_ENABLE is invoked with enabled !=3D 0 whi=
le
FMB measurement is already active in firmware, can
vfio_pci_zdev_feature_fmb_enable() -> zpci_fmb_enable() race with a periodic
firmware FMB DMA update and leave stale pre-reset or torn counters in
zdev->fmb?

In arch/s390/pci/pci.c, existing callers such as zpci_fmb_request_on() only
call zpci_fmb_enable() when FMB measurement is not already active:

arch/s390/pci/pci.c:zpci_fmb_request_on() {
	if (zdev->statistics_on && zdev->fmb)
		return -EINVAL;
	...
	zdev->statistics_on =3D true;
	return zpci_fmb_enable(zdev);
}

Here, vfio_pci_zdev_feature_fmb_enable() in drivers/vfio/pci/vfio_pci_zdev.c
calls zpci_fmb_enable() directly on a nested enable so that FMB counters are
reset to zero as documented for VFIO_DEVICE_FEATURE_ZPCI_FMB_ENABLE in
include/uapi/linux/vfio.h. However, zpci_fmb_enable() zeroes the live DMA
buffer before issuing the ZPCI_MOD_FC_SET_MEASURE command via zpci_mod_fc():

arch/s390/pci/pci.c:zpci_fmb_enable() {
	...
	if (!zdev->fmb) {
		zdev->fmb =3D kmem_cache_zalloc(zdev_fmb_cache, GFP_KERNEL);
		if (!zdev->fmb)
			return -ENOMEM;
	} else {
		/* reuse the same FMB buffer for as long as the zdev lives */
		memset(zdev->fmb, 0, sizeof(*zdev->fmb));
	}
	...
	fib.fmb_addr =3D virt_to_phys(zdev->fmb);
	fib.gd =3D zdev->gisa;
	cc =3D zpci_mod_fc(req, &fib, &status);
}

Because virt_to_phys(zdev->fmb) is still registered with firmware during the
memset() and up until zpci_mod_fc() completes, a periodic firmware FMB upda=
te
firing in that window can overwrite zdev->fmb with pre-reset counters and a
non-zero timestamp. Since firmware only writes to zdev->fmb at fmb_update
intervals, subsequent VFIO_DEVICE_FEATURE_ZPCI_FMB_READ calls would then
return those stale values instead of zeroed counters.

Should FMB measurement be disabled in firmware before zeroing zdev->fmb, or
zdev->fmb cleared again after stopping measurement?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020212427.2561=
-1-oelghoul@linux.ibm.com?part=3D5
