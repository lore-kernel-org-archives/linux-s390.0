Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C545C433EF
	for <linux-s390@archiver.kernel.org>; Tue, 28 Jun 2022 14:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347265AbiF1O7u (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 28 Jun 2022 10:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345917AbiF1O7t (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 28 Jun 2022 10:59:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F6872B278
        for <linux-s390@vger.kernel.org>; Tue, 28 Jun 2022 07:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656428387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NA1Sz+wVDcR/rJAU5bZ+/3HiC4NCXtugc0RNHSSRKEs=;
        b=XpTmOph4cUtnCqMzCBCKSllRh0oN8FpUf7IqC5IIEx70YLurRd5H1z+RxL+uxEVeE6bzzl
        yzi+ED2dyJoZp/bc0Ht/+5sYJcJd2qFBWcF8meWqspr6uyn9zgln647d1ZJ2wM9/CRvxU3
        oMPqQuNYc3QiJXefTVLbD8spkBTj16I=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-670-2ZfXl5UePzeLX0reMxK1sA-1; Tue, 28 Jun 2022 10:59:46 -0400
X-MC-Unique: 2ZfXl5UePzeLX0reMxK1sA-1
Received: by mail-io1-f69.google.com with SMTP id c8-20020a056602334800b0067500ca88aaso6886634ioz.0
        for <linux-s390@vger.kernel.org>; Tue, 28 Jun 2022 07:59:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=NA1Sz+wVDcR/rJAU5bZ+/3HiC4NCXtugc0RNHSSRKEs=;
        b=u+VOViAURO3FnL0cBnKAulKnq7yyIeaiG9us4rrlQyscBZuUzu6qxRdNGkiWseZJ70
         zGlxNgq2J1V+vXTXU5jGim36Owu2REMPOV9AVvvn7MpCf+QcaJIe/ma8eLB98B2wseAV
         +dZv3wkovIoLSeJNzll7pWS2eICNmPOHuQM77HicyQvPoFXsYI0u/DfEGcnaqNSikgnX
         9CJXcc5l5xmdSliHEngvGZBXUebz06PQ2e1ZaO2yH1+rZ7dLrv+2f0O72lpQ9pIGtcnf
         W7ZuIBnyNb37c+EU62zbcKBSVGi148rl9qUX20QhqusuBillX85q3sPb690PdvibVAJq
         T3uA==
X-Gm-Message-State: AJIora9qG8kd0Vxg5edjmlUp0Mj6X4zfFdCUfyRg1p4w9KGxwaXL7BeX
        FDTC9vFdewdBDptUpXEKew071RIFoKNCDY41nZ7IBWkhZZakj4eywyrRlWGDIV5kTywo3ejF0Gv
        22LDfdFf4xeoJNjx5CgulFg==
X-Received: by 2002:a05:6638:3712:b0:33c:9cc6:58ce with SMTP id k18-20020a056638371200b0033c9cc658cemr6323979jav.127.1656428385760;
        Tue, 28 Jun 2022 07:59:45 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tedjbCrxuwywAC/MaACC3UdjIhVsYgmBCdcJODdrmWI+w3P8UU7WCJxxIy6LT8tcQ21NG+VA==
X-Received: by 2002:a05:6638:3712:b0:33c:9cc6:58ce with SMTP id k18-20020a056638371200b0033c9cc658cemr6323960jav.127.1656428385576;
        Tue, 28 Jun 2022 07:59:45 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id o9-20020a056638124900b00331767e8113sm6193295jas.52.2022.06.28.07.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 07:59:45 -0700 (PDT)
Date:   Tue, 28 Jun 2022 08:59:43 -0600
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
Subject: Re: [PATCH v9 18/21] vfio-pci/zdev: add function handle to clp base
 capability
Message-ID: <20220628085943.5d4d5646.alex.williamson@redhat.com>
In-Reply-To: <20220606203325.110625-19-mjrosato@linux.ibm.com>
References: <20220606203325.110625-1-mjrosato@linux.ibm.com>
        <20220606203325.110625-19-mjrosato@linux.ibm.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon,  6 Jun 2022 16:33:22 -0400
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> The function handle is a system-wide unique identifier for a zPCI
> device.  With zPCI instruction interpretation, the host will no
> longer be executing the zPCI instructions on behalf of the guest.
> As a result, the guest needs to use the real function handle in
> order for firmware to associate the instruction with the proper
> PCI function.  Let's provide that handle to the guest.
> 
> Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>  drivers/vfio/pci/vfio_pci_zdev.c | 5 +++--
>  include/uapi/linux/vfio_zdev.h   | 3 +++
>  2 files changed, 6 insertions(+), 2 deletions(-)


Acked-by: Alex Williamson <alex.williamson@redhat.com>


> diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
> index 686f2e75e392..4f28cdd7ecd1 100644
> --- a/drivers/vfio/pci/vfio_pci_zdev.c
> +++ b/drivers/vfio/pci/vfio_pci_zdev.c
> @@ -24,14 +24,15 @@ static int zpci_base_cap(struct zpci_dev *zdev, struct vfio_info_cap *caps)
>  {
>  	struct vfio_device_info_cap_zpci_base cap = {
>  		.header.id = VFIO_DEVICE_INFO_CAP_ZPCI_BASE,
> -		.header.version = 1,
> +		.header.version = 2,
>  		.start_dma = zdev->start_dma,
>  		.end_dma = zdev->end_dma,
>  		.pchid = zdev->pchid,
>  		.vfn = zdev->vfn,
>  		.fmb_length = zdev->fmb_length,
>  		.pft = zdev->pft,
> -		.gid = zdev->pfgid
> +		.gid = zdev->pfgid,
> +		.fh = zdev->fh
>  	};
>  
>  	return vfio_info_add_capability(caps, &cap.header, sizeof(cap));
> diff --git a/include/uapi/linux/vfio_zdev.h b/include/uapi/linux/vfio_zdev.h
> index b4309397b6b2..78c022af3d29 100644
> --- a/include/uapi/linux/vfio_zdev.h
> +++ b/include/uapi/linux/vfio_zdev.h
> @@ -29,6 +29,9 @@ struct vfio_device_info_cap_zpci_base {
>  	__u16 fmb_length;	/* Measurement Block Length (in bytes) */
>  	__u8 pft;		/* PCI Function Type */
>  	__u8 gid;		/* PCI function group ID */
> +	/* End of version 1 */
> +	__u32 fh;		/* PCI function handle */
> +	/* End of version 2 */
>  };
>  
>  /**

