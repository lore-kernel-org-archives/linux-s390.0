Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6ABD3403EC;
	Fri, 26 Jun 2026 18:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782497167; cv=none; b=dp7r6359F40fqIjS348uiUX16YLSYBtXePujBfmHvxLryq47dkrA6ll3jwVoQMXiMmrqIn47xL3MYyWxVL/YNjTE+4XL7JupwFRjIWazFZtSouzD9H/lDLbbSyrL0kez32gbZbIcyWTrBHGrIQWmwkDjmrDUmK2yyRfzCMwVaUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782497167; c=relaxed/simple;
	bh=KptHpNS1VH1jjrAs6CJC7GgvTopeV5d1AIZn94/B1xc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y+5mAowFOKwYqZkZstbc/wFCNGMLWBzfMJWI/P22nRs2XfekwKKNy1fk7Os6uoQsu9bhhimlLi17a6Zk/7bpcfXfDpffvuRuClw2HiJTbYO9/r21bObAj1eypZ99TwS1aU9sUvFBAm8kS04LCIrTB7BwaTwYGXC9DsfVVSmh90c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0SOYEr7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0SOYEr7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF961F000E9;
	Fri, 26 Jun 2026 18:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782497166;
	bh=NC44CepU1ErdNSkgELoT8ZTzb9/40szhMVb7wZJ8BVo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K0SOYEr7K78/EsMvm8qjT8k6gqHsqSBn7wHFJt6ItSZvDurg7QwSr8o671KIAEDBm
	 9ec9aeM2q3J2EE3LruTt3qHQ7xi5bSnXb6fLClpqf5JQF9+XkTqvtGfh9zC5/FHQO9
	 rMhdmPnWN2CyvWqgcurvdLKMEjC566EpM46FjflrtR9S1KIMcmwf1QDJcVil7H8/0I
	 bM6M7vuLKgjUP/5D+lRTxtb5unmGOWLSft2nse6wSBUudYyRe1dilymb0smxtr765r
	 tFx2H9G0vDISKV8z5qJnkGN+9Of8BelvhphFlyGVZD1Fde2PCY5bKbq2zW4WXDXKyq
	 fWz8me2IFSSwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/4] s390/pci: Preserve FMB state in device
 re-enablement
Reply-To: sashiko-reviews@lists.linux.dev
To: "Omar Elghoul" <oelghoul@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260626175525.37370-3-oelghoul@linux.ibm.com>
References: <20260626175525.37370-1-oelghoul@linux.ibm.com>
 <20260626175525.37370-3-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 18:06:05 +0000
Message-Id: <20260626180606.2EF961F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but there is a missi=
ng resource cleanup in `zpci_reenable_device()` on the `zpci_set_irq()` err=
or path. If `zpci_set_irq()` fails, the function returns immediately withou=
t calling `zpci_disable_device()`, unlike the subsequent IOMMU registration=
 error path. This leaves the device enabled in an inconsistent state.
--

commit 94bfdcea02e7e7dca9c322a0dc40fac61a9fb275
Author: Omar Elghoul <oelghoul@linux.ibm.com>

s390/pci: Preserve FMB state in device re-enablement

This commit introduces zpci_fmb_reenable_device() to check the FMB state and
ensure it is enabled. It resets the counters and handles re-enabling if the
FMB was already active.

> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index 2910d4038d39c..1eb6aa772eb3f 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
[ ... ]
> @@ -737,9 +765,13 @@ int zpci_reenable_device(struct zpci_dev *zdev)
>  	}
> =20
>  	rc =3D zpci_iommu_register_ioat(zdev, &status);
> -	if (rc)
> +	if (rc) {
>  		zpci_disable_device(zdev);
> +		return rc;
> +	}

[Severity: High]
This isn't a bug introduced by this patch, but there is a pre-existing issue
with resource cleanup in zpci_reenable_device().

If zpci_set_irq() fails earlier in this function:

        if (zdev->msi_nr_irqs > 0) {
                rc =3D zpci_set_irq(zdev);
                if (rc)
                        return rc;
        }

It returns immediately without calling zpci_disable_device(), unlike the
subsequent zpci_iommu_register_ioat() error path. Does this leave the device
enabled in the firmware but failed in Linux, rendering it unusable and
leaking its enabled state?

> =20
> +	guard(mutex)(&zdev->fmb_lock);
> +	zpci_fmb_reenable_device(zdev);
>  	return rc;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626175525.3737=
0-1-oelghoul@linux.ibm.com?part=3D2
