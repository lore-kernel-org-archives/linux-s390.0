Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60541331EB8;
	Wed, 12 Aug 2026 20:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786565798; cv=none; b=sORT1iw5vDKPjuAUfdO9QYPlqkKSmFgWz6MjBPZCawxjojiXsTpwkWnb8Xt7OmNFzq+jNDlH3rU7pcQEtsG8KYpv48oE0Poz6817ICbsqOz/fmnLxAC47jcOpAn7DT2tZN4SCBjMRfEUUUmKDvVcOxlbjzQUZAX2do+nssCL9N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786565798; c=relaxed/simple;
	bh=/qZ1QUbTSPKkkqj+84AQL/WqguylAu2gXimJXfHb3Y0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fZdWBH2cqcNC/lPZzufZRlWXmEM9s0Izy9pEEpLXtBI1qmsUTopTZzYrJnR2aO8FgSECV5/NwLLXDNjuNx+GhOdORfVNzTAENrXBo+dGpqmSJ0onUAqEXuQOxRWS8F75dyZbtwsOX5GxZcd4kwL4eOkIMuxIo0ZHFugmMW7xfOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRWRCIaO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRWRCIaO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 882861F000E9;
	Wed, 12 Aug 2026 20:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786565797;
	bh=r5ROglx6za+qto2X7F5gJ+5NcqeI9DK7Cv1tXOZqGCs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NRWRCIaO74pIRKSU57yNaEj2eQ//DvMGNF+bYwKiJevfh+R9oVEVv0HeznfkXecl0
	 UBStqz+SDixnX8bHK/X0f9sXI75nJmcHdqNXRqia7ArpGt6qyLaCUpaQUM3Tl11H+Q
	 bffO/7a/o+O15d2QuaYWElPwXi30fFFjF9BMN2219PB17xMt5ca/Rqi8CYbTFgcd2z
	 zihJsRcptWoDWM23Lq6pl6g3YdUtmq7HUirVKgNDuV4m3xDu3++QpVGwtSlyZX6TkG
	 Qg38u1zX7qqoKQ1BruYvM0974XK8eN/oGZLWVYp1IjD7EZY+zshQgBUalHONCT4SzT
	 y53Cy208nQ9oA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/9] s390/vfio-ap: Fix control domain removal in
 vfio_ap_mdev_cfg_remove
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.vom>, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260812200240.818004-6-akrowiak@linux.ibm.com>
References: <20260812200240.818004-1-akrowiak@linux.ibm.com>
 <20260812200240.818004-6-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 20:16:36 +0000
Message-Id: <20260812201636.882861F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] vfio_ap_mdev_hot_unplug_cfg incorrectly uses the return value of b=
itmap_andnot to track configuration changes, skipping KVM guest updates whe=
n the last AP resource is unplugged.
--

--- Patch [5]: [PATCH v5 5/9] s390/vfio-ap: Fix control domain removal in v=
fio_ap_mdev_cfg_remove ---
commit 2e94c01dff5c7206d21da99863677a285a17a31f
Author: Anthony Krowiak <akrowiak@linux.ibm.com>
s390/vfio-ap: Fix control domain removal in vfio_ap_mdev_cfg_remove

This commit fixes the removal of control domains in the vfio_ap_mdev_cfg_re=
move
function. It correctly uses bitmap_and instead of bitmap_andnot to clear the
assigned control domains, allowing unplugged control domains to be properly
removed from the KVM guest.

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index 21c502598f8ca..0f3537aadea87 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -2636,9 +2636,9 @@ static void vfio_ap_mdev_cfg_remove(unsigned long *=
ap_remove,
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
This is a pre-existing issue, but does vfio_ap_mdev_hot_unplug_cfg() correc=
tly
handle configuration updates when the last AP resource is unplugged?

Looking at vfio_ap_mdev_hot_unplug_cfg():

drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_mdev_hot_unplug_cfg() {
        int do_hotplug =3D 0;

        if (!bitmap_empty(aprem, AP_DEVICES)) {
                do_hotplug |=3D bitmap_andnot(matrix_mdev->shadow_apcb.apm,
                                            matrix_mdev->shadow_apcb.apm,
                                            aprem, AP_DEVICES);
        }

[ ... ]

        if (do_hotplug)
                vfio_ap_mdev_update_guest_apcb(matrix_mdev);
}

The bitmap_andnot() function returns true only if the resulting destination
bitmap is non-empty. If the last device or domain is removed, the resulting
bitmap becomes empty, meaning bitmap_andnot() returns false.

Consequently, do_hotplug evaluates to false, and the guest update function
vfio_ap_mdev_update_guest_apcb() is never called.

Could this skip updating the KVM guest, leaving it with access to AP hardwa=
re
that was hot-unplugged from the host configuration?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812200240.8180=
04-1-akrowiak@linux.ibm.com?part=3D5
