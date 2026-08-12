Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991BE4334A0;
	Wed, 12 Aug 2026 12:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786536316; cv=none; b=MtxojPYP6x/6ha2QmJXgpQa1K1KpT7NCy6BuA5ZHOB0UDoqQlwDipt9038oZFBah8Hk7bOBTVopIPQLgnNabOt4p/BhlYRBqY87aLy0PIvIYZR6/vsZhUhBBlH1Bi3zsLGaufo+nGfVcdAs0BvR7GcVamT8srR4n2aqMyeHWtTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786536316; c=relaxed/simple;
	bh=VXHT82yd6CsknE+4/O/DUZAbDplWzZmVtjc9ljKHtls=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LLAJ0DOXMMe4oBDgV27zGvQbMRFdfATO7HJeD4j7ExAztWGi2fAptDnfsrCUCgedDmM/4MeB7VmtinScGo76BKuXD3EgQ8/2CibBfNFmFZFoEkpUP5GMcICN70LOoAnajeuwXX1CIKMhtAFLZOxZisOCDLUdQTkDz/CokjzBRE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZQOCgfH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZQOCgfH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B48E1F000E9;
	Wed, 12 Aug 2026 12:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786536314;
	bh=/fNILufjLsrRroxGDcnGt+oCDmIC1Yd6eDjQKSj3G/8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QZQOCgfHxyW4VGg+Q7DIPKVH9l5q1MvZGws3uZFWhFzxG0+xGy6CWn3D7XNWcR4UC
	 JxZ5YqwWloF4rrFsyuPMSlYOHitCyv0TuClKJAzta6vTdCwkozf/WacbGSLWfc9fWj
	 wV9WuaBepI0D05u0Ca/JcWUM/Q9UrNCeZR1o1LTyFrwMz7AukAQHl/wgTDKLOxCYqQ
	 5AihmVWhbSQ73yTjDi1twn8TbDCJKPsdOdEF+V0BtsY3rfRoUMlCvPEjJFuLnFWM8N
	 Zi35t51bbKok0lY1Kly8Bb2hWoLX3pqZV9RTXN0owwqsfy/G4rhpjk9VITO0EjXW80
	 T8IMeD/t21ACA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/9] s390/vfio-ap: Fix control domain removal in
 vfio_ap_mdev_cfg_remove
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.vom>, linux-s390@vger.kernel.org
In-Reply-To: <20260812115139.576303-6-akrowiak@linux.ibm.com>
References: <20260812115139.576303-1-akrowiak@linux.ibm.com>
 <20260812115139.576303-6-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 12:05:13 +0000
Message-Id: <20260812120513.9B48E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unplugging the last AP adapter, domain, or control domain fails to=
 update the KVM guest's APCB.
--

--- Patch [5]: [PATCH v3 5/9] s390/vfio-ap: Fix control domain removal in v=
fio_ap_mdev_cfg_remove ---
commit ac232781abc6c5d395fdb856a5975b162da68506
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Fix control domain removal in vfio_ap_mdev_cfg_remove

This commit resolves an issue in vfio_ap_mdev_cfg_remove where the use of
bitmap_andnot prevented explicitly unplugged control domains from being
removed from the KVM guest. The fix correctly changes the bitwise operation
to use bitmap_and instead.

Cc: stable@vger.kernel.org

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index 8a1ecb8915044..b6d0c988cc810 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -2625,9 +2625,9 @@ static void vfio_ap_mdev_cfg_remove(unsigned long *=
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
This is a pre-existing issue, but does this function call successfully
update the KVM guest APCB when the very last hardware resource is
unplugged?

Looking inside vfio_ap_mdev_hot_unplug_cfg(), it uses the return value of
bitmap_andnot() to determine if an update is required:

drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_mdev_hot_unplug_cfg() {
    ...
	if (!bitmap_empty(aprem, AP_DEVICES)) {
		do_hotplug |=3D bitmap_andnot(matrix_mdev->shadow_apcb.apm,
					    matrix_mdev->shadow_apcb.apm,
					    aprem, AP_DEVICES);
	}
    ...
	if (do_hotplug)
		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
}

Because bitmap_andnot() returns false when the resulting bitmap is empty,
clearing the final bit from the shadow APCB returns 0.

If the last AP adapter, domain, or control domain is unplugged, do_hotplug
evaluates to 0 and the vfio_ap_mdev_update_guest_apcb() call is completely
bypassed.

Could this allow a guest to retain architectural access to hardware that has
been explicitly removed and potentially reassigned to another driver?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812115139.5763=
03-1-akrowiak@linux.ibm.com?part=3D5
