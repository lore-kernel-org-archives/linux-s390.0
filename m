Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D4E4399EA;
	Wed, 12 Aug 2026 12:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786536757; cv=none; b=YTBEQi4dZANjQOr1xd7ZujBhIPW8bIl/CXCgpdObhCFAmlMKUUjOfTbV/soVnS0hTqrdQOYp+njB5HZ9qGLhSpCqZH+GKgDloea9qW54xcSF/gyOjtXCgoYfH+5fa0IYN3cHUZ9kLNe+f48LcOMlxWTTjA0PaAjZcZJl63DnWV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786536757; c=relaxed/simple;
	bh=g7r/+Wxk1bZLJrZ+0obMmUbIEiSh8CywKs20FmXPvsg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mzYm8wjDoKJA00DHQ6ZVFEXHk0HCaIdxqZHw5ppGaR1JgeeTPDif0oTe5Ze9AbsEoKBiOuA6Oty7SvYReVaQq5PSizM4UVMphDb09qbanhK8QMDG2XvAr+77Z2MX+b8LnpJTs2hzDn7ykQ2lv40a1CYBwDEcWdzSbxSK37FYAro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ra2BezD3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ra2BezD3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ACDE1F000E9;
	Wed, 12 Aug 2026 12:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786536755;
	bh=rOmY5GUXE8DqZvB7awURu6rs/GONxy3PX9VXOD+ItwU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ra2BezD3MLFTEZNEOJ3yhESD1CVCdkfj73RCpNBH1dQfF0Ba5GfaxjXbrZ3BoFwG+
	 OvzuZ9YiVlaST8QUBY3ebIUiRe4Rnvtv14EeDOgJuizbfZ9tKEl/KQj5km9xkfn7Kd
	 nvWzG3sWTjqn0Rn2G3Lw/tgRgve5F8VWlg6NNIQaYlu98dKR0P5EjxKaijjGbw7BhT
	 Au3H+rN4xC7fXvVXHGi/aY2iC1F9XD2SmTpezJAkwzCFppqdEwEUOOnXeNcpi5E3pt
	 YTKDQp2vusIwnsECxnNpMxybs6GsyyCUGEBY9lri4cGKQdaoa8cIAW3lZdB0mSny1c
	 SqSIeYo+MAYZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/9] s390/vfio-ap: Fix stale do_remove flag across
 iterations in vfio_ap_mdev_cfg_remove
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260812115139.576303-2-akrowiak@linux.ibm.com>
References: <20260812115139.576303-1-akrowiak@linux.ibm.com>
 <20260812115139.576303-2-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 12:12:35 +0000
Message-Id: <20260812121235.8ACDE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Data race due to iterating `mdev_list` without holding `mdevs_lock=
` across the entire loop.
- [High] Unconditional dereference of `matrix_mdev->kvm` when acquiring the=
 KVM lock.
- [High] Incorrect use of `bitmap_andnot` instead of `bitmap_and` for calcu=
lating `cdrem` prevents control domains from being hot-unplugged.
- [High] Misuse of `bitmap_andnot` return value causes missed and spurious =
hotplug events in `vfio_ap_mdev_hot_unplug_cfg`.
- [Medium] Incorrect bitmap size constants (`AP_DEVICES` vs `AP_DOMAINS`) p=
assed to bitmap operations.
--

--- Patch [1]: [PATCH v3 1/9] s390/vfio-ap: Fix stale do_remove flag across=
 iterations in vfio_ap_mdev_cfg_remove ---
commit 9ff3dc11652e82272549805f96671e76c090b814
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Fix stale do_remove flag across iterations in vfio_ap_mdev_cf=
g_remove

The do_remove flag in vfio_ap_mdev_cfg_remove() is initialized to zero but
never reset at the start of each iteration. Because do_remove is accumulated
with bitwise OR across iterations, a positive result from one mdev carries
over to subsequent mdevs. This commit fixes the issue by setting the
do_remove flag directly with the first call to bitmap_and.

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
This is a pre-existing issue, but does iterating over mdev_list here while
repeatedly dropping and reacquiring mdevs_lock inside the loop create a data
race?

Because mdevs_lock is not held when the iterator advances, couldn't a
concurrent call to vfio_ap_mdev_probe() modify mdev_list, leading to
list corruption or use-after-free?

vfio_ap_mdev_probe() adds to this list holding only mdevs_lock:

vfio_ap_mdev_probe()
    mutex_lock(&matrix_dev->mdevs_lock);
    list_add(&matrix_mdev->node, &matrix_dev->mdev_list);
    mutex_unlock(&matrix_dev->mdevs_lock);

>  		mutex_lock(&matrix_mdev->kvm->lock);

[Severity: High]
This isn't a bug introduced by this patch, but can matrix_mdev->kvm be NULL
here?

When an mdev is created via sysfs, matrix_mdev->kvm appears to be initializ=
ed
to NULL and is only assigned when the mdev is opened by KVM. If a host AP
configuration change occurs before the mdev is attached to a guest, couldn't
this unconditional dereference cause a host kernel panic?

(Note: similar unconditional dereferences appear in
vfio_ap_mdev_hot_plug_cfg)

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
This is a pre-existing issue, but does the calculation for cdrem just below
this diff use the wrong bitwise operation?

    do_remove |=3D bitmap_andnot(cdrem, cd_remove,
                               matrix_mdev->matrix.adm,
                               AP_DOMAINS);

By using bitmap_andnot (which computes cd_remove & ~matrix_mdev->matrix.adm=
),
isn't this incorrectly identifying domains removed from the host that are n=
ot
assigned to this guest? Shouldn't this be an intersection (bitmap_and) to
identify assigned domains being removed, just like the calculations for apr=
em
and aqrem?


[Severity: High]
This isn't a bug introduced by this patch, but is the return value of
bitmap_andnot() being misused in vfio_ap_mdev_hot_unplug_cfg()?

    if (!bitmap_empty(aprem, AP_DEVICES)) {
        do_hotplug |=3D bitmap_andnot(matrix_mdev->shadow_apcb.apm,
                                    matrix_mdev->shadow_apcb.apm,
                                    aprem, AP_DEVICES);
    }

The standard bitmap_andnot() function returns true if the resulting
destination bitmap is non-empty, not whether bits were actually changed.

If the last device is removed from the guest's shadow APCB, the resulting
bitmap is empty, so bitmap_andnot() returns false and the guest is never
notified. Conversely, if a device is removed that wasn't in the shadow APCB
but the guest has other devices, it returns true, triggering a spurious
update.


[Severity: Medium]
This is a pre-existing issue, but are the wrong size constants being passed=
 to
bitmap operations for domains?

In vfio_ap_mdev_hot_unplug_cfg():

    do_hotplug |=3D bitmap_andnot(matrix_mdev->shadow_apcb.aqm,
                                matrix_mdev->shadow_apcb.aqm,
                                aqrem, AP_DEVICES);

And in vfio_ap_mdev_cfg_add():

    bitmap_and(matrix_mdev->adm_add,
               matrix_mdev->matrix.adm, adm_add, AP_DEVICES);

Since aqm and adm represent domains, shouldn't these use AP_DOMAINS instead
of AP_DEVICES? This could lead to out-of-bounds memory accesses if the
definitions of AP_DEVICES and AP_DOMAINS ever diverge.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812115139.5763=
03-1-akrowiak@linux.ibm.com?part=3D1
