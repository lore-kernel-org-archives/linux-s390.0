Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E8E33F597;
	Mon, 22 Jun 2026 17:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782149361; cv=none; b=VwEcARLZNN/Vdu08epJj4OgEAarvIkRnSKcmlLs8OYMAE1Qwrvs+vjIdkVtCbRIvqU62VjnedrCnXHOXCwf5bezHk16vMWFo0Si/e5MST7b/JKIugXgM+vHtFo4GAIDR7mw6EsDU5iSZYb365ST3I5NQky/cvFQ/yJ2Bhsm0m3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782149361; c=relaxed/simple;
	bh=P8/xpr1iBFRLslqS+cPhcEu7b0DhY2Sgnw5AUoGtClU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aMd4c5QJEaOajadeHEoIzeJNA/ILmWF3N3dhTL/p6M/4IqeEdfh/7uJGRecveMG5GdL83IvrIDQ+TCfNWG4CkB2PvtB9w0oTUMHQ9l5z64GxCFgOJWBvM46+JbeQvuQwmlY/oden+8Wzjxttl0eQprM8+jf0I1ddP2c1WRrK7BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMDfIBbx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMDfIBbx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B091F000E9;
	Mon, 22 Jun 2026 17:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782149360;
	bh=KhEQncDBKejb1FIrJj6yHPW+YT1G6LMz0c3Q/EZ5hmI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SMDfIBbxgECkZ92+52210vPSd5/tFdIu+TQdOnp6LT5LNMH2+XHD5vW1myEK9nIHS
	 TtIW8Amk99ntutncVkTKmfqbJ/QsZzhBZdUxfccuxxUmghEAE9GB2PyUZQx/LLTmjM
	 4cNRfEi4nJxGua2Dt2u0PU/vJu11krQaPDDria/Q8Hdi18fPjXRsJKcfovLnx80WzO
	 jNrzP5qCHyeczE3ttjHTyhLhwl00huwGS1bT3IgjnCWa4JEL1BTOjZiWcrXrXL2sUf
	 dva4hxq0JBCqAkQY/uGYhSq1CC7oAhOl1CusY9Qo82TEJYLYuRDGMvj7WpmZjDxRvo
	 zsLbrceCsT31Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 2/4] PCI: Avoid saving config space state if
 inaccessible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, linux-pci@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260622171840.1618-3-alifm@linux.ibm.com>
References: <20260622171840.1618-1-alifm@linux.ibm.com>
 <20260622171840.1618-3-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 17:29:19 +0000
Message-Id: <20260622172920.50B091F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The `msg` parameter in `pci_dev_config_accessible` is declared as `=
char *` but is passed string literals.
--

commit 9495eb9f8f7d4d9784f1bb256b565bf60e0d2bb7
Author: Farhan Ali <alifm@linux.ibm.com>

PCI: Avoid saving config space state if inaccessible

This commit modifies the device reset process to check if the device's
configuration space is accessible before attempting to save its state. If
the space is inaccessible, it skips saving to prevent invalid values from
being written back during state restoration.

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
This isn't a bug, but could the msg parameter be declared as const char *
instead?

This function is passed string literals like "save state" when called from
pci_dev_save_and_disable(), and using a const pointer would ensure
const-correctness and help prevent potential compiler warnings.

> +{
> +	u32 val;
> +
> +	/*
> +	 * If device's config space is inaccessible it can return ~0 for
> +	 * any reads. Since VFs can also return ~0 for Device and Vendor ID
> +	 * check Command and Status registers. Note that this is racy
> +	 * because the device may become inaccessible partway through
> +	 * next access.
> +	 */
> +	pci_read_config_dword(dev, PCI_COMMAND, &val);
> +	if (PCI_POSSIBLE_ERROR(val)) {
> +		pci_warn(dev, "Device config space inaccessible; unable to %s\n",
> +				msg);
> +		return false;
> +	}
> +
> +	return true;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622171840.1618=
-1-alifm@linux.ibm.com?part=3D2
