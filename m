Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD1446F489;
	Wed, 12 Aug 2026 17:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786555357; cv=none; b=ulCZ9G0nJljyYjvlZmSy2r/X0r+vSxf6/Pc6gR7zMp3cKaJ7xTWqYNKqmaC2qtM/U/o4eJ3OXudSgcnNDeTix0Gd37iBCnq9F0Nnj4u3W1NtCv3yKmuXCv9WiVLhietIXhhf/xedNBfYNiBCvqvIcgauws9ifDSz23wpBAqfSh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786555357; c=relaxed/simple;
	bh=wOGA6LaG6IoZsDvNt2Ifwb1Cyz6ai+QOoW8pTx39an4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QH5t0VRLisxuV1i3pilo0Oenao82QHzsj2kaADFSTGRFtcxfP4JUMvfYuqTe30cBhTd11+sKCvLt8sBSJo86Gl8hBo/eziZIJRhkunH8aW3corgXF6KfDNI5Tj8ukbhulxOmTr/XpYSoqry9NLjcf6GRm0pVG+Zw/g/L+C4MvHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIO0TM4F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIO0TM4F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A501F000E9;
	Wed, 12 Aug 2026 17:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786555355;
	bh=ff2l/F2f0aLtkMgIGirZz4BC2jlMNLgHBsJZTGi7QSo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PIO0TM4FYOQQiTxZYfq3nUEDROrxM5InnNpldmau/i1SAXefc77qIR8W6LAZZUTzl
	 ugrkmgP5mBMGw2Qdv6f1dooQ2TUyd50McC6AzB7JeiyG+WsrL5cXEblcRa3+i29S2x
	 Ofk+qRyfPvkp2BFGusSi7grmY0OWNztBFGnn2jIDvZ5SkF528uZFxW3U6Tbt0mrxwd
	 XrzmhTqq2c2yJmsV8aqFXbQzjBrhFgnLvgcmQwKqGJlYmthQKCeNotDXLOl+y9Rzlj
	 j0AzeRrNm0n4830xx2mZK+/9gvPU/fHr9vmsuzFi44Bi8pFbLTTNCzr2GI7t38HwHY
	 GmPe3V6LiEf2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/9] s390/vfio-ap: Fix stale do_remove flag across
 iterations in vfio_ap_mdev_cfg_remove
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260812170945.738351-2-akrowiak@linux.ibm.com>
References: <20260812170945.738351-1-akrowiak@linux.ibm.com>
 <20260812170945.738351-2-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 17:22:34 +0000
Message-Id: <20260812172235.07A501F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unchecked dereference of `matrix_mdev->kvm` in `vfio_ap_mdev_cfg_r=
emove` and `vfio_ap_mdev_hot_plug_cfg` leading to a kernel panic for mediat=
ed devices not attached to a KVM guest.
- [High] Control domain hot unplug in `vfio_ap_mdev_cfg_remove()` is comple=
tely broken due to incorrect use of `bitmap_andnot` instead of `bitmap_and`.
- [High] Unsafe iteration over `matrix_dev->mdev_list` in `vfio_ap_mdev_cfg=
_remove` without holding `matrix_dev->mdevs_lock`, risking a data race.
- [High] Unsupported older AP adapters (pre-CEX4) can bypass filtering in `=
vfio_ap_mdev_cfg_add` if no new domains are added simultaneously.
--

--- Patch [1]: [PATCH v4 1/9] s390/vfio-ap: Fix stale do_remove flag across=
 iterations in vfio_ap_mdev_cfg_remove ---
commit 842cc8fca6dcd2512ea1bac051db5a235987ced0
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Fix stale do_remove flag across iterations in vfio_ap_mdev_cf=
g_remove

This commit fixes the initialization and accumulation of the do_remove flag
in vfio_ap_mdev_cfg_remove(). Previously, the flag was never reset per
iteration, causing a positive result to carry over to subsequent matrix mde=
vs.
The fix sets the flag using bitmap_and() for the first check rather than
accumulating it.

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
This isn't a bug introduced by this patch, but is it safe to iterate over
matrix_dev->mdev_list here without holding matrix_dev->mdevs_lock?

The caller vfio_ap_on_cfg_changed() holds matrix_dev->guests_lock, but not
matrix_dev->mdevs_lock. Since mdevs_lock is acquired inside the loop and
released before the next iteration, concurrent modifications might corrupt
the list traversal if new mdevs are added in vfio_ap_mdev_probe() holding
only mdevs_lock.

>  		mutex_lock(&matrix_mdev->kvm->lock);

[Severity: High]
This is a pre-existing issue, but does this code unconditionally dereference
matrix_mdev->kvm without checking for null?

If a mediated device is created but not yet attached to a kvm guest,
matrix_mdev->kvm remains initialized to null. If a host ap configuration
change occurs in this state, wouldn't this cause a kernel panic?

The same unconditional dereference appears to exist in
vfio_ap_mdev_hot_plug_cfg() when called from vfio_ap_on_cfg_changed().

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
This isn't a bug introduced by this patch, but looking at the next lines in
vfio_ap_mdev_cfg_remove():

drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_mdev_cfg_remove() {
    ...
    do_remove |=3D bitmap_andnot(cdrem, cd_remove,
                               matrix_mdev->matrix.adm,
                               AP_DOMAINS);
    ...
}

Is it correct to use bitmap_andnot() here instead of bitmap_and()?

This computes cd_remove & ~matrix_mdev->matrix.adm, yielding domains that
were removed from the host but are explicitly not assigned to the mdev.
Later, vfio_ap_mdev_hot_unplug_cfg() checks for intersection between the
guest's active domains and cdrem, which will always fail. Should this be
bitmap_and() instead?

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for unsupport=
ed
older ap adapters to bypass filtering?

In vfio_ap_mdev_cfg_add(), the code calls:

drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_mdev_cfg_add() {
    ...
    vfio_ap_filter_apid_by_qtype(apm_add, aqm_add);
    ...
}

If an older adapter is added to the host configuration without any
new domains being added simultaneously (because the domains were already
present), aqm_add will be empty.

This causes the inner loop in vfio_ap_filter_apid_by_qtype() to be skipped:

drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_filter_apid_by_qtype() {
    ...
    for_each_set_bit_inv(apqi, aqm, AP_DOMAINS) {
        status =3D ap_test_queue(AP_MKQID(apid, apqi), 1, &info);
    ...
}

Because aqm is empty, the loop evaluating adapter type does not execute,
meaning the adapter's type is never verified and it remains in apm_add.
Should the active domains be passed to the filter instead of the delta?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812170945.7383=
51-1-akrowiak@linux.ibm.com?part=3D1
