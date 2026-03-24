Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6B920E702;
	Tue, 24 Mar 2026 21:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774388452; cv=none; b=iBnvxTQuQKNVeeqIACGEsTF7md6v0B/mcdCCp9TOCFOtOlCye6M8b7ph0UHyH6nJksc4zDaTy3wCCfDYIAMrDT1QEUWzLy9Hk/T8r6iqC/cdszans8Uw5sAJc2MNTuZ+aQyQ/E/8wXvaacwKuT8tyT6KB8tBv+HrUv5hLgzMXTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774388452; c=relaxed/simple;
	bh=BE5Ka5em6EIlNmLMSknEhfQ/6K4e1oYW9hJDpjKrhbc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Nupudw98f+wfyf7Hzr2r5Dr/QzfA2WCny3Vo+HSXPuRyEi5utHqOUiSLJ2xpPGywDREZRoHREjA82+SmOaMeWlhBw77z4uj4vNIGzH1OLqfAsMthZeVBXJHE/NtvxzPFx8XxT/NJgfkMUAIbXxHFBaZEV6QnHKd5lwJwWPVr4D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anDeqvEr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anDeqvEr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A347C19424;
	Tue, 24 Mar 2026 21:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774388452;
	bh=BE5Ka5em6EIlNmLMSknEhfQ/6K4e1oYW9hJDpjKrhbc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=anDeqvEr6fHcykAnibRONIDcReQH7ozd1lDFtwLX0qkAvI7UPbvRYqIvor/5YgNWl
	 oylQ4ELnjDuzkBVRI4Dc9i4O4mqrV0qkxu17fjumfoTtsU50sMb5TANftjPmiZ1QOk
	 FBPxV7Gqu8qJp2IdYNpx6+G3Y6IkL/Txq177yWlGhdjfOfA9AeYp5F8llMhoIiebv6
	 iW4c5/hwbg77ro3Sbh29U58C5cM2blVDmChZ5uLnWHUyQpqm7y0nMxaeqhExJjNcot
	 Q/TjrB6QDdskRoFJtbVo/oEhnoH3NGhT5zxsfp1MAhuLMZ+gauaFGQVJccHhoq0GaA
	 v3R1kmSzROcSA==
Date: Tue, 24 Mar 2026 16:40:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, lukas@wunner.de, alex@shazbot.org,
	kbusch@kernel.org, clg@redhat.com, stable@vger.kernel.org,
	schnelle@linux.ibm.com, mjrosato@linux.ibm.com
Subject: Re: [PATCH v11 3/9] PCI: Avoid saving config space state if
 inaccessible
Message-ID: <20260324214051.GA1156527@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316191544.2279-4-alifm@linux.ibm.com>

On Mon, Mar 16, 2026 at 12:15:38PM -0700, Farhan Ali wrote:
> The current reset process saves the device's config space state before
> reset and restores it afterward. However errors may occur unexpectedly and
> it may then be impossible to save config space because the device may be
> inaccessible (e.g. DPC) or config space may be corrupted. This results in
> saving corrupted values that get written back to the device during state
> restoration.

This patch only addresses the "inaccessible" part, so I'd drop the
"config space may be corrupted" because we aren't checking for that.

> With a reset we want to recover/restore the device into a functional state.
> So avoid saving the state of the config space when the device config space
> is inaccessible.
> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/pci.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index a93084053537..373421f4b9d8 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5014,6 +5014,7 @@ static void pci_dev_save_and_disable(struct pci_dev *dev)
>  {
>  	const struct pci_error_handlers *err_handler =
>  			dev->driver ? dev->driver->err_handler : NULL;
> +	u32 val;
>  
>  	/*
>  	 * dev->driver->err_handler->reset_prepare() is protected against
> @@ -5033,6 +5034,19 @@ static void pci_dev_save_and_disable(struct pci_dev *dev)
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

Obviously this is still racy because the device may become
inaccessible partway through saving the state, and it might be worth
acknowledging that in the comment.  But I think this is an improvement
over what we do now.

Sashiko complains about this, but I think it's mainly because of that
last sentence of the comment that says "error bits set in Status
register".  This patch has to do with *saving*, not restoring, so I'd
just drop that last sentence.  FWIW, Sashiko said:

  The comment indicates that we should avoid restoring config space
  for a device with error bits set in the Status register, but the
  code only uses PCI_POSSIBLE_ERROR(val).

  Since PCI_POSSIBLE_ERROR() only evaluates whether the entire 32-bit
  value is exactly 0xFFFFFFFF (indicating complete device
  inaccessibility), does this actually check for individual error
  flags in the Status register?

  If a device logs an error but is still accessible, val will reflect
  those bits but will not equal 0xFFFFFFFF, causing the check to
  evaluate to false. Should this code also check specific bits in the
  upper 16 bits of val (such as PCI_STATUS_SIG_SYSTEM_ERROR or
  PCI_STATUS_DETECTED_PARITY) to match the stated intention in the
  comment?

> +		pci_warn(dev, "Device config space inaccessible\n");
> +		return;
> +	}
> +
>  	pci_save_state(dev);
>  	/*
>  	 * Disable the device by clearing the Command register, except for
> -- 
> 2.43.0
> 
