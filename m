Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4E93DB330;
	Tue, 30 Jun 2026 17:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782839592; cv=none; b=fsoY9CpK8tLoLeONqOXLHU+juhpXhhKiE6hMDRZioMS54xL5TPLiPMMq5qCdeYuid9uTqOSbyyx5gzkLXd2mSGKPpCW7hKuHHh8WzAYLYv4ldCl5uuRhFgGLwI7z2aNeY3KZauKaJf/vsVx2kCpUNw+M1YJPzPRc1LI3uZfk/y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782839592; c=relaxed/simple;
	bh=rLBRw33xgkY8vLviSAY6jX3PpQnq0u0dPb2e7pHMn1g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NW/ZOUEnSeqLToUFUMBKD6UH+8kw5SdTWT8wRWZmUE/GptIXmzv9q3D2ATvfgIITSldKxiOpmZlVa6rvBfycoqFAdSEOHCP4GeBIfv2481vlNP+OiyVXwF+cszpKNKdWyokOuDvzLLR18MXmOEyr7slawW3i3brKPw69hcFL1sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ca7PA1F3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ca7PA1F3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25D41F000E9;
	Tue, 30 Jun 2026 17:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782839591;
	bh=ljZ42aPMj1B004p3jyeo7lLInpIHo2zWL07nNiCGCx4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ca7PA1F3/+8afDexgwJX+Vlm6euDJ6cA/bbbnpZYMLldv5rdT2AL4FBD4i2DH0reB
	 nJdykIIzn/HHBz5SlkMAdFEL/c/6U8yoeiwAdgLJBRvyl3wzeIY9L1ZWAq/9Aa2qCg
	 TJZI+H+6MIl70SYQ83SUeYwCKNbHx4U+FfVV6lDnIw8OdOC1YPIwj/i7peNqWwQHrB
	 CCoFR7EFwtgPC/t6w8XFvKmXndZURkPImMCIHKI4nW9r/RH/oXNL7+fe1+t/6/lwv7
	 Qp/1I3chGPkjduyAoJ18woUsgswOcyLeJGjkdfqab96NB+Bc0CSPR5CxlWdVny1kiD
	 3Fl9BOGyIpBcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 3/4] PCI: Fail FLR when config space is inaccessible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-pci@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260630164807.643-4-alifm@linux.ibm.com>
References: <20260630164807.643-1-alifm@linux.ibm.com>
 <20260630164807.643-4-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 17:13:10 +0000
Message-Id: <20260630171310.F25D41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Un-ratelimited pci_warn() in pci_dev_config_accessible() allows an=
 attacker to flood the host kernel log.
- [High] Early bailout in pcie_flr() when config space is inaccessible skip=
s the Function Level Reset and the subsequent wait, allowing device assignm=
ent to continue without reset, leaking state.
--

commit ce2804b7f0c0409f73465726275859a70fa16be3
Author: Farhan Ali <alifm@linux.ibm.com>

PCI: Fail FLR when config space is inaccessible

This commit adds a check to validate if a device's config space is
accessible before attempting a Function Level Reset (FLR). If the
device is in an error state and inaccessible, the reset returns early.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e8d7de77241a6..9a9d021301c4e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4384,6 +4384,9 @@ int pcie_flr(struct pci_dev *dev)
>  {
>  	int ret;
> =20
> +	if (!pci_dev_config_accessible(dev, "FLR"))
> +		return -ENOTTY;
> +

[Severity: High]
If a device is momentarily unresponsive and this check returns -ENOTTY
immediately, doesn't this skip the FLR entirely?

Since VFIO's vfio_pci_core_enable() allows assignment to continue if a reset
returns -ENOTTY (by setting vdev->reset_works =3D false), could a malicious
guest intentionally put the device into an unresponsive state to bypass the
reset and leak device state to the next user?

The previous code path waited before issuing the FLR, but this early return
removes the grace period.

[Severity: High]
Because this early return bypasses the previous delay loop, can a userspace
process spam the VFIO_DEVICE_RESET ioctl in a tight loop?

If the device's config space reads ~0, pci_dev_config_accessible() prints a
warning:

drivers/pci/pci.c:pci_dev_config_accessible() {
	...
	if (PCI_POSSIBLE_ERROR(val)) {
		pci_warn(dev, "Device config space inaccessible; unable to %s\n",
				msg);
		return false;
	}
	...
}

Since this warning is unconditional and not rate-limited, could this tight
loop allow an attacker to trivially flood the host's kernel log?

>  	if (!pci_wait_for_pending_transaction(dev))
>  		pci_err(dev, "timed out waiting for pending transaction; performing fu=
nction level reset anyway\n");
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630164807.643-=
1-alifm@linux.ibm.com?part=3D3
