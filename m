Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B1A37E5CC;
	Sat,  8 Aug 2026 17:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786210223; cv=none; b=nMPJ/NgWheZJqgwoE8cIzsv1tOFV1rP/yENaXeOdxKB0EeGBsRMEHrKJcfxgkxDmypXStFUpXQ0reM1hTBo7QKbH6zbGlBHX9IOoB5Z0Zc+n+IZBsyjr5ZEKH+9J+kU9vBnupNIICbXucVrjHYsvQ+PqwuyibURV12MqJBzs1hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786210223; c=relaxed/simple;
	bh=rsElWkvUYgvAyp1sAPh4+m+3bk/HJdTuXyq+EMfnCXo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qoX1Zibg1M30bVU4y38aYK8s88/95Usa/zr/i3ejzta/lfmkmVgqxlaDhJZ4e9MTNT8zakcS1vk6C+nqPbSew+9an+LipZXw+S8P3oRnxOGtjqgvn8OJGN6ynVH8+yYKlMqg6AgBnijsZ97S8PVdBJGf530g/FSrTEmV+bg7B0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R12v5t+S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R12v5t+S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0208E1F000E9;
	Sat,  8 Aug 2026 17:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786210222;
	bh=iq5t4GF7OYa+zrL/HHM8AUnl9bIgpAHqa/DS17eNYwo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R12v5t+S1yy27qdyGBYIEsJPbHwAuCqkKX5YnGSv9AOIWDDhL7XW7zFcOoGqsUKne
	 zBjmyjHjd5ZXGKqpoTCzeovkluVNSSRzdcirl+dQI47AcA/GuBUi+oGB9TBcETQ79w
	 hEpmwvpagy8OUWWQU1zYVdqt53xGb6XrBEklDZdFyaaZBSjd4yQAmtram+SlEv1CBq
	 a58awgXdarBe3yZhVHpUaxrl7h1h8ifsKzPTxF74s9BehA8M6MwAZ++jobJHNTjzXu
	 kYhPVF5OfzyU+FF/Q/Q+nC03QaYZ//opPbQc8RexTMUrI2hfjBEnfNcPQFNT6Mq3x9
	 OsNG6bZ89y11g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] s390/vfio-ap: Fix control domain removal in
 vfio_ap_mdev_cfg_remove
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260808170712.839066-6-akrowiak@linux.ibm.com>
References: <20260808170712.839066-1-akrowiak@linux.ibm.com>
 <20260808170712.839066-6-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 17:30:21 +0000
Message-Id: <20260808173022.0208E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing KVM guest configuration updates when the last AP devic=
e or domain is unplugged due to incorrect usage of `bitmap_andnot` return v=
alue.
--

--- Patch [5]: [PATCH 5/5] s390/vfio-ap: Fix control domain removal in vfio=
_ap_mdev_cfg_remove ---
commit c11c3bac302d3bc1f0a23db222df493383b0819f
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Fix control domain removal in vfio_ap_mdev_cfg_remove

The vfio_ap_config_remove function uses the bitmap_andnot function to clear
bits from the matrix_mdev->matrix.adm bitmap (specifies the control domains
assigned to the mdev). This prevents the explicitly unplugged control
domains from being removed the KVM guest. The bitmap_and function is used
instead.

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index 897518b88c281..9c7257c179a7a 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -2621,9 +2621,9 @@ static void vfio_ap_mdev_cfg_remove(unsigned long *=
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

[Severity: Critical]
This is a pre-existing issue, but does the bitwise logic in
vfio_ap_mdev_hot_unplug_cfg() incorrectly assume bitmap_andnot() returns tr=
ue
when bits are cleared?

Looking at vfio_ap_mdev_hot_unplug_cfg(), the return value of bitmap_andnot=
()
is used to determine if a hotplug update is necessary:

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

However, bitmap_andnot() returns false when the resulting destination bitmap
becomes empty.

If a host administrator unplugs the final active AP adapter or domain assig=
ned
to an mdev, the unplugged bit is cleared from the guest mask, leaving the
shadow_apcb bitmap entirely empty. Because it is empty, bitmap_andnot()
returns false.

Will this cause do_hotplug to evaluate to 0 and skip calling
vfio_ap_mdev_update_guest_apcb() entirely, allowing the KVM guest to retain
hardware access to unplugged or revoked AP devices? The same pattern is used
for aqm and adm on subsequent lines.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808170712.8390=
66-1-akrowiak@linux.ibm.com?part=3D5
