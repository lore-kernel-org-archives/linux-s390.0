Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C4E39A070;
	Fri, 12 Jun 2026 18:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781288937; cv=none; b=grcnP4S1fU5Xv4DBLW4wYrCFwNOIeW5vtPI/q3IM6/nX5MVAZ8n1uzf1Xgc68xQQm2LUHUwW7yNP9uy2GAHMWkmMbTpomMxtOENvAP6z0H5nEwW6Em66XLLjgZ4u20yUqPvYO18h4ZMYhDF0RIBm1BCUzrF67USU9dqDI+ZesGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781288937; c=relaxed/simple;
	bh=Ly1PYa899UtyYNpBqIhYWql10McczNtgFsVTaFN6A5A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XSTJH/FTv/H7tk22IbVm5HQWWaiHnh6vsEkE5qzxZD9e69G67blufjvk7GS1quRBSh+Rz8zZKdgJ+giuyPQPSuZVdopigWbRTdfbMK3mnqDKZ9WMuovP84jmNbJnttex2d/ybQOYO2XSXzDuBTVWLSAwYcsDWVOba/qOnV+9x2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PV6j6lTe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PV6j6lTe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E641F000E9;
	Fri, 12 Jun 2026 18:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781288935;
	bh=+smTXPP8dfhgcbsok/vUjJO21k9sw6+q5mKVNTUFBBs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PV6j6lTeQHkbKD0VR1G/emNK+as+y0Qh1XqmrBo6ZyUMv8FcKTCC5mvp07DLIdKIw
	 2UGoOTHk6oRk3TfevAqgjtPNo4ZQ5bLnD+GBlmfwltQJ3mQHfQIFVsgh7qbaSJl5np
	 ecsESTdWlpfm+e5U9Bvjk0AbW1IURUDFemlf1JQO7x1sKk2huXFjXi4qmd5W/3Q8JU
	 qbyrtsvTJYKjXDsuqhCg0orkOTJ/wnuiFrU+aC7BzXrWz0JskPHw5aS/PxyjfJc200
	 /c4GUDXAuc0CbjaggGg71yV7kBVN4xuDgtL3jwZWHrg6fgAlVZYfUtOxHEKx/cIkWe
	 rOLMa3RV6oN8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/4] vfio-pci/zdev: Add VFIO FMB device features
Reply-To: sashiko-reviews@lists.linux.dev
To: "Omar Elghoul" <oelghoul@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260612181048.91548-4-oelghoul@linux.ibm.com>
References: <20260612181048.91548-4-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 18:28:54 +0000
Message-Id: <20260612182854.97E641F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Holding `zdev->fmb_lock` across user memory accesses allows a mali=
cious userspace process to stall host device management.
- [Medium] Enabling the FMB feature via `VFIO_DEVICE_FEATURE_ZPCI_FMB_ENABL=
E` will unconditionally fail with `-EINVAL` on a newly opened device.
--

commit 67b6ef61b40cb8ad6b8fa03e4587c893d168c03d
Author: Omar Elghoul <oelghoul@linux.ibm.com>

vfio-pci/zdev: Add VFIO FMB device features

Introduce new VFIO features for zPCI devices to provide FMB passthrough to
userspace. Allow the user to enable or disable the FMB using the SET-only
feature VFIO_DEVICE_FEATURE_ZPCI_FMB_ENABLE and read it using the GET-only
feature VFIO_DEVICE_FEATURE_ZPCI_FMB_READ.

[ ... ]

> diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci=
_zdev.c
> index 0990fdb146b78..ad1bcaf52ff24 100644
> --- a/drivers/vfio/pci/vfio_pci_zdev.c
> +++ b/drivers/vfio/pci/vfio_pci_zdev.c
> @@ -167,3 +167,58 @@ void vfio_pci_zdev_close_device(struct vfio_pci_core=
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
> +	if (fmb_enable.enabled)
> +		return zpci_fmb_enable_device(zdev);

[Severity: Medium]
Will enabling this feature fail with -EINVAL on a newly opened device?

When userspace opens a VFIO device, vfio_pci_core_enable() automatically
enables the physical device via pci_enable_device(). On s390,
pcibios_enable_device() unconditionally calls zpci_fmb_enable_device(),
which successfully allocates zdev->fmb.

If userspace subsequently attempts to enable the FMB feature via this ioctl,
it calls into zpci_fmb_enable_device() again:

arch/s390/pci/pci.c:zpci_fmb_enable_device() {
        ...
        if (zdev->fmb || sizeof(*zdev->fmb) < zdev->fmb_length)
                return -EINVAL;
        ...
}

Does this make it impossible for userspace to explicitly enable the feature
without first disabling it?

> +	return zpci_fmb_disable_device(zdev);
> +}
> +
> +int vfio_pci_zdev_feature_fmb_read(struct vfio_pci_core_device *vdev, u3=
2 flags,
> +				   void __user *arg, size_t argsz)
> +{
> +	struct zpci_dev *zdev;
> +	struct vfio_device_feature_zpci_fmb_read fmb_read;
> +	int ret;
> +
> +	ret =3D vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_GET, sizeo=
f(fmb_read));
> +	if (ret !=3D 1)
> +		return ret;
> +
> +	zdev =3D to_zpci(vdev->pdev);
> +	if (!zdev)
> +		return -ENODEV;
> +
> +	guard(mutex)(&zdev->fmb_lock);
> +
> +	if (!zdev->fmb)
> +		return -ENOMSG;
> +	if (copy_from_user(&fmb_read, arg, sizeof(fmb_read)))
> +		return -EFAULT;
> +	if (!fmb_read.data)
> +		return -EINVAL;
> +
> +	if (copy_to_user((struct zpci_fmb __user *) fmb_read.data, zdev->fmb, z=
dev->fmb_length))
> +		return -EFAULT;

[Severity: High]
Can holding this lock across user memory accesses cause a denial of service?

A malicious userspace process could provide a userfaultfd-backed memory
region for arg or fmb_read.data to intentionally stall the thread
indefinitely while holding zdev->fmb_lock.

Since pcibios_disable_device() also requires this lock during device
teardown, would this stall permanently block the host from hot-unplugging
the PCI device or unbinding the VFIO driver?

> +
> +	return 0;
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612181048.9154=
8-1-oelghoul@linux.ibm.com?part=3D3
