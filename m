Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB97D175A88;
	Sat,  8 Aug 2026 17:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786211397; cv=none; b=NfOcaMxc0itsszqCJSAEv6GA2YCPPF24BErdw9z2i2XHPcwZRV/3DLuspbv1LawxCVZz5DlCVd1Hu6TKJos1Mt15dlZiFg3UvkVdqa3kmcSniInkG37nhgy1uaK2wggpphRxABQWxGECURbdMAyS90kzhGGlrFBWGsQZTEXKZUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786211397; c=relaxed/simple;
	bh=ALztxF0QNUBml+fzzpI3VPI9kkn/PSmNBg9uapRCTc4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Zs63K1GmtSZtdaZt2NzvfeIVNfNUBHLQiJ/RWOyLUshcMPKnmKZ1sM7j9JiKT7TVYX/qOM7mMEtSCbbpG55xq7ELvLBoDso80cTQMLQJsj1Mt8cJ0LLTfDLOS4Lecv0hiAgKxHZSA6kk3SAoNf/McvfH1TPOsnr15fJF9tssNO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DgUdqFiy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DgUdqFiy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 163381F000E9;
	Sat,  8 Aug 2026 17:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786211395;
	bh=GuhKGEFznq7tiATRMV7BqJZ4iU00My3cOQnh6yhcSoQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DgUdqFiyNiy93Oeyf0RTRidDHDsY1DBlJkKskxFfdOjGNrsWbUlE6pGoNYrp78Lf3
	 RmOdXZcRCEDDgVVCmTnQk1ZKIevw456OOY2qD5mrnKVkEjl7dHrOwtrtBGD3J9wQJe
	 ff4Onn/2O8mzWNQarm1LUPWlAwquSm8+k9M52EPbrzMeoBzcxMJv6klNIGsareUdEZ
	 dNbHOT71h2ZtmUjehVxPHj4Du6hsmRs7UOc+W/VgTK3/zb9fGNilKUocIjO+U1EjWC
	 EcgI9a5QqTNO5MRztkh7YwhHuYgSQ4vyPs3/ktuTbYtu+638fTBijdb8v0byX88R8W
	 bFMMBsgqxdaFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] s390/vfio-ap: Fix stale do_remove flag across
 iterations in vfio_ap_mdev_cfg_remove
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260808170712.839066-2-akrowiak@linux.ibm.com>
References: <20260808170712.839066-1-akrowiak@linux.ibm.com>
 <20260808170712.839066-2-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 17:49:54 +0000
Message-Id: <20260808174955.163381F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Unconditional dereference of `matrix_mdev->kvm` pointer leadin=
g to host kernel panic.
- [High] Concurrent modification and traversal of `matrix_dev->mdev_list` w=
ithout consistent locking.
- [High] Assigned control domains removed from the host are not unplugged f=
rom the KVM guest due to incorrect bitmap calculation.
- [High] Unplugging the last assigned AP resource from an mdev fails to upd=
ate the KVM guest configuration.
--

--- Patch [1]: [PATCH 1/5] s390/vfio-ap: Fix stale do_remove flag across it=
erations in vfio_ap_mdev_cfg_remove ---
commit bb84df1768da7fbde04fb6494c22c41ed756bd46
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Fix stale do_remove flag across iterations in vfio_ap_mdev_cf=
g_remove

This commit fixes an issue in vfio_ap_mdev_cfg_remove() where the do_remove
flag is incorrectly accumulated across iterations. It ensures the flag is
properly assigned on the first bitmap operation for each mdev.

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index 44b3a1dcc1b36..845c86ba8bc30 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -2603,15 +2603,15 @@ static void vfio_ap_mdev_cfg_remove(unsigned long=
 *ap_remove,
>  	DECLARE_BITMAP(aprem, AP_DEVICES);
>  	DECLARE_BITMAP(aqrem, AP_DOMAINS);
>  	DECLARE_BITMAP(cdrem, AP_DOMAINS);
> -	int do_remove =3D 0;
> +	int do_remove;
> =20
>  	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {

[Severity: High]
This isn't a bug introduced by this patch, but does this code risk list
corruption or following invalid pointers?

The list is being iterated without holding mdevs_lock across the entire loop
(the lock is acquired and released inside the loop). Concurrently,
vfio_ap_mdev_probe() adds new mdevs to the list while holding only mdevs_lo=
ck:

drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_mdev_probe() {
    ...
    list_add(&matrix_mdev->node, &matrix_dev->mdev_list);
    ...
}

Could this concurrent modification and traversal crash the host kernel?

>  		mutex_lock(&matrix_mdev->kvm->lock);

[Severity: Critical]
This is a pre-existing issue, but can this unconditionally dereference a nu=
ll
pointer?

When an mdev is created, its kvm pointer is null until it is attached to a
guest. If a host AP configuration change occurs while an unattached mdev
exists, this unconditionally executes mutex_lock(&matrix_mdev->kvm->lock),
which dereferences the null kvm pointer.

Could this lead to a host kernel panic?

>  		mutex_lock(&matrix_dev->mdevs_lock);
> =20
> -		do_remove |=3D bitmap_and(aprem, ap_remove,
> -					  matrix_mdev->matrix.apm,
> -					  AP_DEVICES);
> +		do_remove =3D bitmap_and(aprem, ap_remove,
> +				       matrix_mdev->matrix.apm,
> +				       AP_DEVICES);
>  		do_remove |=3D bitmap_and(aqrem, aq_remove,
>  					  matrix_mdev->matrix.aqm,
>  					  AP_DOMAINS);

[Severity: High]
This is a pre-existing issue in vfio_ap_mdev_cfg_remove(), but is this bitm=
ap
calculation correct?

Right below the quoted code, cdrem is calculated:

drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_mdev_cfg_remove() {
    ...
		do_remove |=3D bitmap_andnot(cdrem, cd_remove,
					     matrix_mdev->matrix.adm,
					     AP_DOMAINS);
    ...
}

This evaluates to cd_remove & ~(matrix.adm), which yields domains removed f=
rom
the host that are explicitly not assigned to the mdev. Assigned domains that
are removed from the host are omitted and therefore not hot-unplugged.

Could this allow a control domain removed from the host AP configuration to
remain improperly assigned and accessible to the KVM guest?

[Severity: High]
This is another pre-existing issue, but does unplugging the last assigned
AP resource from an mdev fail to update the KVM guest configuration?

In vfio_ap_mdev_hot_unplug_cfg(), do_hotplug is determined using bitmap_and=
not:

drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_mdev_hot_unplug_cfg() {
    ...
	if (!bitmap_empty(aprem, AP_DEVICES)) {
		do_hotplug |=3D bitmap_andnot(matrix_mdev->shadow_apcb.apm,
					    matrix_mdev->shadow_apcb.apm,
					    aprem, AP_DEVICES);
	}
    ...
}

bitmap_andnot returns true only if the resulting destination bitmap is
non-empty. If the last adapter or domain is removed, the resulting mask is
empty, bitmap_andnot returns false, and do_hotplug remains false.

Would this skip the APCB update, leaving the KVM guest with its old KVM CRY=
CBD
configuration and retaining access to an AP resource that was successfully
removed from the host?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808170712.8390=
66-1-akrowiak@linux.ibm.com?part=3D1
