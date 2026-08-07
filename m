Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9696C3B8948;
	Fri,  7 Aug 2026 22:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786143483; cv=none; b=rDpkg9jYagCLHYzJ7Af9y2+U+eiOSVt7Q30365RD9jnozAadYplppedkpHoQgkBNkmkWN/bizzo/pzUS9ShKHZL0Emq9gmf/OJlxzDSS4pVw5+KyxqvM3lzQ7RidBUs/o/WXNipsYmpWIRIXakfbmG0WDXAE4NPmxCA8OuyETg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786143483; c=relaxed/simple;
	bh=XEgq+iwDY02SiK/n3W3QVOYduor4LILIs4ezOgaW1uU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RGovSZsSCXPao35Y2nLR25mAOu9peTNu2Efb37/PB9lHivKje0ILQQVL3dO4VTltEzrQA2mraM5oOf5dVzkuSiJ4/muUDywOwBmRwa6ojjbaAA1NZukUbrqvF9UPkHsqnwZD2JT8fWnauXo+UOrwV4SEilivkfcDbxa6AYw9L8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OsCbWi6/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OsCbWi6/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41BCD1F000E9;
	Fri,  7 Aug 2026 22:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786143482;
	bh=sS1eoKQs5rb8sB8syrW09t1OKEjkyAqmNb3wwIisQ58=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OsCbWi6/gJhos5yWMD2KtJePHgjA+tECRjFVEhKGLgvSBtXp2hlvRnGodVihX+Oul
	 ywbyyohtAAO7If1xKQo5Oz804U8ViTFSGRTkuAtG8R3lX35aZiCC3bFpFAGQxJ8xbG
	 Bg7DU7FXiXFm0Stv6x7aTww1BMHS8zBkgyl/HuCu7PByaPmWs21xI9rK6ujdMRNPTa
	 PsRGdYju9oWQplOidnlX6Zp6+otrmwalN4hx+/BIWO4YIJC3a+CMwSIFrdtif96wdo
	 5C98cwrdvPKQus49sfRj28F2GViTKgYe4OUH2eUnU0q2iz5vRkDDGluDl+xBcpN5F2
	 ZH8yeYUfAr0Og==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/vfio-ap: Fix control domain removal in
 vfio_ap_mdev_cfg_remove
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260807223939.573718-1-akrowiak@linux.ibm.com>
References: <20260807223939.573718-1-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 22:58:01 +0000
Message-Id: <20260807225802.41BCD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing NULL check on `matrix_mdev->kvm` before acquiring its lock=
 on AP configuration change paths, leading to a kernel panic if a mediated =
device is unattached.
- [High] Guest APCB is not updated when the last adapter or domain is remov=
ed, leaving the guest with unauthorized hardware access.
- [High] Iterating `mdev_list` without the appropriate mutex allows concurr=
ent list modifications, leading to list corruption or use-after-free.
--

--- Patch [1]: [PATCH] s390/vfio-ap: Fix control domain removal in vfio_ap_=
mdev_cfg_remove ---
commit 934a77df4b71bb3ee940f94ad6abdd8290e96d28
Author: Anthony Krowiak <akrowiak@linux.ibm.com>
Subject: s390/vfio-ap: Fix control domain removal in vfio_ap_mdev_cfg_remove

This commit modifies the vfio_ap_config_remove function to use bitmap_and()
instead of bitmap_andnot() when clearing bits from matrix_mdev->matrix.adm.
This ensures that explicitly unplugged control domains are correctly removed
from the KVM guest.

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index 44b3a1dcc1b36..1bfdbe85023dd 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -2615,9 +2615,9 @@ static void vfio_ap_mdev_cfg_remove(unsigned long *=
ap_remove,

[Severity: High]
This is a pre-existing issue, but does vfio_ap_mdev_cfg_remove() safely han=
dle
unattached mediated devices?

If an mdev is created via sysfs, matrix_mdev->kvm is initialized to NULL. I=
f a
host AP configuration change occurs before this mdev is attached to a guest,
the loop in this function:

drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_mdev_cfg_remove() {
    ...
    list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
        mutex_lock(&matrix_mdev->kvm->lock);
    ...
}

will unconditionally dereference the NULL kvm pointer. Is there a missing N=
ULL
check for matrix_mdev->kvm before acquiring its lock on AP configuration ch=
ange
paths?

[Severity: High]
This isn't a bug introduced by this patch, but can the iteration over
mdev_list in vfio_ap_mdev_cfg_remove() race with mdev creation?

vfio_ap_mdev_probe() adds a new mdev to matrix_dev->mdev_list using list_ad=
d()
while holding only matrix_dev->mdevs_lock:

drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_mdev_probe() {
    ...
    mutex_lock(&matrix_dev->mdevs_lock);
    list_add(&matrix_mdev->node, &matrix_dev->mdev_list);
    mutex_unlock(&matrix_dev->mdevs_lock);
    ...
}

However, vfio_ap_mdev_cfg_remove() iterates over mdev_list using
list_for_each_entry() holding only matrix_dev->guests_lock, as mdevs_lock is
only acquired individually inside the loop body.

Could this lead to kernel memory corruption or use-after-free if a user
creates a new mdev concurrently with an asynchronous host AP configuration
change?

>  		do_remove |=3D bitmap_and(aqrem, aq_remove,
>  					  matrix_mdev->matrix.aqm,
>  					  AP_DOMAINS);
> -		do_remove |=3D bitmap_andnot(cdrem, cd_remove,
> -					     matrix_mdev->matrix.adm,
> -					     AP_DOMAINS);
> +		do_remove |=3D bitmap_and(cdrem, cd_remove,
> +					matrix_mdev->matrix.adm,
> +					AP_DOMAINS);
> =20
>  		if (do_remove)
>  			vfio_ap_mdev_hot_unplug_cfg(matrix_mdev, aprem, aqrem,

[Severity: High]
This is a pre-existing issue, but does vfio_ap_mdev_hot_unplug_cfg() proper=
ly
update the guest APCB when the last device is removed?

In vfio_ap_mdev_hot_unplug_cfg(), the decision to update the guest's APCB
relies on bitmap_andnot():

drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_mdev_hot_unplug_cfg() {
    ...
    if (!bitmap_empty(cdrem, AP_DOMAINS))
        do_hotplug |=3D bitmap_andnot(matrix_mdev->shadow_apcb.adm,
                                    matrix_mdev->shadow_apcb.adm,
                                    cdrem, AP_DOMAINS);
    ...
}

The kernel's bitmap_andnot() function returns true only if the resulting
destination bitmap is non-empty. If the last adapter, domain, or control do=
main
is explicitly removed, the destination shadow APCB becomes entirely empty,
causing bitmap_andnot() to return false.

Since do_hotplug remains false, vfio_ap_mdev_update_guest_apcb() is skipped.
Does this leave KVM guests with unauthorized access to physical hardware de=
vices
that have been explicitly removed from the host's AP configuration?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807223939.5737=
18-1-akrowiak@linux.ibm.com?part=3D1
