Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646D3318EF4;
	Tue, 23 Jun 2026 21:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782248871; cv=none; b=WjnNFIHZaEQmcfaBhzyaGFvxGbtkGJztSsLkpyo83lOjuVYAxw+Zu5PXqoJIcB0XOLQ7E9kXkEt50tdaC7644KBbZIjAQBxqQa8TiHgkZElNXLgtrIpqHQCIg3iMzvB8Bcxj4ikLy3rFRf100Og38d6YIYGM3ebbDs/lzWy1/yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782248871; c=relaxed/simple;
	bh=ZCJjbND+dvUmLYpAsQCf6dCnLt3RXg/Mb9eZMJ1NaOE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LfO1Z/rCEAHA/lq/341Ei23+Hw9K6LDSUoudLuMFjnQRcTEYGrjKdwkV6NYiyFIPav4quXHtCo/wF0dujbcmdFpW4jZFoyOzO06jh3q5gdrOZE+CaiSM3EUxIW18HkeboDatMvTs6ctOHZIFRIiMZrIWXSlXVNbCNPVix/ZC2TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=TQWvkV3G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YdHyxiOC; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="TQWvkV3G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YdHyxiOC"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 3CFD7EC01F0;
	Tue, 23 Jun 2026 17:07:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 23 Jun 2026 17:07:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1782248867;
	 x=1782335267; bh=i9k4FWXWjlm74Pk++H3eS7qVTwnxuUxoRDpdwNetvfE=; b=
	TQWvkV3Gb1Q5xGZLgU5+I/A74Ylbb0g6sYs1Fb0KOvxJfsDsRdJgcNVOqtZkvSCI
	aUlk3FlVV9VmKdqVE0Y2PLewfnkqlhQ/wa0mxnez6Wk0b1ioSiHB7EfLWU2FBVRQ
	LDESdUFBxVgeK9oclFS0lD1YGyoDeabvzDeYCE2HScW4CSUqak4KbN5xP9xUdVNF
	PeHt+qeJQ30yRZl+8wqc/QdoXrv+fyLjwma6ffEAGTwlUdh1EWYoFBLR+9kbeemC
	UOUYC5qncWCuOWFMT537kSmV+jC9jQkmRLbxV+5tKZd99KFaHQhfmfGmIWEFgBlx
	i5D2hXPLobEUXgWhURl6fA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782248867; x=
	1782335267; bh=i9k4FWXWjlm74Pk++H3eS7qVTwnxuUxoRDpdwNetvfE=; b=Y
	dHyxiOCyv4plMXUEXAB98fCUnIeq1SU+AR2M5jhPGO/XVzlu8Iihc+s+/ggHqC58
	P8hrxDZB6LUkzJsizErY/70K1yQ0khcpaoY0zjIfQH2ttJsaOUVEZfkej3tDdFbJ
	eNAotRaUOmDBYvqdcYvjH6nV0gvLcvRP36BNHLf+Dt2NYKHKxZUcMnreYlPbgMgf
	ZwvrwOJw+nl9dO3yNWYrj4rWNaWgfcMfcAr0zx0p6j+llTmyv5kgIlfF3hnivsVc
	Q7QtuYgQMZ1QbihLlY+u+S2rs3fac0f4iwUGlNhpf/h2iCZeG8/7NIz5eLQ6dc6b
	dt8i7RBTo4fVeRhu6DPiQ==
X-ME-Sender: <xms:ovU6as_N4Zx84PcIOIHU0H_HBduaed9KBeOuReNmdo559EGjPMxhJQ>
    <xme:ovU6alJRgvkPwLYZISxmsa5BOPJqHezbU9UmEYfyG9riCkKMCQARFhNaAnNDOiYXB
    K2jP1y573KvfaifZVfu9wvRjLR5bpfEjfafuRS-gzPnJy7DTlfvQA>
X-ME-Received: <xmr:ovU6aitIKy5NYBM1hyYPhQIYHq9A4pkvO_NCM4wIJRDqsV48_aXfLv3Xslc>
X-ME-Proxy-Cause: dmFkZTE2Ji8K3Uq/U6mVv0pnHsogV0ANNJB9Qkj3z3aNP2l75MUuxlv3Q6TPJsfBcHHXfL
    0lzXAFqDxZsEgk2klQwpsuhevo9JaIU2EZbEUzfLaxx8NbW+ANfbx7db1kH+lofVY1ESl5
    UOjmKnfDfEb2QrKVtE2br+IvP9nRF5yKnvoyBS08/Nw7EmzsLsRiYi3icyKhKTzxTuxILz
    DQ2xsFYmy8FHRROZt0zBN+yUyZdVu0kXUyaGUdfzZgkHjX+d7lnURJY55rvhQDl+j9Ir2u
    R3tOlTqMSsQipCpD77qNF0o0DGJnKHaZiyVGPvff+woM8WknFxZh9Jq+PBkqkMVWPTTGtc
    hASojoFOfwLazj4NCRIPFJEx1rP0Ewx8F4Y4oiKtjwcRGSxFshqpBmyEZdyJphV8G8NQql
    dT2ZADLi3dFX9mXGAlzpv4kvGRK4XCFeswDFizxUuHjKRs6tvXNifLdR7jW3/BVCRVBFTO
    GZg0aW29+iGy9m449LdX9UEEJOeMKy8rRzqpRD3hPkX/kzEKcbMFn1ptzQrLyjUR6kLZbw
    vHLB4Z7bty1LEbtDXaJXhZTUYTrXlRX9a/KGp070AztZ05fpDKfgx6g5sAFvKk7pZujr7r
    tKzD20b+DkvCMugFRcLFiW735nx023NpQrf++fuXM9bglef30sx3wKrDvexw
X-ME-Proxy: <xmx:ovU6akBDtNSFvMX7RH7gecE0vDPEKAPwrnXsjp7mjW1SXF9KAuvw9A>
    <xmx:ovU6aiNb0ndPTvJrxLMI4p0FIcthKasvsPvX1z5eMSb4d6RCzybJgA>
    <xmx:ovU6akBBK5E0FYlAV-CT1x1LZW00McI5cFFW6yL_pWIkjhKg2BKSZA>
    <xmx:ovU6aj4gKK-AARVmNDgPCvZr8OjARM5HOxj2-wEt7_rMya5_ye5kmA>
    <xmx:o_U6aq0h_oafBmO7ta2xg-_whaYEV734yClxaVPgs1190CK60dkwpjBV>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jun 2026 17:07:46 -0400 (EDT)
Date: Tue, 23 Jun 2026 15:07:44 -0600
From: Alex Williamson <alex@shazbot.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, helgaas@kernel.org, schnelle@linux.ibm.com,
 mjrosato@linux.ibm.com, alex@shazbot.org
Subject: Re: [PATCH v19 2/3] vfio-pci/zdev: Add a device feature for error
 information
Message-ID: <20260623150744.08177808@shazbot.org>
In-Reply-To: <20260615183616.2902-3-alifm@linux.ibm.com>
References: <20260615183616.2902-1-alifm@linux.ibm.com>
	<20260615183616.2902-3-alifm@linux.ibm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jun 2026 11:36:15 -0700
Farhan Ali <alifm@linux.ibm.com> wrote:

> For zPCI devices, we have platform specific error information. The platform
> firmware provides this error information to the operating system in an
> architecture specific mechanism. To enable recovery from userspace for
> these devices, we want to expose this error information to userspace. Add a
> new device feature to expose this information.
> 
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  arch/s390/include/asm/pci.h      |  2 ++
>  arch/s390/pci/pci_event.c        | 19 ++++++++++++++
>  drivers/vfio/pci/vfio_pci_core.c |  2 ++
>  drivers/vfio/pci/vfio_pci_priv.h |  9 +++++++
>  drivers/vfio/pci/vfio_pci_zdev.c | 43 ++++++++++++++++++++++++++++++++
>  include/uapi/linux/vfio.h        | 30 ++++++++++++++++++++++
>  6 files changed, 105 insertions(+)
> 
> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
> index 016386f7ef4a..88a125b92bdd 100644
> --- a/arch/s390/include/asm/pci.h
> +++ b/arch/s390/include/asm/pci.h
> @@ -364,6 +364,8 @@ int zpci_clear_error_state(struct zpci_dev *zdev);
>  int zpci_reset_load_store_blocked(struct zpci_dev *zdev);
>  void zpci_start_mediated_recovery(struct zpci_dev *zdev);
>  void zpci_stop_mediated_recovery(struct zpci_dev *zdev);
> +int zpci_get_pending_error(struct zpci_dev *zdev,
> +			   struct zpci_ccdf_err *ccdf);
>  
>  #ifdef CONFIG_NUMA
>  
> diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
> index 8934b640a095..3ad16038e005 100644
> --- a/arch/s390/pci/pci_event.c
> +++ b/arch/s390/pci/pci_event.c
> @@ -77,6 +77,25 @@ static int zpci_store_pci_error(struct pci_dev *pdev,
>  	return 0;
>  }
>  
> +int zpci_get_pending_error(struct zpci_dev *zdev,
> +			   struct zpci_ccdf_err *ccdf)
> +{
> +	int head = 0;
> +
> +	guard(mutex)(&zdev->pending_errs_lock);
> +
> +	if (!zdev->pending_errs.count)
> +		return -ENOMSG;
> +
> +	head = zdev->pending_errs.head % ZPCI_ERR_PENDING_MAX;
> +	memcpy(ccdf, &zdev->pending_errs.err[head],
> +	       sizeof(struct zpci_ccdf_err));
> +	zdev->pending_errs.head++;
> +	zdev->pending_errs.count--;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(zpci_get_pending_error);
> +
>  void zpci_start_mediated_recovery(struct zpci_dev *zdev)
>  {
>  	guard(mutex)(&zdev->pending_errs_lock);
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 050e7542952e..27642f10fe97 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1569,6 +1569,8 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
>  		return vfio_pci_core_feature_token(vdev, flags, arg, argsz);
>  	case VFIO_DEVICE_FEATURE_DMA_BUF:
>  		return vfio_pci_core_feature_dma_buf(vdev, flags, arg, argsz);
> +	case VFIO_DEVICE_FEATURE_ZPCI_ERROR:
> +		return vfio_pci_zdev_feature_err(device, flags, arg, argsz);
>  	default:
>  		return -ENOTTY;
>  	}
> diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
> index fca9d0dfac90..4e7162234a2e 100644
> --- a/drivers/vfio/pci/vfio_pci_priv.h
> +++ b/drivers/vfio/pci/vfio_pci_priv.h
> @@ -93,6 +93,8 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
>  				struct vfio_info_cap *caps);
>  int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev);
>  void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev);
> +int vfio_pci_zdev_feature_err(struct vfio_device *device, u32 flags,
> +			      void __user *arg, size_t argsz);
>  #else
>  static inline int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
>  					      struct vfio_info_cap *caps)
> @@ -107,6 +109,13 @@ static inline int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
>  
>  static inline void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev)
>  {}
> +
> +static inline int vfio_pci_zdev_feature_err(struct vfio_device *device,
> +					    u32 flags, void __user *arg,
> +					    size_t argsz)
> +{
> +	return -ENOTTY;
> +}
>  #endif
>  
>  static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
> diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
> index 78a28db00c6d..c0d6362cc4eb 100644
> --- a/drivers/vfio/pci/vfio_pci_zdev.c
> +++ b/drivers/vfio/pci/vfio_pci_zdev.c
> @@ -141,6 +141,49 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
>  	return ret;
>  }
>  
> +int vfio_pci_zdev_feature_err(struct vfio_device *device, u32 flags,
> +			      void __user *arg, size_t argsz)
> +{
> +	struct vfio_device_feature_zpci_err err = {};
> +	struct vfio_pci_core_device *vdev;
> +	struct zpci_ccdf_err ccdf = {};
> +	struct zpci_dev *zdev;
> +	int ret;
> +
> +	vdev = container_of(device, struct vfio_pci_core_device, vdev);
> +	zdev = to_zpci(vdev->pdev);
> +	if (!zdev)
> +		return -ENODEV;
> +
> +	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_GET,
> +				 sizeof(err));
> +	if (ret != 1)
> +		return ret;
> +
> +	ret = zpci_get_pending_error(zdev, &ccdf);
> +	if (ret)
> +		return ret;
> +
> +	err.fh = ccdf.fh;
> +	err.fid = ccdf.fid;
> +	err.ett = ccdf.ett;
> +	err.mvn = ccdf.mvn;
> +	err.dmaas = ccdf.dmaas;
> +	err.q = ccdf.q;
> +	err.rw = ccdf.rw;
> +	err.faddr = ccdf.faddr;
> +	err.pec = ccdf.pec;
> +
> +	if (copy_to_user(arg, &err, sizeof(err))) {
> +		dev_warn_ratelimited(device->dev,
> +				     "Failed to handle PCI error event for PCI function 0x%x",
> +				     zdev->fid);
> +		return -EFAULT;
> +	}
> +
> +	return 0;
> +}
> +
>  int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
>  {
>  	struct zpci_dev *zdev = to_zpci(vdev->pdev);
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 5de618a3a5ee..83c93193b22d 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -1534,6 +1534,36 @@ struct vfio_device_feature_dma_buf {
>   */
>  #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
>  
> +/**
> + * VFIO_DEVICE_FEATURE_ZPCI_ERROR feature provides PCI error information to
> + * userspace for vfio-pci devices on s390. On s390, PCI error recovery
> + * involves platform firmware and notification to operating systems is done
> + * by architecture specific mechanism. Exposing this information to
> + * userspace allows it to take appropriate actions to handle an
> + * error on the device. The ioctl returns -ENOMSG if there are no pending
> + * PCI errors.
> + */
> +
> +struct vfio_device_feature_zpci_err {
> +	__u32 feature_flags;		/* Indicate future features */
> +	__u32 reserved1;
> +	__u32 fh;			/* function handle */
> +	__u32 fid;			/* function id */
> +	__u64 faddr;                    /* failing address */
> +	__u32 ett		:  4;	/* expected table type */
> +	__u32 mvn		: 12;	/* MSI vector number */
> +	__u32 dmaas		:  8;	/* DMA address space */
> +	__u32 reserved2		:  6;
> +	__u32 q			:  1;	/* event qualifier */
> +	__u32 rw		:  1;	/* read/write */
> +	__u32 reserved3;
> +	__u16 reserved4;
> +	__u16 pec;			/* PCI event code */
> +	__u8 reserved5[28];		/* Allow for future expansion */
> +};

In v18 I probed whether this should be passed as opaque data as we're
doing for FMB, which was declined because the user doesn't know the
size.  However, the fmb_length is provided through a device info cap,
where we could extend the existing zpci info cap with a v3 that does
report this fixed size.  That doesn't seem like an insurmountable
barrier.

In the implementation here, we have the worst combination of
trade-offs, reserved fields for some vague notion of future expansion
and bitfields that mimic the architecture specification but don't fit
well into a uAPI as their position is compiler dependent.

This should either fully abandon the architecture layout and create a
well defined, naturally aligned uAPI structure, or extend the zpci info
cap to report the size and pass the error data as opaque.

As Bjorn notes, we're already into the merge window, so this is at best
v7.3 material, and as we've designed the split, merging the vfio
changes will be dependent on a branch provided with the PCI changes.
Thanks,

Alex
