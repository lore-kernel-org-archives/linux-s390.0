Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B4EEB64D7
	for <linux-s390@archiver.kernel.org>; Tue, 13 Jun 2023 20:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234318AbjFMUM2 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 13 Jun 2023 16:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240499AbjFMUMH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 13 Jun 2023 16:12:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC00A268A
        for <linux-s390@vger.kernel.org>; Tue, 13 Jun 2023 13:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686687054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sIOI1MZa8Qvt3GA5tgX3/QbGmFAGID2zKyAE50cAXvQ=;
        b=U4vA+yORQYVRtg4xl0VH6TlsxQeCHG2C7ohtN99hKPGlUdhsRPbp8k/8OrswTHYkermX3Y
        r/O4rZ7hYnK9H9EzJ+vMvbXtaS3TV0A4i/3XTbZNxWovIDpu7+KXkkeUpjSb9sizTc9fpr
        FLM+2EH/j24yVr6zpzj0vcjaDTgAbMc=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-jo_D8VNbOEK6LQYxr62XVg-1; Tue, 13 Jun 2023 16:10:53 -0400
X-MC-Unique: jo_D8VNbOEK6LQYxr62XVg-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-77ad94642d4so709730139f.1
        for <linux-s390@vger.kernel.org>; Tue, 13 Jun 2023 13:10:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686687052; x=1689279052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sIOI1MZa8Qvt3GA5tgX3/QbGmFAGID2zKyAE50cAXvQ=;
        b=OagH2d8tyGpu/cotcQ8+Xfl4zBWBOS/egR3eV1O1m0PcajeOw9YJJ9x7Dhu45Gzcvq
         ICHHjijxMeDH/XYXA4+DE9RdyTRFGiGFqRKjLqM8zq9ZnnOb+7bCmvl2RbFgtuzob97p
         RS0ET71v2t5+5snbYPqk3HR7BTJ1EtOxoQBsHZugXJunetm1ey0Zf62Um9eR8YBsyZOz
         zrx13qbLbSB3kZ9CXIaG5lrG5Ud+pevL/Wfpso22/2q7Aee9WUgcgaGQ7qfLWpN4dj+m
         J5g0GYtbjE9z0hXtsE7k7UCv2/wDRGvhCzqqUZt/qnanOlYiyJORZeuLYALBZqdiABXj
         lMOw==
X-Gm-Message-State: AC+VfDz45DqTfu2wavOs8loOp4YzPFMiychPgCzV/dHXQdqYRAzVwzsk
        5pyXinkhMbOjfx8KnF8J9Y5HwNVz3bzYYzNKRU7/F+CYCDjUSLwDClXUOHy4S8OUdgBgXa8rmQr
        oMOo1W85A+Q6V3gf/SOib2A==
X-Received: by 2002:a5d:9d4e:0:b0:753:ca30:6bb0 with SMTP id k14-20020a5d9d4e000000b00753ca306bb0mr12540447iok.4.1686687052513;
        Tue, 13 Jun 2023 13:10:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4DNZHxVZbAxwbazA89i6boaoAMcqTbpYJSYBiB4fBVRBnBcDqPvcZYm0qsZ2hQJsBCtxR5uA==
X-Received: by 2002:a5d:9d4e:0:b0:753:ca30:6bb0 with SMTP id k14-20020a5d9d4e000000b00753ca306bb0mr12540429iok.4.1686687052264;
        Tue, 13 Jun 2023 13:10:52 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id f13-20020a6bdd0d000000b0076c569c7a48sm3955848ioc.39.2023.06.13.13.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 13:10:51 -0700 (PDT)
Date:   Tue, 13 Jun 2023 14:10:50 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
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
Message-ID: <20230613141050.29e7a22b.alex.williamson@redhat.com>
In-Reply-To: <ZIiozfqet185iLIs@nvidia.com>
References: <20230602121653.80017-1-yi.l.liu@intel.com>
        <20230602121653.80017-22-yi.l.liu@intel.com>
        <20230612164228.65b500e0.alex.williamson@redhat.com>
        <DS0PR11MB7529AE3701E154BF4C092E57C355A@DS0PR11MB7529.namprd11.prod.outlook.com>
        <20230613081913.279dea9e.alex.williamson@redhat.com>
        <DS0PR11MB7529EB2903151B3399F636F5C355A@DS0PR11MB7529.namprd11.prod.outlook.com>
        <20230613084828.7af51055.alex.williamson@redhat.com>
        <DS0PR11MB7529E84BCB100DE620FD2468C355A@DS0PR11MB7529.namprd11.prod.outlook.com>
        <20230613091301.56986440.alex.williamson@redhat.com>
        <20230613111511.425bdeae.alex.williamson@redhat.com>
        <ZIiozfqet185iLIs@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 13 Jun 2023 14:35:09 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Jun 13, 2023 at 11:15:11AM -0600, Alex Williamson wrote:
> > [Sorry for breaking threading, replying to my own message id with reply
> >  content from Yi since the Cc list got broken]  
> 
> Yikes it is really busted, I think I fixed it?
> 
> > If we renamed your function above to vfio_device_has_iommu_group(),
> > couldn't we just wrap device_add like below instead to not have cdev
> > setup for a noiommu device, generate an error for a physical device w/o
> > IOMMU backing, and otherwise setup the cdev device?
> > 
> > static inline int vfio_device_add(struct vfio_device *device, enum vfio_group_type type)
> > {
> > #if IS_ENABLED(CONFIG_VFIO_GROUP)
> > 	if (device->group->type == VFIO_NO_IOMMU)
> > 		return device_add(&device->device);  
> 
> vfio_device_is_noiommu() embeds the IS_ENABLED

But patch 23/ makes the definition of struct vfio_group conditional on
CONFIG_VFIO_GROUP, so while CONFIG_VFIO_NOIOMMU depends on
CONFIG_VFIO_GROUP and the result could be determined, I think the
compiler is still unhappy about the undefined reference.  We'd need a
!CONFIG_VFIO_GROUP stub for the function.

> > #else
> > 	if (type == VFIO_IOMMU && !vfio_device_has_iommu_group(device))
> > 		return -EINVAL;
> > #endif  
> 
> The require test is this from the group code:
> 
>  	if (!device_iommu_capable(dev, IOMMU_CAP_CACHE_COHERENCY)) {
> 
> We could lift it out of the group code and call it from vfio_main.c like:
> 
> if (type == VFIO_IOMMU && !vfio_device_is_noiommu(vdev) && !device_iommu_capable(dev,
>      IOMMU_CAP_CACHE_COHERENCY))
>    FAIL

Ack.  Thanks,

Alex

