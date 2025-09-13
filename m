Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75F82EA17E
	for <linux-s390@vger.kernel.org>; Sat, 13 Sep 2025 09:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757754388; cv=none; b=W7SOJzlcNMynBv2n3lprsg3HcxxVlPxp9nOfND8FB4Gou6823bXqdZAVt/KVp3IcEeyD2q4gcZ3JdqSQjCIn+Zgv8EoRxkH/7b/umniYD3iD3vXh7+54/rUZbeYM8xb7Ln7X2vjaamOmFuT7SkuvAMwAbPBk/A1OSPfNmNut4jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757754388; c=relaxed/simple;
	bh=8dEp1AU6wmo+g+BbWCezxqlLsb7zc0IB8g7OnuHFGSE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J5o9IT5rzw+ro5+TaQ5IV/dMChaR3awy2j04ibVfmZFxa45Gf9KsR+3Sj8nD59YC16mcL+NEYBpXsVggCBhAemvBJiMp4JHx2SROokad64mQE3BC5mHahQjiyQzrG/kN8nHEGf8iLwpOxNKmPvXj+8GVR2pFbViYvJLkq7hp5lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OiAHel96; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OiAHel96"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757754385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uOsyKEsT4d7f0MxqTpsXQLTyDPQ6JiWR10VEY3czRBY=;
	b=OiAHel96hdSqvygMwcXVsT10EtcUCX9BpTXezygfuP/jBvNclpxulxObdAR4cRtSCnhfK0
	eOS8zfg4mS4hHcUwKXOXeMIDgoPV3qMpsU3qLttR/OXuilFYddzyAYRgzbuDMDkkFN7uaG
	eALZPTwooHpmZAyA1bBp835V1xmHMj4=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-ddF4dc0nMCmP49XxCGPtYw-1; Sat, 13 Sep 2025 05:06:24 -0400
X-MC-Unique: ddF4dc0nMCmP49XxCGPtYw-1
X-Mimecast-MFC-AGG-ID: ddF4dc0nMCmP49XxCGPtYw_1757754383
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-4223e391be2so3474095ab.0
        for <linux-s390@vger.kernel.org>; Sat, 13 Sep 2025 02:06:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757754383; x=1758359183;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uOsyKEsT4d7f0MxqTpsXQLTyDPQ6JiWR10VEY3czRBY=;
        b=ZE1i6hHIEPPW85FNCUKSoP77JCJgFQx5hhRLfVs47UAEwcLWjlIGvYiQnuS5azuGfD
         YN3Z7EJ2eTmUB/3GHpNLDVeIKDiXcxz4M81ByacbglAaGCLu1E2W+GWjoAXIuodREBS/
         FoaqJeTeszljuODzjjx2/64ns0n0a3+KdB1VDVEhsugdBWE6bEC7tjrAS8adWBohep5a
         +BGi12cCuem8fxQrp5JceATo/3NgeBu7HCpybolCTE8Q9446f1cwSi/GLhVkVn8CZdHw
         +cWQPQjouHdHugkWkK15K1OX6r95UGJywe8S0odIwMLbk9/d24Y9uDzgHAxvz7ztO9sj
         h9gA==
X-Gm-Message-State: AOJu0YxfQmSZHV0riR3zahlrTR8JLvfrnJSvk/i8XBuPSOn7q4SaxKC3
	dXwck4cjyb6onA+lqptwAnBXqGg1iVc0hku4HzG4GVi+fJfKL3h24iX++8rYMpqsVwiimGZZE4Z
	Jyg6PTuEWpmg8nk9f0mNwZ7uQnaWXXXkvQDnVU7LYw+FTtLBW+JCNuEHFsX+bUDE=
X-Gm-Gg: ASbGnctF7fDA1fVkBj0QBbvEZl4lAQfjtHq7mfkZKJKCnnVNgWOCMjTB1MqdB87XjsS
	SWzw0uOqsPCx1ia9LAjMkmNqlKPeydTGpaX2uo1aLtzW9GYJFMWT+Ck2a6eooPUeKLGbJD//IMx
	+Rfoju3zN8Zq+OsZ93UoO8D2cSbvc7wrGAG/EUQaGVs3Tk/vyHwH1g2p2CbCHdBNYzVYOWIHexl
	YuozxgzGu40tTRDxe6THzEZfl9DkRffcVOX9G+rNqoEY83JhCkRKRooBmx106Vh0A5zh/UIMAn4
	LmbympbEqRsLZ7RW9L0HQj21z8xQ9l2zw7HUirn/qF8=
X-Received: by 2002:a92:ca4d:0:b0:419:de32:2d01 with SMTP id e9e14a558f8ab-420a1bf0e2amr28604205ab.4.1757754383430;
        Sat, 13 Sep 2025 02:06:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENFwGsYCj5we8cqrgqcps0vU//BTqxnSv90KfRfiVLx0DBHmLiooNtsdQvyKhq4QCqGgNKww==
X-Received: by 2002:a92:ca4d:0:b0:419:de32:2d01 with SMTP id e9e14a558f8ab-420a1bf0e2amr28604185ab.4.1757754383024;
        Sat, 13 Sep 2025 02:06:23 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-41deede6d15sm31335025ab.7.2025.09.13.02.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 02:06:21 -0700 (PDT)
Date: Sat, 13 Sep 2025 10:04:57 +0100
From: Alex Williamson <alex.williamson@redhat.com>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 helgaas@kernel.org, schnelle@linux.ibm.com, mjrosato@linux.ibm.com
Subject: Re: [PATCH v3 08/10] vfio-pci/zdev: Add a device feature for error
 information
Message-ID: <20250913100457.1af13cd7.alex.williamson@redhat.com>
In-Reply-To: <20250911183307.1910-9-alifm@linux.ibm.com>
References: <20250911183307.1910-1-alifm@linux.ibm.com>
	<20250911183307.1910-9-alifm@linux.ibm.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Sep 2025 11:33:05 -0700
Farhan Ali <alifm@linux.ibm.com> wrote:

> For zPCI devices, we have platform specific error information. The platform
> firmware provides this error information to the operating system in an
> architecture specific mechanism. To enable recovery from userspace for
> these devices, we want to expose this error information to userspace. Add a
> new device feature to expose this information.
> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c |  2 ++
>  drivers/vfio/pci/vfio_pci_priv.h |  8 ++++++++
>  drivers/vfio/pci/vfio_pci_zdev.c | 34 ++++++++++++++++++++++++++++++++
>  include/uapi/linux/vfio.h        | 14 +++++++++++++
>  4 files changed, 58 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 7dcf5439dedc..378adb3226db 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1514,6 +1514,8 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
>  		return vfio_pci_core_pm_exit(device, flags, arg, argsz);
>  	case VFIO_DEVICE_FEATURE_PCI_VF_TOKEN:
>  		return vfio_pci_core_feature_token(device, flags, arg, argsz);
> +	case VFIO_DEVICE_FEATURE_ZPCI_ERROR:
> +		return vfio_pci_zdev_feature_err(device, flags, arg, argsz);
>  	default:
>  		return -ENOTTY;
>  	}
> diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
> index a9972eacb293..a4a7f97fdc2e 100644
> --- a/drivers/vfio/pci/vfio_pci_priv.h
> +++ b/drivers/vfio/pci/vfio_pci_priv.h
> @@ -86,6 +86,8 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
>  				struct vfio_info_cap *caps);
>  int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev);
>  void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev);
> +int vfio_pci_zdev_feature_err(struct vfio_device *device, u32 flags,
> +			      void __user *arg, size_t argsz);
>  #else
>  static inline int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
>  					      struct vfio_info_cap *caps)
> @@ -100,6 +102,12 @@ static inline int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
>  
>  static inline void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev)
>  {}
> +
> +static int vfio_pci_zdev_feature_err(struct vfio_device *device, u32 flags,
> +				     void __user *arg, size_t argsz);
> +{
> +	return -ENODEV;
> +}
>  #endif
>  
>  static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
> diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
> index 2be37eab9279..261954039aa9 100644
> --- a/drivers/vfio/pci/vfio_pci_zdev.c
> +++ b/drivers/vfio/pci/vfio_pci_zdev.c
> @@ -141,6 +141,40 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
>  	return ret;
>  }
>  
> +int vfio_pci_zdev_feature_err(struct vfio_device *device, u32 flags,
> +			      void __user *arg, size_t argsz)
> +{
> +	struct vfio_device_feature_zpci_err err;
> +	struct vfio_pci_core_device *vdev =
> +		container_of(device, struct vfio_pci_core_device, vdev);
> +	struct zpci_dev *zdev = to_zpci(vdev->pdev);
> +	int ret;
> +	int head = 0;
> +
> +	if (!zdev)
> +		return -ENODEV;
> +
> +	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_GET,
> +				 sizeof(err));
> +	if (ret != 1)
> +		return ret;
> +
> +	mutex_lock(&zdev->pending_errs_lock);
> +	if (zdev->pending_errs.count) {
> +		head = zdev->pending_errs.head % ZPCI_ERR_PENDING_MAX;
> +		err.pec = zdev->pending_errs.err[head].pec;
> +		zdev->pending_errs.head++;
> +		zdev->pending_errs.count--;
> +		err.pending_errors = zdev->pending_errs.count;
> +	}
> +	mutex_unlock(&zdev->pending_errs_lock);
> +
> +	if (copy_to_user(arg, &err, sizeof(err)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
>  int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
>  {
>  	struct zpci_dev *zdev = to_zpci(vdev->pdev);
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 75100bf009ba..a950c341602d 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -1478,6 +1478,20 @@ struct vfio_device_feature_bus_master {
>  };
>  #define VFIO_DEVICE_FEATURE_BUS_MASTER 10
>  
> +/**
> + * VFIO_DEVICE_FEATURE_ZPCI_ERROR feature provides PCI error information to
> + * userspace for vfio-pci devices on s390x. On s390x PCI error recovery involves
> + * platform firmware and notification to operating system is done by
> + * architecture specific mechanism.  Exposing this information to userspace
> + * allows userspace to take appropriate actions to handle an error on the
> + * device.
> + */
> +struct vfio_device_feature_zpci_err {
> +	__u16 pec;
> +	int pending_errors;
> +};

This should have some explicit alignment.  Thanks,

Alex

> +#define VFIO_DEVICE_FEATURE_ZPCI_ERROR 11
> +
>  /* -------- API for Type1 VFIO IOMMU -------- */
>  
>  /**

