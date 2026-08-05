Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022EC484254;
	Wed,  5 Aug 2026 17:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785949512; cv=none; b=L1VWI80J5MSBcY3GeBAkE2e1c4UWrfZ+FxyrDNQN0IZ8Bs/Z+3zFP49M5wdq2r08/DDVdshCc4BkNTym4D7exayWB/e26HhFLn2OQ1iy4QOQuYty1tftVAnpUKvy9vXGoD5YljhsEtKIoHWKnExlHJyMCPqlXFijw7d0Xz//1Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785949512; c=relaxed/simple;
	bh=7FFG8zQsiLQIuLNNcwJFf9es/4LRi5uaHru4q+uVDZ4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KE/y3MB90cY1cpfu7RhmC2/RikTmCCa3lk98XjY/yTOrn3zAi4buMwMExJa4eQH7bAMkFaHBXTCBTphTgU5QjjuulLd0Dewp2jKqe2X2bbUrO2o+KKPU2twd4tmabd3a7uIPBgg5omGst5MD9u//0D5eM9nE639M268IPeAoy/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZOBRgPvj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOBRgPvj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482081F000E9;
	Wed,  5 Aug 2026 17:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785949510;
	bh=gg5XXmd3ja4UtbabPZZKsTgXh8sK2PQ7ArvwDrJDiCY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZOBRgPvjfYzSD+STtSkHaczrye6CaUUsiUKFLtgLG3o3C8MqRhaoisP/SE7WsqCL+
	 XXG647rDOZ9QuDPtR3myr+oyUuOK6yF/TaZpc4r2zpKWxSfZrtwAx7oormdbnN0miU
	 ewGHoodgYmHUa6/NvEUKPJ69cxZ/Jd0E3/lki9PQPYRsYVU7kqygmCHi16ZdhlpW6n
	 1n4MJAx3w3juJk4wmPeamZu4jJ71DtVmtVOLx2xDoKe3NBn+4XqE9LGTnrceOJYq8o
	 lmSShh6rBTYyFP7zLNeQH2D6GHkHgy6giTz0kKTFhh9Jiuqxvjr4O1hl64teXX67jj
	 RsMtXpt5uPROA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v23 3/5] PCI: Avoid saving config space state if
 inaccessible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-pci@vger.kernel.org, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260805165518.794-4-alifm@linux.ibm.com>
References: <20260805165518.794-1-alifm@linux.ibm.com>
 <20260805165518.794-4-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 17:05:09 +0000
Message-Id: <20260805170510.482081F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Function parameter `msg` should be declared as `const char *` inste=
ad of `char *`.
--

--- Patch [3]: [PATCH v23 3/5] PCI: Avoid saving config space state if inac=
cessible ---
commit d2cfd742f2dfe4c4445b198bcb7010bd9ef42491
Author: Farhan Ali <alifm@linux.ibm.com>

PCI: Avoid saving config space state if inaccessible

This commit modifies the PCI reset process to avoid saving the device's
configuration space state if it is inaccessible. It checks the PCI_COMMAND
register to determine accessibility before attempting to save the state.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 350bae907ebf8..e8d7de77241a6 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c

[ ... ]

> @@ -713,6 +713,27 @@ u16 pci_find_dvsec_capability(struct pci_dev *dev, u=
16 vendor, u16 dvsec)
>  }
>  EXPORT_SYMBOL_GPL(pci_find_dvsec_capability);
> =20
> +static bool pci_dev_config_accessible(struct pci_dev *dev, char *msg)

[Severity: Low]
This isn't a bug, but should the msg parameter be declared as const char *
instead of char *?

The function is called with string literals, which violates const
correctness and can trigger discarded-qualifier compiler warnings.

> +{
> +	u32 val;
> +
> +	/*
> +	 * If device's config space is inaccessible it can return ~0 for

[ ... ]

> @@ -5059,6 +5080,9 @@ static void pci_dev_save_and_disable(struct pci_dev=
 *dev)
>  	 */
>  	pci_set_power_state(dev, PCI_D0);
> =20
> +	if (!pci_dev_config_accessible(dev, "save state"))
> +		return;
> +
>  	pci_save_state(dev);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805165518.794-=
1-alifm@linux.ibm.com?part=3D3
