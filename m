Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C397014A619;
	Tue,  2 Jun 2026 20:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780432329; cv=none; b=jUjJ1H2l+84mzXismqNVkROCoFm+ZL/Iy//GCAMx9KV3IR/uoT//rsTlxBzUZelKiukiU0fPPUmPe0gDqZuApHFo/1PhbiGP3s3IhMM0Ck37PSoOM2JFkkNxz2o90eDRi63ug9ACp7OiLKnXMjL4RPPCn5xlWjGzlMhYOz8sm3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780432329; c=relaxed/simple;
	bh=XriJpakl3eeNtBAmRCwuqsAe3EytmLDNQD88oqSmE5A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q3wx649uVk+o3GXRnZeoO83SNg8hBu0kN7KTUknOFkgxXzRIV3BDNYoHLm9rQmPBOGcaYjB1bQuxa3UCAOlaI0J8Xbad0UsQEAotwlzJgLHvJRIQG9q8Li+StW9NYHB1zliYxd+DRXx6gwrM9bKYTnkPszwnedUK2yZrqwgdwIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=TGQ4H+ge; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QmrlAI98; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="TGQ4H+ge";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QmrlAI98"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 5A9E31D000B1;
	Tue,  2 Jun 2026 16:32:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 02 Jun 2026 16:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1780432325;
	 x=1780518725; bh=S/7ObgL4kdORe1WMDW9bBxpxZCDDMLrxGhBZJcH1Ckg=; b=
	TGQ4H+ge3y2NRLD63TU8FyTT7GTbnz+TWa5sRmmtx5Z36fLVa07jYKQa7HZIdqib
	Wtd5vrzEEgzDYIAIO8Umzu2Q1WfVudJc99QZwJSHmEmQNUw2vJ72IjCNf7mAI9yz
	1cLEKww3di3h7RAbo5ltZYM+u79Bdhbw1uUEoUbG6PNLBrdFyOLeBx45UveeRP9a
	p4OZg1FAk0FLRR1sKYG1fScRPYg6I4EdSQUtIBAw28unDStrfZ7ANPfpp79mcUEg
	jBoArnYeNl2RwDLb86M7LI38TqWQLP6ONO4wn8jmSJ4Sg9tvZ/wqAG+qODmERSTr
	MFPjhWtl7pBg3gnQfWeLuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780432325; x=
	1780518725; bh=S/7ObgL4kdORe1WMDW9bBxpxZCDDMLrxGhBZJcH1Ckg=; b=Q
	mrlAI98Ge+WIYczsbpfB3938rO9sHiZKDEkFgmW17DD00fjmcRmWNlzYNTp11ygL
	6nYRcf5RDX1YyvMsXdcP1smUIEYjoAnzhx+f5HfqpsUBtuPjkVaqroHfTVRVU9XQ
	2OlXggxZPmdipBiJ3PrPTaw4HBg0Vw8Afz/p6awov9qsw7qwYMZQ/7Jewmq0nDA9
	HQOaQ6KzFYis/nqZPi7ANvzzexkUsN1CcKyeCZMfXvmVKcIWzH25OpxUs4pTV6m7
	2Hwk/shgjvw+S8MZ8pn1xSTuUzZnP/uTJ2TCNuXMuG1xLTexn1OpymxLAeaYLz4b
	PDkCBaoQM+KQrmgvnI0hw==
X-ME-Sender: <xms:xD0fajvq3hC6uGZzoltDUU87IAu-KFYUwb7mutTuDAEj2bZtpNaocg>
    <xme:xD0fak5zYJ-NMBEgh_vjS6J_y9xR1zlctcEXj0Bt7eUMHic8bDBN-JA343vvOK8au
    dUHXihty-309BPlKorMM0DSDL-64Ahc8V-bdKM7Q7S5MiBz13187w>
X-ME-Received: <xmr:xD0fancomDwSix8KUsJMSt3GJRg5ikck8aWy5iSv4D_7HSjfo1dKaQyOM1k>
X-ME-Proxy-Cause: dmFkZTFmhR1UEdp+RegDlkR7XrCRU2o0u1DxFjG4SCp4OPPUEvLbEqK+6NiWQcHXxQBjd9
    x3uFHlb8TCsLu2tjN0LNDa1C0isKbNZiV+dB/21oFmEY8i0/gWtFKBqCSvJM4sisZtFGc3
    BK4QBCF+j2XizZbPzmpOPDDChjxNHJu0lcADdI6EiVdNNBW8UdX3JLCXikXo685iEqS81j
    C0lCT3W5hSutEkfAI88akBKEnKdf8cYGqqYNBtE/DeOsJELJygl/ZoYPu5s1ILvDz1TMo2
    1jChlh0c7IydsvfjZ8wLuiXneKiy1abOKaf4Se4v6BFTgBuezfMrC2P4jHouu0NSx6QDMs
    P96V/fr0o+pBafJELp1ceIC0WWTgKdbKTdvbIqW2m1xmhOtVN+u65rqPhsyWqBc1VHF3CF
    Fy+eipdFMuhNwzsxVaZsxWzfqeVA6ODjMFLAshMpF9u1pCbGmgiYYyFAb/DvCnJ9SkRttf
    JHqUlT/qLogUaIxDpx/QMT73uIDGMBm+Bk+P7FvRy7FnktByDLTuM3CVvbjKjmXZQQEbQL
    zHCXrpRCE/ybLErZZoQ27zXfRUiHBCiHAGekQgrNfP0tEnyKB544VnWrJJbROijrNg29O0
    RKTIte4pcbZ4fFqIKG73/OX1/0PNpqsu5mNb2pKXLgxQFlQDPOtZbWIcOXoA
X-ME-Proxy: <xmx:xD0fapwLpHgIko0JHETRdny6S6DgLK0ZA8jXB9HyolqTVsONeHolpA>
    <xmx:xD0fak9SvS8sPqtohx8SrIgOECniOR40FhpG4MHsiLqKlfZD_vIH7Q>
    <xmx:xD0favwG2P6qbT-c4AA-9xivcpb_8GNWUnX4EVtUzc1ke67GPLt-1g>
    <xmx:xD0fako5r-xJUvmNo-Gg322iw5gEx1H3T5GgDWffNG7GkwJU096HKA>
    <xmx:xT0fariwunGr8illK9CUNw9KvbhakstpcZU7T91yHpSX22OtlpEP8zqb>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 16:32:03 -0400 (EDT)
Date: Tue, 2 Jun 2026 14:32:02 -0600
From: Alex Williamson <alex@shazbot.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, helgaas@kernel.org, schnelle@linux.ibm.com,
 mjrosato@linux.ibm.com, alex@shazbot.org
Subject: Re: [PATCH v17 5/7] vfio-pci/zdev: Add a device feature for error
 information
Message-ID: <20260602143202.6395e9e2@shazbot.org>
In-Reply-To: <20260520171113.1111-6-alifm@linux.ibm.com>
References: <20260520171113.1111-1-alifm@linux.ibm.com>
	<20260520171113.1111-6-alifm@linux.ibm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 May 2026 10:11:11 -0700
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
>  arch/s390/pci/pci_event.c        | 19 ++++++++++++++++
>  drivers/vfio/pci/vfio_pci_core.c |  2 ++
>  drivers/vfio/pci/vfio_pci_priv.h |  9 ++++++++
>  drivers/vfio/pci/vfio_pci_zdev.c | 39 ++++++++++++++++++++++++++++++++
>  include/uapi/linux/vfio.h        | 30 ++++++++++++++++++++++++
>  6 files changed, 101 insertions(+)
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
> index cf2ffa21ab8c..db1b44baf8fa 100644
> --- a/arch/s390/pci/pci_event.c
> +++ b/arch/s390/pci/pci_event.c
> @@ -75,6 +75,25 @@ static int zpci_store_pci_error(struct pci_dev *pdev,
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
> index 78a28db00c6d..cc148123a97b 100644
> --- a/drivers/vfio/pci/vfio_pci_zdev.c
> +++ b/drivers/vfio/pci/vfio_pci_zdev.c
> @@ -141,6 +141,45 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
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
> +	if (copy_to_user(arg, &err, sizeof(err)))
> +		return -EFAULT;
> +
> +	return 0;
> +}

There's a concern here that the error is dequeued but we can still fail
resulting in a lost error.  Is that a sufficiently unlikely scenario to
ignore or should it at least be documented?

> +
>  int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
>  {
>  	struct zpci_dev *zdev = to_zpci(vdev->pdev);
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 5de618a3a5ee..3eead86a00ab 100644
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
> +	__u32 ett		:  4;	/* expected table type */
> +	__u32 mvn		: 12;	/* MSI vector number */
> +	__u32 dmaas		:  8;	/* DMA address space */
> +	__u32 reserved2		:  6;
> +	__u32 q			:  1;	/* event qualifier */
> +	__u32 rw		:  1;	/* read/write */
> +	__u64 faddr;			/* failing address */
> +	__u32 reserved3;
> +	__u16 reserved4;
> +	__u16 pec;			/* PCI event code */
> +	__u8 reserved5[28];		/* Allow for future expansion */
> +};
> +
> +#define VFIO_DEVICE_FEATURE_ZPCI_ERROR 13
> +

There are currently at least 4 different patch series, including this
one, that are vying for device feature allocations.  This series spans
PCI, s390, and vfio, and I'm not entirely sure which maintainer should
take it.  With Niklas' review on patch 4, should we ask Bjorn to take
1-3 through PCI, share a branch, and I could merge 4-7 through vfio?
Thanks,

Alex
