Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA9C346774;
	Wed, 12 Aug 2026 17:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786555164; cv=none; b=qDk59npEx1c9+Sj9MCZbhCE7jEC/Q6gAURVuAjJevCl0hkKQSZFI1Eho8dvOY9+7+QqoL1/dNu++WU6oAdP8C3eTDeJCegc3TU3N6kjPkDacSheSbMM3l+TLjtHfJ5KY8NADtT3elVEG11Q/0F8gCofP9eHAPEFWLl1H11FKbK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786555164; c=relaxed/simple;
	bh=HKK2FT1UBejl3aLkCS9dmMsQQ+yFQ3SfJNylNNccEeA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HDZBW/Ntb2inJHuSufV+RJnJRCrcKV/EEEWzYzHNzgCne7SsvsXz2tt6G3R/lwDGqkya0iLWG2wdtWvlFDgWdzZc1yZJSodiDS6/q16uaWfSd1v+nVW/XElsZEjouF3IFoqLtqxQ/Ft4SbV/hkInF0Lg3ySMDLVvCzJbInXidWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuPbvhQH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuPbvhQH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885B91F000E9;
	Wed, 12 Aug 2026 17:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786555163;
	bh=Q8by5rr13lL3Rx2XmuEFFqZd2r51dNuV0vQGnx0jmFo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TuPbvhQHXmLTEXyBHo9Sb8LVvm+KImzqSZfj1uwBVVTF/tTijBsu87/CuyeeFf/0A
	 7RHH40Og0cMirKedpim69vsS9rnonbfcBGvlIrUncGMqYYq7LFc2M6C76g/2wBqWTU
	 O0jpauIAYZ3zIZpVGVPXICjm6PSlD/ra5fj7eL5/CjXBqfjJsYdMcJmWiwT3GkRLvI
	 yUiSReiBC6apNc61IvYS8JDKqnEB229HISI4pUu+8LB032fBB+80StIjIKCO3+HXrA
	 utqOvm1tRNXRWVTFPnitVFslBGNV1B3Jn8Lb/eY2R7FRLgyw9/X+/fwGF3L8dHMEvd
	 XVvsEfDfPAzAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/9] s390/vfio-ap: Fix control domain removal in
 vfio_ap_mdev_cfg_remove
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>, linux-s390@vger.kernel.org
In-Reply-To: <20260812170945.738351-6-akrowiak@linux.ibm.com>
References: <20260812170945.738351-1-akrowiak@linux.ibm.com>
 <20260812170945.738351-6-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 17:19:21 +0000
Message-Id: <20260812171922.885B91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] vfio_ap_mdev_hot_unplug_cfg uses the return value of bitmap_andnot=
 to decide whether to update the guest APCB, bypassing the update when the =
last device or domain is removed.
--

--- Patch [5]: [PATCH v4 5/9] s390/vfio-ap: Fix control domain removal in v=
fio_ap_mdev_cfg_remove ---
commit 10842a74fdddf431bdf00cf897b82e3096df6c33
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Fix control domain removal in vfio_ap_mdev_cfg_remove
   =20
The vfio_ap_config_remove function uses the bitmap_andnot function to clear
bits from the matrix_mdev->matrix.adm bitmap. This prevents the explicitly
unplugged control domains from being removed from the KVM guest. The
bitmap_and function is used instead.

Fixes: eeb386aeb5b7c ("s390/vfio-ap: handle config changed and scan complet=
e notification")
Cc: stable@vger.kernel.org

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
This is a pre-existing issue, but does vfio_ap_mdev_hot_unplug_cfg() fail to
update the guest APCB when the last device or domain is removed?

In drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_mdev_hot_unplug_cfg(), the ret=
urn
value of bitmap_andnot() is used to determine if the hotplug update should
occur:

	if (!bitmap_empty(aprem, AP_DEVICES)) {
		do_hotplug |=3D bitmap_andnot(matrix_mdev->shadow_apcb.apm,
					    matrix_mdev->shadow_apcb.apm,
					    aprem, AP_DEVICES);
	}
...
	if (do_hotplug)
		vfio_ap_mdev_update_guest_apcb(matrix_mdev);

Because bitmap_andnot() returns true only if the resulting destination bitm=
ap
is non-empty, removing the final remaining bits will cause bitmap_andnot() =
to
return 0.

If a host administrator removes the last remaining assigned AP adapter or
domain from the host configuration for a specific mdev, do_hotplug remains =
0.
Will this skip the vfio_ap_mdev_update_guest_apcb() call and allow the KVM
guest to retain hardware access to the unplugged resources?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812170945.7383=
51-1-akrowiak@linux.ibm.com?part=3D5
