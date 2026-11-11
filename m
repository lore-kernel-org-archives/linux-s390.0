Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794417661;
	b=EZrlbkT8pK1BwcGAovIpPRkOfu0GAeBX4vwJovZxvU52gInNqd8Bzxlu4We+uPpoyZlQ
	 7jcSAO2gFqu45Zszyv27TBFptJk3k/SvvZ8YiPNEWuR9Fxov08079LYUNOlEHPKbJHWrQ
	 s2OX7/wtUd8Fbp+sGKlUmkorYWGXsHWZSXN7iA+zNGASVsHrOjQRBmlHK47eB2DhzCkC5
	 u90d4rf5MfHVi4qoHLuFEVH+YcvAISTPyEm+hOcVZIk2IZ4+J7ozOhFFJRQ7q6BncOfYC
	 7qDq0W9ivhQa32fbHtOpYTROLeD9n4sDH2jdLFV1t++74YJ7jyXufviML2vyzYl0tDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417661;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FKOJ8KDuosOi8BJQqftHePAK8e5SSSs2999hEBZf9eE=;
	b=eIQPst/ntPtfUX6deEeiB47sg11jUcT8xiMkNbtfqrqwrU17Yq/jBMX9onKkS1PCvipQ
	 ZAYaRngBA8pit98gwSn8Q29PoL55SIh5QXvYiRXEzjLj19R6xNip1RKCgNDc0QCv5HZkQ
	 x8s1zAjdL7r4rGXrRpoxYKA8zrBXlTgl5U3ALyWHfEQQZWWs+ty5I61M3nhQjKEymgL9T
	 31s7RnVJ7Vs3dlgos8MEKkTG6c9WOiQPZz/BCjcPFZ4Ja1r5usb35Sg0sntZqmZ0V3loT
	 dyLf9qJpZt0dFuw6r3bwEbdbPvnnCny07DZep6yS5VkSXq5Uzg4aevynqSl2qXBdqgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="SeU/cBwg";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB79A606A321;
	Wed, 11 Nov 2026 17:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SeU/cBwg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FDDD1F00A05;
	Wed, 11 Nov 2026 17:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794417660;
	bh=FKOJ8KDuosOi8BJQqftHePAK8e5SSSs2999hEBZf9eE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SeU/cBwgH2gsHJ56ZYshk+tzucy4trXksw3HuYDfxBhFeYUYMCD/FYQudcN1prdPn
	 atVlENmq53VO9OWPceztO37Q6x1KVGAR7MD4rsv7jPl8kDTwyNeQY8wVEtdbHpRoyc
	 GArhhBO211YMXJiWiayLVJkXAMOY8sLkhnjR9HW4KrC+C14WpSaHl4rnvokABdsxXT
	 0SsLyKuPHgoGcuP66JJw0McOQmluoHjCRFGJkFm8q+zZLahRb9nzC0APdZzbr/ZDog
	 5WieUQCfTTa9MrtrUWRRy7Av9sONLxHb/RccGTIuCEav54a6S0JF6R++dzAxtsRwKY
	 swZDayWCksjGg==
Message-ID: <sashiko-outbox-209403@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 2/5] s390/pci: Improve function measurement state
 management
Reply-To: sashiko-reviews@lists.linux.dev
To: "Omar Elghoul" <oelghoul@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261111162758.9792-3-oelghoul@linux.ibm.com>
References: <20261111162758.9792-1-oelghoul@linux.ibm.com>
 <20261111162758.9792-3-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 17:20:59 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] s390/pci: zpci_reenable_device() enables FMB on disabled PCI
  devices
--

commit fa84ea4339ffa82b899be0638304928f5c7daa03
Author: Omar Elghoul <oelghoul@linux.ibm.com>

s390/pci: Improve function measurement state management

This commit tracks the desired function measurement state in
zdev->statistics_on and restores it when enabling, disabling, or
re-enabling a zPCI device.

> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index c055a9ad09724..f49736386eb7c 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c

[ ... ]

> @@ -737,8 +769,14 @@ int zpci_reenable_device(struct zpci_dev *zdev)
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
Does this enable FMB measurement in firmware when the PCI device is
disabled?

zdev->statistics_on is initialized to 1 in zpci_create_device() and
remains 1 after pcibios_disable_device() disables FMB.  Callers such as
_do_recover() and vfio_pci_core_disable() -> ... -> zpci_hot_reset_device()
disable or remove the struct pci_dev before calling
zpci_reenable_device(zdev):

arch/s390/pci/pci_sysfs.c:_do_recover() {
	pci_stop_and_remove_bus_device(pdev);
	if (zdev_enabled(zdev)) {
		ret =3D zpci_disable_device(zdev);
		...
	}

	ret =3D zpci_reenable_device(zdev);
}

Because zdev->statistics_on is still 1, zpci_reenable_device() allocates
zdev->fmb and enables FMB DMA in firmware even though pcibios_disable_devic=
e()
already ran.  If no driver re-enables the PCI device, firmware FMB
measurement stays active on a disabled device, and at this commit
zpci_release_device() leaks zdev->fmb if the device is later deconfigured
(though commit "s390/pci: Improve FMB memory management" later in the
series frees zdev->fmb on release).  When a driver does later enable the
device, pcibios_enable_device() -> zpci_fmb_enable() sees zdev->fmb
already allocated and returns -EINVAL instead of zeroing zdev->fmb and
resetting the software IOMMU counters.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111162758.9792=
-1-oelghoul@linux.ibm.com?part=3D2
