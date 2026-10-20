Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792536837;
	b=cS0fVIYFPdYNGv59EzfG8PVJ0DY14Bvb7epQ5vXfIiVGTE97KgvlMFpbKaDCfst7mctc
	 tSbwJ6jmNA+x14TPIKG7jiRbIc9ALCCLKgss/6CjzDLWabirKI/FZcCar0sjJZyAmFI4u
	 1J+YEwqABNgfHUfCQ8325sjrbf0K7uJltHs+s/z01+FPtka8xM0v/fGRVMwLO/oe5igL+
	 h6yrSviPyFeTvqC/RsVqzD9dZrcexJsTEmzpLVlYc1WUlZ8YSu7fpL8pkHJWFLWwCdHKS
	 PFUOiDuVjQmQ5eX2vPs5cQjZ0vJU1SkOY8fqlXuzX9Xv8MGdVEHKYdp9VYi4Xyirsfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792536837;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LddUcKY31bKSJjWQ2gCn2C+sYOB/+FnEoN46KWIQvFA=;
	b=a46tcA/IGyQbX2zRAH8bfq+eeAep21Fw4dJA+3g/k3xYfM2rWxWC0pYy02pd0u6tPVp0
	 hNnhkAxGKQZXg26vhdDn7ccT25ReJqaiNGakJLvo+0EE3mbGK/Z8BfhBMpV2UI+BaM3X3
	 H/I5AtiU1mnaPKateSsyhsAhB0hWtsQyGBTGpgGUUWlor7V2xLVRxcrXrlyB89+M47cGD
	 cvAcVWIWqSqFwd0OYAQxGiVCBVvNKPbd7a/iGHCfeOexptzBFO0zzstkNvzh0FsEeday/
	 9tY0cs7ifG31Qz7zHHRz92tkaTD27V9CDK3NG+USMVL0FEcfGSg7fOkQCL33Ysu/9DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GwBRaumf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344C5606A31A;
	Tue, 20 Oct 2026 22:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GwBRaumf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF461F000C9;
	Tue, 20 Oct 2026 22:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792536836;
	bh=LddUcKY31bKSJjWQ2gCn2C+sYOB/+FnEoN46KWIQvFA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GwBRaumfRMBV8X6oUKRGobiLiIPE9N1PaZxFmhy7RWamVk0CV4vSp4bB5sL9yA7Gh
	 dYWlX+gfKwVsv9uYTAnfQCSO0JmbZtIL0XhcH+zfQaVrYP/0ry7f/EzvxSsFQafdRz
	 8SCdAFJnH1/f3K+SznIITrPtckZxDcs56TMn6Aw2Yu/d7J3CwyP3BzHIuC4AxAAi79
	 pQ+sanPifrocEhU/XgbrrGNlQaoRFRicuP9EelsdgsxhWZvWrzXhSJSvWLFQGgyhIY
	 LxPMbZ/rQ9F6eoVn6trP20MVSl308HokcsNgra0KAg81plOMXvaYaKYVzHFTNiEGAI
	 Sju8gx9/6hlHg==
Message-ID: <sashiko-outbox-179585@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 3/5] s390/pci: Improve function measurement state
 management
Reply-To: sashiko-reviews@lists.linux.dev
To: "Omar Elghoul" <oelghoul@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261020212427.2561-4-oelghoul@linux.ibm.com>
References: <20261020212427.2561-1-oelghoul@linux.ibm.com>
 <20261020212427.2561-4-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 22:53:55 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] s390/pci: broken FMB retry and status check when zpci_fmb_enable=
() fails
- [Medium] s390/pci: zpci_reenable_device() enables FMB on disabled PCI dev=
ices
- [Medium] s390/pci: zpci_fmb_request_off() clears statistics_on before dis=
able succeeds
--

commit 523239d2fe74e7716841144f189ac1575251eac3
Author: Omar Elghoul <oelghoul@linux.ibm.com>

s390/pci: Improve function measurement state management

This commit decouples the user's desired function measurement state in
zdev->statistics_on from the firmware enablement state via
zpci_fmb_request_on(), zpci_fmb_request_off(), zpci_fmb_enable(), and
zpci_fmb_disable(). It also preserves and restores function measurement
across device enable, disable, and re-enable paths.

[ ... ]

> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index 2a7e1ca0fa12f..98a4e938865ae 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
> @@ -165,7 +165,37 @@ int zpci_unregister_ioat(struct zpci_dev *zdev, u8 d=
maas)
>  }
> =20
>  /* Modify PCI: Set PCI function measurement parameters */
> -int zpci_fmb_enable_device(struct zpci_dev *zdev)
> +int zpci_fmb_request_on(struct zpci_dev *zdev)
> +{
> +	lockdep_assert_held(&zdev->fmb_lock);
> +
> +	if (zdev->statistics_on && zdev->fmb)
> +		return -EINVAL;
> +
> +	/*
> +	 * Record the user's intent first. If the enable fails, the flag stays =
set
> +	 * so we can retry enabling the FMB upon the next device (re-)enable. T=
he
> +	 * consumer can detect that a measurement sample was never written if t=
he
> +	 * timestamp is still zero, or if the FMB pointer is null.
> +	 */
> +	zdev->statistics_on =3D true;
> +	return zpci_fmb_enable(zdev);
> +}

[Severity: Medium]
In arch/s390/pci/pci.c, zpci_fmb_enable() allocates (or reuses and zeroes)
zdev->fmb via kmem_cache_zalloc() before calling zpci_mod_fc(), and leaves
zdev->fmb non-NULL if zpci_mod_fc() fails and returns -EIO:

	if (!zdev->fmb) {
		zdev->fmb =3D kmem_cache_zalloc(zdev_fmb_cache, GFP_KERNEL);
		if (!zdev->fmb)
			return -ENOMEM;
	} else {
		/* reuse the same FMB buffer for as long as the zdev lives */
		memset(zdev->fmb, 0, sizeof(*zdev->fmb));
	}
	...
	cc =3D zpci_mod_fc(req, &fib, &status);
	if (cc)
		return -EIO;

If zpci_fmb_enable() fails in zpci_mod_fc() during pcibios_enable_device(),
zpci_reenable_device(), or pci_perf_seq_write() -> zpci_fmb_request_on(),
both zdev->statistics_on and zdev->fmb remain set while function
measurement is disabled in firmware.

When that happens, won't the (zdev->statistics_on && zdev->fmb) check in
zpci_fmb_request_on() reject any subsequent retry from pci_perf_seq_write()
with -EINVAL instead of calling zpci_fmb_enable()?

Also, in arch/s390/pci/pci_debug.c, pci_perf_show() only checks
zdev->statistics_on and zdev->fmb:

	mutex_lock(&zdev->fmb_lock);
	if (!zdev->statistics_on || !zdev->fmb) {
		mutex_unlock(&zdev->fmb_lock);
		seq_puts(m, "FMB statistics disabled\n");
		return 0;
	}

Wouldn't pci_perf_show() report zeroed or stale counters instead of
"FMB statistics disabled" when zpci_mod_fc() fails after zdev->fmb has been
allocated?

> +
> +/* Modify PCI: Disable PCI function measurement */
> +int zpci_fmb_request_off(struct zpci_dev *zdev)
> +{
> +	lockdep_assert_held(&zdev->fmb_lock);
> +
> +	if (!zdev->statistics_on)
> +		return -EINVAL;
> +
> +	zdev->statistics_on =3D false;
> +	return zpci_fmb_disable(zdev);
> +}

[Severity: Medium]
What happens in zpci_fmb_request_off() in arch/s390/pci/pci.c if
zpci_fmb_disable(zdev) fails with -EIO when zpci_mod_fc() returns cc =3D=3D=
 1?

Because zdev->statistics_on is set to false before zpci_fmb_disable(zdev)
succeeds, a failed disable leaves function measurement active in firmware
while zdev->statistics_on is false. A subsequent retry via
pci_perf_seq_write() -> zpci_fmb_request_off() will then fail with -EINVAL
at the (!zdev->statistics_on) check, and pcibios_disable_device() will also
skip calling zpci_fmb_disable(zdev).

[ ... ]

> @@ -647,7 +672,8 @@ int pcibios_enable_device(struct pci_dev *pdev, int m=
ask)
> =20
>  	zpci_debug_init_device(zdev, dev_name(&pdev->dev));
>  	mutex_lock(&zdev->fmb_lock);
> -	zpci_fmb_enable_device(zdev);
> +	if (zdev->statistics_on)
> +		zpci_fmb_enable(zdev);
>  	mutex_unlock(&zdev->fmb_lock);
> =20
>  	return pci_enable_resources(pdev, mask);
> @@ -658,7 +684,8 @@ void pcibios_disable_device(struct pci_dev *pdev)
>  	struct zpci_dev *zdev =3D to_zpci(pdev);
> =20
>  	mutex_lock(&zdev->fmb_lock);
> -	zpci_fmb_disable_device(zdev);
> +	if (zdev->statistics_on)
> +		zpci_fmb_disable(zdev);
>  	mutex_unlock(&zdev->fmb_lock);
>  	zpci_debug_exit_device(zdev);
>  }
> @@ -740,8 +767,14 @@ int zpci_reenable_device(struct zpci_dev *zdev)
>  	}
> =20
>  	rc =3D zpci_iommu_register_ioat(zdev, &status);
> -	if (rc)
> +	if (rc) {
>  		zpci_disable_device(zdev);
> +		return rc;
> +	}
> +
> +	guard(mutex)(&zdev->fmb_lock);
> +	if (zdev->statistics_on)
> +		zpci_fmb_enable(zdev);
> =20
>  	return rc;
>  }

[Severity: Medium]
Could zpci_reenable_device() in arch/s390/pci/pci.c enable function
measurement while the upper-layer pci_dev is disabled or removed?

In zpci_create_device(), zdev->statistics_on is initialized to true, and
pcibios_disable_device() preserves zdev->statistics_on =3D true when disabl=
ing
measurement.

In arch/s390/pci/pci_sysfs.c, recover_store() -> _do_recover() removes the
pci_dev before calling zpci_reenable_device():

	pci_stop_and_remove_bus_device(pdev);
	if (zdev_enabled(zdev)) {
		ret =3D zpci_disable_device(zdev);
		if (ret =3D=3D -EINVAL)
			ret =3D 0;
		if (ret)
			return ret;
	}

	ret =3D zpci_reenable_device(zdev);

Here pci_stop_and_remove_bus_device(pdev) unbinds the driver and calls
pcibios_disable_device(pdev), leaving zdev->statistics_on set to true.
_do_recover() then calls zpci_reenable_device(zdev) (and similarly
reset_slot() -> zpci_hot_reset_device() -> zpci_reenable_device() can run
when no driver has enabled the pci_dev), which immediately starts firmware
measurement updates to zdev->fmb while the pci_dev is not enabled.

When recover_store() subsequently calls pci_rescan_bus() and a driver probes
and enables the device via pci_enable_device() -> pcibios_enable_device(),
pcibios_enable_device() sees zdev->statistics_on is true and calls
zpci_fmb_enable(zdev) again, executing memset() on zdev->fmb while firmware
measurement updates to zdev->fmb are already active.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020212427.2561=
-1-oelghoul@linux.ibm.com?part=3D3
