Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BB534CFC6;
	Tue, 30 Jun 2026 17:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782839276; cv=none; b=ppeJvGVjuz91MSDHorAojDGrv7nWOkf0uwWCYn1t0PKdFU45CQF4cIazxILgzOy7f4YQA08Yn0/b5oxdRFmyMP5QRN3TszL/qlaN4yH+Lt9Wbcs2s5/wJu8oqK1MU/2ED6IkNMVzA4He5xZRxeX4Ehz/5/vr1wyQxFsSwnTytw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782839276; c=relaxed/simple;
	bh=hSLrV0hbDxCiGzLnvHTchBD9yx1b1XM6mdqzrKzxYhY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BUdxRH7B5iXnp+Su9AF1aJxn/xMFGRDVZGb/WACACZOKDkBnBY0NkDt4iKSSY8Mkp/xhG2IqqsLL8y7tCj/n6YQe1h1X9Mc6A6u26SL9f/nSCcw6E0KN8dQD8w7AcV/iCuhdLhb6yqqoakop6d6r+UvO6J0TK90Rc5FQXio4LNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQEl0nka; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQEl0nka"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093021F00A3A;
	Tue, 30 Jun 2026 17:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782839274;
	bh=gg4vU68nunxT6DEXNx97mSLUNCo+H3w5ToMWCZuGavQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PQEl0nkacrStnbeXlD4W7RkwO8ezse8vJ5Y0PE4NE26DMz/7Ls6l5s0SVEMkGgJ38
	 LnQ6d8Kh0807nWIfZt/42OWKSzmDCX+bIRFdxmsP3SO4Hh9LepiADKfA6iQuv8K5tU
	 Y45DgAZt7RkEteyJmwRaIm3RbE/CY8xc7NRdjC/VtDuxbYD1Z1ARjXE1Xls+bkm8I1
	 HUTon9BBWXlZUmVY300ReNLrQtSglBDVas0XHBbkjm4kZj1n4mqvysLWkCjSR87kx8
	 +K1DTaQ60PKW/mS+nPxZJMm26sJucF7+1u2Qm5cZQbuQ85Y+Le+j6GoC+YeXn5MBTa
	 z6AFKheu7D8kg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 2/4] PCI: Avoid saving config space state if
 inaccessible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-pci@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260630164807.643-3-alifm@linux.ibm.com>
References: <20260630164807.643-1-alifm@linux.ibm.com>
 <20260630164807.643-3-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 17:07:53 +0000
Message-Id: <20260630170754.093021F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] pci_dev_save_and_disable() skips disabling the device if config sp=
ace is momentarily inaccessible, potentially leaving DMA and interrupts ena=
bled.
- [Low] String literal passed to a non-const `char *` pointer in `pci_dev_c=
onfig_accessible()`.
--

commit 067c10f20c7b3c97acf8c9886f6586c07bea7142
Author: Farhan Ali <alifm@linux.ibm.com>

PCI: Avoid saving config space state if inaccessible

This commit avoids saving the device's config space state during a reset
if the device config space is temporarily inaccessible, preventing invalid
values from being written back later.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -713,6 +713,27 @@ u16 pci_find_dvsec_capability(struct pci_dev *dev, u=
16 vendor, u16 dvsec)
>  }
>  EXPORT_SYMBOL_GPL(pci_find_dvsec_capability);
> =20
> +static bool pci_dev_config_accessible(struct pci_dev *dev, char *msg)

[Severity: Low]
This isn't a bug, but should the msg parameter be marked const?

Since a string literal ("save state") is passed to this function, keeping
it as a non-const pointer violates const-correctness and might trigger
compiler warnings.

> +{
> +	u32 val;
> +

[ ... ]

> @@ -5059,6 +5080,9 @@ static void pci_dev_save_and_disable(struct pci_dev=
 *dev)
>  	 */
>  	pci_set_power_state(dev, PCI_D0);
> =20
> +	if (!pci_dev_config_accessible(dev, "save state"))
> +		return;
> +

[Severity: High]
Does this early return skip disabling the device entirely if the config
space is momentarily inaccessible?

If the device is only transiently inaccessible and recovers immediately
after the pci_dev_config_accessible() check, this early return skips the
subsequent pci_write_config_word() that clears the Command register.

Could this leave the device with Bus Master enabled, potentially allowing
it to generate unexpected DMA requests or interrupt storms during the
reset sequence?

>  	pci_save_state(dev);
>  	/*
>  	 * Disable the device by clearing the Command register, except for

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630164807.643-=
1-alifm@linux.ibm.com?part=3D2
