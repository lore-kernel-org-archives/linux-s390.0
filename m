Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9660FC433EF
	for <linux-s390@archiver.kernel.org>; Thu, 23 Sep 2021 20:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AA446124B
	for <linux-s390@archiver.kernel.org>; Thu, 23 Sep 2021 20:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243048AbhIWULp (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 23 Sep 2021 16:11:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30798 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243028AbhIWULp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 23 Sep 2021 16:11:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632427813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pm6ldAPw3QBicFualtGkXcxl0EGrBnYy1E2YrtIEBcU=;
        b=FvnQ/OlMgYezjgX6s025E9fSNOL7oz5bxtVmofXvdUbTas//UYgL0brT0LNUAARVhBW2VY
        2xh0injU/SNf6J7OTZKFvc60jUFMHGHw43gCvX38aL1WxskyDm6l4ut2tuUDP6CCBXF024
        5L2o2F7621196neOlckfocig10EYD2I=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-DgwdpRRyOXWol7mqh2OIew-1; Thu, 23 Sep 2021 16:10:12 -0400
X-MC-Unique: DgwdpRRyOXWol7mqh2OIew-1
Received: by mail-oi1-f198.google.com with SMTP id 17-20020aca1111000000b0027368cbf687so4860638oir.23
        for <linux-s390@vger.kernel.org>; Thu, 23 Sep 2021 13:10:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pm6ldAPw3QBicFualtGkXcxl0EGrBnYy1E2YrtIEBcU=;
        b=HtjpwyfgVvfHO+d30fPRYNrIRwXh4mWBkWc15ddGK3yk1bhzIN3mIb4SIUcXs83YGw
         20+B6/5ngrBCJTdN85CHdtLFLcn5vxS2wntlZlf/IKptMAK+XZVE0LAXev8a7+S8sdIj
         CMmQVtHbIzMc/6u68y25dPaWais82vE0vIaISmQPodd679Yv3ZCyYJV/H3lesVbLuENN
         EJX0J8VYtAOSeBRreGiMGTiq4ye0oz+PZ3ugR5FYoclGjGlh/pPnSuUb4+3FNjL2zw1b
         AIju5LmwwnepT7PvL6QsG+gK1KK+kfYFmQdyXL5hVZI+a9HzPqJn86W1gtir7+HzizFE
         WArg==
X-Gm-Message-State: AOAM530W02EHQUkqZQRBq39VSeaAdHC8dBV5PFQ0IJylFQ7WsMt9viuD
        X9u2l3O09Jn2nFRxP3qZ8VMC7mpVEBb0yBeL9/d6x2EQP2r1MIAwTuliJoHAUqzzOJ5pJib/Gcv
        NYuwvGbMoRUdRF9GZdJWVqg==
X-Received: by 2002:a05:6830:3101:: with SMTP id b1mr510074ots.21.1632427811290;
        Thu, 23 Sep 2021 13:10:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNoizfos0xOXONbPoXxhPavPdK/o+164G5dpAJrJuPwhpQDVyihOFF+oINDFaTtoFUCQrNhQ==
X-Received: by 2002:a05:6830:3101:: with SMTP id b1mr510058ots.21.1632427811056;
        Thu, 23 Sep 2021 13:10:11 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id d7sm1614012ooa.36.2021.09.23.13.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 13:10:10 -0700 (PDT)
Date:   Thu, 23 Sep 2021 14:10:09 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        linux-s390@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Christoph Hellwig <hch@lst.de>, kvm@vger.kernel.org
Subject: Re: [PATCH v3] vfio/ap_ops: Add missed vfio_uninit_group_dev()
Message-ID: <20210923141009.5196b90b.alex.williamson@redhat.com>
In-Reply-To: <20210922131150.GP327412@nvidia.com>
References: <0-v3-f9b50340cdbb+e4-ap_uninit_jgg@nvidia.com>
        <4a50ed05-c60c-aad0-bceb-de9665602aed@linux.ibm.com>
        <20210922131150.GP327412@nvidia.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 22 Sep 2021 10:11:50 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Sep 22, 2021 at 09:05:06AM -0400, Tony Krowiak wrote:
> > 
> > 
> > On 9/21/21 8:11 AM, Jason Gunthorpe wrote:  
> > > Without this call an xarray entry is leaked when the vfio_ap device is
> > > unprobed. It was missed when the below patch was rebased across the
> > > dev_set patch. Keep the remove function in the same order as the error
> > > unwind in probe.
> > > 
> > > Fixes: eb0feefd4c02 ("vfio/ap_ops: Convert to use vfio_register_group_dev()")
> > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > Tested-by: Tony Krowiak <akrowiak@linux.ibm.com>
> > > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > >   drivers/s390/crypto/vfio_ap_ops.c | 4 +++-
> > >   1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > v3:
> > >   - Keep the remove sequence the same as remove to avoid a lockdep splat
> > > v2: https://lore.kernel.org/r/0-v2-25656bbbb814+41-ap_uninit_jgg@nvidia.com/
> > >   - Fix corrupted diff
> > > v1: https://lore.kernel.org/r/0-v1-3a05c6000668+2ce62-ap_uninit_jgg@nvidia.com/
> > > 
> > > diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> > > index 118939a7729a1e..623d5269a52ce5 100644
> > > +++ b/drivers/s390/crypto/vfio_ap_ops.c
> > > @@ -361,6 +361,7 @@ static int vfio_ap_mdev_probe(struct mdev_device *mdev)
> > >   	mutex_lock(&matrix_dev->lock);
> > >   	list_del(&matrix_mdev->node);
> > >   	mutex_unlock(&matrix_dev->lock);
> > > +	vfio_uninit_group_dev(&matrix_mdev->vdev);
> > >   	kfree(matrix_mdev);
> > >   err_dec_available:
> > >   	atomic_inc(&matrix_dev->available_instances);
> > > @@ -376,9 +377,10 @@ static void vfio_ap_mdev_remove(struct mdev_device *mdev)
> > >   	mutex_lock(&matrix_dev->lock);
> > >   	vfio_ap_mdev_reset_queues(matrix_mdev);
> > >   	list_del(&matrix_mdev->node);
> > > +	mutex_unlock(&matrix_dev->lock);
> > > +	vfio_uninit_group_dev(&matrix_mdev->vdev);
> > >   	kfree(matrix_mdev);
> > >   	atomic_inc(&matrix_dev->available_instances);  
> > 
> > I think the above line of code should be done under the
> > matrix_dev->lock after removing the matrix_mdev from
> > the list since it is changing a value in matrix_dev.  
> 
> No, the read-side doesn't hold the lock
> 
> 	if ((atomic_dec_if_positive(&matrix_dev->available_instances) < 0))
> 		return -EPERM;
> 
> I think it is just a leftover from the atomic conversion that Alex
> did to keep it under the matrix_dev struct.
> 
> If we were going to hold the lock then it wouldn't need to be an
> atomic.

Tony, I'd love to get an ack if you're satisfied with this so we can
close up fixes for v5.15.  Thanks,

Alex

