Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06ADC433B4
	for <linux-s390@archiver.kernel.org>; Mon, 26 Apr 2021 17:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8844E61007
	for <linux-s390@archiver.kernel.org>; Mon, 26 Apr 2021 17:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237628AbhDZRtz (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 26 Apr 2021 13:49:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30531 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236170AbhDZRty (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 26 Apr 2021 13:49:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619459352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2Crmi0DUyxYtIVOImM/xNxjHPY8pNvq03psOEn3ymWc=;
        b=KP8XmiWF3BXDi2eI1mJ7bEkKvHwGAOKMkma+LeU1XHnLpio2/NQwNJJbvIwqFaeLorUcNf
        enuXZmr4F5uX/pxHh5Fa8PC/yZ9JdCZLqPm1bdm5nf2F9fKo1Po22Ll7nopAGfDoMZwhd4
        JsPFtOPQmdraThWP6SiZoV68uGIItuQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-3LDSUsIaOeG-61I0BythoQ-1; Mon, 26 Apr 2021 13:49:08 -0400
X-MC-Unique: 3LDSUsIaOeG-61I0BythoQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D40AB1006C81;
        Mon, 26 Apr 2021 17:49:05 +0000 (UTC)
Received: from gondolin.fritz.box (ovpn-113-150.ams2.redhat.com [10.36.113.150])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A90560C4A;
        Mon, 26 Apr 2021 17:49:02 +0000 (UTC)
Date:   Mon, 26 Apr 2021 19:48:59 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Tony Krowiak <akrowiak@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        Halil Pasic <pasic@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Christoph Hellwig <hch@lst.de>,
        Leon Romanovsky <leonro@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Tarun Gupta <targupta@nvidia.com>
Subject: Re: [PATCH 06/12] vfio/ap_ops: Convert to use
 vfio_register_group_dev()
Message-ID: <20210426194859.1665730d.cohuck@redhat.com>
In-Reply-To: <6-v1-d88406ed308e+418-vfio3_jgg@nvidia.com>
References: <0-v1-d88406ed308e+418-vfio3_jgg@nvidia.com>
        <6-v1-d88406ed308e+418-vfio3_jgg@nvidia.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 23 Apr 2021 20:03:03 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> This is straightforward conversion, the ap_matrix_mdev is actually serving
> as the vfio_device and we can replace all the mdev_get_drvdata()'s with a
> simple container_of().
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c     | 137 ++++++++++++++++----------
>  drivers/s390/crypto/vfio_ap_private.h |   2 +
>  2 files changed, 89 insertions(+), 50 deletions(-)
> 

(...)

> -static int vfio_ap_mdev_remove(struct mdev_device *mdev)
> +static void vfio_ap_mdev_remove(struct mdev_device *mdev)
>  {
> -	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> +	struct ap_matrix_mdev *matrix_mdev = dev_get_drvdata(&mdev->dev);
>  
> -	if (matrix_mdev->kvm)
> -		return -EBUSY;
> +	/* FIXME: Remove isn't allowed to fail */
> +	if (WARN_ON(matrix_mdev->kvm))
> +		return;

This is a pre-existing problem, but the rework now makes it more
obvious.

Previously, the mdev code would only print a warning and then continue
with device removal, even if a ->remove() callback returned an error.
Now, it's quite clear that we'll end up in a weird half-dead state.

IIRC, the check for matrix_mdev->kvm is intended to protect against
ripping out the device under a running guest (I think it needs to
manipulate some crypto control blocks?)

So my question for the vfio-ap maintainers is: Can we actually end up
in this case? If yes, is there any way to gracefully shut down the
device?

> +
> +	vfio_unregister_group_dev(&matrix_mdev->vdev);
>  
>  	mutex_lock(&matrix_dev->lock);
> -	vfio_ap_mdev_reset_queues(mdev);
> +	vfio_ap_mdev_reset_queues(matrix_mdev);
>  	list_del(&matrix_mdev->node);
>  	mutex_unlock(&matrix_dev->lock);
>  
>  	kfree(matrix_mdev);
> -	mdev_set_drvdata(mdev, NULL);
>  	atomic_inc(&matrix_dev->available_instances);
> -
> -	return 0;
>  }

(...)

