Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6709403E8E;
	Fri, 31 Jul 2026 13:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785504460; cv=none; b=C46qp73m2+AjQL6MwIGeychpSghRejr/UciypCN3YMZRbsbSkQhap/mXg92YJZ9mhtHH1AJ8YwxV808DBvjwvGUkl2hD/ZxnGkJtU0yq3NyF0am2szzQR8JKUgwAjmZ8WIRyvi8y2/220lHQ39YfNZG/8vQVKEJ2mOwlQLFU1NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785504460; c=relaxed/simple;
	bh=Shq6PhMR+d9iGwinIIuto2f7t7tLSiVf8R/fADUGZ/w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S3Mz7KcHrSEp47Sv2JworAtIgYpkbvUhXCLPdsHwkuD5EMbEbFeSclRNw5JIZauiHizE0ECGu0A5XoggEKdPOH7bktuafgdgRPq2rsKmpOTWKUweGAo6DSlpn3Ti0ZyzV/CEgQFoQm/+gVmiKOK9Q7w4FiQkE06JkLbXOcHbtG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQ4PsHCU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQ4PsHCU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB4B51F000E9;
	Fri, 31 Jul 2026 13:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785504458;
	bh=845ph5ozDR8LOAKAczfg3TTNNUX06hlI+zIg99eFPlw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kQ4PsHCU+nDSge9KTKH3lMlhIpThf+g5xRz8AapjpHKKMf0H7pL+9GLPpM2XynOF+
	 blY/TiL1ZwG8QCXECCpBbqm2WMImBKtAuXkQcYPQVQsqt+yHKl0oybsG3K585WIbQY
	 RmKBLnnTOu3SStO5JCo3BvKulYkRBi7BKjQX4/eFiyGL72Imm8lVT1Ckg4PpuzW/dk
	 2pDyIM41opd+K7TQcvM/1rnGAxn5/Q1B/W0rAauA+DMuWJImKivT/HcDLtlRY3wAdn
	 hPLGqEcGnlz6LmFfnREACtF3TLwo2Uk8is1sirV8XvW8GKnVuVJ60Zb9LA1Cv0dvdu
	 lxj9s8o1DjRoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/31] vfio: Use file-based reference counting for
 KVM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Oliver
 Upton" <oupton@kernel.org>, "Marc Zyngier" <maz@kernel.org>, "Heiko
 Carstens" <hca@linux.ibm.com>, kvmarm@lists.linux.dev, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260731130902.654679-2-seiden@linux.ibm.com>
References: <20260731130902.654679-1-seiden@linux.ibm.com>
 <20260731130902.654679-2-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 13:27:37 +0000
Message-Id: <20260731132737.DB4B51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Architectural Use-After-Free and Type Confusion due to danglin=
g `kvm->file` and `get_file_active` API misuse.
- [High] The KVM file reference is permanently leaked in `vfio_ap_mdev_set_=
kvm()` when KVM crypto is unavailable.
- [Low] Unused parameter 'file' added to `kvm_ioctl_create_device`.
--

--- Patch [1]: [PATCH v5 01/31] vfio: Use file-based reference counting for=
 KVM ---
commit 0d6533aa3c5f21c080ec0d95c626b95fd5fb711d
Author: Steffen Eiden <seiden@linux.ibm.com>

vfio: Use file-based reference counting for KVM

Replace manual module reference counting with file-based reference
counting for KVM integration. Previously, VFIO used symbol_get() to
obtain function pointers for kvm_get_kvm_safe() and kvm_put_kvm(),
then manually tracked module references through these symbols. This
approach required storing the put_kvm function pointer in each device
and carefully managing symbol references.

Pass struct file pointers instead of struct kvm pointers throughout the
VFIO-KVM interface. This leverages the kernel's existing file reference
counting mechanism via get_file_active() and fput(), eliminating the
need for manual module reference tracking. The file->private_data field
provides access to the underlying struct kvm when needed.

This simplifies the code and removes all remaining externally exported
symbols for KVM, paving the path for a second concurrent KVM module.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index 44b3a1dcc1b36..177c8f5ab6b91 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
[ ... ]
> @@ -1815,13 +1816,26 @@ static const struct attribute_group *vfio_ap_mdev=
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
>   *
>   */
>  static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
> -				struct kvm *kvm)
> +				struct file *kvm_file)
>  {
> +	struct file *kvm_file_ref __free(fput) =3D NULL;
>  	struct ap_matrix_mdev *m;
> +	struct kvm *kvm;
> +
> +	kvm_file_ref =3D get_file_active(&kvm_file);

[Severity: Critical]
Because kvm_file is passed by value, &kvm_file is a stack address. Doesn't
this bypass the RCU validation in get_file_active()? Since it checks the
address on the stack, the RCU validation will always succeed even if the
underlying struct file was reallocated.

> +	if (!kvm_file_ref)
> +		return -ENOENT;
> +
> +	kvm =3D kvm_file->private_data;
> +	if (!kvm)
> +		return -ENOENT;
> =20
>  	if (kvm->arch.crypto.crycbd) {
>  		down_write(&kvm->arch.crypto.pqap_hook_rwsem);
[ ... ]
> @@ -1837,13 +1851,13 @@ static int vfio_ap_mdev_set_kvm(struct ap_matrix_=
mdev *matrix_mdev,
>  			}
>  		}
> =20
> -		kvm_get_kvm(kvm);
>  		matrix_mdev->kvm =3D kvm;
>  		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
> =20
>  		release_update_locks_for_kvm(kvm);
>  	}
> =20
> +	no_free_ptr(kvm_file_ref);
>  	return 0;
>  }

[Severity: High]
Does this unconditionally leak the file reference if kvm->arch.crypto.crycbd
is false?

In the false case, matrix_mdev->kvm is not set, but no_free_ptr(kvm_file_re=
f)
is still called, which inhibits the __free(fput) cleanup. Later, when the
device is released, vfio_ap_mdev_unset_kvm() will see a NULL matrix_mdev->k=
vm
and do nothing, permanently leaking the struct file reference.

> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index ed538aebb0b8e..8fad1ca1189f8 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
[ ... ]
> @@ -448,35 +448,13 @@ void vfio_unregister_group_dev(struct vfio_device *=
device)
>  EXPORT_SYMBOL_GPL(vfio_unregister_group_dev);
> =20
>  #if IS_ENABLED(CONFIG_KVM)
> -void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kv=
m)
> +void vfio_device_get_kvm_safe(struct vfio_device *device, struct file *k=
vm)
>  {
> -	void (*pfn)(struct kvm *kvm);
> -	bool (*fn)(struct kvm *kvm);
> -	bool ret;
> -
>  	lockdep_assert_held(&device->dev_set->lock);
> =20
> -	if (!kvm)
> -		return;
> -
> -	pfn =3D symbol_get(kvm_put_kvm);
> -	if (WARN_ON(!pfn))
> +	if (!get_file_active(&kvm))
>  		return;

[Severity: Critical]
Does this usage of get_file_active() defeat its RCU reallocation safety
checks? Similar to the vfio_ap_mdev_set_kvm() case above, kvm is a stack
variable here, so get_file_active() is checking a stack address rather than
the original pointer location.

If the struct file is reallocated (which can happen because the weak back
reference kvm->file can outlive the file descriptor, as noted below),
couldn't this increment the f_count of an arbitrarily reallocated file and
lead to type confusion?

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 45e784462ec6e..994cb40cf2efe 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
[ ... ]
> @@ -4802,7 +4802,7 @@ void kvm_unregister_device_ops(u32 type)
>  		kvm_device_ops_table[type] =3D NULL;
>  }
> =20
> -static int kvm_ioctl_create_device(struct kvm *kvm,
> +static int kvm_ioctl_create_device(struct file *file, struct kvm *kvm,
>  				   struct kvm_create_device *cd)
>  {
>  	const struct kvm_device_ops *ops;

[Severity: Low]
Is the new file parameter intended to be used in this function? It looks
like the function body still relies on kvm_get_kvm(kvm) and ignores this
argument.

[ ... ]
> @@ -5508,6 +5517,10 @@ static int kvm_dev_ioctl_create_vm(unsigned long t=
ype)
>  	 * cases it will be called by the final fput(file) and will take
>  	 * care of doing kvm_put_kvm(kvm).
>  	 */
> +
> +	/* Store back-reference for VFIO and other subsystems */
> +	kvm->file =3D file;
> +
>  	kvm_uevent_notify_change(KVM_EVENT_CREATE_VM, kvm);
> =20
>  	fd_install(fd, file);

[Severity: Critical]
Could this lead to a use-after-free or type confusion?

When userspace closes the KVM VM fd, the file is destroyed and freed by RCU.
However, the kvm object remains alive if kvm_vfio holds a reference to it
(since kvm_vfio_file_add passes dev->kvm->file to VFIO). This would leave
kvm->file as a dangling pointer.

If a VFIO operation later calls vfio_device_get_kvm_safe() on that dangling
pointer, it might operate on a reallocated struct file.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731130902.6546=
79-1-seiden@linux.ibm.com?part=3D1
