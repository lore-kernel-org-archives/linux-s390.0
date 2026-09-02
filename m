Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58163383987;
	Wed,  2 Sep 2026 20:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788380362; cv=none; b=T2HPVX3St+2/ypHlDGB99qsTO5BtALUcS6E/DIVa95/3jDc8zn6Bb1NH7T1C2NBhCncBFUt1cMdJwq22JxktzbcwklJxtAwEkgL6VQf37TAtIVY9tbsra7Z6CbgpAaFFjMAMp0Bsq4ltmHqte5gE4PO6eMhsKKALpgVfzpTBDV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788380362; c=relaxed/simple;
	bh=vXyA8eKvyWRBp/K6V0k9Rd35E94JwkahGZdlw+yf8dQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rl6pp/INgyiBVOTSi71R8vrS0xbXVD1ugjSkZTCk+2oLPHXDRMZB3Xcu6sG+S/IOMyS5yk7YFrJDB4reAkCAAruUTlP0fqVu4qW2x0erETFlJK9vyTslYy4yEohI9PU6+GLoQ4NklNHD+grb5OCuXNi+D1y+ZDcd44ZgvoFTUC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=ZZ/oL0fF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YOQKMyi3; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="ZZ/oL0fF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YOQKMyi3"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailflow.phl.internal (Postfix) with ESMTP id 38C7A13802B7;
	Wed,  2 Sep 2026 16:19:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 02 Sep 2026 16:19:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788380358;
	 x=1788387558; bh=Vz9quh9nvRJcQM3CzvMjGEPr3bSdixOFEm0bNlRkrO0=; b=
	ZZ/oL0fFJfM06bLBWKqfF51tay77Ozbj7KUCYvnDD4aesbtfsdJtamNItiA5OUGa
	UFyReTB76y4MCbK4iHVlSTFiw5MQNnxmlYIHapPZ6q9WXF6kFNvj/YLbrHJqK0+0
	dhNmUYO4wzskV1G9rLf9az60taKzXf/nTTxlssOL7sMPBCLvBKXu0VMThkTrhMoa
	o5IaATe7jEEU4Hk9LYuDBKfJMU21F5L6xtGSoatpeibfGF9U4wrT64V64erwseJx
	3gP+gPwbp9fY5WlyawY2k+F7H83ZOCOXRGpRCAk1O+M6esgN32DrXYtRzLZ3DKTZ
	SHTymqJTAblPS+XTUGZNQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788380358; x=
	1788387558; bh=Vz9quh9nvRJcQM3CzvMjGEPr3bSdixOFEm0bNlRkrO0=; b=Y
	OQKMyi311nAd/mqiNJV6ioXgS/xGjTVNeyqQsE4VmGMopFRWAHngL/AOkxB9Itzf
	6mwnzWMquSoAsDnWJ4OTlPt2pVTFb5Ktd7k0zvhdDwuFW/V6AJ2jjnNosD9OdILE
	7lnoXF3znzUqXW6UPmZWBXn9iICK432x1ceiTbqje09tR/jzVAP6TAgkfIJcl+nS
	i1fmxgWPK6XRPv/Ta8iRjUhbBjdEh9DbsXw33NGPQPmKPGuE0gFX41MPWS8dgbeu
	ZEPe9bF0mvNyixzMh9Vm8nmoN9OxypgC/orN4F7hEH/G7Y1cvGfHXUjMABd+x40+
	B6tN9G0KkB4lUQt8Ak9jg==
X-ME-Sender: <xms:xYSYasVMGSFZUbc_xKp1d80iKJUf8oOAnOEOedjXKkCp52QiP-V2zg>
    <xme:xYSYak16gkAaPFj_Lo0-ZDnPg5y7qYZCftlSltamu6EPPddeRsk3bC1VdFyZp9SF3
    S3zb2k0vh2x5MtUK5N0pWca-wJpsG2ITaqSieDy2bqrHlZmG99kt9U>
X-ME-Received: <xmr:xYSYatX4UkC3b5W2nBs5WM5QEbktFpS05n1MTj86HXSGEOgiYuo1TCljn6ifnw>
X-ME-Proxy-Cause: dmFkZTFDPnGKjj96XPPfptgd57/UcEhtbx2v3FA1uJyozmap57p8WrmU6i68nMmSieeH6C
    2QfQhdON/c0RpQshQ9lDgC4CqOne/nSPw5my63jFMyB92Lhrwhb/mBbVRgQQfY3wpx0oaf
    T4bGrvxjMYkHDvjmA9MCbxPninh1qk4D92ZSL3HcI+USIIdNQO0in5ZhgMvm3tNNoAZujN
    MTv88bmpvyrFbeHcleUhdPLwslNEI1ELKI+99Hw5XXj6CjQLLZTOFcBalFQMi4T6w2A0hU
    U85ttGNB4nOYeH2GbGypnletvvGxPMxzoeijCMzhJ+lr6tDwvHd8g0BCJT0e9mP03uWdeo
    Q3MJZah/5/AAE3fgKFhhd/+NP8EmKKAJtH8mv02acvChwOdMue4ysS6GPHrmQtCNawMXGB
    kdc+eFiMciyhhKI5z6SyXJRIj8F/cFJ9FHWAAs4I8P+I4Tcu3LpeOZs5pLg22OJRDz2Mvt
    Rg5fFIdA1rrbwlkw+xn85h2Lj+Bxu9Wv90qTD1qXCsfvtMnz4UPbfYI4YOxkjSe38zutpA
    bICCrDiT+omIUXz8Px9EBW65T8wDt26i7FzX5uVdjQB1Wldo5cuQ3j1a4Up8cQ51Cg87Kz
    OIJGrygxD6OryfiOWU/mURjE0iumH8cqH0o5EVzIHXn+SKHjHLy2iL3a9SOg
X-ME-Proxy: <xmx:xYSYaqDRzuyHC1aCzKRyrUdEW_rKlHeQ3r9XAHizO0sptxPUtE7Kgw>
    <xmx:xYSYagpMw66uCsmInbiPbyfC3PPZTwydQJYNI-h_WbqwdFZT6GFTjw>
    <xmx:xYSYam14BWIxLjQy6Y8Q7DlY_qMUDaqbfx1KiJ1Qt5SCOOVS1LIsHQ>
    <xmx:xYSYan2Z5YTqhysqaK0h18Cz6CD01-aEEcDpoYpOFb31SSyRIqhXVA>
    <xmx:xoSYavBGO8yOzmhhBz-FRvWc6LYzXx4mufSs4DYR60NXNYTtO90oZwks>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 16:19:15 -0400 (EDT)
Date: Wed, 2 Sep 2026 14:19:14 -0600
From: Alex Williamson <alex@shazbot.org>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Tony Krowiak <akrowiak@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Harald Freudenberger <freude@linux.ibm.com>,
 Holger Dengler <dengler@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, alex@shazbot.org
Subject: Re: [PATCH] vfio: Use file-based reference counting for KVM
Message-ID: <20260902141914.15a30449@shazbot.org>
In-Reply-To: <20260812-vfio-v1-1-5cfe0b1fa4e7@linux.ibm.com>
References: <20260812-vfio-v1-1-5cfe0b1fa4e7@linux.ibm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Aug 2026 20:55:30 +0200
Steffen Eiden <seiden@linux.ibm.com> wrote:

> Replace manual module reference counting with file-based reference
> counting for KVM integration. Previously, VFIO used symbol_get() to
> obtain function pointers for kvm_get_kvm_safe() and kvm_put_kvm(),
> then manually tracked module references through these symbols. This
> approach required storing the put_kvm function pointer in each device
> and carefully managing symbol references. Remove the put_kvm field in
> struct vfio_device as is it no longer used.
> 
> Pass struct file pointers instead of struct kvm pointers throughout the
> VFIO-KVM interface. This leverages the kernel's existing file reference
> counting mechanism via get_file()/get_file_active() and fput(),
> eliminating the need for manual module reference tracking. The
> file->private_data field provides access to the underlying struct kvm
> when needed.
> 
> group->kvm and df->kvm hold a reference of their own, taken when the
> pointer is stored and dropped when it is overwritten or cleared. They
> have to: the kvm-vfio device fd holds a VM reference of its own, so the
> VM file can be closed and released while the kvm-vfio device is still
> alive and still pointing at it. filp_cachep is SLAB_TYPESAFE_BY_RCU, so
> a stale pointer left in those slots could be made to reference a
> recycled, unrelated file.
> 
> kvm->file itself carries no reference, so that it does not pin the VM.
> It is only ever read with get_file_active(), which is safe because
> kvm_vm_release() clears it, i.e. before the struct file is freed.
> 
> This simplifies the code and removes all remaining externally exported
> symbols for KVM, paving the path for a second concurrent KVM module.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> ---
> This is a spin-off for the arm-on-s390 series for fast-lane merging
> requested by sean[0]. It is based on patch 1 [1] of the v6 of the
> arm-on-s390 series but with some fixes for some issues pointed out by
> sashiko. The useless rcu protection of kvm->file is removed and
> the getting-the-file-handle process is streamlined.

We'll need a shared branch to merge this across two subsystems and the
vfio-ap driver.  Based on $Subject and LoC I can volunteer to provide
that once we're settled.  A couple minor issues below...

> diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
> index 0990fdb146b7..d3a110101353 100644
> --- a/drivers/vfio/pci/vfio_pci_zdev.c
> +++ b/drivers/vfio/pci/vfio_pci_zdev.c
> @@ -144,6 +144,7 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
>  int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
>  {
>  	struct zpci_dev *zdev = to_zpci(vdev->pdev);
> +	struct kvm *kvm;
>  
>  	if (!zdev)
>  		return -ENODEV;
> @@ -151,8 +152,12 @@ int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
>  	if (!vdev->vdev.kvm)
>  		return 0;
>  
> +	kvm = vdev->vdev.kvm->private_data;
> +	if (!kvm)
> +		return -ENOENT;
> +
>  	if (zpci_kvm_hook.kvm_register)
> -		return zpci_kvm_hook.kvm_register(zdev, vdev->vdev.kvm);
> +		return zpci_kvm_hook.kvm_register(zdev, kvm);

There are conflicts here with Farhan's 9f240376d034 ("s390/pci: Store
PCI error information for passthrough devices"), we need to maintain
the error exit funnel through stop mediation.
  
>  	return -ENOENT;
>  }
> diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> index 7728bc99b63d..f76504d707e1 100644
> --- a/drivers/vfio/vfio.h
> +++ b/drivers/vfio/vfio.h
> @@ -23,7 +23,7 @@ struct vfio_device_file {
>  	u8 access_granted;
>  	u32 devid; /* only valid when iommufd is valid */
>  	spinlock_t kvm_ref_lock; /* protect kvm field */
> -	struct kvm *kvm;
> +	struct file *kvm;
>  	struct iommufd_ctx *iommufd; /* protected by struct vfio_device_set::lock */
>  };
>  
> @@ -88,7 +88,7 @@ struct vfio_group {
>  #endif
>  	enum vfio_group_type		type;
>  	struct mutex			group_lock;
> -	struct kvm			*kvm;
> +	struct file			*kvm;
>  	struct file			*opened_file;
>  	struct iommufd_ctx		*iommufd;
>  	spinlock_t			kvm_ref_lock;
> @@ -107,7 +107,7 @@ void vfio_device_group_unuse_iommu(struct vfio_device *device);
>  void vfio_df_group_close(struct vfio_device_file *df);
>  struct vfio_group *vfio_group_from_file(struct file *file);
>  bool vfio_group_enforced_coherent(struct vfio_group *group);
> -void vfio_group_set_kvm(struct vfio_group *group, struct kvm *kvm);
> +void vfio_group_set_kvm(struct vfio_group *group, struct file *kvm);
>  bool vfio_device_has_container(struct vfio_device *device);
>  int __init vfio_group_init(void);
>  void vfio_group_cleanup(void);

There's a stub in the !CONFIG_VFIO_GROUP set of declarations below this
that isn't updated to the new prototype, build breaks.  Thanks,

Alex
