Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CB3C433EF
	for <linux-s390@archiver.kernel.org>; Thu, 16 Sep 2021 18:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4DE660462
	for <linux-s390@archiver.kernel.org>; Thu, 16 Sep 2021 18:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345880AbhIPSw5 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 16 Sep 2021 14:52:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20046 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349710AbhIPSwz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 16 Sep 2021 14:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631818294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t0dZXEuvtEjF+iOlGPVVpNuboXtZjlBCWt2sC2E9Ta0=;
        b=iKTjSg/pY1mXJ2R4NvqoHR8JcnJ9PB7r7/Tgnw7snAuXR6HMSFC8ciFg/ik7Pdoe3GMYBe
        OlEOqZ6D66IA6arut7V2UQlA48802suI2p2c1v563CB1fS++ABbWFYVqUxz7pzpz01E9Lk
        COHgnnxitUGNhpVWdE0cpNv82QVRPHA=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-EYbq7bGuMGW_cVAMIHEFZA-1; Thu, 16 Sep 2021 14:51:32 -0400
X-MC-Unique: EYbq7bGuMGW_cVAMIHEFZA-1
Received: by mail-oi1-f197.google.com with SMTP id s10-20020a056808008a00b00268c82cc7a0so30723820oic.14
        for <linux-s390@vger.kernel.org>; Thu, 16 Sep 2021 11:51:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=t0dZXEuvtEjF+iOlGPVVpNuboXtZjlBCWt2sC2E9Ta0=;
        b=MOUS2vwmuLqZEemy45KWCBNhQvr+cnuGoIWU86LNIjfPfsiVsGP7mg+nXWNeKb1sXv
         fPcNTnPnPvt05ZdVgUnTODUdjftEglMwOrRqAswK51Oxk9BoWy7yoagNPZn/cdpgmXy9
         4r9L3oDXvoPKgUN+LOBvyS0tl/rS9QeRTwI39bICJKBPYia2ykdWHiyBInvuD4vsrgUl
         Ifr4QAtV1RQxdath9ZobPp2IjbRP5Xzi47NFoG9JuofzPJrTnihgaGq6NDngRJ2DQvEN
         5fDgWPyxyFxGabAOa0ZPUuXK/BZvxoxyfWhtaMXXUfbc+8Agy1O57V+91GQktXlfQRGv
         rgdA==
X-Gm-Message-State: AOAM5307nX0q7D0q0ozV0KfaaeTKS58RucbepjHw99KrvNP4m52JuvOK
        PMblxY5OMOk4bCUJcklmrVNO+pd1w1i7wnLV6H9u5Hycnj9IrePmjfhqG+zOHBWiQUTk4u+Sirw
        zwFBuTO4ZLKjP+cIu2lFT8w==
X-Received: by 2002:aca:6254:: with SMTP id w81mr980163oib.83.1631818292324;
        Thu, 16 Sep 2021 11:51:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwG5lUyD94BxYl3xRntKqwsHjZwEOV6TUGUMKu8At8EeuUfhEszbIKW3Ykbxrnhdgjnid87Eg==
X-Received: by 2002:aca:6254:: with SMTP id w81mr980137oib.83.1631818292043;
        Thu, 16 Sep 2021 11:51:32 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id r20sm891428oot.16.2021.09.16.11.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 11:51:31 -0700 (PDT)
Date:   Thu, 16 Sep 2021 12:51:30 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        linux-s390@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Christoph Hellwig <hch@lst.de>, kvm@vger.kernel.org
Subject: Re: [PATCH v2] vfio/ap_ops: Add missed vfio_uninit_group_dev()
Message-ID: <20210916125130.2db0961e.alex.williamson@redhat.com>
In-Reply-To: <0-v2-25656bbbb814+41-ap_uninit_jgg@nvidia.com>
References: <0-v2-25656bbbb814+41-ap_uninit_jgg@nvidia.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 10 Sep 2021 20:06:30 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> Without this call an xarray entry is leaked when the vfio_ap device is
> unprobed. It was missed when the below patch was rebased across the
> dev_set patch.
> 
> Fixes: eb0feefd4c02 ("vfio/ap_ops: Convert to use vfio_register_group_dev()")
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c | 2 ++
>  1 file changed, 2 insertions(+)

Hi Tony, Halil, Jason (H),

Any acks for this one?  Thanks,

Alex

 
> v2: Fix corrupted diff
> v1: https://lore.kernel.org/all/0-v1-3a05c6000668+2ce62-ap_uninit_jgg@nvidia.com/
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 2347808fa3e427..54bb0c22e8020e 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -360,6 +360,7 @@ static int vfio_ap_mdev_probe(struct mdev_device *mdev)
>  	mutex_lock(&matrix_dev->lock);
>  	list_del(&matrix_mdev->node);
>  	mutex_unlock(&matrix_dev->lock);
> +	vfio_uninit_group_dev(&matrix_mdev->vdev);
>  	kfree(matrix_mdev);
>  err_dec_available:
>  	atomic_inc(&matrix_dev->available_instances);
> @@ -375,6 +376,7 @@ static void vfio_ap_mdev_remove(struct mdev_device *mdev)
>  	mutex_lock(&matrix_dev->lock);
>  	vfio_ap_mdev_reset_queues(matrix_mdev);
>  	list_del(&matrix_mdev->node);
> +	vfio_uninit_group_dev(&matrix_mdev->vdev);
>  	kfree(matrix_mdev);
>  	atomic_inc(&matrix_dev->available_instances);
>  	mutex_unlock(&matrix_dev->lock);
> 
> base-commit: ea870730d83fc13a5fa2bd0e175176d7ac8a400a

