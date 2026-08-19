Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31757429CF4
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787130868; cv=none; b=MMMHNX/aDSANLpLHt1+HDE3NYGXu0w0d1r80fmB7VnHph2DX2/l4aB9WlzjTrghm+uBE+kLDI6rDF4z4jFMqE5ymFGfp9XOMon6Zp4B420t40tMFZmo495oO8mfhy51kMK3yfKYVdxtrQ3itJ1BGk8h8WFCz3lYCQFlS78HRdFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787130868; c=relaxed/simple;
	bh=ULme9yamJgIh/stQ5LwNFkwv04IfMvxTcbtLvChFwv4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JGy4ONN7JdzoPHM3GQU/AEH6cbhoQo36gX0GXRV2YQGx643Ow1SF5d/J8lmG8omMxrIdVQOcm9bmT3AAK6TzwVORCpHHvPjLDAJ6jpbY0fbTWKvSPnIGefcX58SaDKaPQQqG+if8kIdLzKTjF7UU0lsTCLlJNUGWNG7l8hlF2Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUJ5tlvZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUJ5tlvZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F6FD1F000E9;
	Wed, 19 Aug 2026 09:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787130866;
	bh=2wVQ9lvAIFCIDftOs6OlNwtMjTyTvKs7+rr9HThZBk8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IUJ5tlvZjRczJgUxeatRXT3qql/cCJyMRokXZfkm/epOTPxKSQcukLw1XlgQNiJQB
	 bq/qXacASFZXf0dMpF1xhha7csnEtI+HBM7pOd+zffvMVEHIad9c7lTQ18rakhOX9h
	 w8RDtuYojCNBddt+gZEY+4ngoy0+S2W1efIcz3X4c7r03K3U631/8QGjsTs56bHRSU
	 mOjWUrqK/ETp4aM+dL6ho61gDYzKOPuL44UR1z18BjqwBlX+wzbYUeAO4DiBk6jPUk
	 myRVTuhkhYhZ9Gau7lu4Pxijln7Rsd1NwVYQ4TsFBKPxO2yrfXtYHzIWweShPf4U2c
	 aF9ulVF6m+Z9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/7] s390/pci: add NULL check in zpci_msi_clear_airq()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tobias Schumacher" <ts@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260819-s390_irq_domain_fixes-v1-5-826ff27b6e97@linux.ibm.com>
References: <20260819-s390_irq_domain_fixes-v1-0-826ff27b6e97@linux.ibm.com>
 <20260819-s390_irq_domain_fixes-v1-5-826ff27b6e97@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 09:14:25 +0000
Message-Id: <20260819091426.3F6FD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] The patch introduces dead code by adding NULL checks for impossi=
ble scenarios due to a misunderstanding of the MSI irqdomain lifecycle.

Pre-existing issues:
- [Critical] Double addition of the loop index `i` in `zpci_msi_clear_airq(=
)` causes a heap out-of-bounds write during multi-MSI teardown.
- [High] Missing device teardown in `pci_base_init()` error path creates a =
Use-After-Free condition, which the added NULL checks silently evaluate.
--

--- Patch [5]: [PATCH 5/7] s390/pci: add NULL check in zpci_msi_clear_airq(=
) ---
commit a9e3adc4d04b20107c5f8c48da92688566d873e6
Author: Tobias Schumacher <ts@linux.ibm.com>
s390/pci: add NULL check in zpci_msi_clear_airq()

This commit adds null checks for the interrupt vector pointers in
zpci_msi_clear_airq() for both DIRECTED and FLOATING modes. It attempts
to prevent crashes during error cleanup and shutdown paths if the pointers
are already freed.

> In FLOATING mode, zdev->aibv can be NULL if:
> - zpci_msi_prepare() fails after __alloc_airq() but before setting
>   up the device's AIBV, and zpci_msi_domain_free() is called during
>   error cleanup
> - The device is being torn down and zpci_msi_teardown_floating()
>   has already released the AIBV

[Severity: Medium]
Is this description accurate?

If the .msi_prepare callback fails, it returns an error and the MSI core
halts allocation without invoking .alloc. Consequently, the .free callback
is never invoked for this device, so zpci_msi_clear_airq() wouldn't
execute on this error path.

During normal device teardown, the MSI core guarantees that .free is invoked
per-IRQ strictly before the domain is destroyed and .msi_teardown is invoke=
d.
Since zpci_msi_teardown_floating() is the only function that sets zdev->aibv
to null, zdev->aibv should be valid whenever zpci_msi_clear_airq() executes.

> diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
> index e9eda846cb2d2..1515d8d7460ea 100644
> --- a/arch/s390/pci/pci_irq.c
> +++ b/arch/s390/pci/pci_irq.c
> @@ -465,12 +465,16 @@ static void zpci_msi_clear_airq(struct irq_data *d,=
 int i)
> =20
>  	if (irq_delivery =3D=3D DIRECTED) {
>  		for_each_possible_cpu(cpu) {
> -			airq_iv_set_ptr(zpci_ibv[cpu], bit + i, 0);
> -			airq_iv_set_data(zpci_ibv[cpu], bit + i, 0);
> +			if (zpci_ibv[cpu]) {

[Severity: High]
This is a pre-existing issue, but does checking zpci_ibv[cpu] here lead to a
use-after-free read?

In pci_base_init(), if zpci_fw_sysfs_init() fails, it jumps to out_find and
calls zpci_irq_exit(). This frees the zpci_ibv array via kfree(), but leaves
active PCI devices registered.

When drivers later bind to these devices and tear them down,
zpci_msi_clear_airq() will execute. Checking the freed zpci_ibv array point=
er
will likely evaluate to true, causing a use-after-free read and subsequent
write when it is dereferenced.

> +				airq_iv_set_ptr(zpci_ibv[cpu], bit + i, 0);
> +				airq_iv_set_data(zpci_ibv[cpu], bit + i, 0);

[Severity: Critical]
This is a pre-existing issue, but does this code write out of bounds during=
 a
multi-MSI teardown?

Earlier in zpci_msi_clear_airq(), the local variable bit is computed as
zdev->msi_first_bit + msi_index. The hwirq of the irq_data d was already
initialized as base_hwirq + i during allocation, so msi_index already
includes the offset i.

Passing bit + i to the airq_iv_set_ptr() and airq_iv_set_data() macros means
the index evaluated is zdev->msi_first_bit + desc->msi_index + 2 * i. For
any index greater than zero, this skips the intended target and writes 0 out
of bounds. This same calculation impacts both the zpci_ibv and zdev->aibv
array writes in this function.

> +			}
>  		}
>  	} else {
> -		airq_iv_set_ptr(zdev->aibv, bit + i, 0);
> -		airq_iv_set_data(zdev->aibv, bit + i, 0);
> +		if (zdev->aibv) {
> +			airq_iv_set_ptr(zdev->aibv, bit + i, 0);
> +			airq_iv_set_data(zdev->aibv, bit + i, 0);
> +		}
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-s390_irq_d=
omain_fixes-v1-0-826ff27b6e97@linux.ibm.com?part=3D5
