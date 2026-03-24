Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800372F3C26;
	Tue, 24 Mar 2026 22:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774392578; cv=none; b=d4oYCerbAPHI+PUw1QHPUqFMK/CgTotK2V9vqLLbIQzS4vIqFcs6+/SBynO8NC/8w9U8StlK4c1Fc1OQtnweUTe4VdkZCan4xmdVzTaTSacFiIEsr1GtzBpHHQfX1VH2rTojfGIGpBUO6bfHoQj3uPviZe+V6ix1Ximk4qs/bdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774392578; c=relaxed/simple;
	bh=JW3WSzqzEacKIr5TFoj4Y2bRWpAi138QmuJ67XAY1fs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gX8xljDSI+rX7xfvHI7PCKCDYHYLmOjLfvCtC954JHes/riUjHYonPST1Ggo/DKbx5127OqXKkXFFP2Fw4mw7rN1JNkc3eeThPTpeF+Ai5pBsN0t+ecl29ChKUEnDUBrxKYcgvQxd9YIOS1pF1lHP7qf+maHtMY82WCbCRh2xAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGsc7FOh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGsc7FOh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E038BC19424;
	Tue, 24 Mar 2026 22:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774392578;
	bh=JW3WSzqzEacKIr5TFoj4Y2bRWpAi138QmuJ67XAY1fs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=WGsc7FOhtji9dar4UgVNyHHmaBrGIUm+8NPf0jpN7cmpCshcw1MGvYw9CVTG5GyCO
	 ESvix7VqD/2yIbqDRs3sJ/2rdXcI2d6KjaBAhNBosRsxVENH8D2ACZs/kDB49wj037
	 9svJ2NGQN5q/02EAvG6W0TjNGF2uprs5kZhwAq5W3lyQ5AtZ/2DUPVnrMVtKv+u+KV
	 HueQnCn9R4TIvB9Ntjcd/LOBoUl4NeFpmPwiVh9zlAGOfkR1ofjHXFDvL5KquTQCW4
	 +ASJS54jAN7Wcu7BYEtDJWrhlLQru15ZNgM/0IaMT7lMVD9L2elsWHDE7+/lrR+kP1
	 DsfMYbAOxlhdw==
Date: Tue, 24 Mar 2026 17:49:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, lukas@wunner.de, alex@shazbot.org,
	kbusch@kernel.org, clg@redhat.com, stable@vger.kernel.org,
	schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
	Benjamin Block <bblock@linux.ibm.com>
Subject: Re: [PATCH v11 4/9] PCI: Add additional checks for flr reset
Message-ID: <20260324224936.GA1157694@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316191544.2279-5-alifm@linux.ibm.com>

On Mon, Mar 16, 2026 at 12:15:39PM -0700, Farhan Ali wrote:
> If a device is in an error state, then any reads of device registers can
> return error value. Add additional checks to validate if a device is in an
> error state before doing an flr reset.

s/flr/FLR/ (also in subject)

Also please extend the subject to say something specific about the
"additional checks".  E.g.,

  PCI: Fail FLR when config space inaccessible

> Cc: stable@vger.kernel.org
> Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  drivers/pci/pci.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 373421f4b9d8..8e4d924f4e88 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4371,12 +4371,19 @@ EXPORT_SYMBOL_GPL(pcie_flr);
>   */
>  int pcie_reset_flr(struct pci_dev *dev, bool probe)
>  {
> +	u32 reg;
> +
>  	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
>  		return -ENOTTY;
>  
>  	if (!(dev->devcap & PCI_EXP_DEVCAP_FLR))
>  		return -ENOTTY;
>  
> +	if (pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &reg)) {
> +		pci_warn(dev, "Device unable to do an FLR\n");
> +		return -ENOTTY;
> +	}

I guess the point of this is to detect devices that are inaccessible?
The same sort of thing as in pci_dev_save_and_disable() from patch
3/9?  But we use "dev->error_state == pci_channel_io_perm_failure"
instead?

No matter what we do, this has the same race as in patch 3/9.  And I
think using dev->error_state also depends on AER being enabled, which
cuts out many PCIe devices.

I think using the same exact code as in pci_dev_save_and_disable()
would be more straightforward.  And also the same sort of wording in
the message, e.g., "Device config space inaccessible; unable to FLR"
or similar.  I foresee many of these messages in my future, and it
will be helpful to have a specific clue about why FLR failed :)

>  	if (probe)
>  		return 0;
>  
> -- 
> 2.43.0
> 
