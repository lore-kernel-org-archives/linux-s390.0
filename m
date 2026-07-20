Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5900B42E8C3;
	Mon, 20 Jul 2026 19:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576576; cv=none; b=pS7y7wIrTp82xzwKzDO+v+FEawbaeZvkAKH1l7oyrlwt9H5ul9HmU8ugaKzB3oggKcxvftJTuU2jMMjkXVHnVYcKNnN5aylxicl6VIrNqvZ0GBP8sZvNEqrJEEgbLv3zXJDtnTQA2syN4dmtBZPFPoDHwTpxEjjVAMUQou+7bsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576576; c=relaxed/simple;
	bh=mzr/p1LAe39Xrkv4Anue+Ja0gwqYmg+8pNmzrwizsd0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V6d2rc5KjWHpF87mTKHLb258NthKTFWUhtypQZHDjffrXTr4R/U1ZCbvsT/7PZ6V8EszUXz5GV3AKmu2NiGgkTdJpPwKX/YV89KVCoOLilv7H6HF5en+fkZggLr1IcMFCUbiTfD8uNAR+Xe+nNzgbA1FjWTvjrumrtg4SeQMyoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBolKckj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBolKckj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B811F000E9;
	Mon, 20 Jul 2026 19:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784576575;
	bh=e2PfZP1V7tfUfpjXVzfY/irZN07WljH2ottDN/AM5V4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IBolKckjg8Snv4oaZF9ACi7cWFZSIauHHeZbrt9nMFWpHNcdUZonwJ/v/ddDliw/Z
	 QL9yUtB7ae0uHlvN3q+onivvIM9oxK00ZauvXwGVNJu6j5UbB/tVd5prYoEjWJTDVA
	 Vv0HQ4Rs2bGyEhm8vv1n4N2lUX2BhquJoQ2xyZxi1ohWvrW3AQ2Wwrwwx4+TgEened
	 lKUfYRY/qMQ6XCkzkI7IpJgzPmVuqDvwnGcmTXYPkjkZSmU0UinJxaZPtY2YYefZ15
	 8ALeBK07NBsJhKcYuBo9PI00So1mTMtIOR5g0BwpmpUKOnQ73q5fdXCBcYf2EfKfZQ
	 SoVBRZPbQjXYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v22 2/4] PCI: Avoid saving config space state if
 inaccessible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: linux-pci@vger.kernel.org, linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260720192505.2957-3-alifm@linux.ibm.com>
References: <20260720192505.2957-1-alifm@linux.ibm.com>
 <20260720192505.2957-3-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 19:42:54 +0000
Message-Id: <20260720194254.E6B811F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The `msg` parameter in `pci_dev_config_accessible` is declared as `=
char *` but is called with a string literal (`"save state"`). It should be =
declared as `const char *`.
--

--- Patch [2]: [PATCH v22 2/4] PCI: Avoid saving config space state if inac=
cessible ---
commit 768de665c145b6f3d683260f85032db4d5e81b6f
Author: Farhan Ali <alifm@linux.ibm.com>

PCI: Avoid saving config space state if inaccessible

This commit updates the reset process to check if the device's config space
is accessible before saving its state. By avoiding saving invalid values
when the device is inaccessible, it prevents writing back those invalid
values during state restoration.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 350bae907ebf8..e8d7de77241a6 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -713,6 +713,27 @@ u16 pci_find_dvsec_capability(struct pci_dev *dev, u=
16 vendor, u16 dvsec)
>  }
>  EXPORT_SYMBOL_GPL(pci_find_dvsec_capability);
> =20
> +static bool pci_dev_config_accessible(struct pci_dev *dev, char *msg)

[Severity: Low]
This isn't a bug, but should the msg parameter be declared as const char *
since it is called with a string literal in pci_dev_save_and_disable()?

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
>  	pci_save_state(dev);
>  	/*
>  	 * Disable the device by clearing the Command register, except for

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720192505.2957=
-1-alifm@linux.ibm.com?part=3D2
