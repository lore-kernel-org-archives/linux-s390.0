Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF447C433EF
	for <linux-s390@archiver.kernel.org>; Tue,  8 Feb 2022 17:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384372AbiBHRn2 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 8 Feb 2022 12:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384360AbiBHRn1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Feb 2022 12:43:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B247C06157A
        for <linux-s390@vger.kernel.org>; Tue,  8 Feb 2022 09:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644342205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fTAtQQtX8ynRTOTjJerCkOOYhkWBiy04WDPWHFPH1vo=;
        b=aPl86JgzO6XXTb5h7sUe0LlxzbCDYZ7sMK5BZbuWkiQoaUi6Mx6WaddB+hDKXe26p5iHiH
        Vba/r9NNrkyfb+OK6NEhVSnAGvAetOip9cSI723PWq6biWU1tVkNhHM2oI7t743bCeAT7d
        cA13QH1sjogH/o0hXjo9XwEdnRZzvhg=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-119-OFNwAsHbMD66lvMDL4b6OA-1; Tue, 08 Feb 2022 12:43:24 -0500
X-MC-Unique: OFNwAsHbMD66lvMDL4b6OA-1
Received: by mail-oo1-f69.google.com with SMTP id n8-20020a4abd08000000b002eabaaab571so11828319oop.11
        for <linux-s390@vger.kernel.org>; Tue, 08 Feb 2022 09:43:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=fTAtQQtX8ynRTOTjJerCkOOYhkWBiy04WDPWHFPH1vo=;
        b=khOmnqtsLjbs0KcHiiFo9vbbv6vvLFSrjrOH8se8RSwnS3f3nCDlqhPm3U980/gtnR
         Aq1AtKQSDAeQYAXOVzSh8/Z3mbbg4DD2akIWVeEM/T2iBmfhnpo1e04BQLxWdHI9iGyH
         BU81/CR+mA+fp+9U9qf/zjhX1DDT24Z6P93c9ULjfJ6Y/Nd9D1vhQHYCz4gqMv4qZMq0
         3howvnVqDAhszm6SGqsM3fDd4f0XQjDATlQz9Iuuo0eTywsrdt0SK+NE5KPsGuFGSL9m
         h3BpXwjCNoSi8vbLTAw45OcfjMID7gXMQLg34mD4SBicXJFeVRIjLEXWI6lPj1qC92q7
         h6cA==
X-Gm-Message-State: AOAM533sqDIVams0SJhwSgTeqv+95WpgHG0efZXFL6sHkfy140nboW6X
        V8c85UeHu0RVMvzQ3+NJDZwHaGxcK8RMaecuoQX3fM5vUOucAEE/Ri7IyGN/xK557HDXED3BxeI
        j6dv52JmdrsyeSLqenWLIFQ==
X-Received: by 2002:a9d:7745:: with SMTP id t5mr2336031otl.254.1644342201839;
        Tue, 08 Feb 2022 09:43:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwO9ltSzIoG91Af/O1KWvnxNeiLqj6JxqFTQKli+Ed+9vVShlH1mHu2H9ZNDPJSfzOIE9vpMQ==
X-Received: by 2002:a9d:7745:: with SMTP id t5mr2336007otl.254.1644342201559;
        Tue, 08 Feb 2022 09:43:21 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id 12sm6101166oaj.31.2022.02.08.09.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 09:43:21 -0800 (PST)
Date:   Tue, 8 Feb 2022 10:43:19 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, cohuck@redhat.com,
        schnelle@linux.ibm.com, farman@linux.ibm.com, pmorel@linux.ibm.com,
        borntraeger@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        vneethv@linux.ibm.com, oberpar@linux.ibm.com, freude@linux.ibm.com,
        thuth@redhat.com, pasic@linux.ibm.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 24/30] vfio-pci/zdev: wire up group notifier
Message-ID: <20220208104319.4861fb22.alex.williamson@redhat.com>
In-Reply-To: <20220204211536.321475-25-mjrosato@linux.ibm.com>
References: <20220204211536.321475-1-mjrosato@linux.ibm.com>
        <20220204211536.321475-25-mjrosato@linux.ibm.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri,  4 Feb 2022 16:15:30 -0500
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> KVM zPCI passthrough device logic will need a reference to the associated
> kvm guest that has access to the device.  Let's register a group notifier
> for VFIO_GROUP_NOTIFY_SET_KVM to catch this information in order to create
> an association between a kvm guest and the host zdev.
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>  arch/s390/include/asm/kvm_pci.h  |  2 ++
>  drivers/vfio/pci/vfio_pci_core.c |  2 ++
>  drivers/vfio/pci/vfio_pci_zdev.c | 46 ++++++++++++++++++++++++++++++++
>  include/linux/vfio_pci_core.h    | 10 +++++++
>  4 files changed, 60 insertions(+)
> 
> diff --git a/arch/s390/include/asm/kvm_pci.h b/arch/s390/include/asm/kvm_pci.h
> index e4696f5592e1..16290b4cf2a6 100644
> --- a/arch/s390/include/asm/kvm_pci.h
> +++ b/arch/s390/include/asm/kvm_pci.h
> @@ -16,6 +16,7 @@
>  #include <linux/kvm.h>
>  #include <linux/pci.h>
>  #include <linux/mutex.h>
> +#include <linux/notifier.h>
>  #include <asm/pci_insn.h>
>  #include <asm/pci_dma.h>
>  
> @@ -32,6 +33,7 @@ struct kvm_zdev {
>  	u64 rpcit_count;
>  	struct kvm_zdev_ioat ioat;
>  	struct zpci_fib fib;
> +	struct notifier_block nb;
>  };
>  
>  int kvm_s390_pci_dev_open(struct zpci_dev *zdev);
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index f948e6cd2993..fc57d4d0abbe 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -452,6 +452,7 @@ void vfio_pci_core_close_device(struct vfio_device *core_vdev)
>  
>  	vfio_pci_vf_token_user_add(vdev, -1);
>  	vfio_spapr_pci_eeh_release(vdev->pdev);
> +	vfio_pci_zdev_release(vdev);
>  	vfio_pci_core_disable(vdev);
>  
>  	mutex_lock(&vdev->igate);
> @@ -470,6 +471,7 @@ EXPORT_SYMBOL_GPL(vfio_pci_core_close_device);
>  void vfio_pci_core_finish_enable(struct vfio_pci_core_device *vdev)
>  {
>  	vfio_pci_probe_mmaps(vdev);
> +	vfio_pci_zdev_open(vdev);
>  	vfio_spapr_pci_eeh_open(vdev->pdev);
>  	vfio_pci_vf_token_user_add(vdev, 1);
>  }

If this handling were for a specific device, I think we'd be suggesting
this is the point at which we cross over to a vendor variant making use
of vfio-pci-core rather than hooking directly into the core code.  But
this is meant to extend vfio-pci proper for the whole arch.  Is there a
compromise in using #ifdefs in vfio_pci_ops to call into zpci specific
code that implements these arch specific hooks and the core for
everything else?  SPAPR code could probably converted similarly, it
exists here for legacy reasons. [Cc Jason]

Also, please note the DEVICE_FEATURE generalizations in the latest
series from NVIDIA for mlx5 migration support:

https://lore.kernel.org/all/20220207172216.206415-8-yishaih@nvidia.com/

If this series were to go in via the s390 tree, I'd request a branch so
that we can continue to work on this in vfio code as well.  Thanks,

Alex

> diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
> index ea4c0d2b0663..9f8284499111 100644
> --- a/drivers/vfio/pci/vfio_pci_zdev.c
> +++ b/drivers/vfio/pci/vfio_pci_zdev.c
> @@ -13,6 +13,7 @@
>  #include <linux/vfio_zdev.h>
>  #include <asm/pci_clp.h>
>  #include <asm/pci_io.h>
> +#include <asm/kvm_pci.h>
>  
>  #include <linux/vfio_pci_core.h>
>  
> @@ -136,3 +137,48 @@ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
>  
>  	return ret;
>  }
> +
> +static int vfio_pci_zdev_group_notifier(struct notifier_block *nb,
> +					unsigned long action, void *data)
> +{
> +	struct kvm_zdev *kzdev = container_of(nb, struct kvm_zdev, nb);
> +
> +	if (action == VFIO_GROUP_NOTIFY_SET_KVM) {
> +		if (!data || !kzdev->zdev)
> +			return NOTIFY_DONE;
> +		kzdev->kvm = data;
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
> +void vfio_pci_zdev_open(struct vfio_pci_core_device *vdev)
> +{
> +	unsigned long events = VFIO_GROUP_NOTIFY_SET_KVM;
> +	struct zpci_dev *zdev = to_zpci(vdev->pdev);
> +
> +	if (!zdev)
> +		return;
> +
> +	if (kvm_s390_pci_dev_open(zdev))
> +		return;
> +
> +	zdev->kzdev->nb.notifier_call = vfio_pci_zdev_group_notifier;
> +
> +	if (vfio_register_notifier(vdev->vdev.dev, VFIO_GROUP_NOTIFY,
> +				   &events, &zdev->kzdev->nb))
> +		kvm_s390_pci_dev_release(zdev);
> +}
> +
> +void vfio_pci_zdev_release(struct vfio_pci_core_device *vdev)
> +{
> +	struct zpci_dev *zdev = to_zpci(vdev->pdev);
> +
> +	if (!zdev || !zdev->kzdev)
> +		return;
> +
> +	vfio_unregister_notifier(vdev->vdev.dev, VFIO_GROUP_NOTIFY,
> +				 &zdev->kzdev->nb);
> +
> +	kvm_s390_pci_dev_release(zdev);
> +}
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index 5e2bca3b89db..05287f8ac855 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -198,12 +198,22 @@ static inline int vfio_pci_igd_init(struct vfio_pci_core_device *vdev)
>  #ifdef CONFIG_VFIO_PCI_ZDEV
>  extern int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
>  				       struct vfio_info_cap *caps);
> +void vfio_pci_zdev_open(struct vfio_pci_core_device *vdev);
> +void vfio_pci_zdev_release(struct vfio_pci_core_device *vdev);
>  #else
>  static inline int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
>  					      struct vfio_info_cap *caps)
>  {
>  	return -ENODEV;
>  }
> +
> +static inline void vfio_pci_zdev_open(struct vfio_pci_core_device *vdev)
> +{
> +}
> +
> +static inline void vfio_pci_zdev_release(struct vfio_pci_core_device *vdev)
> +{
> +}
>  #endif
>  
>  /* Will be exported for vfio pci drivers usage */

