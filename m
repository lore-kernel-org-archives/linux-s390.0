Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42CB1E7C34;
	Sat,  7 Feb 2026 00:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770424778; cv=none; b=LKy/1NUU43D0/Hl4TrMQ5OsvdCkNI4Zw8rH+6baukbCa2D55p6IPCNoOe0Mrb7UAwyGrIYqGW+45J7XA9ID/xQ31SXQtHSzQqNUlT42vMwG9UCsyXtiCHNyvGLbcfLDMxNMWirsUyY8Ys7w3lMINVEamXkI/3bqd2/4kP4OF1ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770424778; c=relaxed/simple;
	bh=85XLBK9aXy3xZ4AEZ2jM/Bv0nLnUq4J1knGqiDExiag=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kHw/qG8lfN441Rcfj7b1Ah54/945KamHqejWAWiQVs5FXAqn++SscEvthzMvVCteZTQZvVNvx2JdoHApogk83UBj0J8D3FnrWYTmkUWv3XWUOkcr9kgdLsIF5CFxYbeYPKThBdfUcFreHpe0KoWphqSlTROj/CIFgZFICLasYNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLX/np+P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLX/np+P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264CEC116C6;
	Sat,  7 Feb 2026 00:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770424778;
	bh=85XLBK9aXy3xZ4AEZ2jM/Bv0nLnUq4J1knGqiDExiag=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZLX/np+PkZ8A2ZDFqQEOoGgyaGXRRpY1dWZdUoeTzBBSg0MHOEEwnq2+rYfSz+qpv
	 knbVu1r3bfcS2OkCrkqoAnoTdcDbbt7XaoBhZ1oWhjBurRb76qm4M1Hv3doWZVuWH8
	 2R/eSz5BjmtQp2NSMO2amRhL3S2myKx/8r94oTZuI/3e6ChdQbjKyxt2vpPrH5Ftxn
	 8eFwKn6Gv2m1VPvVyLPSjjTOka4brkGYkXHBTPBUcMbgId5jrp6ySkuQRTPv6V4FuL
	 N6jQx+T41YmNOehezbZran68uDw/BUAvOoYcHclj3uUlC/AuhsnH6sZHJuK/oZB8Ot
	 YdJU2YOdQhEfw==
Date: Fri, 6 Feb 2026 18:39:36 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, lukas@wunner.de, alex@shazbot.org,
	clg@redhat.com, stable@vger.kernel.org, schnelle@linux.ibm.com,
	mjrosato@linux.ibm.com, julianr@linux.ibm.com
Subject: Re: [PATCH v8 3/9] PCI: Avoid saving config space state if
 inaccessible
Message-ID: <20260207003936.GA112515@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122194437.1903-4-alifm@linux.ibm.com>

On Thu, Jan 22, 2026 at 11:44:31AM -0800, Farhan Ali wrote:
> The current reset process saves the device's config space state before
> reset and restores it afterward. However errors may occur unexpectedly and
> it may then be impossible to save config space because the device may be
> inaccessible (e.g. DPC) or config space may be corrupted. This results in
> saving corrupted values that get written back to the device during state
> restoration.
> 
> With a reset we want to recover/restore the device into a functional state.
> So avoid saving the state of the config space when the device config space
> is inaccessible.
> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  drivers/pci/pci.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index c105e285cff8..e7beaf1f65a7 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4960,6 +4960,7 @@ EXPORT_SYMBOL_GPL(pci_dev_unlock);
>  
>  static void pci_dev_save_and_disable(struct pci_dev *dev)
>  {
> +	u32 val;
>  	const struct pci_error_handlers *err_handler =
>  			dev->driver ? dev->driver->err_handler : NULL;
>  
> @@ -4980,6 +4981,19 @@ static void pci_dev_save_and_disable(struct pci_dev *dev)
>  	 */
>  	pci_set_power_state(dev, PCI_D0);
>  
> +	/*
> +	 * If device's config space is inaccessible it can return ~0 for
> +	 * any reads. Since VFs can also return ~0 for Device and Vendor ID
> +	 * check Command and Status registers. At the very least we should
> +	 * avoid restoring config space for device with error bits set in
> +	 * Status register.
> +	 */
> +	pci_read_config_dword(dev, PCI_COMMAND, &val);
> +	if (PCI_POSSIBLE_ERROR(val)) {
> +		pci_warn(dev, "Device config space inaccessible\n");
> +		return;
> +	}

This seems related to Lukas' recent patches:

  a2f1e22390ac ("PCI/ERR: Ensure error recoverability at all times")
  5e09895b4063 ("Documentation: PCI: Amend error recovery doc with pci_save_state() rules")

My poor understanding is that the PCI core now saves config space for
every device at enumeration time, and if a driver wants to capture an
updated config space after it has changed things, it is responsible
for doing that explicitly.

a2f1e22390ac gives us a baseline saved state that will be restored in
some cases.  This pci_dev_save_and_disable() is part of the reset path
and saves a potentially different state.  I'm a little uncomfortable
about the fact that we save the state at different times, including
unpredictable times after an error, and I'm not sure the driver can
always know what gets restored.

Maybe the reset path shouldn't even try to save config space again,
since we're now guaranteed to have at least the state from
enumeration?  I suppose skipping the save here would expose cases
where the driver changed config space without doing a pci_save_state()
itself, and a driver- or sysfs-initiated reset would lose that change,
whereas today we preserve it because we save/restore as part of that
reset.

That change would also be lost if the reset was unintentional, e.g.,
during error recovery, but I guess in that case the driver does know
that an error occurred, so it could redo the change.

It seems like the ideal thing would be if every restore used the
enumeration saved-state or the driver's intentional saved-state, never
a state saved at the unpredictable time of an error recovery reset.

I hope Lukas and Alex can chime in here.

>  	pci_save_state(dev);
>  	/*
>  	 * Disable the device by clearing the Command register, except for
> -- 
> 2.43.0
> 
