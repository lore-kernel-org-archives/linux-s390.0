Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272003382DA;
	Fri,  9 Oct 2026 14:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791557768; cv=none; b=RQs2fw/iVUaNWI1RBCzX5gxVXGBbhSe9SRt4RxlfEQbke2PRfAzXA4tAMgkkIcMheyVLci4QsNyqWKu0Aj5RE1hhMvNpe8uVuUpoOO9TUMp2AB3qzMseD/EKQDc4fK+7e8sDdx7UWHEyVmxkAdi8Uxp7gqK7EZ4hZ+lYtGyfbeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791557768; c=relaxed/simple;
	bh=SPA8sL8uqjb9qQImzBDK6ntY+yI2cWW2BUAY5291+q8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=DIJjpSW1mpSAbHA392ruFVNc7OjYWMNTfYvZ/XvIiaMWkMaqvHiFftmMLZwwqbvYn/9jRdZ2w38g7iJ3bScvHB0i3Yi+kg8I5aFIE1kRnt/9VHeWPMvmciteMb5nrTJ6xtxuP/xqt24+jt2bFt5iyv4Na0YqahGYJo3eTXb3Owo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOqwYVx4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOqwYVx4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D9761F000FF;
	Fri,  9 Oct 2026 14:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791557766;
	bh=fRa0LQLV2voQRIxVySyPp38yqcNwEaSAlvt1VMdpA7M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TOqwYVx4Emiv+tNzPukrCsValvJEZDgd7Tat8KqBn9g0FdG8H7+QtVqqg8z5ukyh1
	 0EnUYv7KocMRt/YoEXyZSvfwOEC4obOoYj43kiC1mtkHkVu0otlzGiD0tZ8Q4EXpkI
	 2ixgpAvzoun/eeGVMmcur5bWPhdE0w6eaNPbkgj2yAQOrZu5fiZpizBTUQYQNP8zax
	 y7x7xb7pdR58EYf1oVdhv8Jpd/7mT9VW6F69smPDg5FdJtcE7QO3mou3SG4wnBqdzq
	 19+yzuyoezQnr8wNC78HVdlOASeS+YSWOsVhxAJjLWGfecEnXy9U50iOqpD3UgVFK8
	 ufZh9x0bI7rDw==
Message-ID: <sashiko-outbox-165746@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL 4/6] KVM/vfio: Use file-based reference counting for
 KVM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Borntraeger" <borntraeger@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20261009142749.186650-5-borntraeger@linux.ibm.com>
References: <20261009142749.186650-1-borntraeger@linux.ibm.com>
 <20261009142749.186650-5-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 14:56:05 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] vfio: Circular file reference between KVM and VFIO introduces =
massive VM leak
- [High] kvm: build breakage due to missing file_to_kvm_* and struct kvm->f=
ile
- [High] vfio/kvm: circular file reference cycle prevents KVM and VFIO clea=
nup
--

commit 658cd9bf8e504d53c76b0f2917e7380f6de55ab6
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM/vfio: Use file-based reference counting for KVM
   =20
This commit replaces manual module reference counting with file-based
reference counting for KVM integration. It passes struct file pointers
instead of struct kvm pointers throughout the VFIO-KVM interface.

> diff --git a/arch/s390/kvm/s390/pci.c b/arch/s390/kvm/s390/pci.c
> index 82892e1e03d94..d79bd3bdc68e9 100644
> --- a/arch/s390/kvm/s390/pci.c
> +++ b/arch/s390/kvm/s390/pci.c
> @@ -498,17 +498,22 @@ static void kvm_s390_pci_dev_release(struct zpci_de=
v *zdev)
>   * available, enable them and let userspace indicate whether or not they=
 will
>   * be used (specify SHM bit to disable).
>   */
> -static int kvm_s390_pci_register_kvm(void *opaque, struct kvm *kvm)
> +static int kvm_s390_pci_register_kvm(void *opaque, struct file *kvm_file)
>  {
>  	struct zpci_dev *zdev =3D opaque;
> +	struct kvm *kvm;
>  	int rc;
> =20
>  	if (!zdev)
>  		return -EINVAL;
> =20
> +	kvm =3D file_to_kvm_s390(kvm_file);

[Severity: High]
Does this cause a build failure? I couldn't find the definition for
file_to_kvm_s390() in this patch or anywhere in the tree. The same issue
appears in drivers/s390/crypto/vfio_ap_ops.c for vfio_ap_mdev_set_kvm().

[ ... ]

> diff --git a/arch/x86/kvm/mmu/page_track.c b/arch/x86/kvm/mmu/page_track.c
> index 7e8195a311bb0..f12558dfcd812 100644
> --- a/arch/x86/kvm/mmu/page_track.c
> +++ b/arch/x86/kvm/mmu/page_track.c
> @@ -237,10 +239,11 @@ static int kvm_enable_external_write_tracking(struc=
t kvm *kvm)
>   * register the notifier so that event interception for the tracked guest
>   * pages can be received.
>   */
> -int kvm_page_track_register_notifier(struct kvm *kvm,
> +int kvm_page_track_register_notifier(struct file *file,
>  				     struct kvm_page_track_notifier_node *n)
>  {
>  	struct kvm_page_track_notifier_head *head;
> +	struct kvm *kvm =3D file_to_kvm_x86(file);

[Severity: High]
Similarly, is file_to_kvm_x86() defined? It appears to be missing, which
would break the x86 build.

[ ... ]

> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 423ead48aafe3..ea8e6cc13c457 100644
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

[Severity: Critical]
Does taking a strong reference to the KVM file here create a circular
reference cycle?

When userspace adds a VFIO device to a KVM VM, kvm_vfio_file_add() takes a
reference to the VFIO file. If vfio_device_file_set_kvm() then takes a
reference to the KVM file, both files hold references to each other.

Because both file descriptors hold each other's references, their f_count
will never reach 0 when userspace closes the FDs, permanently leaking the
KVM VM and the VFIO structures.

[ ... ]

> diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
> index 6cdc4e9a333a3..19548a4309426 100644
> --- a/virt/kvm/vfio.c
> +++ b/virt/kvm/vfio.c
> @@ -144,6 +144,7 @@ static int kvm_vfio_file_add(struct kvm_device *dev, =
unsigned int fd)
>  {
>  	struct kvm_vfio *kv =3D dev->private;
>  	struct kvm_vfio_file *kvf;
> +	struct file *kvm_file __free(fput) =3D NULL;
>  	struct file *filp __free(fput) =3D NULL;
> =20
>  	filp =3D fget(fd);
> @@ -154,6 +155,10 @@ static int kvm_vfio_file_add(struct kvm_device *dev,=
 unsigned int fd)
>  	if (!kvm_vfio_file_is_valid(filp))
>  		return -EINVAL;
> =20
> +	kvm_file =3D get_file_active(&dev->kvm->file);

[Severity: High]
Does struct kvm contain a member named 'file'? Looking at
include/linux/kvm_host.h, it doesn't appear to exist, which would cause a
compilation error here.

> +	if (!kvm_file)
> +		return -ENOENT;
> +
>  	guard(mutex)(&kv->lock);
> =20
>  	list_for_each_entry(kvf, &kv->file_list, node) {
> @@ -168,7 +173,7 @@ static int kvm_vfio_file_add(struct kvm_device *dev, =
unsigned int fd)
>  	kvf->file =3D get_file(filp);
>  	list_add_tail(&kvf->node, &kv->file_list);
> =20
> -	kvm_vfio_file_set_kvm(kvf->file, dev->kvm);
> +	kvm_vfio_file_set_kvm(kvf->file, kvm_file);

[Severity: Critical]
This is where KVM takes its strong file reference on the VFIO device file,
which completes the reference cycle discussed above.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009142749.1866=
50-5-borntraeger@linux.ibm.com?part=3D1
