Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A101F4477E4;
	Thu,  3 Sep 2026 08:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788424944; cv=none; b=Kp/G/9NNXf7ukRJbFMyO2tDCm55Ie+aU3yWlw1JO7oHJViitTmra6cpDXKA4OowAWWppDhSUZNL90sG8CkgPXd35l/EZ6476pVDHP7A17K64yD8ds73t7raS67i0BNVmyHH1QcUc+FAeVDXixmUqOSGyMJFIJIcWPDvcDvFg6+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788424944; c=relaxed/simple;
	bh=0deCoJPjQaFNAdCgRJZQ44dwdni0KS5QLsxJqTJKMW8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HwvPAb5EQ/MuZaBo7us5m/bFf8YGO4VQgXFR6t2Is2Dy2CPCOcG10127eV9r+0V0/DfIs3qTQH1NsTeaDhS2ktTGSCuvdGuErOzaogyx10sFA4YZNEjMFGJx44a/D18sJ3tCG+Sgbjci7hOyuAgrMzF+6WdQmUNrCiv9wQBQhIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ioiUhmOv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ioiUhmOv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B871F000E9;
	Thu,  3 Sep 2026 08:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788424942;
	bh=nhLwjSfN//3mqfDunBcGd3l+h69O3upfL2HzMr4Sy2Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ioiUhmOvdxCih3nwI+wr1W0B1GHxNxe5eUj3JK3qbbbPHPvCgOag63TLqXsmYKB8v
	 /A0hV7tWBgqBxL/F5o5Un/MYmWOYoH3DqyyNiVtBQAG3qU2v4fjze+sHRTmj5oONum
	 fG9j5KNlgalotjtLWZeOruXWrq97tVus9BLDHyd7XuEQr2m0syUiafXf5/OazvEBxG
	 gU1at0zWdJBk+8JknIDfJ9mdKK0fLzQXKziz/RbF2/vRU7UNEvZnuEkLlt/7pC7fgN
	 mIibRpQGuXImmL8/pTYdZFgrd1+nMwbS/EfZsGtHdaslK1HkGaoo4sj4uNGu40GAg8
	 JVqWCEDRp5wyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] vfio: Use file-based reference counting for KVM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260903-vfio-v2-1-ef4cd4190ae7@linux.ibm.com>
References: <20260903-vfio-v2-1-ef4cd4190ae7@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 08:42:21 +0000
Message-Id: <20260903084221.C3B871F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Critical] Untyped `struct file *` for KVM VM leads to type confusion and=
 out-of-bounds access in VFIO device drivers when multiple concurrent KVM m=
odules are loaded.

Pre-existing issues:
- [High] Pre-existing bug in the cdev IOMMUFD binding path allows concurren=
t opens to leak the KVM file reference and prematurely clear `device->kvm`.
--

commit dd4fd68a7d7d9888bc552f388401d95d1f137c5f
Author: Steffen Eiden <seiden@linux.ibm.com>

vfio: Use file-based reference counting for KVM

This patch replaces manual module reference counting with file-based refere=
nce
counting for KVM integration in VFIO. It passes struct file pointers instead
of struct kvm pointers across the interface to leverage the kernel's existi=
ng
file reference counting mechanism. This removes exported symbols and suppor=
ts
multiple concurrent KVM modules.

Link: https://lore.kernel.org/all/20260831144802.834315-1-seiden@linux.ibm.=
com/
Link: https://lore.kernel.org/r/20260812-vfio-v1-1-5cfe0b1fa4e7@linux.ibm.c=
om

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index 940c0ff668bee..f160e1945fbce 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c

[ ... ]

> @@ -1822,17 +1822,27 @@ static const struct attribute_group *vfio_ap_mdev=
_attr_groups[] =3D {
> =20
>  /**
>   * vfio_ap_mdev_set_kvm - sets all data for @matrix_mdev that are needed
> - * to manage AP resources for the guest whose state is represented by @k=
vm
> + * to manage AP resources for the guest whose state is represented by
> + * @kvm_file
>   *
>   * @matrix_mdev: a mediated matrix device
> - * @kvm: reference to KVM instance
> + * @kvm_file: the KVM VM file this vfio device is associated with
>   *
> - * Return: 0 if no other mediated matrix device has a reference to @kvm;
> + * Return: 0 if no other mediated matrix device has a reference to the V=
M;
>   * otherwise, returns an -EPERM.
>   */
>  static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
> -				struct kvm *kvm)
> +				struct file *kvm_file)
>  {
> +	struct kvm *kvm;
> +
> +	if (!kvm_file)
> +		return -ENOENT;
> +
> +	kvm =3D kvm_file->private_data;
> +	if (!kvm)
> +		return -ENOENT;
> +
>  	if (kvm->arch.crypto.crycbd) {

[Severity: Critical]
Does this code adequately verify that the file is an s390 KVM file before
casting its private_data in vfio_ap_mdev_set_kvm() inside
drivers/s390/crypto/vfio_ap_ops.c?

If a user instantiates a VM using a concurrent KVM-arm64 module and attaches
an s390-specific VFIO device to its KVM device, could this driver extract t=
he
untyped private_data and mistakenly treat an arm64 struct kvm as an s390 on=
e?

Because the memory layouts of struct kvm_arch differ across architectures,
would accessing s390-specific fields in the arch member (like
kvm->arch.crypto.pqap_hook) result in arbitrary memory corruption?

>  		get_update_locks_for_kvm(kvm);
>  		if (kvm->arch.crypto.pqap_hook) {

[ ... ]

> diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci=
_zdev.c
> index f47f36314a1cc..045132e90bfee 100644
> --- a/drivers/vfio/pci/vfio_pci_zdev.c
> +++ b/drivers/vfio/pci/vfio_pci_zdev.c
> @@ -184,6 +184,7 @@ int vfio_pci_zdev_feature_err(struct vfio_device *dev=
ice, u32 flags,
>  int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
>  {
>  	struct zpci_dev *zdev =3D to_zpci(vdev->pdev);
> +	struct kvm *kvm;
>  	int ret;
> =20
>  	if (!zdev)
> @@ -195,9 +196,14 @@ int vfio_pci_zdev_open_device(struct vfio_pci_core_d=
evice *vdev)
>  		return 0;
> =20
>  	ret =3D -ENOENT;
> +	kvm =3D vdev->vdev.kvm->private_data;
> +	if (!kvm)
> +		goto recovery;
> +
>  	if (zpci_kvm_hook.kvm_register)
> -		ret =3D zpci_kvm_hook.kvm_register(zdev, vdev->vdev.kvm);
> +		ret =3D zpci_kvm_hook.kvm_register(zdev, kvm);

[Severity: Critical]
Is it possible for a similar regression to occur here in
vfio_pci_zdev_open_device() within drivers/vfio/pci/vfio_pci_zdev.c?

If an arm64 VM file is passed via vdev->vdev.kvm, passing it to
zpci_kvm_hook.kvm_register() could potentially cause type confusion in the
host kernel.

> =20
> +recovery:
>  	if (ret)
>  		zpci_stop_mediated_recovery(zdev);

[ ... ]

> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 423ead48aafe3..ed96acfa86358 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c

[ ... ]

> @@ -511,14 +489,7 @@ void vfio_device_put_kvm(struct vfio_device *device)
>  	if (!device->kvm)
>  		return;
> =20
> -	if (WARN_ON(!device->put_kvm))
> -		goto clear;
> -
> -	device->put_kvm(device->kvm);
> -	device->put_kvm =3D NULL;
> -	symbol_put(kvm_put_kvm);
> -
> -clear:
> +	fput(device->kvm);
>  	device->kvm =3D NULL;

[Severity: High]
This is a pre-existing issue, but does this error path leave the first acti=
ve
file descriptor with a NULL KVM pointer during concurrent cdev IOMMUFD bind=
s?

Looking at vfio_df_ioctl_bind_iommufd() in drivers/vfio/device_cdev.c, if a
user opens a VFIO cdev twice, obtaining two vfio_device_file (df) instances:

1. bind_iommufd on the first df succeeds, setting device->kvm and
device->open_count.

2. bind_iommufd on the second df bypasses the df->access_granted check and
unconditionally calls vfio_df_get_kvm_safe(df). If a KVM file was linked to
the second df, this overwrites device->kvm with the second file's reference
without releasing the first, causing a resource leak.

3. The subsequent vfio_df_open(df) fails because device->open_count !=3D 0.

4. The error path then calls vfio_device_put_kvm() in
drivers/vfio/vfio_main.c, which drops the reference and sets
device->kvm =3D NULL.

Could this sequence leave the first df operating with a NULL device->kvm,
leading to potential NULL pointer dereferences in drivers?

>  }
>  #endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903-vfio-v2-1-=
ef4cd4190ae7@linux.ibm.com?part=3D1
