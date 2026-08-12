Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E053C1D67;
	Wed, 12 Aug 2026 22:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786572442; cv=none; b=juVuGj9bRaIODSAisv1c0ieqprrHOqjEyyOBzhNFTVI0sz/5r24MjpDiqGdIFn4Caqb5/TjRmtn9AA7F0snhE/Xehk7rwDXXhA89GxXgIrgfDw7SZT1Ea0C+mdlBY41kvawsbKzsXNV0lp3A1CnhHBBWZ4D5oe04Flg/NDgfRsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786572442; c=relaxed/simple;
	bh=l95Clo9hj4mcMnhqd2g2Nsw0dU9m4xoF9S/M9G0cVGM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ll4JH+d+s0hSRd/BtULnyMvo77blEo3Z3G51cJFG/Ua/dyzGMCnLxhT5di+u+ucYKOp9HJqSqx0VuGj7PI8+sRcJFFoSCKuDdjiLJWPXdz9HoSFzQKdouWgnslftD/LoyRlm2Dc3EbQKsNBmWeEzY4x83jfs//x480WrsGYnGUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRaMc12P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRaMc12P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626201F000E9;
	Wed, 12 Aug 2026 22:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786572440;
	bh=ZLrKVoqQnfL9meWolsnQROS2DkboL75b56U6Y67katw=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=aRaMc12Ps5Nd0XmGoUu0PiLzPVCg5LgVTyv3CfxgtoD9LmzARFkRHBR5RRX0XPHDy
	 fyYDZXo/zHMU0GUKhruuDUifYF+jStw/bXbuRpDTZbEAOVYqhzs70RNs6tO+f1U0H1
	 eaNmTy7krNsYB6ztD78M0cnZqTogJu1Baas71dJQJuUYhmoUdxRPMqgRpzKzmzJ7qu
	 kf0djZP4TiMLVJcf5Uk5HcABL8UHewR1oi9v7Yhko5n4/zOpwtAaRtaIppkMYZREf7
	 iWbXnTUQM8lBAYsGqgnCaPR4PhmZ/eqg73SnmOUb1E99Iz5uHnpYmWELgceKnV71lN
	 +AqXIo7FIu1kA==
Date: Wed, 12 Aug 2026 17:07:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, alex@shazbot.org, schnelle@linux.ibm.com,
	mjrosato@linux.ibm.com, stable@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH v23 5/5] PCI/MSI: Enable memory decoding before restoring
 MSI-X messages
Message-ID: <20260812220719.GA1079019@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805165518.794-6-alifm@linux.ibm.com>

On Wed, Aug 05, 2026 at 09:55:18AM -0700, Farhan Ali wrote:
> The current MSI-X restoration path assumes the Command register Memory bit
> is enabled when writing MSI-X messages. But it's possible the last saved
> and restored state of a device may not have the Memory bit enabled, even if
> a device driver later enables Memory bit and MSI-X. Attempting to access
> Memory space without Memory bit enabled can lead to Unsupported Request
> (UR) from the device. Fix this by enabling Memory bit and restore it
> afterwards.
> 
> Fixes: 41017f0cac92 ("[PATCH] PCI: MSI(X) save/restore for suspend/resume")
> Cc: stable@vger.kernel.org
> Reviewed-by: Thomas Gleixner <tglx@kernel.org>
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  drivers/pci/msi/msi.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index 209373c92e9e..79c7e84d314b 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -870,6 +870,7 @@ void __pci_restore_msix_state(struct pci_dev *dev)
>  {
>  	struct msi_desc *entry;
>  	bool write_msg;
> +	u16 cmd;
>  
>  	if (!dev->msix_enabled)
>  		return;
> @@ -879,6 +880,14 @@ void __pci_restore_msix_state(struct pci_dev *dev)
>  	pci_msix_clear_and_set_ctrl(dev, 0,
>  				PCI_MSIX_FLAGS_ENABLE | PCI_MSIX_FLAGS_MASKALL);
>  
> +	/*
> +	 * The restored device state may not have Memory decoding enabled
> +	 * in the Command register. Since the MSI-X was enabled for the
> +	 * device, enable Memory decoding before restoring MSI-X.

PCI_COMMAND_MEMORY must be set because the MSI-X Table and PBA are in
Memory space (in a BAR), right?  I think a more direct way of saying
this would be:

  * The restored device state may not have Memory Space enabled.
  * Since the MSI-X Table and PBA are in Memory Space, enable it
  * while restoring them.

> +	 */
> +	pci_read_config_word(dev, PCI_COMMAND, &cmd);
> +	pci_write_config_word(dev, PCI_COMMAND, cmd | PCI_COMMAND_MEMORY);
> +
>  	write_msg = arch_restore_msi_irqs(dev);
>  
>  	scoped_guard (msi_descs_lock, &dev->dev) {
> @@ -889,6 +898,7 @@ void __pci_restore_msix_state(struct pci_dev *dev)
>  		}
>  	}
>  
> +	pci_write_config_word(dev, PCI_COMMAND, cmd);
>  	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
>  }
>  
> -- 
> 2.43.0
> 
