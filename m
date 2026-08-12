Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AD43655E6;
	Wed, 12 Aug 2026 20:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786566028; cv=none; b=msplGAIeeEHddIUlN3dgIuVjYqFU0McC16iyTpgMV4pN8N5YEKjqDJFWQh6buq7ju1f+0RXcCFcGGCtB8Yq2xI12sz+Y+5aeYda/OgqQaHaB0icIrq5K0/H6ngDRZIe8o9bO5Ad+UDHwssfU6xHh3TPaIlCDz6gNPpRdme8vNl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786566028; c=relaxed/simple;
	bh=w/VnWzNLKJ5kuFcuB2bL5+fCXi8ejg4HbkNIouJyI6I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PzkeifCQj8DG1P33u9DUnNXJcdmo3BcjaqJWuYOFgihwkSoQx6G69zodaF8ojbo87qnRJc659LNh8QY6YVxI0DVkg66J1o1O4oJDdyKwaq9eMwUCASkmuBfvZntODxUtNI2hNUNS3jMq9pyjugQ8BcPjcr+oa5aNnKMp7Z+5ERY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XP5OapfB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XP5OapfB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57CF1F000E9;
	Wed, 12 Aug 2026 20:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786566027;
	bh=TAk59RNeGf3HXZXKhAvabdr1yNBsf38F2Bfi/LfgUi4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XP5OapfBlzjUwhr5J/ACw/3npsvHkKlcQrFhk6GSV0kYafy2x+Q+e33hCZQUjhm/U
	 hbJYd6Ay77cuYj5vD2dlzLA68LcpNjUoCNbCPgUTuGuqRWyy8jQIMIS6ZqAyRu7Rlq
	 QqETL+OWRt9HN4lAh3rNcYb6gACwwiG9IpddYIntvlWoOBwJVha2hdabDpguJTO+h9
	 TSDOxfjym++aoHVtwQK0ds9pRt6iD4lTUiWq7dpCvbxfyYwbQ34h63Vq7eVgbNYRcV
	 SoJlEM0x+s/w+tgwbUPWNQRERoCOBclyU6CvrNtcWPvdQtdoZPOlIy6bziV7EecZZH
	 bgdrSjr1QKnhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/9] s390/vfio-ap: Fix stale do_remove flag across
 iterations in vfio_ap_mdev_cfg_remove
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.vom>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260812200240.818004-2-akrowiak@linux.ibm.com>
References: <20260812200240.818004-1-akrowiak@linux.ibm.com>
 <20260812200240.818004-2-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 20:20:26 +0000
Message-Id: <20260812202026.E57CF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unconditional dereference of `matrix_mdev->kvm` causes kernel pani=
cs for mdevs not yet attached to a guest.
- [High] Incorrect use of `bitmap_andnot` instead of `bitmap_and` prevents =
removed control domains from being hot-unplugged from guests.
- [High] Unprotected iteration of `matrix_dev->mdev_list` leads to potentia=
l data races and list corruption.
--

--- Patch [1]: [PATCH v5 1/9] s390/vfio-ap: Fix stale do_remove flag across=
 iterations in vfio_ap_mdev_cfg_remove ---
commit 62f5d072f498c6d3b4f1ad645dbc6b551ae4f363
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Fix stale do_remove flag across iterations in vfio_ap_mdev_cf=
g_remove

The do_remove flag in vfio_ap_mdev_cfg_remove() is initialised to zero
before the loop that iterates over the list of matrix mdevs, but is
never reset at the start of each iteration. Since do_remove is
OR-accumulated across iterations, a positive result from one mdev
carries over to subsequent mdevs.

The fix is to set the do_remove flag with the first call to bitmap_and;
for example: do_remove =3D bitmap_an rather than do_remove |=3D bitmap_and.

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
This isn't a bug introduced by this patch, but does iterating
matrix_dev->mdev_list here require holding matrix_dev->mdevs_lock?

Looking at vfio_ap_mdev_probe(), it appears to add new mdevs to this list v=
ia
list_add() while holding only matrix_dev->mdevs_lock.

Since this loop is entered before acquiring matrix_dev->mdevs_lock, can an
mdev creation running concurrently with an AP configuration change modify t=
he
list while it is being iterated, potentially leading to a data race or list
corruption?

>  		mutex_lock(&matrix_mdev->kvm->lock);

[Severity: High]
This is a pre-existing issue, but could this unconditionally dereference a
NULL kvm pointer?

If a user creates a mediated device and assigns AP resources to it without
attaching it to a KVM guest, matrix_mdev->kvm would be NULL.

If a host AP configuration change occurs, would dereferencing matrix_mdev->=
kvm
here cause a kernel panic?

This same pattern appears in vfio_ap_mdev_hot_plug_cfg():

drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_mdev_hot_plug_cfg() {
    ...
	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
		mutex_lock(&matrix_mdev->kvm->lock);
    ...
}

Does this exhibit the same NULL pointer dereference risk when an mdev is not
yet attached to a guest?

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
This is a pre-existing issue, but is bitmap_andnot() the correct operation =
for
calculating cdrem just below this?

drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_mdev_cfg_remove() {
    ...
		do_remove |=3D bitmap_andnot(cdrem, cd_remove,
					     matrix_mdev->matrix.adm,
					     AP_DOMAINS);
    ...
}

This computes the cdrem bitmask using inverted logic, isolating removed
domains that are NOT assigned to the mdev.

Should this use bitmap_and() like the aprem and aqrem calculations, so that
assigned control domains are properly identified and hot-unplugged from
guests?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812200240.8180=
04-1-akrowiak@linux.ibm.com?part=3D1
