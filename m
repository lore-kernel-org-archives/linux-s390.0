Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2D334D397;
	Wed, 12 Aug 2026 20:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786566013; cv=none; b=UvGuN7eOuOBkfYP7UNQUbIp+HHRWPIYFyGRlrgf9B5ESZ1IxAyW2d9n49NdsntFIEFVA1E7yCi7YA8+nE0Sukvfy8txsOA1hyZDSwa0hr1DAo52H7nTua1MXcgnzoWIxogiasSZZ1S6I2q4hhkj90L1J4eYbfVVeChe9GSQMqu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786566013; c=relaxed/simple;
	bh=fVvsWHJIba9ZNDW1DG/cSK1aucTpfVA/TeqwmXfkHx4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cwOfUQM2HQzCU2rysrVuz0AyzTHulXMyYyPZr0PQDF13VrUvcpMMvZ6cLpvaqKImtC7x4FO9UquF8RQhR0nKz2vyCXk+giG8Kch/C0rNQ2TUGpSIEaPudqxcRB0fkzuc/RgEPnXNf5wj2M4XufBIlIj5epzSDJj/3HEOVFCvK3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PbrB79+O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PbrB79+O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 043931F00A3A;
	Wed, 12 Aug 2026 20:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786566011;
	bh=TBs/pAtqQX25eJ5oVCiK92e7KCmi3rMoXndv2RA2GTI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PbrB79+OUWGFtFKlMB4EAV2dMSoK1p+LwvpAJrLoCjEmFKjUaF3vnWSmxHx6d1U3G
	 6cYgY5JelgB7JkxOIhzNgf4PpHZqNmIqQWGwMGEvMlqLYa+TB2kbyCAwl6D+oCLloO
	 ubTdJBnbmM7z8zXRpx3jC2SdpdrqDAL4ogCGKHe0xoxCCJj2R2RSlo8eWgq9pS8VdU
	 s+j9Z1msQ3i0sDlUUgA2zf8DIQSSM3bTOn7su/m9cns5soJY4XsjgCxzr+N+S7YPvG
	 v+35v/aElbfQCMh8ydm4qI3jxjMp8C4cZESTONlolys6sBeriZR+38c6/oFYbq0a37
	 5Q/j0d7DqMzsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/9] s390/vfio-ap: fix potential use of uninitialized
 apm_filtered bitmap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.vom>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260812200240.818004-7-akrowiak@linux.ibm.com>
References: <20260812200240.818004-1-akrowiak@linux.ibm.com>
 <20260812200240.818004-7-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 20:20:10 +0000
Message-Id: <20260812202011.043931F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Leaked pinned NIB memory and KVM GISC registration in `vfio_ap_irq=
_enable()` error path.
- [High] Leaked `req_trigger` and `cfg_chg_trigger` eventfd contexts on VFI=
O device close/remove.
--

--- Patch [6]: [PATCH v5 6/9] s390/vfio-ap: fix potential use of uninitiali=
zed apm_filtered bitmap ---
commit 6362e7fffee6cfc724530d3fd54b669440496a88
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: fix potential use of uninitialized apm_filtered bitmap

The DECLARE_BITMAP(apm_filtered, AP_DEVICES) macro allocates the bitmap
on the stack without zero-initializing it. This can cause unintended
guest hardware queue resets if vfio_ap_mdev_filter_matrix() is bypassed.
This patch zero-initializes the apm_filtered bitmap at the beginning of
vfio_ap_mdev_hot_plug_cfg() using bitmap_zero().

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index 0f3537aadea87..d667ad4bbf705 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -2861,6 +2861,15 @@ static void vfio_ap_mdev_hot_plug_cfg(struct ap_ma=
trix_mdev *matrix_mdev)
>  	DECLARE_BITMAP(apm_filtered, AP_DEVICES);
>  	bool filter_domains, filter_adapters, filter_cdoms, do_hotplug =3D fals=
e;
> =20
> +	/*
> +	 * Zero out the apm_filtered bitmap in case there are no adapters or
> +	 * domains to be added, but only control domains. In that case,
> +	 * vfio_ap_mdev_filter_matrix() - which initializes apm_filtered - will
> +	 * not get called and the reset_queues_for_apids will crash because it
> +	 * will access an uninitialized bitmap.
> +	 */
> +	bitmap_zero(apm_filtered, AP_DEVICES);
> +
>  	filter_adapters =3D bitmap_intersects(matrix_mdev->matrix.apm,
>  					    matrix_mdev->apm_add, AP_DEVICES);
>  	filter_domains =3D bitmap_intersects(matrix_mdev->matrix.aqm,

[ ... ]

> 	case AP_RESPONSE_OTHERWISE_CHANGED:
> 		/* We could not modify IRQ settings: clear new configuration */
> 		ret =3D kvm_s390_gisc_unregister(kvm, isc);
> 		if (ret)
> 			VFIO_AP_DBF_WARN("%s: kvm_s390_gisc_unregister: rc=3D%d isc=3D%d, apqn=
=3D%#04x\n",
> 					 __func__, ret, isc, q->apqn);
> 		vfio_unpin_pages(&q->matrix_mdev->vdev, nib, 1);
> 		break;
> 	default:
> 		pr_warn("%s: apqn %04x: response: %02x\n", __func__, q->apqn,
> 			status.response_code);
> 		vfio_ap_irq_disable(q);
> 		break;
> 	}

[Severity: High]
This is a pre-existing issue, but does this default error path in
vfio_ap_irq_enable() leak the newly allocated NIB pages and KVM GISC
registration?

If a user-space process configures device IRQs and triggers
vfio_ap_irq_enable(), the function successfully pins the new NIB and
registers the GISC. If ap_aqic() fails with an unexpected status code, it
falls through to this default case.

Since vfio_ap_irq_disable(q) only cleans up previously saved resources in
q->saved_iova and q->saved_isc, it appears the newly pinned nib and isc
local variables are left abandoned.

[ ... ]

> static void vfio_ap_mdev_close_device(struct vfio_device *vdev)
> {
> 	struct ap_matrix_mdev *matrix_mdev =3D
> 		container_of(vdev, struct ap_matrix_mdev, vdev);
>=20
> 	vfio_ap_mdev_unset_kvm(matrix_mdev);
> }

[Severity: High]
This is a pre-existing issue, but it looks like this teardown path might
leak the req_trigger and cfg_chg_trigger eventfd contexts.

When a user-space process sets up IRQs, eventfd_ctx_fdget() takes a
reference on the eventfds. If the process crashes or closes the VFIO device
file without explicitly clearing the IRQs, shouldn't
vfio_ap_mdev_close_device() drop these references with eventfd_ctx_put()?

[ ... ]

> static void vfio_ap_mdev_remove(struct mdev_device *mdev)
> {
> 	struct ap_matrix_mdev *matrix_mdev =3D dev_get_drvdata(&mdev->dev);
>=20
> 	vfio_unregister_group_dev(&matrix_mdev->vdev);
>=20
> 	mutex_lock(&matrix_dev->guests_lock);
> 	mutex_lock(&matrix_dev->mdevs_lock);
> 	vfio_ap_mdev_reset_queues(matrix_mdev);
> 	vfio_ap_mdev_unlink_fr_queues(matrix_mdev);
> 	list_del(&matrix_mdev->node);
> 	mutex_unlock(&matrix_dev->mdevs_lock);
> 	mutex_unlock(&matrix_dev->guests_lock);
> 	vfio_put_device(&matrix_mdev->vdev);
> }

[Severity: High]
This is a pre-existing issue, but similar to the above, is it possible for
the mdev teardown path in vfio_ap_mdev_remove() to free the device
structure without cleaning up the eventfd context references?

Could repeatedly opening and closing the device exhaust system file
descriptors and kernel memory due to these missing eventfd_ctx_put()
calls?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812200240.8180=
04-1-akrowiak@linux.ibm.com?part=3D6
