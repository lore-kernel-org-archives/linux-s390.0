Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE37B2FD1A5;
	Mon, 20 Jul 2026 19:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784577087; cv=none; b=FJNEVcCN3nqk9F5BA0eFNLWiBuz/VwWQ9IUoxABdFm4XSGwGm0Ycczja9k9CeLPY1WPI2+Yg2MQrNnVfMoO9PElYNFodPCePchSFd9yDVkTB5Y061dJmzRD04jPHQ/vWo4MBO0Tuji1K7bPAck2O0GjXQmlO8miGBrLGzV3LRAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784577087; c=relaxed/simple;
	bh=mRQD2ilIaoiJgVbgQKyvaJX7PaaCPyDR+3vZMrdF0ms=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TgFv9xSYEHN9Ex7cI28s003U2WBr1QFZx0afsuiQpkxGCkc9uCGa3Rb1UCHIo4qX+Bbsj5MwoLuva6ZNtncUgI/zbcUTqqdNgk7qzJRw1LEtxTWRSTIwLdOOCta7TSSRYGdaANi8RPLdNsYfuKVMnOGy5/RHApkFvVLGah/ajxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMTmnD9M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMTmnD9M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA111F000E9;
	Mon, 20 Jul 2026 19:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784577086;
	bh=HLElwFdaX4a0kqgk3x8uXi0e+3KoNI0RU4wDxHPkg+g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eMTmnD9M2/JT9jZsPfksolzM1XMwtS6MrwzxOvy7wJPIricZNlnlCm8OB3ncF1Dw+
	 dwGDmstGa8RUOaILO8RiR6ekqo+0ayZEsozrBkHxAgx2PgbiMFpc5oCSE/SZwTVYGd
	 OIi4t0TL7nVAAT/4o7agel7Cf4S6s16qcH/oyJYagDq+SzMSALLlAZ+zAMi/JMDcmY
	 ovfCV1dxPRFExlsRX6+zzLCefLl95QyzX81mONR+Gg7jnSSGHGOLxCALyTw8mw576O
	 r2u+41UzBYr4M+9JqGgwGOJWAMaIYLeC7rO6EsgaOj8M4Q3vwpCv5cJrH6xYO3Q7bE
	 BtJovWbAYh0Mg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v22 4/4] PCI/MSI: Enable memory decoding before
 restoring MSI-X messages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, linux-pci@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260720192505.2957-5-alifm@linux.ibm.com>
References: <20260720192505.2957-1-alifm@linux.ibm.com>
 <20260720192505.2957-5-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 19:51:25 +0000
Message-Id: <20260720195126.0CA111F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing flush of posted MMIO writes to MSI-X vector control before=
 disabling memory decoding.
--

--- Patch [4]: [PATCH v22 4/4] PCI/MSI: Enable memory decoding before resto=
ring MSI-X messages ---
commit 42ede3312753d558e00e2b7331687e3440f9c013
Author: Farhan Ali <alifm@linux.ibm.com>

PCI/MSI: Enable memory decoding before restoring MSI-X messages

This commit temporarily enables the memory decoding bit in the PCI command
register while restoring MSI-X state, as the device's saved state may not
have it enabled. It restores the original command register state after
the MSI-X table updates are complete.

> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index 209373c92e9e1..79c7e84d314b7 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c

[ ... ]

> @@ -889,6 +898,7 @@ void __pci_restore_msix_state(struct pci_dev *dev)
>  			pci_msix_write_vector_ctrl(entry, entry->pci.msix_ctrl);
>  		}
>  	}
> =20
> +	pci_write_config_word(dev, PCI_COMMAND, cmd);

[Severity: High]
Could this cause a regression where the configuration write arrives before
the posted memory writes to the MSI-X table have completed?

During __pci_restore_msix_state(), the loop updates the MSI-X table using
pci_msix_write_vector_ctrl(), which issues posted memory writes.

Because PCIe ordering rules allow configuration writes to pass posted memory
writes, this configuration write might arrive at the endpoint first.

If the restored cmd value disables memory decoding, the earlier posted
memory writes might be dropped as unsupported requests by the endpoint. This
could leave MSI-X interrupts broken after resume, and might trigger advanced
error reporting faults.

Does the MSI-X table need a read flush before the command register is
restored?

>  	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720192505.2957=
-1-alifm@linux.ibm.com?part=3D4
