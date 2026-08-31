Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A80146C82A;
	Mon, 31 Aug 2026 18:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788200215; cv=none; b=W2yCmCuIedAhBBzP4npqjewZbRjThlSQfjg/GvRy+pGZYmnCxzbyx3qNT5GDsdIpgBCZ6TXIR6hReXo7pN+De+jRovfvDGh960fOVmJ9dTI3UC7+DHc7Q/DnU4dWgq0YcXLOSVMMp4Z/0thbedQpCsYcwfEyfsjhsVKyvjG9rqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788200215; c=relaxed/simple;
	bh=xWf2NG2NMFbBthSI8YpEM6a/pCLRBL0tLvFDsUPhgHg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SEJsmkM+jD+yQpAWdKsozADijB2Wx8qrZpJUL3hmnG7dmnxdfKlx1gxp4g4sNbFih/jDTQLAeden7h7OxcduOIPyRnvSjP4lvR2dFvmDkX3AZ7kvQK8U5vkINzHWF2AIPg0Y7zP+EM4MMUR+LBl7WJqw8oXwL0P1tBPRC+gmJjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwYU8LW2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwYU8LW2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547C31F000E9;
	Mon, 31 Aug 2026 18:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788200213;
	bh=/NrRRVp++LL7KVy628DKCCV6ChIPaUQYGtiRU2AEwho=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AwYU8LW211Gaq5b+9Nhm0ogFz1YNPPZXMWp+001e49zQPM0NVTirbpttCB9tKnyIQ
	 HPl4Ycp0zMIPPB57WzIGDCDXGtHxJG7rmRdAMkNUDSq26i55AQ0rupC/S5qACnohVg
	 gfvm7zk55KLIV6xJIlxc6+DzEZ0/9yXuw/1Z4cB8C5efhBBXr3J6+THXCAZfQq3M43
	 MV2zdI9gIpOUSqdoOThR0xnEKdvzDuwLsIaemQ0bvZwv2yFEUSK+F62KYbRiPDa8+W
	 JkQ21qK8lJX3k9tTuUGONjseS/MD68E7dxLv146pn4bgdSiRtsxTMZzDo8uZL8F/A1
	 mhwJLrBymiSSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 01/23] vfio: Use file-based reference counting for
 KVM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Marc Zyngier" <maz@kernel.org>, kvmarm@lists.linux.dev, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Oliver Upton" <oupton@kernel.org>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260831144802.834315-2-seiden@linux.ibm.com>
References: <20260831144802.834315-1-seiden@linux.ibm.com>
 <20260831144802.834315-2-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 18:16:52 +0000
Message-Id: <20260831181653.547C31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Unconditional error-path clearing of `device->kvm` in `vfio_df=
_ioctl_bind_iommufd` causes Use-After-Free of KVM VM file.
--

commit 17abe1f20f0f7d26badf30ce42a340a4d82f7c46
Author: Steffen Eiden <seiden@linux.ibm.com>

vfio: Use file-based reference counting for KVM

Replace manual module reference counting with file-based reference
counting for KVM integration. Previously, VFIO used symbol_get() to
obtain function pointers for kvm_get_kvm_safe() and kvm_put_kvm(),
then manually tracked module references through these symbols. This
approach required storing the put_kvm function pointer in each device
and carefully managing symbol references. Remove the put_kvm field in
struct vfio_device as is it no longer used.

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
>  }

[Severity: Critical]
This is a pre-existing issue, but looking at how this function is called
from the error path in vfio_df_ioctl_bind_iommufd(), could this cause a
use-after-free of the KVM VM file?

If a process opens a VFIO cdev (df1) and successfully binds it via
VFIO_DEVICE_BIND_IOMMUFD, device->kvm is set to the KVM file and
device->open_count is 1.

If the process then opens a second cdev fd (df2) for the same device and
calls VFIO_DEVICE_BIND_IOMMUFD again without associating a KVM VM:

df2->access_granted is false, bypassing the already bound check.
vfio_df_get_kvm_safe(df2) does nothing because df2->kvm is NULL, leaving
device->kvm intact.
vfio_df_open(df2) then fails because the device is already open
(device->open_count !=3D 0).

The error path in vfio_df_ioctl_bind_iommufd() then unconditionally drops
the KVM reference:

drivers/vfio/device_cdev.c:vfio_df_ioctl_bind_iommufd() {
    ...
out_put_kvm:
    vfio_device_put_kvm(device);
    ...
}

This calls fput(device->kvm) and sets device->kvm =3D NULL here in
vfio_device_put_kvm(), dropping the legitimate KVM reference held by df1.
When userspace subsequently closes the KVM fd, the VM is freed, but the
active VFIO driver (e.g., vfio_ap) retains a dangling pointer to it.

Could this lead to a use-after-free upon the next operation?

Should the error path in vfio_df_ioctl_bind_iommufd() avoid calling
vfio_device_put_kvm() if the failed caller wasn't the one that set
device->kvm?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831144802.8343=
15-1-seiden@linux.ibm.com?part=3D1
