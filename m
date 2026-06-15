Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42210399368;
	Mon, 15 Jun 2026 18:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781549331; cv=none; b=JzATSoD+AGxQyBpaoV9offtrK6gGTvo7gLNwWtDgpVGaU9lDOfGAp1q9tCJC2/scmzpp9rdZzs+DSKGNIEB/3vH8vFntBFKwjFe6PN3QPlXabf3d0OKXxxIBbMtBksxoM4wVMZfadmmrFLmrgdVg3Shrjj/Jw7sIoDz+34uuhw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781549331; c=relaxed/simple;
	bh=PBUTLLCtnem5Gj/IBSDYbY/9ANonosMPRnVTNw1Qnfs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sb3tA/mncrG/M0tEdIgDrN9+VXdxLbYtmxHTfpaXeuQBd7+qt7qlhTTEv1FUvBAw+2hX2n/3Z4zYJWUx0ZcpRDhjvC8CO1G/OrDXiSfjOA7CqjbRFiXburIt7PTbgO64aAkQODlDz7S6zyOgJQGXrlOhJEfydjXQaEPZUG1Rtxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccD/Men1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccD/Men1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 918991F000E9;
	Mon, 15 Jun 2026 18:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781549329;
	bh=9RDiCNH3QPbkX8+roLmCTTe6vPnJcWf2ckWnzmSQHLU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ccD/Men1vo8AeGttARiq1qnJdhES/QDRxl43xvWzquW5siGyqkU4mXpvNaKTuDRTS
	 aW+liDqhh01kSpEIKW1poODMZqInzGGibj2EkHE+aEGi95kENJYNf/GYY7HxCzJOX6
	 JlJhGgvXtRx26sFGVpUCWnXXBlDp1rOqfJ4ItZB9BpzSOWCR5HkMfvTeW9dGKNQbT5
	 pDAl1ClvNxX30YYwoCfUWSM/RdwzaG/9TGz5j8VcbOLYZjffD5zBkM80GyowXuEq9H
	 xOkwGOps4QOOSdOtvbjzXMoxN89nFLuMGqYuxubeG8Im1OsV2WBLSC6R3VeGTy38oI
	 XP7uBPqyYjCjA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 4/4] PCI/MSI: Enable memory decoding before
 restoring MSI-X messages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-pci@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260615183524.2880-5-alifm@linux.ibm.com>
References: <20260615183524.2880-5-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 18:48:49 +0000
Message-Id: <20260615184849.918991F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Unvalidated PCI_COMMAND read can result in writing 0xFFFF back to =
the device, enabling fatal error reporting.
- [High] Blind restoration of PCI_COMMAND register clobbers concurrent modi=
fications across the locked section (TOCTOU race).

Pre-existing issues:
- [High] Conditional enablement of PCI_COMMAND_MEMORY leaves pci_msix_write=
_vector_ctrl() exposed to Unsupported Request (UR) faults.
--

commit 9bf79a22431c8153c5aed81ed2a19f276bfd3940
Author: Farhan Ali <alifm@linux.ibm.com>

PCI/MSI: Enable memory decoding before restoring MSI-X messages

This commit attempts to fix Unsupported Request (UR) faults during MSI-X=20
restoration by temporarily enabling the Memory bit in the Command register=
=20
when writing MSI-X messages. The bit is enabled prior to restoration and=20
restored to its previous state afterwards.

> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index 81d24a270a795..d8d3c8a911ac0 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -874,6 +874,7 @@ void __pci_restore_msix_state(struct pci_dev *dev)
>  {
>  	struct msi_desc *entry;
>  	bool write_msg;
> +	u16 cmd;
> =20
>  	if (!dev->msix_enabled)
>  		return;

[ ... ]

> @@ -884,6 +885,11 @@ void __pci_restore_msix_state(struct pci_dev *dev)
>  				PCI_MSIX_FLAGS_ENABLE | PCI_MSIX_FLAGS_MASKALL);
> =20
>  	write_msg =3D arch_restore_msi_irqs(dev);
> +	if (write_msg) {
> +		pci_read_config_word(dev, PCI_COMMAND, &cmd);
> +		pci_write_config_word(dev, PCI_COMMAND,
> +				      cmd | PCI_COMMAND_MEMORY);
> +	}

[Severity: High]
Does pci_read_config_word() need its return value checked here?

If the read fails (e.g., due to a transient bus error or recovery state), t=
he
PCI subsystem populates cmd with 0xFFFF (PCI_ERROR_RESPONSE). Computing
cmd | PCI_COMMAND_MEMORY would then write 0xFFFF back to the Command Regist=
er,
enabling all writable capabilities at once (including SERR# Enable), which
could trigger a fatal NMI or system panic.

>  	scoped_guard (msi_descs_lock, &dev->dev) {
>  		msi_for_each_desc(entry, &dev->dev, MSI_DESC_ALL) {
>  			if (write_msg)
>  				__pci_write_msi_msg(entry, &entry->msg);
>  			pci_msix_write_vector_ctrl(entry, entry->pci.msix_ctrl);

[Severity: High]
This is a pre-existing issue, but does this code leave the MSI-X table
exposed to the very Unsupported Request (UR) faults this patch tries to fix?

Since pci_msix_write_vector_ctrl() performs an MMIO write to the MSI-X
Vector Control register unconditionally for every MSI descriptor, what
happens if write_msg is false? The memory decoding bit won't be enabled
above, meaning this unconditional MMIO access could still trigger a UR faul=
t.

>  		}
>  	}
> =20
> +	if (write_msg)
> +		pci_write_config_word(dev, PCI_COMMAND, cmd);
> +

[Severity: High]
Can this blindly overwrite the PCI_COMMAND register with a stale snapshot?

The cmd value was read before the scoped_guard() block. If concurrent
operations modify PCI_COMMAND (such as changing PCI_COMMAND_MASTER or
PCI_COMMAND_INTX_DISABLE via sysfs or other subsystem operations) while
the lock is held, rewriting the old cmd value here would wipe out those
concurrent changes.

Should we re-read the register here, mask out PCI_COMMAND_MEMORY if we
enabled it, and only restore that specific bit?

>  	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615183524.2880=
-1-alifm@linux.ibm.com?part=3D4
