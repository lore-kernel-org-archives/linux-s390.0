Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF479347BAF;
	Wed, 12 Aug 2026 20:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786565927; cv=none; b=QSwDmg3et/HUEaS6Ibi0QR72FYrQ8EXjQ5DowlIjuBaWOLOs9Zx4CpQ+5Nf+H9g/3SUFsKY88m6bs5VJlMLtxXs5BkOgVRcJeN7ryrojjDvhZdZy0uY+/AtnFqQzbt0sFSY2NHPRVFqNfEVayH8qpVr2vsApXrl2Tw61/zns+Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786565927; c=relaxed/simple;
	bh=Qc2mh7CUkM3vzX6WvUk1n1XBXXx047ZDRCTw0yBcoR4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n3QfBR2YVgqjTpzUYItqv9JqondHKyqGtW3hLVxoL3e46cKz6VElDrAMagU62FIm75AidmA0GUJonSys3XSfntyoi75DzoK/LlmUGJhd5DbwIO6XalQloqtMTBnB97bNIIblqjiz8JK0XwlYY13pfakpnvFVMM4HEEROFMCkDA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxDuODzf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxDuODzf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 076301F000E9;
	Wed, 12 Aug 2026 20:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786565925;
	bh=i2grw7U/p/iNfFf76IC0YUgi+0gDFrMicg0kZQthDDM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TxDuODzf78gkHHJoyNKu38zKpxeFPpLcBdj7nL8SFzwJ647BLGLYsuC4ygI00lH//
	 HxlNc0Ddw5m1j6Pda9TBuH+l9r0bA+UHVV6n+ieqQNOskms7qir/i47H5/uEKOqGzo
	 FnjzdptO8QDHRiM8YvcvyznsDgP7Qvi2RJ4fatfbbYumc8qjbdkuiRW1eiC6+BlmQf
	 uHr4AnrKLvwXWEnjVvzaMLKR5aPP85myIERxiVypJtDfmw6chDa886/69sQ3Hx4EXn
	 ZOKMfpqvNhb/sDMp/raXdJAJtgZrV2rH/7DaFyGffxtSE50PY0tZFMGQzA+m1yw/TN
	 rbvleWoDz120g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/9] s390/vfio-ap: Fix required lock not held during
 update of ap_matrix_mdev object
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.vom>, kvm@vger.kernel.org
In-Reply-To: <20260812200240.818004-5-akrowiak@linux.ibm.com>
References: <20260812200240.818004-1-akrowiak@linux.ibm.com>
 <20260812200240.818004-5-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 20:18:44 +0000
Message-Id: <20260812201845.076301F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Hot-plug add state is overwritten instead of accumulated, potentia=
lly dropping hot-plug events.
- [High] Pinned page and GISC registration leak in vfio_ap_irq_enable() whe=
n ap_aqic() returns a default error code.
--

--- Patch [4]: [PATCH v5 4/9] s390/vfio-ap: Fix required lock not held duri=
ng update of ap_matrix_mdev object ---
commit 65680656f25b3ea60807c838ba28f8d65cca5a45
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Fix required lock not held during update of ap_matrix_mdev ob=
ject

This commit adds the missing matrix_dev->mdevs_lock in vfio_ap_mdev_cfg_add=
()
to guard against race conditions when modifying the ap_matrix_mdev object's
fields.

> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index f2d662e388bdc..21c502598f8ca 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -2777,12 +2777,20 @@ static void vfio_ap_mdev_cfg_add(unsigned long *a=
pm_add, unsigned long *aqm_add,
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
>  		bitmap_and(matrix_mdev->aqm_add,
>  			   matrix_mdev->matrix.aqm, aqm_add, AP_DOMAINS);
>  		bitmap_and(matrix_mdev->adm_add,
>  			   matrix_mdev->matrix.adm, adm_add, AP_DEVICES);

[Severity: High]
This isn't a bug introduced by this patch, but does this overwrite the
hot-plug addition state instead of accumulating it?

If multiple AP configuration change events occur before the AP bus scan
completes, it appears that vfio_ap_mdev_cfg_add() unconditionally overwrites
the deferred hot-plug bitmaps with the delta of the most recent event.

Should this logic use a temporary intersection followed by bitmap_or() to
accumulate the pending additions so that hot-plug events aren't dropped?

> +
> +		mutex_unlock(&matrix_dev->mdevs_lock);
>  	}
>  }

While reviewing the file, I noticed a pre-existing issue in
vfio_ap_irq_enable():

> drivers/s390/crypto/vfio_ap_ops.c:vfio_ap_irq_enable() {
> 	...
> 	default:
> 		pr_warn("%s: apqn %04x: response: %02x\n", __func__, q->apqn,
> 			status.response_code);
> 		vfio_ap_irq_disable(q);
> 		break;
> 	}
> 	...
> }

[Severity: High]
This is a pre-existing issue, but does this default error path leak the
newly pinned nib and registered nisc?

When ap_aqic() returns an unexpected error falling into the default case,
vfio_ap_irq_disable() is called. However, it seems vfio_ap_irq_disable()
only cleans up the previously successfully saved configuration, bypassing
the newly pinned nib and isc held in local variables.

Can a malicious KVM guest repeatedly issue the PQAP(AQIC) instruction with
configurations that trigger this error path, causing unbounded memory pinni=
ng
on the host?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812200240.8180=
04-1-akrowiak@linux.ibm.com?part=3D4
