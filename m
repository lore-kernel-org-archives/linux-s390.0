Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A98C4332F
	for <linux-s390@archiver.kernel.org>; Thu, 10 Nov 2022 17:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbiKJRLl (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 10 Nov 2022 12:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbiKJRLa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 10 Nov 2022 12:11:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FCC4875B
        for <linux-s390@vger.kernel.org>; Thu, 10 Nov 2022 09:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668100229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3XBNZVfwHOyxrKzEqgSDBaV/kDGeCsLaREPRXxkN8EM=;
        b=XULxVucSkRIGoY/EN8rhP0fUqRAz3tswTdiEdVuYBewesksd5qBC60MF413K/p5Qg5uyFC
        TelMqzDSbVV24cBNUc6mUQFinKm0NXsV/BHbL7cz1sVKqfaj1Hsqsv08cay9qG13GZ7HJ0
        e1uNlKBGY5Vsajy1edc/kWghC2LupkE=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-635-SnB2kGhDPKWZ2f4cFrkjaQ-1; Thu, 10 Nov 2022 12:10:27 -0500
X-MC-Unique: SnB2kGhDPKWZ2f4cFrkjaQ-1
Received: by mail-io1-f70.google.com with SMTP id n23-20020a056602341700b00689fc6dbfd6so1433632ioz.8
        for <linux-s390@vger.kernel.org>; Thu, 10 Nov 2022 09:10:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3XBNZVfwHOyxrKzEqgSDBaV/kDGeCsLaREPRXxkN8EM=;
        b=S4WUURcg+wBk8PAaZuktVHdQmKDoZGm1kq2Ph18KwQj83tfVp1+bG5xbBkVIIvnR9F
         1nauu6/3m/NJGWXhju2ntP1zmShnuFiMIIWO4sJONScwarP+/pxm1nZW0qxpznzDZJpp
         ADPb69NOrZZtDkMfuKaj2maOaUIHodt1oa6vsKHN0CCPUKL+qx2w/CqlekA7aEhUu/gl
         BCHeVJHYQy9gaRieIV/c+/6AsmhVGnDYV3oQo4zjYal5kj8vgXWJCONpEMubP5vhJP0j
         ugVtLS50wPJ43nI6MPWQ/WI6zs/ctHvCzjTIdqVj7xryW3G1FDLb8dFqIvvSnfXRpzPU
         Dl0w==
X-Gm-Message-State: ACrzQf1HOzp/tfV0UQh0KViUF+IXhxaWtea1nogVTXNjL4u1eu1U6nsP
        PZAvpSa3dsxJ5IZusdpgDEOn8TbwxcPBOEVLVscfvlTQGBpU/cYPgpVT5ZlNVwT4PBxEwg3Z5m3
        QvPD+H+17EP9B898K+AyZ1A==
X-Received: by 2002:a05:6638:4413:b0:374:fbbe:2da6 with SMTP id bp19-20020a056638441300b00374fbbe2da6mr3149409jab.163.1668100226563;
        Thu, 10 Nov 2022 09:10:26 -0800 (PST)
X-Google-Smtp-Source: AMsMyM5st2ROvi8y5IPXYSHhk18Mv2oS6m3aLQCRNeAm9L0KyqI2dN1lMnwqPxWnGmIZODwHu3sF6g==
X-Received: by 2002:a05:6638:4413:b0:374:fbbe:2da6 with SMTP id bp19-20020a056638441300b00374fbbe2da6mr3149377jab.163.1668100226283;
        Thu, 10 Nov 2022 09:10:26 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id m1-20020a924a01000000b002f9652849f6sm30029ilf.67.2022.11.10.09.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 09:10:25 -0800 (PST)
Date:   Thu, 10 Nov 2022 10:10:23 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        David Airlie <airlied@gmail.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        "Christian Borntraeger" <borntraeger@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Eric Auger" <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        "Harald Freudenberger" <freude@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        "Jason Herne" <jjherne@linux.ibm.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Longfang Liu <liulongfang@huawei.com>,
        "Matthew Rosato" <mjrosato@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        "Shameer Kolothum" <shameerali.kolothum.thodi@huawei.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        "Wang, Zhi A" <zhi.a.wang@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 10/11] vfio: Make vfio_container optionally compiled
Message-ID: <20221110101023.28e7a790.alex.williamson@redhat.com>
In-Reply-To: <BN9PR11MB5276494548F01A42694E366A8C019@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v2-65016290f146+33e-vfio_iommufd_jgg@nvidia.com>
        <10-v2-65016290f146+33e-vfio_iommufd_jgg@nvidia.com>
        <20221108152831.1a2ed3df.alex.williamson@redhat.com>
        <Y2r6YnhuR3SxslL6@nvidia.com>
        <20221109101809.2ff08303.alex.williamson@redhat.com>
        <Y2wFFy0cxIIlCeTu@nvidia.com>
        <BN9PR11MB5276494548F01A42694E366A8C019@BN9PR11MB5276.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 10 Nov 2022 06:57:57 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Thursday, November 10, 2022 3:53 AM
> > 
> > On Wed, Nov 09, 2022 at 10:18:09AM -0700, Alex Williamson wrote:
> >   
> > > DPDK supports no-iommu mode.  
> > 
> > Er? Huh? How? I thought no-iommu was for applications that didn't do
> > DMA? How is DPDK getting packets in/out without DMA? I guess it snoops
> > in /proc/ or something to learn PFNs of mlock'd memory? <shudder>  
> 
> iirc dpdk started with UIO plus various tricks (root privilege, hugepage, etc.)
> to lock and learn PFN's from pagemap. Then when migrating it to vfio the
> no-iommu option was introduced to provide UIO compatibility.

IIRC, we essentially introduced no-iommu mode vfio because DPDK started
pushing for extending interrupt support in uio-pci-generic.  The UIO
driver is also only meant for devices that don't do DMA, but obviously
DPDK didn't care about that.  Rather than extend UIO, we offered this
no-iommu mode in vfio since we already had more extensive MSI support,
were better able to impose restrictions on access to the device, and
using the same device access makes the transition to proper IOMMU
backed configurations more seamless.  Thanks,

Alex

