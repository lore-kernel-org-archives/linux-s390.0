Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97E6319617;
	Wed,  7 Oct 2026 14:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791382073; cv=none; b=rCruV989F6vVjCPe6BC3mfscdgOTyzT4QABi4cVDul8M2tTdhhykEZquFbSh0cADxKq6Y5K56WbWtzGb9KVG4rUSU9IBLFtsGnMEc/IbF0O5jPc7ItX95QySdO4RIC6DAh4B2IqmDkpm3pMZiJusm1V7DZMypowJjPuuEw2oZCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791382073; c=relaxed/simple;
	bh=0UxmSHLUEPXU8vEolseMnl8C7JprmE6Mc55wxHJtezw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=JQuF4a85yoMWJc0bNEqleuHJuaH/kD4xQyJttBHw1phVIBbXjQPh4mZkHJEeEdfFaQQ2KISC2b4qYuDgfFBh4AKsPTnwdqbNPcO8gISIMP+q+dQthm393WUfIvqlh2XvBqcy+ubjCHrBgZliLTzjylVHpW9lSNvhTtb5KNPIfkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frP0csSa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frP0csSa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F44C1F0089E;
	Wed,  7 Oct 2026 14:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791382064;
	bh=rUD4ZDqrPLTtjfbEqQmqm0Kwy1r2qI+szjWrG9sBSKI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=frP0csSaS5i6ojS2Sb/3/KIuh6kB6TkOrO6yB5j5ytb7Oz9TnLtKADAmJLD1mfzpB
	 +SQtDrvXv9+vgMKQeenlOi0tDbbPxdZ0q4GoXqujMbMltEs9/lnln+/dtjHth3Dbjw
	 y3eL7d1AYQXW/XmtFcBDslSoXyv6/N1ajzOcIN5bmqBe6TZbpB8y9ar4Q4gxSY0IRw
	 eyV/7JW3TFtBqgOGkuJkhTGXEYGGaGcYq31S8ykLEMDESCazkamPKt0dnfXVanIAHR
	 r3wE2itDzFQr6QcI/hg9ZO/180ZiGDyH8McFVcOlaWhydnAvAKuLwJUcX2QiwQCHDp
	 U2KxIw+929Ipw==
Message-ID: <sashiko-outbox-163087@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 4/4] vfio-pci/zdev: Add VFIO FMB device features
Reply-To: sashiko-reviews@lists.linux.dev
To: "Omar Elghoul" <oelghoul@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20261007135926.82935-5-oelghoul@linux.ibm.com>
References: <20261007135926.82935-1-oelghoul@linux.ibm.com>
 <20261007135926.82935-5-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 14:07:44 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] vfio_pci: NULL pointer deref in fmb_read on fmb allocation failure
- [High] vfio_pci: stack buffer overflow in fmb_read via unbounded fmb_leng=
th
--

commit 759143700fb3898fd78661e48f994eff036f8cf5
Author: Omar Elghoul <oelghoul@linux.ibm.com>

vfio-pci/zdev: Add VFIO FMB device features

This commit introduces new VFIO features for zPCI devices to provide FMB
passthrough to userspace. It allows enabling or disabling the FMB using a S=
ET
feature, and reading the latest FMB using a GET feature.

> diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci=
_zdev.c
> index f47f36314a1cc..1a66f455545ab 100644
> --- a/drivers/vfio/pci/vfio_pci_zdev.c
> +++ b/drivers/vfio/pci/vfio_pci_zdev.c
[ ... ]
> +int vfio_pci_zdev_feature_fmb_enable(struct vfio_pci_core_device *vdev, =
u32 flags,
> +				     void __user *arg, size_t argsz)
> +{
[ ... ]
> +	if (fmb_enable.enabled) {
> +		zdev->fmb_requested =3D true;
> +		return zpci_fmb_reenable_device(zdev);

[Severity: High]
If zpci_fmb_reenable_device() fails (for example, if kmem_cache_zalloc()
returns -ENOMEM), does zdev->fmb_requested remain set to true?

Since the failure doesn't revert the flag to false, could this leave the
device state inconsistent for future FMB reads?

[Severity: High]
Is it intentional to bypass the zdev->fmb_length bounds check here?

The standard enablement path typically validates that zdev->fmb_length fits
within the structure boundaries. By calling zpci_fmb_reenable_device()
directly, it appears a hardware-supplied length greater than the size of
struct zpci_fmb could be accepted and saved.

> +	}
> +
> +	return zpci_fmb_disable_device(zdev);
> +}
> +
> +int vfio_pci_zdev_feature_fmb_read(struct vfio_pci_core_device *vdev, u3=
2 flags,
> +				   void __user *arg, size_t argsz)
> +{
> +	struct zpci_dev *zdev;
> +	struct vfio_device_feature_zpci_fmb_read fmb_read;
> +	struct zpci_fmb fmb_bounce;
[ ... ]
> +	scoped_guard(mutex, &zdev->fmb_lock) {
> +		if (!zdev->fmb_requested)
> +			return -ENOMSG;
> +		memcpy(&fmb_bounce, zdev->fmb, zdev->fmb_length);

[Severity: High]
If a previous call to vfio_pci_zdev_feature_fmb_enable() failed during
allocation but left zdev->fmb_requested =3D true, this check will pass.

Will this result in a NULL pointer dereference when accessing zdev->fmb in
this memcpy()?

[Severity: High]
Can zdev->fmb_length be larger than sizeof(struct zpci_fmb)?

If an oversized fmb_length is reported by the hardware or firmware and was =
not
validated during enablement, could copying up to that length into the
fixed-size local stack variable fmb_bounce result in a stack buffer overflo=
w?

> +	}
> +
> +	if (copy_to_user(u64_to_user_ptr(fmb_read.data), &fmb_bounce, zdev->fmb=
_length))
> +		return -EFAULT;
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007135926.8293=
5-1-oelghoul@linux.ibm.com?part=3D4
