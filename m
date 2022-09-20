Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A77C54EE9
	for <linux-s390@archiver.kernel.org>; Tue, 20 Sep 2022 20:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiITU0y (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 20 Sep 2022 16:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiITU0v (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 20 Sep 2022 16:26:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B9B4620F
        for <linux-s390@vger.kernel.org>; Tue, 20 Sep 2022 13:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663705609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kTuYdzoZrrSVtqbKAPsta2mJ6sY3BJrx+736wsbe0TI=;
        b=FsIsF19HwOVa94Z0n5CqSMmI/cnJtmJcxZYWytDCLFf15PJlnjJdygMPsZvCKIMDbClkJT
        KzbimLL7dQepZhfA0//07SCEt6T0DLuoU7OKVgJDodjOHQV8phHJ+cyd3hBPg0cj6z+rta
        f/RwCL6/+T+GNCVGmq8rDVCbea7UGqc=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-553-gc1FXgeyNnyjSyRbGX3iAQ-1; Tue, 20 Sep 2022 16:26:43 -0400
X-MC-Unique: gc1FXgeyNnyjSyRbGX3iAQ-1
Received: by mail-io1-f70.google.com with SMTP id e4-20020a5d85c4000000b0068bb3c11e72so2038407ios.5
        for <linux-s390@vger.kernel.org>; Tue, 20 Sep 2022 13:26:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=kTuYdzoZrrSVtqbKAPsta2mJ6sY3BJrx+736wsbe0TI=;
        b=usz4ZGOjTd+pYswd0eQf7QCSj/2XPbuYtwv2uIz+BQ/pBXk2jzsN+wEaJanAVp44PT
         hscXVuhu2i4ZnEfXndrtSL+6dt66gKAQL7j4Ln3c9i++Ocfd/IUTIzeuidPdN/NtMDIT
         TQQ0ZsGgHhCMfGnFA+r86HPp8Arcc/KTNt6aIpeqebAOjVxKMd+Oz6+nIz6rrPXcp/vR
         dwj/GIcofMA+mXgMR8lcideGi3i8HMVg77smLO4QXzhzWWYFI9HNP/l/914A5LBinThz
         fpCjRO7l8g38RDPYHyHUm7HKQgV7Y92XwwafdfkFWzM3UdtrddCkFsL5Xpeuq1hSj4BQ
         Dtag==
X-Gm-Message-State: ACrzQf2xzvspguBcx1+rU48n7OLnsfbOaLAW84os/jZaKgEsn3airfPD
        BaG2LRZU03GYp+NGXckCGwK2mDfJaEIcFgFOZmfjsev1vvU2agb2fqkwsLSTxd9YiuyoPC2SutU
        WBg0pQHXCB0tRVEqi+H4OxA==
X-Received: by 2002:a05:6638:379e:b0:35a:6503:453c with SMTP id w30-20020a056638379e00b0035a6503453cmr11604716jal.118.1663705602740;
        Tue, 20 Sep 2022 13:26:42 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7Wn3n/ipGU1Lsd59DpS6zB424nUgnSwe6A3PA6dfJBFxnu4Ya4+9pvipnOK8j87C89TfNNcQ==
X-Received: by 2002:a05:6638:379e:b0:35a:6503:453c with SMTP id w30-20020a056638379e00b0035a6503453cmr11604691jal.118.1663705602488;
        Tue, 20 Sep 2022 13:26:42 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id z18-20020a05663822b200b00359fbe10489sm269899jas.103.2022.09.20.13.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 13:26:42 -0700 (PDT)
Date:   Tue, 20 Sep 2022 14:26:39 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Kevin Tian <kevin.tian@intel.com>
Cc:     Zhenyu Wang <zhenyuw@linux.intel.com>,
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
        Jason Gunthorpe <jgg@ziepe.ca>,
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
Subject: Re: [PATCH v3 15/15] vfio: Add struct device to vfio_device
Message-ID: <20220920142639.29b1bdc2.alex.williamson@redhat.com>
In-Reply-To: <20220909102247.67324-16-kevin.tian@intel.com>
References: <20220909102247.67324-1-kevin.tian@intel.com>
        <20220909102247.67324-16-kevin.tian@intel.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri,  9 Sep 2022 18:22:47 +0800
Kevin Tian <kevin.tian@intel.com> wrote:

> From: Yi Liu <yi.l.liu@intel.com>
> 
> and replace kref. With it a 'vfio-dev/vfioX' node is created under the
> sysfs path of the parent, indicating the device is bound to a vfio
> driver, e.g.:
> 
> /sys/devices/pci0000\:6f/0000\:6f\:01.0/vfio-dev/vfio0
> 
> It is also a preparatory step toward adding cdev for supporting future
> device-oriented uAPI.
> 
> Add Documentation/ABI/testing/sysfs-devices-vfio-dev.
> 
> Also take this chance to rename chardev 'vfio' to 'vfio-group' in
> /proc/devices.

What's the risk/reward here, is this just more aesthetically pleasing
symmetry vs 'vfio-dev'?  The char major number to name association in
/proc/devices seems pretty obscure, but what due diligence have we done
to make sure this doesn't break anyone?  Thanks,

Alex

