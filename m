Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB33EC433FE
	for <linux-s390@archiver.kernel.org>; Thu, 29 Sep 2022 18:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbiI2SYk (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 29 Sep 2022 14:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234909AbiI2SYi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 29 Sep 2022 14:24:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF8FB85A
        for <linux-s390@vger.kernel.org>; Thu, 29 Sep 2022 11:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664475875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BoITIusWH1pgiQYYyYgg2aTCkDBnXRgVNx9UWZzrGmA=;
        b=BMarKcHDLc0c5llMJOIKMYTPQPa+zp6l09z+wDDq7aiSRXCHlp/qPVxu9oEFarmj/PEb8L
        ycmLV47g3de5H7KUARPg0vWcq5/INOVHnxzslOwHIvKRNHX8WW3nqXfuiHM3o158woSdj3
        OKdpP7ZAI+UzmAiUYg/x5w/Arhv3xxY=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-662-dDkAuO_TNMmK5-_k5RzIag-1; Thu, 29 Sep 2022 14:24:33 -0400
X-MC-Unique: dDkAuO_TNMmK5-_k5RzIag-1
Received: by mail-io1-f70.google.com with SMTP id b9-20020a6be709000000b006a469cf388eso1222706ioh.19
        for <linux-s390@vger.kernel.org>; Thu, 29 Sep 2022 11:24:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=BoITIusWH1pgiQYYyYgg2aTCkDBnXRgVNx9UWZzrGmA=;
        b=p3pUOp0F1paRUC62Mb4kUCcIY9uJPCyNupKMyKzEmn2vwC4wo5W5dZIy260NA2Ptog
         KJhPhMyHEqhGUJlFGuU73YdjHaVh6lJ4bbxadu1Hpwm3cPIC+uhhJ28vrPLk/8B4wGNR
         W7BYVmFnsiGca7YcDD9KVSwKk5POfgkW20EVUDJI7tGVbb+PiINZua2qJZmSpQEIvxmK
         rAfZDlZHxMXsfjLiiLkugmFtHGweMAJohnb8EAvx/icd1cyK09Wq4uTPi+TYSFLax6w+
         mBbMEA1w6ouGPf7vm+FkIfuh1eVQCLzptpRYUgqlx9S6xsc2j2rLbG3Meqnjj9N8J64+
         rcEQ==
X-Gm-Message-State: ACrzQf09DJMQn5eoOnTkqC5Y1L6nI4cJ79tOyCz54j1NPEVgwW/pxY5f
        BzbGpg3iS8CuDjYm6kl00KHtk/v4S1/+HoFkZ/OIOtDDGtOxK9RZvfKCoR6ayKL5rBsRq/Awpt5
        03gKi1pwmBgBiFVLuNGyJhA==
X-Received: by 2002:a05:6e02:19ce:b0:2f1:68a6:3bec with SMTP id r14-20020a056e0219ce00b002f168a63becmr2392089ill.78.1664475872947;
        Thu, 29 Sep 2022 11:24:32 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7KUOQo8AbbarGobEgnbxdcS5bS2mn744LEcpjpU+rvkCIe35jyhAfEJ5Pm5FWlRH0iLBHEPg==
X-Received: by 2002:a05:6e02:19ce:b0:2f1:68a6:3bec with SMTP id r14-20020a056e0219ce00b002f168a63becmr2392060ill.78.1664475872712;
        Thu, 29 Sep 2022 11:24:32 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id f13-20020a05660215cd00b006a1fed36549sm96051iow.10.2022.09.29.11.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 11:24:31 -0700 (PDT)
Date:   Thu, 29 Sep 2022 12:24:27 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Kevin Tian <kevin.tian@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Longfang Liu <liulongfang@huawei.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Eric Auger <eric.auger@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Abhishek Sahu <abhsahu@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v4 15/15] vfio: Add struct device to vfio_device
Message-ID: <20220929122427.3a3bca9a.alex.williamson@redhat.com>
In-Reply-To: <YzXaxPpkc+90Xx+T@ziepe.ca>
References: <20220921104401.38898-1-kevin.tian@intel.com>
        <20220921104401.38898-16-kevin.tian@intel.com>
        <20220929105519.5c9ae1d8.alex.williamson@redhat.com>
        <YzXaxPpkc+90Xx+T@ziepe.ca>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 29 Sep 2022 14:49:56 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Thu, Sep 29, 2022 at 10:55:19AM -0600, Alex Williamson wrote:
> > Hi Kevin,
> > 
> > This introduced the regression discovered here:
> > 
> > https://lore.kernel.org/all/20220928125650.0a2ea297.alex.williamson@redhat.com/
> > 
> > Seems we're not releasing the resources when removing an mdev.  This is
> > a regression, so it needs to be fixed or reverted before the merge
> > window.  Thanks,  
> 
> My guess at the fix for this:
> 
> https://lore.kernel.org/r/0-v1-013609965fe8+9d-vfio_gvt_unregister_jgg@nvidia.com

Indeed this seems to work  I'll look for acks and further reviews from
Intel folks. Thanks!

Alex

