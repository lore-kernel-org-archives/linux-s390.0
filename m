Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FCD359A6D;
	Fri, 12 Jun 2026 18:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781288893; cv=none; b=jJnZGv0riL2O7mluL/AG2ZRD0HrZL3oxi6Wkw1O8IJ4TIx63W5JZWvYYl9og6mgYqpkISqe1MYdY+0qJ5QcCWDlD+Sc24FfDqi5V1LhjHq7mMiAEXMnhd7ahERAdfQPWb4xm++43FX8FiNdcY+n5Wynm7ao2hX7EURRE8WuuOko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781288893; c=relaxed/simple;
	bh=0mqgJjOIk55ht4lu03k5cCOWSLD2ymleE+puiTBIWdc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bVH/ol1e2mRqiskMviMt8Oe1KFRwuQc4kFQ8cHAkYhbTGrhWi+b64XTyh79+ZegNQDrL9tveK9jPs5ywOtkl3/3SGOoSdF1cL5KTGm3ezn/5MbxrHLn/aw9jXhn3dsdmfd1OoFA8arP1dDYAe5aPc+ShlyNTBasn3EWHqlKOvvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WgfORKx3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WgfORKx3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 757171F000E9;
	Fri, 12 Jun 2026 18:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781288891;
	bh=biqlCq+Z4NwEEC73vI6V+vdXE31sXCqZNnVkyjnxHH8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WgfORKx3ZurcXerzs1DHWn8CxTTwYFPzhWI8Nv38Z0ATWDzuDpZ2c1NfgJFOofqz2
	 A0fHrt/CRcoEmR6nDgQ/vLvgax7RVRLGjBAjBAMQkrv64CFbV8fpEJa11JIDoye2lD
	 JpsX+0Q9Na8NA59tB3smxQwL7/EQaJs1cBFcJ7UzZMNterJ5ZH/bzjBAzUc9p8fR6L
	 84odOWtNS7bG7onolT3zi5WOulquxmM87qP9xNDP4i2By13nSrhhNbKeU+Eo8Rf6Yb
	 3r/FhcrAC3Njgna14sfU8zCC0Br+NBJxaeyUdN9aTBsSzPE+LadSgErCn2ufRb2jx9
	 qrtrf0Yn4F4oA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/4] s390/pci: Hold fmb_lock when enabling or
 disabling PCI devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Omar Elghoul" <oelghoul@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260612181048.91548-2-oelghoul@linux.ibm.com>
References: <20260612181048.91548-2-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 18:28:11 +0000
Message-Id: <20260612182811.757171F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing cleanup in pcibios_enable_device() error path causes m=
emory leak and a critical Use-After-Free via leaked debugfs files.
- [Critical] Dangling debugfs pointers and FMB leak if device is removed wh=
ile enabled.
- [High] Race condition between pcibios_disable_device() and debugfs write =
causes a permanent FMB memory leak.
--

commit 073e998db2b23cb7423c91c7e1c6e999dbe5b90a
Author: Omar Elghoul <oelghoul@linux.ibm.com>

s390/pci: Hold fmb_lock when enabling or disabling PCI devices

Ensure that fmb_lock is held by pcibios_enable_device() and
pcibios_disable_device() when calling zpci_fmb_enable_device() or
zpci_fmb_disable_device(), respectively. Additionally, assert that the
fmb_lock is held within the latter two functions to prevent future race
conditions regarding new callers.

> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index 39bd2adfc240f..2910d4038d39c 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
[ ... ]
> @@ -639,7 +643,9 @@ int pcibios_enable_device(struct pci_dev *pdev, int m=
ask)
>  	struct zpci_dev *zdev =3D to_zpci(pdev);
> =20
>  	zpci_debug_init_device(zdev, dev_name(&pdev->dev));
> +	mutex_lock(&zdev->fmb_lock);
>  	zpci_fmb_enable_device(zdev);
> +	mutex_unlock(&zdev->fmb_lock);
> =20
>  	return pci_enable_resources(pdev, mask);

[Severity: Critical]
This is a pre-existing issue, but does this leak resources and potentially
cause a use-after-free if pci_enable_resources() fails?

If pci_enable_resources() returns an error, pcibios_enable_device() returns
the error directly without rolling back the debugfs creation or freeing the
FMB. Since pcibios_disable_device() is only invoked by the PCI core if
enablement succeeds, these resources appear to be permanently leaked.

Later, when the device is unregistered, zpci_release_device() frees the zdev
structure via kfree_rcu(). Because the error path bypassed cleanup, the
debugfs files remain active. If userspace then reads or writes to these
orphaned debugfs files, such as in arch/s390/pci/pci_debug.c:pci_perf_show(=
):

	struct zpci_dev *zdev =3D m->private;

	if (!zdev)
		return 0;

	mutex_lock(&zdev->fmb_lock);

won't it dereference the freed zdev pointer?

>  }
> @@ -648,7 +654,9 @@ void pcibios_disable_device(struct pci_dev *pdev)
>  {
>  	struct zpci_dev *zdev =3D to_zpci(pdev);
> =20
> +	mutex_lock(&zdev->fmb_lock);
>  	zpci_fmb_disable_device(zdev);
> +	mutex_unlock(&zdev->fmb_lock);
>  	zpci_debug_exit_device(zdev);

[Severity: High]
This isn't a bug introduced by this patch, but does releasing the lock
before destroying the debugfs endpoints create a race window?

If a concurrent userspace write to the debugfs statistics file in
arch/s390/pci/pci_debug.c:pci_perf_seq_write() is blocked on fmb_lock:

	mutex_lock(&zdev->fmb_lock);
	switch (val) {
	case 0:
		rc =3D zpci_fmb_disable_device(zdev);
		break;
	case 1:
		rc =3D zpci_fmb_enable_device(zdev);
		break;
	}
	mutex_unlock(&zdev->fmb_lock);

it will wake up immediately after pcibios_disable_device() drops the lock.
It will then execute zpci_fmb_enable_device(), which allocates a new
zdev->fmb buffer and re-enables hardware statistics.

After pci_perf_seq_write() releases the lock, pcibios_disable_device()
proceeds to call zpci_debug_exit_device() and permanently deletes the
debugfs files.

Could this race leave the hardware FMB silently active and the zdev->fmb
memory permanently leaked because userspace can no longer disable it?

[Severity: Critical]
This is also a pre-existing issue, but what happens if a zPCI device is
hot-removed while its enable_cnt is greater than 0?

If the device is manually enabled via the PCI sysfs enable attribute while
unbound, or if a bound driver fails to call pci_disable_device(), the PCI
subsystem's teardown path (pci_stop_and_remove_bus_device) does not
automatically invoke pci_disable_device().

As a result, pcibios_disable_device() is never executed. When the device is
subsequently unregistered, zpci_release_device() invokes kfree_rcu() to
free the zdev structure:

arch/s390/pci/pci.c:zpci_release_device() {
    ...
	zpci_bus_device_unregister(zdev);
	zpci_destroy_iommu(zdev);
	zpci_dbg(3, "rem fid:%x\n", zdev->fid);
	kfree_rcu(zdev, rcu);
    ...
}

Because the debugfs teardown step in pcibios_disable_device() was bypassed,
will the active debugfs endpoints remain registered with pointers to the
freed zdev structure, leading to a use-after-free upon access?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612181048.9154=
8-1-oelghoul@linux.ibm.com?part=3D1
