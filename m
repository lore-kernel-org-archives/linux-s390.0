Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DF23AF668;
	Tue,  9 Jun 2026 22:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781045018; cv=none; b=GSiWPnSGgvyEktUifZzzzRMXWwkoAtiY4JaqjXWQSkJa91wLcLUR8JeaIs4MxVDIolch6pdw8Vn93+UZpOOgcYl4l7hSHVwW25NOGZoskVb2Qom6d24k32xyNp2v60krPcJL1khDzBPrqOI6VHcfpPhqP6j8ZIgd3zmxkrFBTYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781045018; c=relaxed/simple;
	bh=0IpaWrIodcly2t7PYOgU+dX1cmASrL64/OfF49Vv3kY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TcrZhQkm3/lJ1ZV7rco3TyUOS6LjwTWMMNLDIZsdk2vCzabsF0sDJfB1BT2IJuqcDEsp//cNxTTLg4g7F42vr70qU0r0haf6TfP5v6+PBF1lguOtME5t2zDDiicEwtl+Hdgt6Hcqt29a4ROu85UZ66eH7wDQgAVXmTVuElD+Ip4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=exNfD1wD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LnfyTPDc; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="exNfD1wD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LnfyTPDc"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id AEDCCEC0184;
	Tue,  9 Jun 2026 18:43:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 09 Jun 2026 18:43:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781045015;
	 x=1781131415; bh=LG2vrIAk2mS1EqfLIJ+l00ZnjUcmIRtgt527GUdbCAI=; b=
	exNfD1wDZGAQYN5+qISNu9xtgGcYJ5t7XT9qaTzIsDN5CLg07RWuzC1dgAeDaieb
	uGMXdoS27uPeqTBwU6+SrgqDaAwTxENsdZVkvresVe7x9oWfFQfDmsRHbe3rZ/dU
	Fsv2aFDAd1VmEhL0eHyeY2ZWQWW8muUfjteh8PVv7H79KgSrdABUVGJQg1x/q5Qr
	jRcub36xWcE55I3ciFzlZkzsh9exGnU54lOSfvLXUwfNDo/XKL32OwSeO12/oTkF
	hkpH/wZFENd5SP/iOM7Z+rTJpbNs/JpEdNenT1xHg+5j5VtW898g/zfh8eiKySS+
	wwKB0kfBPT1vhE/oNGERAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781045015; x=
	1781131415; bh=LG2vrIAk2mS1EqfLIJ+l00ZnjUcmIRtgt527GUdbCAI=; b=L
	nfyTPDckOvl2xHgwUZfZppyakFX0+ppWAPuM0bv9wGM84d6z4itXCZfmkXWaUJjy
	cgFrq7Pkw9DkqRT5grTU5tDG2h4ixWc/dVkS+0FsvhinsPrUDSnwWw3VdvUjP9sL
	yVCyQXBdw9H5kD8fXjNzJ1a2pOd8jFFzopPA40a2iRm0jmGZSQklR1R6sOckEoGt
	ugratWCI9++FCk0oufahGqbrMOJteuzTzOoZ6c79ONlQYtdWb7OaehYa5CPrgBU2
	gWUizzm5MgIz0xZikjVtDPIeupKqumPvaDOGytwNZV1FbCasgkJ0+FNeB3cIvPA9
	TbhGSDhNcG/aYs2iMyy8A==
X-ME-Sender: <xms:F5coavug36U3Oe3SqkAIt72BsZ5kb-WFtQvxQJ5V2SnJQWffX37KiA>
    <xme:F5coah2kV_4MYU6TJNGLz-VjegysrZsfOqqfHRpf8iNFb4CbEr-nyECScjHjTOFlA
    s7xyzAPrA3RKecrN4Uu3IIk0VV5Dqq3ULQ4ouebdDWWsLVXm-NkJg>
X-ME-Received: <xmr:F5coasCtNRWKhKHa93CeHGXdEJV8UwKRNObXA9PHJ2CO2Dwqb2b80a5V3Vo>
X-ME-Proxy-Cause: dmFkZTE8jEnSpP6DxEe5aJ5ZGJxvLElyKulphKp2EhYMQTxhzHICItgQMblQxVAoCsUwrb
    d3AggRcsfGtRcC5wb7FJuapqNCWSHyBMhuzXKqPEnFI6mHeQjXRWTGQaNgnOjqagRqoUBs
    SAj+igc4EH/Bmm9TacT/LIhWBuB9IClNgG/aqDEsayoBXWJZeKk++zRmjTpcgfrtucyMWq
    tgmWpb8KGRDJFz3fby/lfV1O8cNu9V5tDG4byEch5rsNRPQuHTeZm2tb2wRaoNEBqkBDJm
    7rLIFzayeZMTZytNY4tTfWfS5haxYKief6U3VkZIAFam9TLHq+ihbUv7sBU5T0rXTT3hmY
    nObayYPmbilUpX+8FXw/ZJdSBgEj7BAgUaCHQMWoklh/IBjdoBTWeG9Hh66hbj1owQcwQD
    8SS4i7Inkr2mhf9GIubb/SsdogW977SV2ICqsxU0NBHpUwK27jpJChNW+WsbnbRY6CkVme
    lWMGBZ9B/pR7IJmrPYRhf22fYV6Dju1XOSj5lmsB63mAOcYIpymf/lgDwoa1KBKmjAZf55
    b33eKByPGn6uqniikIgixJ1s6c0mwJhPlxF2ts2dTKAGskxxZGwpQpMxZ9H4GRHvkXJLNN
    B34mC0ig5t+/IhMnPxbM0ocmf2psISR+oxR1G37NFyXnPwXjxdZ3dDZSMqvw
X-ME-Proxy: <xmx:F5coamcx7PKts6QlyfO9vylXYU__-qBM8VkI0z2vsEjX8W3gSG1kcw>
    <xmx:F5coamycjZWmhcJySK0A0MfnPX1f8dLbFR9eczKSzPZ56lLGN70WfQ>
    <xmx:F5coapP_R9hF-peGqKVBsH_3hT31g5ZYmn2eZkVRACinRZ80HutW3w>
    <xmx:F5coatY1uY2UXDWWK4I5YCqlFyI-UEKISfauliJBliz5eqK9j-g-Pw>
    <xmx:F5coans8O-X_XC3TlwWXQ0a5wdtnVcJxaYWZlEl0iss6WYgxD6dAhH1S>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 18:43:34 -0400 (EDT)
Date: Tue, 9 Jun 2026 16:43:32 -0600
From: Alex Williamson <alex@shazbot.org>
To: Omar Elghoul <oelghoul@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
 farman@linux.ibm.com, gbayer@linux.ibm.com, alex@shazbot.org
Subject: Re: [PATCH v3 3/4] vfio-pci/zdev: Add VFIO FMB device features
Message-ID: <20260609164332.5dc548f5@shazbot.org>
In-Reply-To: <20260608171850.62829-4-oelghoul@linux.ibm.com>
References: <20260608171850.62829-1-oelghoul@linux.ibm.com>
	<20260608171850.62829-4-oelghoul@linux.ibm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Jun 2026 13:18:49 -0400
Omar Elghoul <oelghoul@linux.ibm.com> wrote:

> diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
> index 0990fdb146b7..09454495ee23 100644
> --- a/drivers/vfio/pci/vfio_pci_zdev.c
> +++ b/drivers/vfio/pci/vfio_pci_zdev.c
> @@ -167,3 +167,60 @@ void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev)
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
> +	guard(mutex)(&zdev->fmb_lock);
> +
> +	if (copy_from_user(&fmb_enable, arg, sizeof(fmb_enable)))
> +		return -EFAULT;

The guard can drop to here, it doesn't protect anything related to the
copy_from_user().

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
> +	struct zpci_fmb fmb_temp = {0};

Unnecessary initialization, we only copy to the user what's been
written.

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
> +	guard(mutex)(&zdev->fmb_lock);
> +
> +	if (!zdev->fmb)
> +		return -ENOMSG;
> +	if (copy_from_user(&fmb_read, arg, sizeof(fmb_read)))
> +		return -EFAULT;
> +	if (!fmb_read.data)
> +		return -EINVAL;
> +
> +	memcpy(&fmb_temp, zdev->fmb, zdev->fmb_length);
> +	if (copy_to_user(fmb_read.data, &fmb_temp, zdev->fmb_length))
> +		return -EFAULT;

The bounce buffer itself seems unnecessary in this usage, we could just:

	if (copy_to_user(fmb_read.data, zdev->fmb, zdev->fmb_length))

But maybe there was an intention to scope the bounce buffer copy within
the guard and perform the copy_to_user() after releasing the lock?


> +
> +	return 0;
> +}
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 5de618a3a5ee..3988e8690e0b 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -1534,6 +1534,35 @@ struct vfio_device_feature_dma_buf {
>   */
>  #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
>  
> +/**
> + * Upon VFIO_DEVICE_FEATURE_SET, enable or disable FMB for the VFIO zPCI device.
> + *
> + * enabled is treated as a bool, so any non-zero value evaluates to true. This
> + * feature fails on attempt to double enable/disable.

Does it?  Double enable just does a re-enable.

> + *
> + * Returns: 0 on success, -1 and errno set appropriately on error.
> + */
> +#define VFIO_DEVICE_FEATURE_ZPCI_FMB_ENABLE 13
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
> +#define VFIO_DEVICE_FEATURE_ZPCI_FMB_READ 14
> +
> +struct vfio_device_feature_zpci_fmb_read {
> +	void __user *data;

We should use explicit data sizes for uAPI:

	__aligned_u64 data;

Thanks,
Alex
