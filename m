Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C42C399368;
	Mon, 15 Jun 2026 18:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781549380; cv=none; b=lNZpTf42t0Ee1VRYItYmB6Ms1r2d5LOqQSfjXGOiKeOhq+mmygLsYfDC2caBvkix2u1Rmws0+mgmpafPpFVKavQpVWYXoM7bG8WDvo2oyLAZCMx8yBKb88kyxalDwtcLTXQm1ZwpkUPK2AtBgEXImU/1tCyfAsEbsS2VB+sasQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781549380; c=relaxed/simple;
	bh=eUZzBfDxP9rIZ6gJ/gnqocxWfSi1HUOLkctdpiTegrw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rA5E7YEZTl4GW9LbNAWIa53rciJMGYv1B2Bkzdb0Ejry3erkOsYbPekuobnD2Hw0X6WcssBZpkM0W7CLrmju9KP/F7p6UXLHvVvrR+J8fTrx/9eCU+9h94XKRgqM/1tjoWdFO5x2yaeUcSlJopNzn0KFkP9ouC5uBGjeKz8A2M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHIFpcX1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHIFpcX1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FFC01F00A3A;
	Mon, 15 Jun 2026 18:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781549378;
	bh=VZtBCarQ1iPxSybaJpulEV0eSo2PJBHIwXyFCcvvW80=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kHIFpcX1+FBsM6/ar8gY+f1KyXnBpbq/O0ZfjBIFnLdskkEvvcXqRXgjNHgnM6gqU
	 aU1r/5c3rx5RT4ps8s9Yleto9xIW3WWIQATWebeHUFZcmHWCrAVaOEEq0tPTs+9mAy
	 INZPj9+XRf3U0ceB5+vHYR3Kp3zJhEzYsZPP12zjZD/FtKrfhjQ6GjBDwoFqLBAHLL
	 pMygDgkRNn5sw9AtbW/1B6pduG1CuuvQsftOE6lLM5O3EGY/sQ1ops/7JTN7PljEP4
	 Ho8jqaCRHDUvUdCZm320g6EbquxJwK6sR5nDHJAfYIyuGHXQ8PdqvFnQenP7EjrKeE
	 zinHCO0PsizFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 2/4] PCI: Avoid saving config space state if
 inaccessible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-pci@vger.kernel.org
In-Reply-To: <20260615183524.2880-3-alifm@linux.ibm.com>
References: <20260615183524.2880-3-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 18:49:37 +0000
Message-Id: <20260615184938.3FFC01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The `msg` parameter in `pci_dev_config_accessible` should be declar=
ed as `const char *msg`.
--

commit a6a510b639eb621fca4f9673a8ce4e45c59a4efe
Author: Farhan Ali <alifm@linux.ibm.com>

PCI: Avoid saving config space state if inaccessible

The current reset process saves the device's config space state before
reset and restores it afterward. However errors may occur unexpectedly and
it may then be impossible to save config space because the device may be
inaccessible (e.g. DPC). This results in saving invalid values that get
written back to the device during state restoration.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index d0c9f0166af5c..e71b814153921 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c

[ ... ]

> @@ -722,6 +722,27 @@ u16 pci_find_dvsec_capability(struct pci_dev *dev, u=
16 vendor, u16 dvsec)
>  }
>  EXPORT_SYMBOL_GPL(pci_find_dvsec_capability);
> =20
> +static bool pci_dev_config_accessible(struct pci_dev *dev, char *msg)

[Severity: Low]
This isn't a bug, but should the msg parameter be declared as const char *?

The function is called with the string literal "save state" later in this
patch. Using a non-const pointer for string literals can trigger compiler
warnings.

> +{
> +	u32 val;
> +

[ ... ]

> @@ -5027,6 +5048,9 @@ static void pci_dev_save_and_disable(struct pci_dev=
 *dev)
>  	 */
>  	pci_set_power_state(dev, PCI_D0);
> =20
> +	if (!pci_dev_config_accessible(dev, "save state"))
> +		return;
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615183524.2880=
-1-alifm@linux.ibm.com?part=3D2
