Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D796C335081;
	Wed, 12 Aug 2026 17:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786555484; cv=none; b=gCi2V7xNTmTjKugn4gOtijqGKP4+8igfxqafV1lowtjX7iZRKj6U9qjD2x1AQSPXVA/HWtZ9VpaqvgJ2MWo6gREeU7fXweP6xpJY0qUTCC4GcRoZ8Ofwvp4PxwXnXOQJxTKfcY66PYHnY4pCBOhmpIatHXtaQXo0yA7Vgx2sBD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786555484; c=relaxed/simple;
	bh=gdZZo5PnPTu1A38Xsm61bBsL34g39/Vq3FOkuP/WF0Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gcAOvkfiWgl/O0LyadBW+vuR6F8LotmRbbW4nvWMRk8i9BvmyamzUf1oV2l0EP+I7Uhxhq1NBUoKu1w2Ji3GXwg80AvQJksYGLaFE/Y3P54IEc1VQYawH5ejHlMLlrWANYJDOBqgLoy8E97pnGKWBN9k6/i6g4ps3J2rlMbHI1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQKNRlla; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQKNRlla"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF551F00A3A;
	Wed, 12 Aug 2026 17:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786555483;
	bh=fQJnLgEd0MC4IUFcUs6AZpm4YUEzvmAbagghdfDsPMo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eQKNRlla9YjxbPQzqPQPjYKUW1r344BVNtlYAEKYmqhEvtjm9rXyrYsNs0JxT2cBe
	 SDkTV3DxGU4G6dHEtVjtXEgiAZgkGHlQuvwJoLC/g0v98oqhqmto31gorzhf5MglwE
	 18Ck0yx7HVkS+qxjluv/XE70Ki8I1IsoyS8Ixf9EO/HS6eV7W0IlB4/NzaCseYdsR9
	 QdPpfHp5S2B3Z6pxdAHOqjsdxhyr9p+dT4H6M3q7VLrAvPxBfjvHjfJ1C3nz8GPMft
	 rHYCcyjysGMTTS3cB/thoIM/yRb006hs5ujm0MGK4CELNvOM8FaGxJID1Rbz4HMNWF
	 1hviUrGlYp90Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/9] s390/vfio-ap: Fix required lock not held during
 update of ap_matrix_mdev object
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.vom>, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260812170945.738351-5-akrowiak@linux.ibm.com>
References: <20260812170945.738351-1-akrowiak@linux.ibm.com>
 <20260812170945.738351-5-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 17:24:42 +0000
Message-Id: <20260812172443.5BF551F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Hardware validation is skipped when an adapter is hotplugged witho=
ut new domains, allowing unsupported hardware to be assigned.
--

--- Patch [4]: [PATCH v4 4/9] s390/vfio-ap: Fix required lock not held duri=
ng update of ap_matrix_mdev object ---
commit 6a90ea8f2f04defd282ac1432c8f5ff791b149f2
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Fix required lock not held during update of ap_matrix_mdev ob=
ject

This patch resolves a missing lock issue in vfio_ap_mdev_cfg_add(). It ensu=
res
that the mdevs_lock is held while modifying the apm_add, aqm_add, and adm_a=
dd
bitmap fields. This prevents race conditions with concurrent modifications =
to
the matrix device.

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index f2d662e388bdc..21c502598f8ca 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -2777,12 +2777,20 @@ static void vfio_ap_mdev_cfg_add(unsigned long *a=
pm_add, unsigned long *aqm_add,

[Severity: High]
This isn't a bug introduced by this patch, but does=20
vfio_ap_filter_apid_by_qtype() skip hardware validation if an adapter is=20
hotplugged without new domains?

In vfio_ap_filter_apid_by_qtype(), if aqm is empty:

drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_filter_apid_by_qtype() {
...
    for_each_set_bit_inv(apid, apm, AP_DEVICES) {
        apid_cleared =3D false;

        for_each_set_bit_inv(apqi, aqm, AP_DOMAINS) {
            status =3D ap_test_queue(AP_MKQID(apid, apqi), 1, &info);
...
}

The inner loop iterating over aqm (which maps to aqm_add) will not execute
if no domains were added during the config change. As a result, the hardware
is never queried with ap_test_queue(), and unsupported older adapters (older
than CEX4) are not filtered out from apm_add.

Can this allow unsupported hardware to be assigned to a KVM guest if a host
administrator hotplugs an older AP adapter without simultaneously hotpluggi=
ng
new domains?

>  	 * called.
>  	 */
>  	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
> +		/*
> +		 * The mdevs_lock must be held in order to access fields
> +		 * within matrix_mdev
> +		 */
> +		mutex_lock(&matrix_dev->mdevs_lock);
> +
>  		bitmap_and(matrix_mdev->apm_add,
>  			   matrix_mdev->matrix.apm, apm_add, AP_DEVICES);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812170945.7383=
51-1-akrowiak@linux.ibm.com?part=3D4
