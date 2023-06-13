Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1ABEB64D0
	for <linux-s390@archiver.kernel.org>; Tue, 13 Jun 2023 14:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242675AbjFMOt0 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 13 Jun 2023 10:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242625AbjFMOtU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 13 Jun 2023 10:49:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF76173E
        for <linux-s390@vger.kernel.org>; Tue, 13 Jun 2023 07:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686667714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Au5yHcPaamLUTDAy1lALivyiFfLlJB/EXoLrOXOPPA=;
        b=TQqpJzgba6o/rCE4QhBLNmRH8iBqQKbiEAwQkbMn5qUwDIyJwajOIktqIReHr5pyAbPjDZ
        P00qU2SSGI6RUyTk+Jgk99bTip7D6uHoRElOxeoTXBe5WNH3rMB7u368/8PD7wH15h2EP1
        1zVrz8ebO7g6ElLlaooQkxb//h7fZuE=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-QCtAhBOnOOqeMrE68LA9DQ-1; Tue, 13 Jun 2023 10:48:33 -0400
X-MC-Unique: QCtAhBOnOOqeMrE68LA9DQ-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-77ac14e9bc5so650476539f.2
        for <linux-s390@vger.kernel.org>; Tue, 13 Jun 2023 07:48:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686667711; x=1689259711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Au5yHcPaamLUTDAy1lALivyiFfLlJB/EXoLrOXOPPA=;
        b=O4VhsTXxXYhsLPOuo+W+20Nr3PsJ0RXu7mhXDjZpMT6MnBDqqkLW/473HOwJYPtOMX
         s9CuXcCgqzoeoDGi+9SKhhV/l8LqtZFmqc5c+zTeS7k4bW35zGZe0qSC+G/8I2eL4IhP
         ZHqX+3/yhbKPAkiyQFMNKrE7kxY/iDslBllkq1PjdNyyizElrdHm+CqrfwEHvaj5tFil
         Y8O6dk2H4/2r8zaTnnkuhIK1deM/TmujqOkTlfEZyaj040bQs26qEZbF7cn6ExqMRX2J
         Rn8hKnXgfuQKQDqJpPvYUTMHsB1KgxV2mYrgV/6O2iH3jWkpO5y7ppiJIBnFJclYgC6X
         BWyg==
X-Gm-Message-State: AC+VfDx6IOWDU51kngFtA3v6WwoEMfzNB01HEcayvZqwSCfc6Z8ycKN5
        N9mh+NXpiKAvkcLBO+aVNQX21bL1iH9ZvpUFovrbJCJZnCuCirNLhjS5ubbJPuv7XYc3aBoEec6
        dXi0M9DDJ3r90XHpBVJJLEg==
X-Received: by 2002:a05:6602:224e:b0:76c:6382:8d5b with SMTP id o14-20020a056602224e00b0076c63828d5bmr11619912ioo.10.1686667710780;
        Tue, 13 Jun 2023 07:48:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7kDLAWaKUO1yUsXW0IekRRbMRMPnfJq0GCOYazAfEkGhrECmQ2ohZ2H0Yn3F4btXNUZoyJKQ==
X-Received: by 2002:a05:6602:224e:b0:76c:6382:8d5b with SMTP id o14-20020a056602224e00b0076c63828d5bmr11619888ioo.10.1686667710504;
        Tue, 13 Jun 2023 07:48:30 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id w12-20020a02968c000000b0041d7ad74b36sm3502462jai.17.2023.06.13.07.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 07:48:30 -0700 (PDT)
Date:   Tue, 13 Jun 2023 08:48:28 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>
Cc:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "Hao, Xudong" <xudong.hao@intel.com>,
        "Zhao, Yan Y" <yan.y.zhao@intel.com>,
        "Xu, Terrence" <terrence.xu@intel.com>,
        "Jiang, Yanting" <yanting.jiang@intel.com>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "clegoate@redhat.com" <clegoate@redhat.com>
Subject: Re: [PATCH v12 21/24] vfio: Determine noiommu device in
 __vfio_register_dev()
Message-ID: <20230613084828.7af51055.alex.williamson@redhat.com>
In-Reply-To: <DS0PR11MB7529EB2903151B3399F636F5C355A@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230602121653.80017-1-yi.l.liu@intel.com>
        <20230602121653.80017-22-yi.l.liu@intel.com>
        <20230612164228.65b500e0.alex.williamson@redhat.com>
        <DS0PR11MB7529AE3701E154BF4C092E57C355A@DS0PR11MB7529.namprd11.prod.outlook.com>
        <20230613081913.279dea9e.alex.williamson@redhat.com>
        <DS0PR11MB7529EB2903151B3399F636F5C355A@DS0PR11MB7529.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 13 Jun 2023 14:33:01 +0000
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Tuesday, June 13, 2023 10:19 PM
> > 
> > On Tue, 13 Jun 2023 05:53:42 +0000
> > "Liu, Yi L" <yi.l.liu@intel.com> wrote:
> >   
> > > > From: Alex Williamson <alex.williamson@redhat.com>
> > > > Sent: Tuesday, June 13, 2023 6:42 AM
> > > >
> > > > On Fri,  2 Jun 2023 05:16:50 -0700
> > > > Yi Liu <yi.l.liu@intel.com> wrote:
> > > >  
> > > > > This moves the noiommu device determination and noiommu taint out of
> > > > > vfio_group_find_or_alloc(). noiommu device is determined in
> > > > > __vfio_register_dev() and result is stored in flag vfio_device->noiommu,
> > > > > the noiommu taint is added in the end of __vfio_register_dev().
> > > > >
> > > > > This is also a preparation for compiling out vfio_group infrastructure
> > > > > as it makes the noiommu detection and taint common between the cdev path
> > > > > and group path though cdev path does not support noiommu.  
> > > >
> > > > Does this really still make sense?  The motivation for the change is
> > > > really not clear without cdev support for noiommu.  Thanks,  
> > >
> > > I think it still makes sense. When CONFIG_VFIO_GROUP==n, the kernel
> > > only supports cdev interface. If there is noiommu device, vfio should
> > > fail the registration. So, the noiommu determination is still needed. But
> > > I'd admit the taint might still be in the group code.  
> > 
> > How is there going to be a noiommu device when VFIO_GROUP is unset?  
> 
> How about booting a kernel with iommu disabled, then all the devices
> are not protected by iommu. I suppose they are noiommu devices. If
> user wants to bound them to vfio, the kernel should have VFIO_GROUP.
> Otherwise, needs to fail.

"noiommu" is a vfio designation of a device, it must be created by
vfio.  There can certainly be devices which are not IOMMU backed, but
without vfio designating them as noiommu devices, which is only done
via the legacy and compat paths, there's no such thing as a noiommu
device.  Devices without an IOMMU are simply out of scope for cdev,
there should never be a vfio cdev entry created for them.  Thanks,

Alex

