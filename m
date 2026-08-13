Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035BA31F984;
	Thu, 13 Aug 2026 23:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786664454; cv=none; b=lPQIsRCy/JRZOq2z8I301L5dbWDlg63PnZS3TajTZZVho/t5uP9S0+ITMBGAwImvD9iwcOVEg3BnQUniRWb26/FtLNsq4RHWvbZpVmMTR37851FXo85utQzAtQqpmFjUX4Suv+baYduNx6iOsvbVapp16y02UUdQE6v9DISn9Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786664454; c=relaxed/simple;
	bh=g0vJrIhp/IFphXuZLnHGpSHcX8i/lpGR5sH5Jcv25bk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nslT/uHFJorAIDjebenaSkWD2HyFlk8VwOsMZmcLpPTDfaLMvoOTiaj+8TfJzM2wYD+reUOBrBM5Gl2x5DN59WCh1jP3BbLE+9CrnsJp6WMTAU32WikM/9xpri55sOTeouoEQ7ZP6N4kyFKUpvrS3Vp2HT3BtpSZpAjZjUAZKwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8O5e+t+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8O5e+t+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12B61F000E9;
	Thu, 13 Aug 2026 23:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786664452;
	bh=glbMup09peRFIDMkoWez21RDNoa37s6Ixxfk8euJiXw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e8O5e+t+NIXVm4rrQotNWdx8JCK9DdyLITFoszwIIIe91curwedgrsGLozqwLeTk0
	 XgjvGQiEBN/FMvauevjndeaHbASLl4B/zMLx4Gt45oe/+3IZOiSn4j5VCCuOzfBq2o
	 vzpBxKVFcH/aCCDXgKriLxjKbTqlF1KkMuoNetuKnpWd/lY7d5G7dFt81K0fsldMyk
	 7L2yABHg+sCwrjcJodwK82adD0YZUUeU/2zS48uG8UrcAjLnF9XD3GMoMscixjOcB/
	 1Ze9O4ueFs9pklBeELSChFZCyecrVJkJKg/C2J8QGPuWmDBE66J1cnlP+A1rycirTL
	 jlM71RHsqlxlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/16] s390/vfio-ap: Provide access to queue objects
 and related info
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>, kvm@vger.kernel.org
In-Reply-To: <20260407205100.331150-3-akrowiak@linux.ibm.com>
References: <20260407205100.331150-3-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 23:40:45 +0000
Message-Id: <20260813234046.F12B61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Inefficient O(N*M) loop to calculate the number of queues instea=
d of a constant-time weight calculation.
--

--- Patch [2]: [PATCH v2 02/16] s390/vfio-ap: Provide access to queue objec=
ts and related info ---
commit ead4ee761bf33471a8b6bc2e8080a705110bd528
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Provide access to queue objects and related info

This commit provides functions to access vfio_ap_queue objects and to return
the number of queues passed through to a guest. It makes an existing queue
retrieval function non-static, adds a lockdep assertion, and introduces a
new function to count the total queues.

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index ef3101f6865e5..cd85866b81a05 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c

[ ... ]

> @@ -2098,6 +2098,20 @@ static void vfio_ap_mdev_request(struct vfio_devic=
e *vdev, unsigned int count)
>  	release_update_locks_for_mdev(matrix_mdev);
>  }
> =20
> +int vfio_ap_mdev_get_num_queues(struct ap_matrix *ap_matrix)
> +{
> +	unsigned long apid, apqi;
> +	int num_queues =3D 0;
> +
> +	lockdep_assert_held(&matrix_dev->mdevs_lock);
> +
> +	for_each_set_bit_inv(apid, ap_matrix->apm, AP_DEVICES)
> +		for_each_set_bit_inv(apqi, ap_matrix->aqm, AP_DOMAINS)
> +			num_queues++;

[Severity: Medium]
Since the total number of AP queues is determined by the Cartesian product =
of
the set bits in these two matrices, could this be calculated more efficient=
ly
without a nested loop?

For example, utilizing bitmap_weight() would avoid the iterations entirely:
bitmap_weight(ap_matrix->apm, AP_DEVICES) * bitmap_weight(ap_matrix->aqm, A=
P_DOMAINS)

The current nested loop executes an iteration for every set bit combination=
=20
while holding the mdevs_lock, whereas the bitmap_weight approach would achi=
eve
the same result in a few word-level popcount operations.

> +
> +	return num_queues;
> +}
> +
>  static int vfio_ap_mdev_get_device_info(unsigned long arg)
>  {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260407205100.3311=
50-1-akrowiak@linux.ibm.com?part=3D2
