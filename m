Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B02F430CF6;
	Mon,  6 Jul 2026 09:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783329956; cv=none; b=euoyU1JmhAqF+t6MnxDe2DwVYbx7w8PAXhGyyEPOPXqHhS8z8bVAILyClnPzIjxkpw8WqYhMHGlwgOPpZ6XJWy/pgzAPLNNK4m7A69w5Xlc6fd1AMaEbt4NhvvW+aiDmgntv0aQ/TKebGxPK04gGW+udgv9EjF/0+DExwNfMgIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783329956; c=relaxed/simple;
	bh=oty1/96wJyWLitsGR9nwUkN/mj/V5xAFX8XdL4v8MYI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TrkZMC9MGr5frYIDPTyZklqw/96VRoG4raEFPMNoJyg2NEYuL2vAlgu6yVeHYxZiRJZliUuvCYy2J4QpI+RWRKOJL8PrLryWKT2d4EqlrD0foGwTtDB5v6a7jsqoYRKTWnzi/o5VJ9Brn3f51wqTR41qdrLHdW+1LO2lFDRGYvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dG0TzzjQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dG0TzzjQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C801F000E9;
	Mon,  6 Jul 2026 09:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783329951;
	bh=+/fWQ+QG45cgBPI1uF/izqTOV3+cn8KwK33lpRrQdII=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dG0TzzjQvH8C7/evhmqKgLDQXN6d9VFS794TxSX4feW8ryM4dPLX9v8XfBXc551k1
	 irRTY7rANEyXVdmRIfbuQxL9j2bnHEzvTA8Uh4RZ4TZ6yy7ubjpqaCknvqO03IC+Eq
	 S3BU8lNHxkR6tn9bHSlNmVs5Sv48AodmSFYSC8FTm/dvdSIAQRBCA2aApusI0r/gm/
	 GKyIJBUWdjFFFB0EffsPDIJWs1UwuddE2LtRo4qTa9/Rsi2cIewqNBlnuOehy+ZplE
	 b+nPgDzXBaKPhWEzHXVkk+hXrFRf4ataV5h0c19QbSGMZAnUdmdyCXs7lMnj+WmviW
	 EwKuAy8NJKV+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/27] KVM, vfio: remove symbol_get(kvm_put_kvm) from
 vfio
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Oliver Upton" <oupton@kernel.org>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvmarm@lists.linux.dev, "Marc Zyngier" <maz@kernel.org>, linux-s390@vger.kernel.org
In-Reply-To: <20260706085229.979525-4-seiden@linux.ibm.com>
References: <20260706085229.979525-1-seiden@linux.ibm.com>
 <20260706085229.979525-4-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 09:25:50 +0000
Message-Id: <20260706092550.A6C801F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent or subsequent bindings of cdev file descriptors to the =
same VFIO device overwrite the `device->kvm` and `device->kvm_module` point=
ers without dropping the previous reference, causing a KVM instance memory =
leak and premature KVM reference drop.
- [High] The architecture-specific KVM module (e.g., kvm-intel.ko) can be u=
nloaded while VFIO still holds a reference to a KVM instance, leading to ex=
ecution of freed memory when the instance is eventually destroyed.
--

commit 31b847131145e41ad6d50358b1c90ea462e38022
Author: Paolo Bonzini <pbonzini@redhat.com>

KVM, vfio: remove symbol_get(kvm_put_kvm) from vfio
   =20
Right now, KVM and VFIO are using symbol_get to access each other's
symbols because of a circular reference between the modules, as well
as to avoid loading them unnecessarily.
   =20
The remaining use in VFIO is for kvm_put_kvm, which is not inline
because it needs to call kvm_destroy_vm.  However, storing the
address of kvm_destroy_vm in the "struct kvm" is enough to remove
the dependency from VFIO.

> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index b7b8b45f1cec2..6bddea4d384ff 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c

[ ... ]

> @@ -451,9 +451,6 @@ EXPORT_SYMBOL_GPL(vfio_unregister_group_dev);
>  void vfio_device_get_kvm_safe(struct vfio_device *device, struct kvm *kv=
m,
>  			      struct module *kvm_module)
>  {
> -	void (*pfn)(struct kvm *kvm);
> -	bool ret;
> -
>  	lockdep_assert_held(&device->dev_set->lock);
> =20
>  	if (!kvm)
> @@ -462,21 +459,13 @@ void vfio_device_get_kvm_safe(struct vfio_device *d=
evice, struct kvm *kvm,
>  	if (!try_module_get(kvm_module))
>  		return;

[Severity: High]
This isn't a bug introduced by this patch, but does pinning only the generic
kvm.ko module leave us vulnerable to the architecture-specific module being
unloaded?

When VFIO acquires a reference via try_module_get(kvm_module), it doesn't
pin the architecture module (e.g., kvm-intel.ko). If userspace closes the
KVM fds, the VFS reference count drops to 0, allowing an administrator to
unload the arch module.=20

Since VFIO still holds a reference to the struct kvm, when VFIO later drops
its reference, KVM destruction proceeds:

kvm_destroy_vm()
    kvm_arch_pre_destroy_vm(kvm);
    ...
    kvm_arch_destroy_vm(kvm);

Could these calls into the architecture-specific teardown execute unmapped
memory if the arch module has already been unloaded?

> -	pfn =3D symbol_get(kvm_put_kvm);
> -	if (WARN_ON(!pfn))
> +	if (!kvm_get_kvm_safe(kvm))
>  		goto out_put_mod;
> =20
> -	ret =3D kvm_get_kvm_safe(kvm);
> -	if (!ret)
> -		goto out_put_sym;
> -
> -	device->put_kvm =3D pfn;
>  	device->kvm =3D kvm;
>  	device->kvm_module =3D kvm_module;

[Severity: High]
This is a pre-existing issue, but if multiple cdev file descriptors are
opened for the same VFIO device, does this overwrite device->kvm without
dropping the previous reference?

For instance, if vfio_df_get_kvm_safe() is called successfully on a second
file descriptor, but then vfio_df_open() fails because
device->open_count !=3D 0:

drivers/vfio/device_cdev.c:vfio_df_ioctl_bind_iommufd() {
    ...
    vfio_df_get_kvm_safe(df);
   =20
    ret =3D vfio_df_open(df);
    if (ret)
        goto out_put_kvm;
    ...
}

Would this leak the first KVM instance reference since device->kvm is
unconditionally overwritten here?

Additionally, if the second fd has no KVM instance associated, wouldn't the
error path's call to vfio_device_put_kvm() prematurely drop the original
reference and clear device->kvm?

>  	return;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706085229.9795=
25-1-seiden@linux.ibm.com?part=3D3
