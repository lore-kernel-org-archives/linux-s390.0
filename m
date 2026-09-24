Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466553F12D8;
	Thu, 24 Sep 2026 09:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790241299; cv=none; b=RAGQklFE0/JZ9usaw/AKdqYzeznHYwjZRHhMZggx5akGsYlavdnlrM2Mwc7psQEZWwYmPY/46ZukkQJrm/0OxISWPQIqKqJPhchcC2jYmxcXeHl0sz/rLuRzoFk/ISeyTbX0EkJOhMcya6wfXZeK/vuo9iS6/ooFuBQ7wqBfxE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790241299; c=relaxed/simple;
	bh=jf/nK1g3Wda6lR3BPFq6EFpTZwmO3gp2tJ3k+YnjxVs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V3GN3uzYeAoNy+XOZp1ybhKlVw5vhKqiO86PWZq0n+VsZeXnc6fnFNNQ+JvBHFnpQSjzi+gF82UrKqaLBNhp0Np6HHmfi9HPuOoXiNBlLC/slXMB5D3T69ZcHIjqv7F7xc5cvf2osTwvowniwOOZqoEcXkpMgGHOaNP3dhVFX5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjQoJrnr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjQoJrnr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D2E1F000FF;
	Thu, 24 Sep 2026 09:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790241297;
	bh=uY5bSMY6x5o41b1iEma2RQ9QRtxQu0vUR+DvDD71gCI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BjQoJrnrahdRDDDeZ/K1t3i/0CXV03MG2JpyODT7XgGB66Ro1d/JMMPhwSWvdfBf6
	 R5XlWAJ1tw1ZloDveuh1b/RbEKmaYtssF7taYlmDzWte4sqvZPPlLyB8L++aGECK2n
	 adXeWMr2gUTPzyD5pSl3QE42FZXogYlM9/Z/QGVnNTbTH4S++Equ3TXwoiN6sstPlo
	 ftcC53UrfNMIeHfwiVY7FEIzztg5Za8K2SQq72s4itKZptROcEBNLq3MVfIpLlSFq2
	 /lMzjrjRTPVr4+gCZMGllgmOr0pihU6OLq1ovqay5PHj0ZczE7seuyhjkZNoIPcAL0
	 Eb0n7effGSs6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/5] KVM/vfio: Use file-based reference counting for
 KVM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260924-vfio-v3-4-4a294307797b@linux.ibm.com>
References: <20260924-vfio-v3-0-4a294307797b@linux.ibm.com>
 <20260924-vfio-v3-4-4a294307797b@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 09:14:56 +0000
Message-Id: <20260924091457.74D2E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kvm/vfio: memory leak due to circular file reference
--

commit 67e757ae1d0e68e93f61ad99fbdfb9cdb735b83e
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM/vfio: Use file-based reference counting for KVM

This commit replaces manual module reference counting for KVM integration w=
ith
file-based reference counting. It passes struct file pointers instead of
struct kvm pointers across the VFIO-KVM interface, using get_file() and
fput() to manage references.

> diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
> index b2299e5bc6df3..5bf8cbdff377c 100644
> --- a/drivers/vfio/group.c
> +++ b/drivers/vfio/group.c
> @@ -860,11 +860,20 @@ bool vfio_group_enforced_coherent(struct vfio_group=
 *group)
>  	return ret;
>  }
> =20
> -void vfio_group_set_kvm(struct vfio_group *group, struct kvm *kvm)
> +void vfio_group_set_kvm(struct vfio_group *group, struct file *kvm)
>  {
> +	struct file *old;
> +
> +	if (kvm)
> +		get_file(kvm);
> +
>  	spin_lock(&group->kvm_ref_lock);
> +	old =3D group->kvm;
>  	group->kvm =3D kvm;
>  	spin_unlock(&group->kvm_ref_lock);

[Severity: High]
Does this create a circular file reference? VFIO takes a reference on the K=
VM VM
file here in vfio_group_set_kvm(), while KVM also takes a reference on the
VFIO file.

[ ... ]

> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 423ead48aafe3..ed96acfa86358 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -1544,9 +1515,13 @@ bool vfio_file_enforced_coherent(struct file *file)
>  }
>  EXPORT_SYMBOL_GPL(vfio_file_enforced_coherent);
> =20
> -static void vfio_device_file_set_kvm(struct file *file, struct kvm *kvm)
> +static void vfio_device_file_set_kvm(struct file *file, struct file *kvm)
>  {
>  	struct vfio_device_file *df =3D file->private_data;
> +	struct file *old;
> +
> +	if (kvm)
> +		get_file(kvm);
> =20
>  	/*
>  	 * The kvm is first recorded in the vfio_device_file, and will
> @@ -1554,28 +1529,32 @@ static void vfio_device_file_set_kvm(struct file =
*file, struct kvm *kvm)
>  	 * iommufd successfully in the vfio device cdev path.
>  	 */
>  	spin_lock(&df->kvm_ref_lock);
> +	old =3D df->kvm;
>  	df->kvm =3D kvm;
>  	spin_unlock(&df->kvm_ref_lock);

[Severity: High]
Similarly, does storing the KVM VM file reference in the VFIO device file
here in vfio_device_file_set_kvm() contribute to the circular reference?

[ ... ]

> diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
> index 6cdc4e9a333a3..19548a4309426 100644
> --- a/virt/kvm/vfio.c
> +++ b/virt/kvm/vfio.c
> @@ -168,7 +173,7 @@ static int kvm_vfio_file_add(struct kvm_device *dev, =
unsigned int fd)
>  	kvf->file =3D get_file(filp);
>  	list_add_tail(&kvf->node, &kv->file_list);
> =20
> -	kvm_vfio_file_set_kvm(kvf->file, dev->kvm);
> +	kvm_vfio_file_set_kvm(kvf->file, kvm_file);
>  	kvm_vfio_update_coherency(dev);
> =20
>  	return 0;

[Severity: High]
Could this complete the circular reference loop? Here KVM takes a reference=
 to
the VFIO file via get_file(filp), while VFIO takes a reference to the KVM f=
ile
when kvm_vfio_file_set_kvm() is called.

If a process opens both files, adds the VFIO file descriptor to the KVM VM =
via
the KVM_DEV_VFIO_GROUP_ADD ioctl, and exits, exit_files() will drop the use=
rspace
FD references. However, both files' f_count remain >=3D 1 due to these inte=
rnal
references. Doesn't this cause both files to never reach their release func=
tions,
resulting in a permanent memory and resource leak of the KVM VM and VFIO de=
vice
structures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924-vfio-v3-0-=
4a294307797b@linux.ibm.com?part=3D4
