Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630EBC43334
	for <linux-s390@archiver.kernel.org>; Tue, 28 Jun 2022 14:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbiF1O7R (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 28 Jun 2022 10:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347233AbiF1O7N (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 28 Jun 2022 10:59:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9DC452B267
        for <linux-s390@vger.kernel.org>; Tue, 28 Jun 2022 07:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656428351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aErs5J0PWDeHLJbFtfkDMT+d/kxZ2NI6oKnOd4kVTIE=;
        b=OVbwPeqE1XIR7YGGyl+9c5GEJ13D9BtNWHX1J9WKFAn+i9VYzh+5rtXBjaNq9eikqcVJ5o
        sZsmHVhNl1IC8+pRPuTTRLVawPuQZjD4iVdoRDqe4+VuNjI7n7gec8PomJ68Prz7AzuNIY
        YAPUTsKOW9fH1mJxk9ZJ8xyvX86/FeI=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-84-O-n2UZHuNfmEUt_gpIClpw-1; Tue, 28 Jun 2022 10:59:05 -0400
X-MC-Unique: O-n2UZHuNfmEUt_gpIClpw-1
Received: by mail-io1-f72.google.com with SMTP id d11-20020a6bb40b000000b006727828a19fso7359798iof.15
        for <linux-s390@vger.kernel.org>; Tue, 28 Jun 2022 07:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=aErs5J0PWDeHLJbFtfkDMT+d/kxZ2NI6oKnOd4kVTIE=;
        b=jcQHZFpKRe/Djy0ZHonskGpL480q5Q9452K2dzG9tKbyy3h0PHDJs5cSatNh6ICzpF
         w0fxdTBGlSHPyeCOCRqLssUko9NO0nGvvuXJrPfOZUNoUHcMO30UF6v2DujqB+ZoQhej
         h+JOlt2YQHTCZycjM5g8oV6M2CUwYmj1HCv1gvFdsz7TZklZWvmptNig6lE9W66gJNUU
         jXwgx0okcCjWh4WTeh1Ug3xNW9YcJUdEZd2tEHtOALh1r9JI3Kj87YHJAkyunYY/sMZA
         PP60rPjGhs6StEXtCFt2HHLv4A3+CuClfeXUFR9uSZJYW81PkSNfs9bEOi+W2HZusaVM
         r+1w==
X-Gm-Message-State: AJIora905zP0RMjx24lIjCwnEW2QLpCoExYtH6yU6JjNXRXAJTBqkXiU
        igYjANOuoPQzcFKXY6ei5v8J6CJGwXqmKAhL2mszARuaMR6a5oNrqKM1pDUV2O25tDojFtT8OHw
        N+8Mt6bvhJBCX6N7DG3zNdA==
X-Received: by 2002:a05:6602:1d4:b0:672:4ea0:e34a with SMTP id w20-20020a05660201d400b006724ea0e34amr9399832iot.107.1656428344724;
        Tue, 28 Jun 2022 07:59:04 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ufpxgA/kaaUg+eSobaX7s+4Q0m1hZPsKdJjvg6M//DeHs6h8kNvyoKWaVYQFIRjH52wQRQtQ==
X-Received: by 2002:a05:6602:1d4:b0:672:4ea0:e34a with SMTP id w20-20020a05660201d400b006724ea0e34amr9399813iot.107.1656428344519;
        Tue, 28 Jun 2022 07:59:04 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id bm13-20020a05663842cd00b0032ead96ee5csm5987285jab.165.2022.06.28.07.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 07:59:04 -0700 (PDT)
Date:   Tue, 28 Jun 2022 08:59:02 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, cohuck@redhat.com,
        schnelle@linux.ibm.com, farman@linux.ibm.com, pmorel@linux.ibm.com,
        borntraeger@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com,
        imbrenda@linux.ibm.com, vneethv@linux.ibm.com,
        oberpar@linux.ibm.com, freude@linux.ibm.com, thuth@redhat.com,
        pasic@linux.ibm.com, pbonzini@redhat.com, corbet@lwn.net,
        jgg@nvidia.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v9 17/21] vfio-pci/zdev: add open/close device hooks
Message-ID: <20220628085902.208c106e.alex.williamson@redhat.com>
In-Reply-To: <20220606203325.110625-18-mjrosato@linux.ibm.com>
References: <20220606203325.110625-1-mjrosato@linux.ibm.com>
        <20220606203325.110625-18-mjrosato@linux.ibm.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon,  6 Jun 2022 16:33:21 -0400
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> During vfio-pci open_device, pass the KVM associated with the vfio group
> (if one exists).  This is needed in order to pass a special indicator
> (GISA) to firmware to allow zPCI interpretation facilities to be used
> for only the specific KVM associated with the vfio-pci device.  During
> vfio-pci close_device, unregister the notifier.
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 10 +++++++++-
>  drivers/vfio/pci/vfio_pci_zdev.c | 24 ++++++++++++++++++++++++
>  include/linux/vfio_pci_core.h    | 10 ++++++++++
>  3 files changed, 43 insertions(+), 1 deletion(-)


Acked-by: Alex Williamson <alex.williamson@redhat.com>


> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index a0d69ddaf90d..b1e5cfbadf38 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -316,10 +316,14 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
>  		pci_write_config_word(pdev, PCI_COMMAND, cmd);
>  	}
>  
> -	ret = vfio_config_init(vdev);
> +	ret = vfio_pci_zdev_open_device(vdev);
>  	if (ret)
>  		goto out_free_state;
>  
> +	ret = vfio_config_init(vdev);
> +	if (ret)
> +		goto out_free_zdev;
> +
>  	msix_pos = pdev->msix_cap;
>  	if (msix_pos) {
>  		u16 flags;
> @@ -340,6 +344,8 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
>  
>  	return 0;
>  
> +out_free_zdev:
> +	vfio_pci_zdev_close_device(vdev);
>  out_free_state:
>  	kfree(vdev->pci_saved_state);
>  	vdev->pci_saved_state = NULL;
> @@ -418,6 +424,8 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
>  
>  	vdev->needs_reset = true;
>  
> +	vfio_pci_zdev_close_device(vdev);
> +
>  	/*
>  	 * If we have saved state, restore it.  If we can reset the device,
>  	 * even better.  Resetting with current state seems better than
> diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
> index ea4c0d2b0663..686f2e75e392 100644
> --- a/drivers/vfio/pci/vfio_pci_zdev.c
> +++ b/drivers/vfio/pci/vfio_pci_zdev.c
> @@ -11,6 +11,7 @@
>  #include <linux/uaccess.h>
>  #include <linux/vfio.h>
>  #include <linux/vfio_zdev.h>
> +#include <linux/kvm_host.h>
>  #include <asm/pci_clp.h>
>  #include <asm/pci_io.h>
>  
> @@ -136,3 +137,26 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
>  
>  	return ret;
>  }
> +
> +int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
> +{
> +	struct zpci_dev *zdev = to_zpci(vdev->pdev);
> +
> +	if (!zdev)
> +		return -ENODEV;
> +
> +	if (!vdev->vdev.kvm)
> +		return 0;
> +
> +	return kvm_s390_pci_register_kvm(zdev, vdev->vdev.kvm);
> +}
> +
> +void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev)
> +{
> +	struct zpci_dev *zdev = to_zpci(vdev->pdev);
> +
> +	if (!zdev || !vdev->vdev.kvm)
> +		return;
> +
> +	kvm_s390_pci_unregister_kvm(zdev);
> +}
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index 63af2897939c..d5d9e17f0156 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -209,12 +209,22 @@ static inline int vfio_pci_igd_init(struct vfio_pci_core_device *vdev)
>  #ifdef CONFIG_VFIO_PCI_ZDEV_KVM
>  extern int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
>  				       struct vfio_info_cap *caps);
> +int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev);
> +void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev);
>  #else
>  static inline int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
>  					      struct vfio_info_cap *caps)
>  {
>  	return -ENODEV;
>  }
> +
> +static inline int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
> +{
> +	return 0;
> +}
> +
> +static inline void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev)
> +{}
>  #endif
>  
>  /* Will be exported for vfio pci drivers usage */

