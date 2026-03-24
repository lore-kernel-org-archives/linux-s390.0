Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4546339FD4;
	Tue, 24 Mar 2026 21:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774387564; cv=none; b=rI2jAKE4o0+Dhb4qwQsLBtIbmSYGE2Bahx3ENvgXnUjPclwM/iQPl4sd6HQ0Hdm6GYukymag+kYdS+EWlWVAgvYo0QA4Vq6BLuK5PyIgvti7P1cRiKxTl9Aj2LJyqE5UnVvLBTb4hU1bSGwWxU6iF67+RYWezGTwc+k3APYdum0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774387564; c=relaxed/simple;
	bh=9F+HdKYAmTDumYmQWst3n/3M3OnO4i+ge3gPYW8ub58=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SDKbgAx1KRb4jASutUj8nU0akkH9j+KaVdXpNWMcriQakZHG5Quvj9UA7vHMWTPSEp2fndF+ezUBqkunwN27IAaB6d9ax10ZXDAbQpKfXYSz4FooXpFGNbnJ/nDofuozQK9Ci/6Maw7Vr9s+EjQ8tUIf7zG8GJ/uPlpEGR25kd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aiZ/LQp8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aiZ/LQp8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5EE1C19424;
	Tue, 24 Mar 2026 21:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774387563;
	bh=9F+HdKYAmTDumYmQWst3n/3M3OnO4i+ge3gPYW8ub58=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=aiZ/LQp8twTvdUbwFmpyCVpJzLud7P2PBK/14kNYXL2Nya6CEKMSlEjXUBq/VIaWo
	 AEw9lf7Ovhha2nOt6I54hOM9WkeHdImSH26mnQsQXXLX9SjHDNp7R1IBl09mCpIdat
	 xNv7IRE5Bql6iVIueF0Wc9DV8eQ1dorR4NVh3Ab2rRRhnBQmwa3240swwe3FbueISo
	 ldxn4UU5uKPdLbvv46q2Kig/1gMEzZ1mGaDlIN/pbOd6jut+ZmrUJwoYPN7bLaJqZS
	 wGPz3PRtPzQHbIuAH9D/GRqEHjhYruD1JzJMAHAwdF1yNnSM1EjX9ljmOywoEMvqj6
	 ydWp08aJtPafg==
Date: Tue, 24 Mar 2026 16:26:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, lukas@wunner.de, alex@shazbot.org,
	kbusch@kernel.org, clg@redhat.com, stable@vger.kernel.org,
	schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
	Julian Ruess <julianr@linux.ibm.com>
Subject: Re: [PATCH v11 9/9] vfio: Remove the pcie check for
 VFIO_PCI_ERR_IRQ_INDEX
Message-ID: <20260324212602.GA1151826@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316191544.2279-10-alifm@linux.ibm.com>

On Mon, Mar 16, 2026 at 12:15:44PM -0700, Farhan Ali wrote:
> We are configuring the error signaling on the vast majority of devices and

Who is "we"?  If a function configures error signaling, can you
mention the name?

> it's extremely rare that it fires anyway. This allows userspace to
> be notified on errors for legacy PCI devices. The Internal Shared
> Memory (ISM) device on s390 is one such device. 

This commit log talks about things that could be done, but doesn't
actually say what the patch does or what makes it safe and effective,
and I'm not VFIO-literate enough for it to be clear.

These pci_is_pcie() tests were added by dad9f8972e04 ("VFIO-AER:
Vfio-pci driver changes for supporting AER"), so I suppose the
dad9f8972e04 assumption was that AER was the only error reporting
mechanism, and AER only exists on PCIe devices?

But s390 can report errors for conventional PCI devices, and you want
VFIO to support that as well?

Obviously this change needs to be safe for all arches, not just s390.
I suppose it's safe to report the VFIO_PCI_ERR_IRQ_INDEX info
everywhere; it's just that it will never be used except on s390?  And
I guess powerpc, which can get to vfio_pci_core_aer_err_detected() via
eeh_report_failure().

It looks like vfio_pci_driver provides vfio_pci_core_err_handlers
whether the device is conventional PCI or PCIe, and s390 can already
call vfio_pci_core_aer_err_detected() (the .error_detected() hook) via
zpci_event_notify_error_detected(), so this patch makes it possible
for the guest (QEMU, etc) to learn about it?

> For PCI devices on IBM s390 error
> recovery involves platform firmware and notification to operating system
> is done by architecture specific way. So the ISM device can still be
> recovered when notified of an error.

I guess this error recovery part would be done by the guest ISM
driver, triggered when when something like QEMU receives the eventfd
signal from vfio_pci_core_aer_err_detected()?

> Reviewed-by: Julian Ruess <julianr@linux.ibm.com>
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>

I don't maintain VFIO, so I'm just kibbitzing here.  Hopefully Alex
will chime in.

> ---
>  drivers/vfio/pci/vfio_pci_core.c  | 8 ++------
>  drivers/vfio/pci/vfio_pci_intrs.c | 3 +--
>  2 files changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index f1bd1266b88f..cfd9a51cd194 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -786,8 +786,7 @@ static int vfio_pci_get_irq_count(struct vfio_pci_core_device *vdev, int irq_typ
>  			return (flags & PCI_MSIX_FLAGS_QSIZE) + 1;
>  		}
>  	} else if (irq_type == VFIO_PCI_ERR_IRQ_INDEX) {
> -		if (pci_is_pcie(vdev->pdev))
> -			return 1;
> +		return 1;
>  	} else if (irq_type == VFIO_PCI_REQ_IRQ_INDEX) {
>  		return 1;
>  	}
> @@ -1163,11 +1162,8 @@ static int vfio_pci_ioctl_get_irq_info(struct vfio_pci_core_device *vdev,
>  	switch (info.index) {
>  	case VFIO_PCI_INTX_IRQ_INDEX ... VFIO_PCI_MSIX_IRQ_INDEX:
>  	case VFIO_PCI_REQ_IRQ_INDEX:
> -		break;
>  	case VFIO_PCI_ERR_IRQ_INDEX:
> -		if (pci_is_pcie(vdev->pdev))
> -			break;
> -		fallthrough;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
> index 33944d4d9dc4..64f80f64ff57 100644
> --- a/drivers/vfio/pci/vfio_pci_intrs.c
> +++ b/drivers/vfio/pci/vfio_pci_intrs.c
> @@ -859,8 +859,7 @@ int vfio_pci_set_irqs_ioctl(struct vfio_pci_core_device *vdev, uint32_t flags,
>  	case VFIO_PCI_ERR_IRQ_INDEX:
>  		switch (flags & VFIO_IRQ_SET_ACTION_TYPE_MASK) {
>  		case VFIO_IRQ_SET_ACTION_TRIGGER:
> -			if (pci_is_pcie(vdev->pdev))
> -				func = vfio_pci_set_err_trigger;
> +			func = vfio_pci_set_err_trigger;
>  			break;
>  		}
>  		break;
> -- 
> 2.43.0
> 
