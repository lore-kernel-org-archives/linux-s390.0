Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917CB3C3F5F;
	Wed, 30 Sep 2026 18:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790794677; cv=none; b=biMcPZ2oQ8xYNT2Vf/SUPs/f+zvyo6AW+i30nmpfrOOG+FK6o1ZBC7npicp/wTr6P7QWbUN0rhLim37uknr4eSTr5MKLvZ5Ny7s+c3m01NAWyg/ePKvuE1BvfhlP7Ob0Bx6tBetBEuYFdtDiS6ATAOTf/cXUzIxgn55Hci8OtmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790794677; c=relaxed/simple;
	bh=OBQlOvS0rycZU5rwrjuB2gjWPsIlXQJCJcbZdMWaon4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KRmFcayxRgLmDMxu63mts4tLWQYfZp2irng8IF3JA6tmCe+h4bB4+7x7DOw3N0k8XH5+nPERP69xRJcOR8SATsBSseZ8dFBMSNGuRS4J0Rm+YarUU9pCgleCtY+c6kWnbnSlWBxARFowX6H5BX0c9xvuJDuiuvmYs8BWfs5K0PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=DvPwnrCk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r5sJDoDN; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="DvPwnrCk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r5sJDoDN"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 79C0C7A007E;
	Wed, 30 Sep 2026 14:57:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 30 Sep 2026 14:57:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790794673;
	 x=1790881073; bh=BspcP9WbuVrQ5jq5qs2D7DIXM++RODNrAXaRMcEdZ5I=; b=
	DvPwnrCkCO6+GTcwVmWeIWuB6xksdRqD7Bj/kw2GFtHLvRsC8+yJOyXFFUrfLadx
	0YW0aTx8MvRr8DOOfzb4PUMBDyJrN0USMrJuHDjPn0yJelZpREtWNGKQrw1H+nox
	CJSo9nFNVrWZs0EzgSkTs4T8GSkijVdt0FU5AQ6X3nd1uA2Ag5Mu8j3NdjM68afs
	+ThWNqLIMlhrIuL8HsNUMEAnYpUo7ef8KT7Yl7rd78rxcPuXpPJoVGs3fvxAXxLa
	QhVTD47cCCWO1f6n3Qd1eFYfc5zKywxvXIbuYQ5nw2z8436ETKL26TAB2+uQrt4p
	j01YzR/IeiG9S99GhtwAHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790794673; x=
	1790881073; bh=BspcP9WbuVrQ5jq5qs2D7DIXM++RODNrAXaRMcEdZ5I=; b=r
	5sJDoDN5xtthMGCA0SDsATwewJo0CTT5bS3F65XlW3pCrqUUdHwKK930ze0BwCWL
	AAV8KAXDMD4MxDXYDNhDgW1WwaWretAyKefMwbtNI/woqYDR49TU4rcQFfu4Vos8
	ggOOyZwKtGHIe4c1blTnYTJh6wc7boKhldsnNutbCfyAEdxt8l3dU9AYEBbj2luf
	onjshL9tYBJHLM7qgRgyyH54byCBZWGgQSS3Ea3361qA2eHtqWPmCFwatDTmyznS
	8BJ9WoUZIDAscXwhyEX+r8ySSeOL1XxrVaY+18ojAUDxOwOj+PbqGVRwdBnYP8BF
	lay3zpZybZbguMtK0fAPQ==
X-ME-Sender: <xms:sVu9aqXre5jzdbLm13LNEQfNQ6mqM5np3bxacqXVIn711vKW9bJ5PA>
    <xme:sVu9ardqZxF42YOhvy1pDG-ci2cWWbzk2JcAr8kYTvlruZ4YHg-_lwaHtO2rPFF_H
    IAuWk5qMpWFvLGWHjxp6hOfCa89k7xSGlHsY9K5kINnXDDnKbNG2ho>
X-ME-Received: <xmr:sVu9am8i6ZiTsK_r6_sYLVyltmfotMWLUT_OgA1vNF_AV5ZAAf8-NZ8zXyZncw>
X-ME-Proxy-Cause: dmFkZTGPV0Anl9AWKDctYPpuR5bZFHSIcSA5aqZBkGJ0RRVdJzzG6TeR1wIjOtlEJ7Nt1s
    uQEGrKJWOp+dJbKh3+EzaIlSHpM5H7Z+wdCForpDuhx4I97gnSL2U2SrnNiW6hX7mnzV7y
    8QMg+Vj47pqhpne5bZIr6smuU+vfpGvBg9OitBJ0nUVdqx11dKkxtUGpZ/YqeaCY52VBTF
    uMPDAC5G6hEUehRWjoE5nGdjuRoUn3arYE/r+yTjQBR8yKhvzqee328bgp3T6/bgLNbFiw
    GJWUlNZ30QU5Ps7dpbfsR6N7nBGuiRoaXqIkkjQpQzAxn7TwL9oy6z+z5vgahLSogVh0Pd
    9MSsQNUkVzuQH8/hreojwaBCujPag7dsFxEBGGKBwCDMhPkFglW8IlB0GxITXbU2Fhmzwe
    7mu7sIsG+vvOLQOs6CxTu7Qhc5fsMwY0XsvrnbSkRu+VDkLcMxnrINz6ZgZNNdD6ue74SQ
    RaQDSL1vXjRvnFatUBPucbpcUXfjRCodG9YZCGyr+hmQ5k63g/qIREx3ZJyXe2JQCN8Ex4
    pY5Ub5PMakHtL5ARkfhnDKoJPch5d8tSfUNd01kC9uvix3rDUtdNNt6vyQod4rhoNzGnz7
    rbZpar1z+DX1OprfTp3/E+bu6w9z3LRbGL9T0S3UEPKvSO51VdQEABIGRlSw
X-ME-Proxy: <xmx:sVu9aimyimxheY0FHhMi3DPj3FSVcnx0dyYVfOQmRhPLMH_5oe2KYw>
    <xmx:sVu9aniY_qefzeaxRS8xZOC-psWmIAbBf2yMLZQt-4kDP7pWy__4aw>
    <xmx:sVu9aialdTbyDJPREXue67-Nw86wQ9hy6BnZiHiAy_PZpsuS5bcv7A>
    <xmx:sVu9ajEu65AkWsuWojpaoe7snGnCXrMBGp1KVCU2vdnZZyGIiFQy0Q>
    <xmx:sVu9amEXYyE2b5UrT5UlGXSmIZVvq3fzGCnwc_p_DHRs53j7WFjAGT4W>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 14:57:52 -0400 (EDT)
Date: Wed, 30 Sep 2026 12:57:50 -0600
From: Alex Williamson <alex@shazbot.org>
To: Omar Elghoul <oelghoul@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
 farman@linux.ibm.com, gbayer@linux.ibm.com, pasic@linux.ibm.com,
 alex@shazbot.org
Subject: Re: [PATCH v7 4/4] vfio-pci/zdev: Add VFIO FMB device features
Message-ID: <20260930125750.7a5bc3a8@shazbot.org>
In-Reply-To: <20260922195141.94548-5-oelghoul@linux.ibm.com>
References: <20260922195141.94548-1-oelghoul@linux.ibm.com>
	<20260922195141.94548-5-oelghoul@linux.ibm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 15:51:41 -0400
Omar Elghoul <oelghoul@linux.ibm.com> wrote:

> Introduce new VFIO features for zPCI devices to provide FMB passthrough to
> userspace.
> 
> Allow the user to enable or disable the FMB using the SET-only feature
> VFIO_DEVICE_FEATURE_ZPCI_FMB_ENABLE. Likewise allow the user to read the
> latest FMB using the GET-only feature VFIO_DEVICE_FEATURE_ZPCI_FMB_READ
> in the case when the FMB is enabled.
> 
> Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c |  4 +++
>  drivers/vfio/pci/vfio_pci_priv.h | 18 ++++++++++
>  drivers/vfio/pci/vfio_pci_zdev.c | 60 ++++++++++++++++++++++++++++++++
>  include/uapi/linux/vfio.h        | 29 +++++++++++++++
>  4 files changed, 111 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 6757054e9d87..3c827a77725b 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1627,6 +1627,10 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
>  		return vfio_pci_core_feature_dma_buf(vdev, flags, arg, argsz);
>  	case VFIO_DEVICE_FEATURE_ZPCI_ERROR:
>  		return vfio_pci_zdev_feature_err(device, flags, arg, argsz);
> +	case VFIO_DEVICE_FEATURE_ZPCI_FMB_ENABLE:
> +		return vfio_pci_zdev_feature_fmb_enable(vdev, flags, arg, argsz);
> +	case VFIO_DEVICE_FEATURE_ZPCI_FMB_READ:
> +		return vfio_pci_zdev_feature_fmb_read(vdev, flags, arg, argsz);
>  	default:
>  		return -ENOTTY;
>  	}
> diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
> index 4e7162234a2e..e04d7e9d0c30 100644
> --- a/drivers/vfio/pci/vfio_pci_priv.h
> +++ b/drivers/vfio/pci/vfio_pci_priv.h
> @@ -95,6 +95,10 @@ int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev);
>  void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev);
>  int vfio_pci_zdev_feature_err(struct vfio_device *device, u32 flags,
>  			      void __user *arg, size_t argsz);
> +int vfio_pci_zdev_feature_fmb_enable(struct vfio_pci_core_device *vdev, u32 flags,
> +				     void __user *arg, size_t argsz);
> +int vfio_pci_zdev_feature_fmb_read(struct vfio_pci_core_device *vdev, u32 flags,
> +				   void __user *arg, size_t argsz);
>  #else
>  static inline int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
>  					      struct vfio_info_cap *caps)
> @@ -116,6 +120,20 @@ static inline int vfio_pci_zdev_feature_err(struct vfio_device *device,
>  {
>  	return -ENOTTY;
>  }
> +
> +static inline int vfio_pci_zdev_feature_fmb_enable(struct vfio_pci_core_device *vdev,
> +						   u32 flags, void __user *arg,
> +						   size_t argsz)
> +{
> +	return -ENOTTY;
> +}
> +
> +static inline int vfio_pci_zdev_feature_fmb_read(struct vfio_pci_core_device *vdev,
> +						 u32 flags, void __user *arg,
> +						 size_t argsz)
> +{
> +	return -ENOTTY;
> +}
>  #endif
>  
>  static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
> diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
> index f47f36314a1c..b028de8e08a4 100644
> --- a/drivers/vfio/pci/vfio_pci_zdev.c
> +++ b/drivers/vfio/pci/vfio_pci_zdev.c
> @@ -219,3 +219,63 @@ void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev)
>  	if (zpci_kvm_hook.kvm_unregister)
>  		zpci_kvm_hook.kvm_unregister(zdev);
>  }
> +
> +int vfio_pci_zdev_feature_fmb_enable(struct vfio_pci_core_device *vdev, u32 flags,
> +				     void __user *arg, size_t argsz)
> +{
> +	struct zpci_dev *zdev;
> +	struct vfio_device_feature_zpci_fmb_enable fmb_enable;
> +	int ret;
> +
> +	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET, sizeof(fmb_enable));
> +	if (ret != 1)
> +		return ret;
> +
> +	zdev = to_zpci(vdev->pdev);
> +	if (!zdev)
> +		return -ENODEV;
> +
> +	if (copy_from_user(&fmb_enable, arg, sizeof(fmb_enable)))
> +		return -EFAULT;
> +
> +	guard(mutex)(&zdev->fmb_lock);
> +
> +	if (fmb_enable.enabled)
> +		return zpci_fmb_reenable_device(zdev);
> +	return zpci_fmb_disable_device(zdev);
> +}
> +
> +int vfio_pci_zdev_feature_fmb_read(struct vfio_pci_core_device *vdev, u32 flags,
> +				   void __user *arg, size_t argsz)
> +{
> +	struct zpci_dev *zdev;
> +	struct vfio_device_feature_zpci_fmb_read fmb_read;
> +	struct zpci_fmb fmb_bounce;
> +	int ret;
> +
> +	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_GET, sizeof(fmb_read));
> +	if (ret != 1)
> +		return ret;
> +
> +	zdev = to_zpci(vdev->pdev);
> +	if (!zdev)
> +		return -ENODEV;
> +
> +	if (copy_from_user(&fmb_read, arg, sizeof(fmb_read)))
> +		return -EFAULT;
> +	if (!fmb_read.data)
> +		return -EINVAL;
> +
> +	mutex_lock(&zdev->fmb_lock);
> +	if (!zdev->fmb_enabled) {
> +		mutex_unlock(&zdev->fmb_lock);
> +		return -ENOMSG;
> +	}
> +
> +	memcpy(&fmb_bounce, zdev->fmb, zdev->fmb_length);
> +	mutex_unlock(&zdev->fmb_lock);

A scoped guard would be preferable for consistency with the enable
path.

> +
> +	if (copy_to_user(u64_to_user_ptr(fmb_read.data), &fmb_bounce, zdev->fmb_length))
> +		return -EFAULT;
> +	return 0;
> +}
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index e41437fa17ad..a8d501e42ef9 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -1555,6 +1555,35 @@ struct vfio_device_feature_zpci_err {
>  
>  #define VFIO_DEVICE_FEATURE_ZPCI_ERROR 13
>  
> +/**
> + * Upon VFIO_DEVICE_FEATURE_SET, enable or disable FMB for the VFIO zPCI device.
> + *
> + * enabled is treated as a bool, so any non-zero value evaluates to true. Nested
> + * enabling resets the FMB counters to zero, and nested disabling fails.
> + *
> + * Returns: 0 on success, -1 and errno set appropriately on error.
> + */
> +#define VFIO_DEVICE_FEATURE_ZPCI_FMB_ENABLE 14
> +
> +struct vfio_device_feature_zpci_fmb_enable {
> +	__u8 enabled;
> +};
> +
> +/**
> + * Upon VFIO_DEVICE_FEATURE_GET, provide FMB passthrough for VFIO zPCI devices.
> + *
> + * The user-provided buffer must be at least fmb_length large, where fmb_length
> + * is reported in VFIO_DEVICE_INFO_CAP_ZPCI_BASE.
> + *
> + * Returns: 0 on success, -1 and errno set appropriately on error. errno==ENOMSG
> + * when the FMB is not enabled.
> + */
> +#define VFIO_DEVICE_FEATURE_ZPCI_FMB_READ 15
> +
> +struct vfio_device_feature_zpci_fmb_read {
> +	__aligned_u64 data;
> +};
> +

As usual, feature numbers need to be coordinated with the vfio tree.
What's the merge plan for this?  Thanks,

Alex
