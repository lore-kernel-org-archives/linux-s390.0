Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DA73C1D67;
	Wed, 12 Aug 2026 22:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786572548; cv=none; b=niorNv326KvmdkekvqUzjagQFMNlt2lR6qvieshqt3LoLpWrf4WPRGeupzXwoG8s3sY9CIK0EZBtwtAojyUPtMF0+G+8gdkuBTbXJx0tCZNQSIQhXbps7YwdXyKhlNSWzfR7btC/2g/LhwCLqsLWIj79L+o2JkcJAiMvyKqkdvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786572548; c=relaxed/simple;
	bh=03MvbvnvzBNLrLa4xu46vuDbzIvqzQGtSXdd4LgEXGg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cTn5J6/Yl/gAtw+Gcv0srEU4XDM3+S51GhJuSouoWjJz5uIGTBT9cGPXqObgcM3YaFZITSo7aG3diy0pav0SHyv0cdmrhdYKQxJdpySwfA6mm02DPbBcSO8qkO7nrm7AbCj+QclVIE2WV1O87a5j4RNoap4IaP42AT+Jn2VXLGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nu2RQ1VX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nu2RQ1VX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C031F000E9;
	Wed, 12 Aug 2026 22:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786572546;
	bh=OSbln/3qeDg91fgmUfZRgjhdSPThhEy5DVcuqLs+y8M=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=Nu2RQ1VXIRLlh0PkmxNwvgy7oKENR6LhnsqwDJd/arhlUHr0iK16XC6rJOGn2x0LV
	 eyDg4DKMZpiPocZf/ArMbEgQfLKhJ7MdZ04VHeQqw82fW7Ju4mieeDSFEtyHpgjmbz
	 Rq4/TAXq6L4MjfOMyDmWS8jP1ccG+j7TqwhiPiLPZzlfycQScQjxD4JFwerfUYwG/X
	 OYohIySrOOkcJFC+tDN5+hihwNiTiBxFZANXyj1TlOG1LCSnyH8aS2l2BiMPtzpnaE
	 Ka8Gz/DvBbLeGo5VR49+y7QTURCSKAtbGo90iGMrWar1oeS8uEMiG9PYK4Nfq9l3H+
	 L5jFWWkUURNqA==
Date: Wed, 12 Aug 2026 17:09:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Farhan Ali <alifm@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
	linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v23 5/5] PCI/MSI: Enable memory decoding before restoring
 MSI-X messages
Message-ID: <20260812220905.GA1082162@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260805170759.3432E1F000E9@smtp.kernel.org>

On Wed, Aug 05, 2026 at 05:07:58PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Missing error check on PCI_COMMAND read leads to permanent register corruption and unintended device enablement on transient PCI errors.

This does seem like a possible issue, but we do the same thing all
over the place, including in pci_intx_for_msi() just above. I don't
think checking for ~0 here will significantly reduce the chance of
problems.

> --
> 
> --- Patch [5]: [PATCH v23 5/5] PCI/MSI: Enable memory decoding before restoring MSI-X messages ---
> commit 6d8ddd25b8ed47c23845049339a3c29cd4e53440
> Author: Farhan Ali <alifm@linux.ibm.com>
> 
> PCI/MSI: Enable memory decoding before restoring MSI-X messages
> 
> This commit temporarily enables the Memory bit in the Command register
> before writing MSI-X messages to prevent Unsupported Request errors.
> It then restores the original Command register state afterwards.
> 
> > diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> > index 209373c92e9e1..79c7e84d314b7 100644
> > --- a/drivers/pci/msi/msi.c
> > +++ b/drivers/pci/msi/msi.c
> 
> [ ... ]
> 
> > @@ -879,6 +880,14 @@ void __pci_restore_msix_state(struct pci_dev *dev)
> >  	pci_msix_clear_and_set_ctrl(dev, 0,
> >  				PCI_MSIX_FLAGS_ENABLE | PCI_MSIX_FLAGS_MASKALL);
> >  
> > +	/*
> > +	 * The restored device state may not have Memory decoding enabled
> > +	 * in the Command register. Since the MSI-X was enabled for the
> > +	 * device, enable Memory decoding before restoring MSI-X.
> > +	 */
> > +	pci_read_config_word(dev, PCI_COMMAND, &cmd);
> > +	pci_write_config_word(dev, PCI_COMMAND, cmd | PCI_COMMAND_MEMORY);
> 
> [Severity: High]
> If the device is inaccessible or experiencing a transient error (e.g., an AER
> link reset), can this read fail and set cmd to 0xFFFF?
> 
> Looking at pci_read_config_word(), it uses PCI_SET_ERROR_RESPONSE() on failure:
> 
> int pci_read_config_word(const struct pci_dev *dev, int where, u16 *val)
> {
>         if (pci_dev_is_disconnected(dev)) {
>                 PCI_SET_ERROR_RESPONSE(val);
>                 return PCIBIOS_DEVICE_NOT_FOUND;
>         }
>         ...
> }
> 
> If cmd is set to 0xFFFF, the subsequent pci_write_config_word() will write
> 0xFFFF back to the Command register.
> 
> Does this unintentionally enable all device capabilities, including Bus
> Mastering (which could lead to rogue DMA) and SERR#? 
> 
> Should we check the return value of pci_read_config_word() before writing?
> 
> > +
> >  	write_msg = arch_restore_msi_irqs(dev);
> >  
> >  	scoped_guard (msi_descs_lock, &dev->dev) {
> 
> [ ... ]
> 
> > @@ -889,6 +898,7 @@ void __pci_restore_msix_state(struct pci_dev *dev)
> >  		}
> >  	}
> >  
> > +	pci_write_config_word(dev, PCI_COMMAND, cmd);
> 
> [Severity: High]
> If cmd was populated with the error response 0xFFFF, does this write
> permanently commit the corrupted state back to the device?
> 
> >  	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260805165518.794-1-alifm@linux.ibm.com?part=5
