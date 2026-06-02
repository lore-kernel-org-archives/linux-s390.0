Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5B23C3443;
	Tue,  2 Jun 2026 22:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780439628; cv=none; b=evTEe3bTrQxxtt2djwz7DtX6+21HVyFVMnlwKqwuWeHsaFXzNpTYWMhf+fKwPJEdAKSGnBSZUEy8M97yduzeyfYR15BTmiZ6mYlfPvTGzJWg6iqKr6BeZGnul6RXJZDuAFWnuTkbyuTRJoJZ30Tvv8uP7aTswug/vjUEKjAaJ/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780439628; c=relaxed/simple;
	bh=zZItSxvdNYv+Ugqol510+DGowtXqXRzDbWmbElgKg+U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QIa7HKxsykrhVMmjS+OlebQWzSiKprTr9pt0X11wMIvD/YNPdgmmypDS1a0EixGKcU9uT0FMlhdmtaSaBHZyP+6E/qmwfKWuqo2lke2sFWkj2l2AeaertR8i5bN7iFfTza59ccpIAp8uUw9fdArYxglnxphDxXvpqLMrHjI9tto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=HidOBnen; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NhBfY8rn; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="HidOBnen";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NhBfY8rn"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 324081D0007A;
	Tue,  2 Jun 2026 18:33:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 02 Jun 2026 18:33:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1780439626;
	 x=1780526026; bh=Ja9GdzTTUf5X91j/iSsP0H5D1+AI2jDabH9dd0Cg+30=; b=
	HidOBnenj1y+rxk0Ju/Po2jheyhztOBOxVIMDAZuj4A88/3UBdWzZpRoa59J6JRV
	sD6H6QD9sfSyspOCRHMjrGf+11pe8UHC/JNuEQu4+kpezyAhdWU7HuSpvL5ps/OB
	UOwywxtB+SnbHKEGrX8Ra1UZn9kcoooa+l613qussFf9NBWvsS9FIuXsX7bdusD7
	++XvOVRmVAtAoYDu9ylhOPuSpk3AdKfp0n+rCt/pBUGLF8AcnZ/q2Exqt+QfC3lA
	Yni8JWZaLqilfI1RSlfVXZfKXCKgTLZWmgEg/zRceJo2J1fg/TdMPt0VTeQHKwmN
	JSQCuqaVGwqAPTtMddzjrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780439626; x=
	1780526026; bh=Ja9GdzTTUf5X91j/iSsP0H5D1+AI2jDabH9dd0Cg+30=; b=N
	hBfY8rnFS3mh1V4kQlVf8yXKWfSYrDCe5W6AAG98hE0MVJXfMThdFp4DEMveXjgQ
	xKj4gyxy5SzxN1a5ySjy1A7lMI+8HJ8XIUOHBhm7U8i7OYYh1zH7Polwykk0XFsY
	lT20PCXfkWNAmmMoX9hEcxn6lwZcCJe/COwQZAwwMmHZFoyhws9beA2ZighSlYeL
	uxb9NpJnBlT5pYh/4WPb2cNDp+UtZhHEv89O4g31/oi/0JYiwWpHIW43eIdLiimv
	eqW5gHxISX0d4QAA8lBSZYFUF1yWw2ytymdB8pTzVCGiLEkz1GviT9pWP2MCCY4A
	NHUdIhrCqfTiIMEa0lh/w==
X-ME-Sender: <xms:SVofaq3bWU3m9D-YRGl7r4vH96e1fY4yjRE-mJ6-hVQOV9AraTXQng>
    <xme:SVofauryIv1JrAYuoYYEIFEkz1f8yDC0SXltSTF0V4Cv78C0P9iuT1l7fEylmgeUJ
    zyML3ZumInW_Ovowood7t-wYvqeIZymFVAO-kaw0IcIuQbOxiXQoA>
X-ME-Received: <xmr:SVofapOQo4Gr7UVKPaUr_GgiA90bP4m35foN00y1s60LIymAcElfjxz_Xyg>
X-ME-Proxy-Cause: dmFkZTEns0hgSaiGRNx/9Qdwg3aHNCmwkwGrifY/S+ykA9yIyzp1P0xOrwjVOQvaJSDTw2
    U0MWHmA2AJQGaasOuAzzmsk0u8Db+6T6F7dFS0pDtTU5/sGSE2exMfscAhxYEc90ZIjPCG
    cUzaos5gP81qC2uCaab6BbD4rkTzyLZxcmHJgS5RPHp3+n1Un/bTF/zr3owRHeP8MPc5bS
    yvr2PrSMXuFtmWETTDOv4xeoXy90eKLTbHbbwvaoVIblxU1XFbZ+SV/KtTPrMT0qoFfNIO
    W/bqBun8TR8e6I6FONCMHrY2BaBUnQ+Uz3CcgEQ9qmZ3/l9cpqgErosO3AC3erU1BnnCkQ
    tGxG6RgMURr8XeGJl6+99ogpXZ3YT296TJENfKZntNQFnvzE8B/Js3/WOj7Zm/7Y/fPlW2
    6/R78qqvY3KlrYAdVJbiooO9BOawfWktLbnO8cHzzkT7qDxeBZ0e0/+p50tRf9jRevTgv9
    OhN7l8pi7Qtc7DvKkWPv7C5pRIzp5rYWj/1xgUhBJ0h0cc3vKeq7EgQCzoL6Kdbrgakrt4
    XX7ATr1fSM4AX0qji7/tjup8skdfnfionj1U+S9YI0YHCTqKScR/0XtvzWglmIGqSMxXau
    BjfJy9YziQvQ1BW1eJvV24tkPW5K8y0bF0XsXVLgJvJ4xglvhxDGlce1xEJg
X-ME-Proxy: <xmx:SVofanrZslvgK-rRQL-e_46a-mc2Z9GNoWmaoZ1hiYihVO-nPSx2fg>
    <xmx:Slofaks2dzNaZFZNMTVAVSBIIwCULAG4zbsF1j_QLpAhpvCAkzt08Q>
    <xmx:Slofau1Xy3cl3CgFQ0mGCqsI9fpE9Ecmi257_Vmh2uphezEj_awlSw>
    <xmx:SlofanHVESC0XSpyYnNoZfeeaMneNpwA46j2dWnF_RzgDqtW2OLFFg>
    <xmx:Slofaluqob2l2MGrmAEbFsrp6bXW8dSdrHmoLFOcrSOR2BIiBRjyY7vP>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 18:33:45 -0400 (EDT)
Date: Tue, 2 Jun 2026 16:33:44 -0600
From: Alex Williamson <alex@shazbot.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, helgaas@kernel.org, schnelle@linux.ibm.com,
 mjrosato@linux.ibm.com, alex@shazbot.org
Subject: Re: [PATCH v17 5/7] vfio-pci/zdev: Add a device feature for error
 information
Message-ID: <20260602163344.1eda12d2@shazbot.org>
In-Reply-To: <a35f1171-eaad-4b5b-a85f-dfb64dbc6454@linux.ibm.com>
References: <20260520171113.1111-1-alifm@linux.ibm.com>
	<20260520171113.1111-6-alifm@linux.ibm.com>
	<20260602143202.6395e9e2@shazbot.org>
	<a35f1171-eaad-4b5b-a85f-dfb64dbc6454@linux.ibm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Jun 2026 14:38:56 -0700
Farhan Ali <alifm@linux.ibm.com> wrote:

> On 6/2/2026 1:32 PM, Alex Williamson wrote:
> > On Wed, 20 May 2026 10:11:11 -0700
> > Farhan Ali <alifm@linux.ibm.com> wrote:
> >  
> >> For zPCI devices, we have platform specific error information. The platform
> >> firmware provides this error information to the operating system in an
> >> architecture specific mechanism. To enable recovery from userspace for
> >> these devices, we want to expose this error information to userspace. Add a
> >> new device feature to expose this information.
> >>
> >> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> >> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> >> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> >> ---
> >>   arch/s390/include/asm/pci.h      |  2 ++
> >>   arch/s390/pci/pci_event.c        | 19 ++++++++++++++++
> >>   drivers/vfio/pci/vfio_pci_core.c |  2 ++
> >>   drivers/vfio/pci/vfio_pci_priv.h |  9 ++++++++
> >>   drivers/vfio/pci/vfio_pci_zdev.c | 39 ++++++++++++++++++++++++++++++++
> >>   include/uapi/linux/vfio.h        | 30 ++++++++++++++++++++++++
> >>   6 files changed, 101 insertions(+)
> >>
> >> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
> >> index 016386f7ef4a..88a125b92bdd 100644
> >> --- a/arch/s390/include/asm/pci.h
> >> +++ b/arch/s390/include/asm/pci.h
> >> @@ -364,6 +364,8 @@ int zpci_clear_error_state(struct zpci_dev *zdev);
> >>   int zpci_reset_load_store_blocked(struct zpci_dev *zdev);
> >>   void zpci_start_mediated_recovery(struct zpci_dev *zdev);
> >>   void zpci_stop_mediated_recovery(struct zpci_dev *zdev);
> >> +int zpci_get_pending_error(struct zpci_dev *zdev,
> >> +			   struct zpci_ccdf_err *ccdf);
> >>   
> >>   #ifdef CONFIG_NUMA
> >>   
> >> diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
> >> index cf2ffa21ab8c..db1b44baf8fa 100644
> >> --- a/arch/s390/pci/pci_event.c
> >> +++ b/arch/s390/pci/pci_event.c
> >> @@ -75,6 +75,25 @@ static int zpci_store_pci_error(struct pci_dev *pdev,
> >>   	return 0;
> >>   }
> >>   
> >> +int zpci_get_pending_error(struct zpci_dev *zdev,
> >> +			   struct zpci_ccdf_err *ccdf)
> >> +{
> >> +	int head = 0;
> >> +
> >> +	guard(mutex)(&zdev->pending_errs_lock);
> >> +
> >> +	if (!zdev->pending_errs.count)
> >> +		return -ENOMSG;
> >> +
> >> +	head = zdev->pending_errs.head % ZPCI_ERR_PENDING_MAX;
> >> +	memcpy(ccdf, &zdev->pending_errs.err[head],
> >> +	       sizeof(struct zpci_ccdf_err));
> >> +	zdev->pending_errs.head++;
> >> +	zdev->pending_errs.count--;
> >> +	return 0;
> >> +}
> >> +EXPORT_SYMBOL_GPL(zpci_get_pending_error);
> >> +
> >>   void zpci_start_mediated_recovery(struct zpci_dev *zdev)
> >>   {
> >>   	guard(mutex)(&zdev->pending_errs_lock);
> >> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> >> index 050e7542952e..27642f10fe97 100644
> >> --- a/drivers/vfio/pci/vfio_pci_core.c
> >> +++ b/drivers/vfio/pci/vfio_pci_core.c
> >> @@ -1569,6 +1569,8 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
> >>   		return vfio_pci_core_feature_token(vdev, flags, arg, argsz);
> >>   	case VFIO_DEVICE_FEATURE_DMA_BUF:
> >>   		return vfio_pci_core_feature_dma_buf(vdev, flags, arg, argsz);
> >> +	case VFIO_DEVICE_FEATURE_ZPCI_ERROR:
> >> +		return vfio_pci_zdev_feature_err(device, flags, arg, argsz);
> >>   	default:
> >>   		return -ENOTTY;
> >>   	}
> >> diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
> >> index fca9d0dfac90..4e7162234a2e 100644
> >> --- a/drivers/vfio/pci/vfio_pci_priv.h
> >> +++ b/drivers/vfio/pci/vfio_pci_priv.h
> >> @@ -93,6 +93,8 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
> >>   				struct vfio_info_cap *caps);
> >>   int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev);
> >>   void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev);
> >> +int vfio_pci_zdev_feature_err(struct vfio_device *device, u32 flags,
> >> +			      void __user *arg, size_t argsz);
> >>   #else
> >>   static inline int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
> >>   					      struct vfio_info_cap *caps)
> >> @@ -107,6 +109,13 @@ static inline int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
> >>   
> >>   static inline void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev)
> >>   {}
> >> +
> >> +static inline int vfio_pci_zdev_feature_err(struct vfio_device *device,
> >> +					    u32 flags, void __user *arg,
> >> +					    size_t argsz)
> >> +{
> >> +	return -ENOTTY;
> >> +}
> >>   #endif
> >>   
> >>   static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
> >> diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
> >> index 78a28db00c6d..cc148123a97b 100644
> >> --- a/drivers/vfio/pci/vfio_pci_zdev.c
> >> +++ b/drivers/vfio/pci/vfio_pci_zdev.c
> >> @@ -141,6 +141,45 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
> >>   	return ret;
> >>   }
> >>   
> >> +int vfio_pci_zdev_feature_err(struct vfio_device *device, u32 flags,
> >> +			      void __user *arg, size_t argsz)
> >> +{
> >> +	struct vfio_device_feature_zpci_err err = {};
> >> +	struct vfio_pci_core_device *vdev;
> >> +	struct zpci_ccdf_err ccdf = {};
> >> +	struct zpci_dev *zdev;
> >> +	int ret;
> >> +
> >> +	vdev = container_of(device, struct vfio_pci_core_device, vdev);
> >> +	zdev = to_zpci(vdev->pdev);
> >> +	if (!zdev)
> >> +		return -ENODEV;
> >> +
> >> +	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_GET,
> >> +				 sizeof(err));
> >> +	if (ret != 1)
> >> +		return ret;
> >> +
> >> +	ret = zpci_get_pending_error(zdev, &ccdf);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	err.fh = ccdf.fh;
> >> +	err.fid = ccdf.fid;
> >> +	err.ett = ccdf.ett;
> >> +	err.mvn = ccdf.mvn;
> >> +	err.dmaas = ccdf.dmaas;
> >> +	err.q = ccdf.q;
> >> +	err.rw = ccdf.rw;
> >> +	err.faddr = ccdf.faddr;
> >> +	err.pec = ccdf.pec;
> >> +
> >> +	if (copy_to_user(arg, &err, sizeof(err)))
> >> +		return -EFAULT;
> >> +
> >> +	return 0;
> >> +}  
> > There's a concern here that the error is dequeued but we can still fail
> > resulting in a lost error.  Is that a sufficiently unlikely scenario to
> > ignore or should it at least be documented?  
> 
> IMHO this scenario would be unlikely and could be ignored. I think to 
> handle this we would need something like a peek() API and only remove 
> and update the pending_errs if copy_to_user succeeds. This would be 
> adding more complexity for a relatively low possibility of failure.

Or just a dev_warn_ratelimited().

> >> +
> >>   int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
> >>   {
> >>   	struct zpci_dev *zdev = to_zpci(vdev->pdev);
> >> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> >> index 5de618a3a5ee..3eead86a00ab 100644
> >> --- a/include/uapi/linux/vfio.h
> >> +++ b/include/uapi/linux/vfio.h
> >> @@ -1534,6 +1534,36 @@ struct vfio_device_feature_dma_buf {
> >>    */
> >>   #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
> >>   
> >> +/**
> >> + * VFIO_DEVICE_FEATURE_ZPCI_ERROR feature provides PCI error information to
> >> + * userspace for vfio-pci devices on s390. On s390, PCI error recovery
> >> + * involves platform firmware and notification to operating systems is done
> >> + * by architecture specific mechanism. Exposing this information to
> >> + * userspace allows it to take appropriate actions to handle an
> >> + * error on the device. The ioctl returns -ENOMSG if there are no pending
> >> + * PCI errors.
> >> + */
> >> +
> >> +struct vfio_device_feature_zpci_err {
> >> +	__u32 feature_flags;		/* Indicate future features */
> >> +	__u32 reserved1;
> >> +	__u32 fh;			/* function handle */
> >> +	__u32 fid;			/* function id */
> >> +	__u32 ett		:  4;	/* expected table type */
> >> +	__u32 mvn		: 12;	/* MSI vector number */
> >> +	__u32 dmaas		:  8;	/* DMA address space */
> >> +	__u32 reserved2		:  6;
> >> +	__u32 q			:  1;	/* event qualifier */
> >> +	__u32 rw		:  1;	/* read/write */
> >> +	__u64 faddr;			/* failing address */
> >> +	__u32 reserved3;
> >> +	__u16 reserved4;
> >> +	__u16 pec;			/* PCI event code */
> >> +	__u8 reserved5[28];		/* Allow for future expansion */
> >> +};
> >> +
> >> +#define VFIO_DEVICE_FEATURE_ZPCI_ERROR 13
> >> +  
> > There are currently at least 4 different patch series, including this
> > one, that are vying for device feature allocations.  This series spans
> > PCI, s390, and vfio, and I'm not entirely sure which maintainer should
> > take it.  With Niklas' review on patch 4, should we ask Bjorn to take
> > 1-3 through PCI, share a branch, and I could merge 4-7 through vfio?
> > Thanks,
> >
> > Alex  
> 
> If it helps I can break the series into PCI only and vfio only patches. 
> Please let me know if there is anything I can help with to make the 
> merge easier.

Let's do that.  Thanks,

Alex
