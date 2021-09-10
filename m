Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD46C433EF
	for <linux-s390@archiver.kernel.org>; Fri, 10 Sep 2021 20:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A15161059
	for <linux-s390@archiver.kernel.org>; Fri, 10 Sep 2021 20:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbhIJU0r (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 10 Sep 2021 16:26:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43647 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233384AbhIJU0q (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 10 Sep 2021 16:26:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631305535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=43k0//Ex2cYDlTEbrRHwYvccCOHqUEbEWZ9s5rg8S24=;
        b=SdjHtmrpIreBKu4aaZgJcCZSd1ynNGJ8vRVqadDJfMxHtzxM6BC57uVBkftfqvAT4rUIAp
        yj2So4+bj2Z+4aW+TFQ7aSGaGrW/DZlFRMYmFkTP10AzNHUlRTt44srRaxQ9JXluw6iwu1
        r8Q9qONu5FijySKfjyXInaQjjekEPc0=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-uAt1uhF8MqS2zo8ZKxIBAg-1; Fri, 10 Sep 2021 16:25:34 -0400
X-MC-Unique: uAt1uhF8MqS2zo8ZKxIBAg-1
Received: by mail-oi1-f199.google.com with SMTP id o8-20020a0568080bc800b0026bf78d5d98so2372426oik.19
        for <linux-s390@vger.kernel.org>; Fri, 10 Sep 2021 13:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=43k0//Ex2cYDlTEbrRHwYvccCOHqUEbEWZ9s5rg8S24=;
        b=6obRSRGun8FEF1wOmDpX79ekeCDJU2ETzIc2GkYZ3R8q4oPv4RmHw0oXMJyOZyDRx+
         JZGy3Rkd8TTNEDZvHmskxOC/q4BhnpmrnPn9iwx/0syDLeJW/IS/cScg/xS3kM6DOTua
         NgTdl1Llc1ytvAsp77Pn7M9lD1NbkewPpVbXBLmu8z30pXedEfF+krrlzaMsFBloceeh
         QkNwXiCukKAoCGE9XkmENrrIPr4fjxVC193jS16BrGpPiVtfGdqHVbHD/jXB2CJR1Bb/
         to4d95tsENDnzmkbi8j53IsPN3MHf7kUdDSuZpgjrpxyHnlJYqq+S8oFjBBZbJuudMhf
         idEw==
X-Gm-Message-State: AOAM5301t4SWpBkTFGVvfntKpM2/cPch78Q90GN5VTA0dlkqHRhchiCh
        3Lulk+1SymuKgNuuG4+bZEZTZTH7xT4O9n3BPoiNwxrF+qhWMWRa/THeOdrRXhYKWyFiaijOd5J
        HRx8fJnv+VIGybiRAOIHbXA==
X-Received: by 2002:a05:6830:18c7:: with SMTP id v7mr6324372ote.126.1631305533202;
        Fri, 10 Sep 2021 13:25:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYrFnBjgHbgw4oFL2xGmKazRhOApYuH6K1Sj3HlCQm6wWY57BvwLdhxibj8FSVdeN7/KJt5g==
X-Received: by 2002:a05:6830:18c7:: with SMTP id v7mr6324353ote.126.1631305532962;
        Fri, 10 Sep 2021 13:25:32 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id 33sm1446635otx.19.2021.09.10.13.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 13:25:32 -0700 (PDT)
Date:   Fri, 10 Sep 2021 14:25:31 -0600
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
Subject: Re: [PATCH] vfio/ap_ops: Add missed vfio_uninit_group_dev()
Message-ID: <20210910142531.2e18e73a.alex.williamson@redhat.com>
In-Reply-To: <0-v1-3a05c6000668+2ce62-ap_uninit_jgg@nvidia.com>
References: <0-v1-3a05c6000668+2ce62-ap_uninit_jgg@nvidia.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu,  9 Sep 2021 14:24:00 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> Without this call an xarray entry is leaked when the vfio_ap device is
> unprobed. It was missed when the below patch was rebased across the
> dev_set patch.
> 
> Fixes: eb0feefd4c02 ("vfio/ap_ops: Convert to use vfio_register_group_dev()")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c | 2 ++
>  1 file changed, 2 insertions(+)
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
> @@ -375,8 +376,8 @@ static void vfio_ap_mdev_remove(struct mdev_device *mdev)


Not sure if you're editing patches by hand, but your line counts above
don't match the chunk below, should be ,6..,7 as the previous chunk.
It's malformed as is.  Thanks,

Alex

>  	mutex_lock(&matrix_dev->lock);
>  	vfio_ap_mdev_reset_queues(matrix_mdev);
>  	list_del(&matrix_mdev->node);
> +	vfio_uninit_group_dev(&matrix_mdev->vdev);
>  	kfree(matrix_mdev);
>  	atomic_inc(&matrix_dev->available_instances);
>  	mutex_unlock(&matrix_dev->lock);
> 

