Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDED7470439;
	Wed,  5 Aug 2026 17:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785949682; cv=none; b=p6fbixV8kF61QrVcklo3izZ6+2voNoUreFFobyoacRiWIaHmkaCm9GoVzX/OO7ohtGaQrKeuazkj/AOLT23f+UULR8Q00HbCvmHcyvC9q4CnTdp8gyGps6tlByiNXnqV8hbYjFAR+QBctvQt0OPRC4hhdi2mhNQ4CYmNdfUANsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785949682; c=relaxed/simple;
	bh=jK4n2ZXObgzujtvCji1s8OWEUtfPDlcElKgLJyC85G0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XwHrjNLrTZuuyuSQW7wcRYYjrvJ3ZXb93Kejmrejj1lLEM3vqEF1YX1z0+eIZ1xXOvEOTXcHOfvNnbpEBjIBKdMOON1VXdZajlz9XZ86ihCnfDOTSeUGS7iSCcDNrm3dNIKR9L/1ezYRPcgtR6frjURFLcOX74Y7Mad+93EKp/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZjAPYzU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZjAPYzU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3432E1F000E9;
	Wed,  5 Aug 2026 17:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785949679;
	bh=GIyDiH7h8ZTt8juberz8qVLCFPMcQtjdFXFcXCxm3qo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jZjAPYzU/Tqi1xbsNO1wcHE3tRCSCaUJailIoC4wXcKexqkrR/CuNYUzlzZP92U+w
	 89Dqohy+dBU8AiTOZ1Skcth+B3hTqiH9aOl3icMJDqrWXFJgp5ELdzarrrYw1Xqzqy
	 jrGpduALsNa2HWTvnTeBf2YkU5NOk90DomxyH1DMGHI5F+J1N0mvckRfmhTrIGKUy5
	 0tnXWvOTVEWO9aBcDb5aAMwquq8vgwuSGxHpP/YFciUSx39iuDQAUOmtKRl+4eAJGh
	 UY7dFBajlNDMIFa2Fa61Y9msv3YZ8yT/QT4xnrombQBJPeDoAjCi41hjcqJcZ1YvI9
	 nhbmrPHRGqi0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v23 5/5] PCI/MSI: Enable memory decoding before
 restoring MSI-X messages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-pci@vger.kernel.org
In-Reply-To: <20260805165518.794-6-alifm@linux.ibm.com>
References: <20260805165518.794-1-alifm@linux.ibm.com>
 <20260805165518.794-6-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 17:07:58 +0000
Message-Id: <20260805170759.3432E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing error check on PCI_COMMAND read leads to permanent registe=
r corruption and unintended device enablement on transient PCI errors.
--

--- Patch [5]: [PATCH v23 5/5] PCI/MSI: Enable memory decoding before resto=
ring MSI-X messages ---
commit 6d8ddd25b8ed47c23845049339a3c29cd4e53440
Author: Farhan Ali <alifm@linux.ibm.com>

PCI/MSI: Enable memory decoding before restoring MSI-X messages

This commit temporarily enables the Memory bit in the Command register
before writing MSI-X messages to prevent Unsupported Request errors.
It then restores the original Command register state afterwards.

> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index 209373c92e9e1..79c7e84d314b7 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c

[ ... ]

> @@ -879,6 +880,14 @@ void __pci_restore_msix_state(struct pci_dev *dev)
>  	pci_msix_clear_and_set_ctrl(dev, 0,
>  				PCI_MSIX_FLAGS_ENABLE | PCI_MSIX_FLAGS_MASKALL);
> =20
> +	/*
> +	 * The restored device state may not have Memory decoding enabled
> +	 * in the Command register. Since the MSI-X was enabled for the
> +	 * device, enable Memory decoding before restoring MSI-X.
> +	 */
> +	pci_read_config_word(dev, PCI_COMMAND, &cmd);
> +	pci_write_config_word(dev, PCI_COMMAND, cmd | PCI_COMMAND_MEMORY);

[Severity: High]
If the device is inaccessible or experiencing a transient error (e.g., an A=
ER
link reset), can this read fail and set cmd to 0xFFFF?

Looking at pci_read_config_word(), it uses PCI_SET_ERROR_RESPONSE() on fail=
ure:

int pci_read_config_word(const struct pci_dev *dev, int where, u16 *val)
{
        if (pci_dev_is_disconnected(dev)) {
                PCI_SET_ERROR_RESPONSE(val);
                return PCIBIOS_DEVICE_NOT_FOUND;
        }
        ...
}

If cmd is set to 0xFFFF, the subsequent pci_write_config_word() will write
0xFFFF back to the Command register.

Does this unintentionally enable all device capabilities, including Bus
Mastering (which could lead to rogue DMA) and SERR#?=20

Should we check the return value of pci_read_config_word() before writing?

> +
>  	write_msg =3D arch_restore_msi_irqs(dev);
> =20
>  	scoped_guard (msi_descs_lock, &dev->dev) {

[ ... ]

> @@ -889,6 +898,7 @@ void __pci_restore_msix_state(struct pci_dev *dev)
>  		}
>  	}
> =20
> +	pci_write_config_word(dev, PCI_COMMAND, cmd);

[Severity: High]
If cmd was populated with the error response 0xFFFF, does this write
permanently commit the corrupted state back to the device?

>  	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805165518.794-=
1-alifm@linux.ibm.com?part=3D5
