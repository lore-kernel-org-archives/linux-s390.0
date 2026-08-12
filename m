Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CE33911BC;
	Wed, 12 Aug 2026 16:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786550451; cv=none; b=RKfDBWvpaEMAtjoledBKL6EgzyI3Xv7wbtZyefJWq0PLif6DWUetRf+E733Tmj5AAfOxnsffiJMLOr03f70iYj6RortEsRBtxWAnuSIIYs961W18w4ydYQfIz/ySVAVEfVqd21LPx9vgENXyKe7Zu/b8fxSavF6gG3cD8a+Mb0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786550451; c=relaxed/simple;
	bh=8kEV9PzoKddYDklakfaMxe3szi5eEjkFZhlFDEjjx/4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qEIWRz5SPjncivJD/9imJS3A2Tj+OSvMf7WxIG2q5Op/TMWwPAwvS4U3JQVPut9Js54jablPCspCZhmvoZKtiTez1gogY4YiYmkzAh01FA9o77HTEU2OvionhNtbtMHj2IJDmxJ6CmKQcrvJNssG1GyXApPbKw/UgP/PjXm4DOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyL1yykn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyL1yykn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4321F000E9;
	Wed, 12 Aug 2026 16:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786550449;
	bh=znbEQP5qeKkTvLwzEeo1qv7S+Toyr6Dx3zZPsY0fb1I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fyL1yyknhziDYrEpczp824Goa1mJKSzdLKBNilGAqyhRyo38EOG+cEo+FF6s4jprU
	 eyWocQTF/fK0p+6G81gnm0y3+BUifDKfyfp57ARL9QRP8/DQwlvFGFOiF1zJOR8XY1
	 LrNZ8Y+w2TkplzD5fJJaWCuu171NQ0jnwYVzjQce5dAOjKDGx5tTIC6UaCSda2vrwg
	 K5AjKVg5DeCmqiUuHNbvE+jLic2xQrDh6xDiNFZk4lmmUjvyIrlQZE2UZBqfaKFmSS
	 l6UUtEhUCy6vhUhbt78xEVrQ6WVquVMSMtN267B10vSLNAut8JhqMn47Pd/gRl6dHn
	 b9chuBrjL8SeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 01/33] vfio: Use file-based reference counting for
 KVM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvmarm@lists.linux.dev, linux-s390@vger.kernel.org, "Marc Zyngier" <maz@kernel.org>, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Oliver
 Upton" <oupton@kernel.org>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260812153631.3376090-2-seiden@linux.ibm.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
 <20260812153631.3376090-2-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 16:00:48 +0000
Message-Id: <20260812160049.4D4321F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] VFIO retains a dangling weak pointer to the KVM VM `struct fil=
e` when the VM fd is closed, leading to use-after-free and type confusion i=
f the file memory is reallocated.
- [Medium] Direct, unsafe access to the RCU-protected pointer `kvm->file` w=
ithout using RCU primitives.
--

--- Patch [1]: [PATCH v6 01/33] vfio: Use file-based reference counting for=
 KVM ---
commit fbb73952530ea819e76b37873395b8b6ce2e0444
Author: Steffen Eiden <seiden@linux.ibm.com>

vfio: Use file-based reference counting for KVM

This commit replaces manual module reference counting with file-based
reference counting for KVM integration. It updates the VFIO-KVM interface
to pass struct file pointers instead of struct kvm pointers, relying on
get_file_active() and fput() for reference management.

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index 99a0efd999ef9..875e67063d8e5 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
[ ... ]
> @@ -1822,12 +1823,25 @@ static const struct attribute_group *vfio_ap_mdev=
_attr_groups[] =3D {
>   * @matrix_mdev: a mediated matrix device
>   * @kvm: reference to KVM instance
>   *
> - * Return: 0 if no other mediated matrix device has a reference to @kvm;
> - * otherwise, returns an -EPERM.
> + * Returns: 0 if the reference to kvm is successfully retrieved from @kv=
m_file
> + * and set into @matrix_mdev; otherwise, returns:
> + *	-ENOENT if a reference to kvm could not be retrieved from @kvm_file
> + *	-EPERM if another mediated matrix device already has a reference to t=
he same kvm instance
>   */
>  static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
> -				struct kvm *kvm)
> +				struct file **kvm_file)
>  {
> +	struct file *kvm_file_ref __free(fput) =3D NULL;
> +	struct kvm *kvm;
> +
> +	kvm_file_ref =3D get_file_active(kvm_file);
> +	if (!kvm_file_ref)
> +		return -ENOENT;
> +
> +	kvm =3D kvm_file_ref->private_data;
> +	if (!kvm)
> +		return -ENOENT;

[Severity: Critical]
If kvm_file_ref points to a file that was freed and reallocated to a
completely different type of file (due to SLAB_TYPESAFE_BY_RCU), could
this cause type confusion?

Since struct file memory can be reused, extracting private_data without fir=
st
verifying the file's operations (f_op) could lead to arbitrary memory
corruption. Should this code use file_is_kvm() or file_to_kvm() before
dereferencing private_data?

> diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci=
_zdev.c
> index 0990fdb146b78..d3a1101013531 100644
> --- a/drivers/vfio/pci/vfio_pci_zdev.c
> +++ b/drivers/vfio/pci/vfio_pci_zdev.c
[ ... ]
> @@ -144,6 +144,7 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_=
device *vdev,
>  int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
>  {
>  	struct zpci_dev *zdev =3D to_zpci(vdev->pdev);
> +	struct kvm *kvm;
> =20
>  	if (!zdev)
>  		return -ENODEV;
> @@ -151,8 +152,12 @@ int vfio_pci_zdev_open_device(struct vfio_pci_core_d=
evice *vdev)
>  	if (!vdev->vdev.kvm)
>  		return 0;
> =20
> +	kvm =3D vdev->vdev.kvm->private_data;
> +	if (!kvm)
> +		return -ENOENT;

[Severity: Critical]
Does this code also need to validate that vdev->vdev.kvm is actually a KVM
file before interpreting its private_data as a struct kvm pointer?

> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 423ead48aafe3..b06d1a9116051 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
[ ... ]
> @@ -472,36 +472,17 @@ void vfio_unregister_group_dev(struct vfio_device *=
device)
>  EXPORT_SYMBOL_GPL(vfio_unregister_group_dev);
> =20
>  #if IS_ENABLED(CONFIG_KVM)
> -void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kv=
m)
> +void vfio_device_get_kvm_safe(struct vfio_device *device, struct file **=
kvm)
>  {
> -	void (*pfn)(struct kvm *kvm);
> -	bool (*fn)(struct kvm *kvm);
> -	bool ret;
> +	struct file *kvm_file_ref __free(fput) =3D NULL;
> =20
>  	lockdep_assert_held(&device->dev_set->lock);
> =20
> -	if (!kvm)
> +	kvm_file_ref =3D get_file_active(kvm);
> +	if (!kvm_file_ref)
>  		return;

[Severity: Critical]
Can this result in getting a reference to a completely unrelated file objec=
t?

If userspace opens a KVM VM and creates a KVM VFIO device (taking a referen=
ce
to the kvm object), VFIO stores a weak pointer to the KVM struct file.

If userspace then closes the KVM VM fd while keeping the KVM VFIO device fd
open:

1. The VM fd closes, dropping the f_count to 0 and freeing the struct file
   via RCU.
2. The kvm->users_count remains > 0 (due to the open KVM VFIO device fd), so
   kvm_destroy_vm() is never called to clear the VFIO weak pointer.
3. Because struct file uses SLAB_TYPESAFE_BY_RCU, the freed memory can be
   reallocated to a completely unrelated file.

When get_file_active() is later called here on the dangling pointer, wouldn=
't
it successfully take a reference on the reused struct file?

> diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
> index 6cdc4e9a333a3..0166cc4d39b31 100644
> --- a/virt/kvm/vfio.c
> +++ b/virt/kvm/vfio.c
[ ... ]
> @@ -168,7 +168,7 @@ static int kvm_vfio_file_add(struct kvm_device *dev, =
unsigned int fd)
>  	kvf->file =3D get_file(filp);
>  	list_add_tail(&kvf->node, &kv->file_list);
> =20
> -	kvm_vfio_file_set_kvm(kvf->file, dev->kvm);
> +	kvm_vfio_file_set_kvm(kvf->file, dev->kvm->file);

[Severity: Medium]
Is it safe to access dev->kvm->file directly here?

Since kvm->file is explicitly annotated as a __rcu pointer in struct kvm,
shouldn't this be accessed within an RCU read-side critical section using
rcu_dereference() to avoid data races with kvm_vm_release()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812153631.3376=
090-1-seiden@linux.ibm.com?part=3D1
