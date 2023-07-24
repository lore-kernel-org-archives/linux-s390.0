Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9C2C001DF
	for <linux-s390@archiver.kernel.org>; Mon, 24 Jul 2023 19:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjGXTKO (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 24 Jul 2023 15:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjGXTKL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 24 Jul 2023 15:10:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB1210E5
        for <linux-s390@vger.kernel.org>; Mon, 24 Jul 2023 12:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690225767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WawsHdGpz2PcjK+rzMy9rXk7uFt8JlrwIupXE53S044=;
        b=OBzDtieTiyJ84w0bsmwKSf3r10BAHqd1IbS+gh2SVZXsKQ8f15MmSsObomYhGEKMJwBu0f
        JEP2T4ZHgZ/FSpN0ay2RRCdRT1raT8F4jNHwmMsLOLoDEUIUOqTjYtQQj6l5fKg14O38qY
        ru52Kmj35xO+rna1g014vVHXKfXHAHA=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-7JsU2uMqNyCWUOAk6j8f5A-1; Mon, 24 Jul 2023 15:09:26 -0400
X-MC-Unique: 7JsU2uMqNyCWUOAk6j8f5A-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-786f4056ac0so240266939f.1
        for <linux-s390@vger.kernel.org>; Mon, 24 Jul 2023 12:09:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690225765; x=1690830565;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WawsHdGpz2PcjK+rzMy9rXk7uFt8JlrwIupXE53S044=;
        b=UZU2x37dnnI1tmkoFLX3QBvvclH8izvq6t4xXd8UMMsP+qIFyGdhHhmOc85AehtmdC
         NoV3RljpjYaRqZhANC7So6glvsgy+N3KT0NWSgOrZt4cn9iUxTM5IfKAV/kXfzcC+05H
         f/lmxwaRcgvGSL62+y7C1a82UoivQnAhfL5a2GpNX/gQPoPIsJH1RJIEjmstUGpjvFYI
         +yNyFZ1KgeAOqLJ7iHvLhzF7FA8tkd6yItNSkFvp8t8GbuhFTEo8Ba7f2W948ZZPGOpO
         1ODcKa2KA0DFzUSQuT3lF4NgfMI2FMNycAOrAdjgu7y+0rZhdTKRFnM7W0N76DmMU0dn
         xWHQ==
X-Gm-Message-State: ABy/qLZl1AQQ4SikxlHkxxEfDboYuFJXVSjfMVnK04WXXqi0eKMwVWNJ
        mIAHgR2ICwVe0w7ZBq1Yxega8rkXss4yMXwZLFPPwObFOcV8WFAp+eaUMtZB7MGp8gn5fQF0mFZ
        nVrY6qh5ip9jiMcIuACNaAQ==
X-Received: by 2002:a5d:8856:0:b0:787:9f4:a286 with SMTP id t22-20020a5d8856000000b0078709f4a286mr830181ios.3.1690225765544;
        Mon, 24 Jul 2023 12:09:25 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGQj4iG8mT+sSEqSQYkZfuQ4Hg9spnEgepBk2H1o6jlqFqHr7tDoImTU/XT+4VwrQSYWZsnbg==
X-Received: by 2002:a5d:8856:0:b0:787:9f4:a286 with SMTP id t22-20020a5d8856000000b0078709f4a286mr830154ios.3.1690225765283;
        Mon, 24 Jul 2023 12:09:25 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id e23-20020a056638021700b0042b4f9ddecasm3133372jaq.85.2023.07.24.12.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 12:09:24 -0700 (PDT)
Date:   Mon, 24 Jul 2023 13:09:22 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Yi Liu <yi.l.liu@intel.com>, kevin.tian@intel.com, joro@8bytes.org,
        robin.murphy@arm.com, cohuck@redhat.com, eric.auger@redhat.com,
        nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-s390@vger.kernel.org,
        xudong.hao@intel.com, yan.y.zhao@intel.com, terrence.xu@intel.com,
        yanting.jiang@intel.com, zhenzhong.duan@intel.com,
        clegoate@redhat.com
Subject: Re: [PATCH v15 00/26] Add vfio_device cdev for iommufd support
Message-ID: <20230724130922.5bf567ef.alex.williamson@redhat.com>
In-Reply-To: <ZLbEigQvwSZFiCqv@nvidia.com>
References: <20230718135551.6592-1-yi.l.liu@intel.com>
        <ZLbEigQvwSZFiCqv@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 18 Jul 2023 13:57:46 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Jul 18, 2023 at 06:55:25AM -0700, Yi Liu wrote:
> > Existing VFIO provides group-centric user APIs for userspace. Userspace
> > opens the /dev/vfio/$group_id first before getting device fd and hence
> > getting access to device. This is not the desired model for iommufd. Per
> > the conclusion of community discussion[1], iommufd provides device-centric
> > kAPIs and requires its consumer (like VFIO) to be device-centric user
> > APIs. Such user APIs are used to associate device with iommufd and also
> > the I/O address spaces managed by the iommufd.
> > 
> > This series first introduces a per device file structure to be prepared
> > for further enhancement and refactors the kvm-vfio code to be prepared
> > for accepting device file from userspace. After this, adds a mechanism for
> > blocking device access before iommufd bind. Then refactors the vfio to be
> > able to handle cdev paths (e.g. iommufd binding, no-iommufd, [de]attach ioas).
> > This refactor includes making the device_open exclusive between the group
> > and the cdev path, only allow single device open in cdev path; vfio-iommufd
> > code is also refactored to support cdev. e.g. split the vfio_iommufd_bind()
> > into two steps. Eventually, adds the cdev support for vfio device and the
> > new ioctls, then makes group infrastructure optional as it is not needed
> > when vfio device cdev is compiled.
> > 
> > This series is based on some preparation works done to vfio emulated devices[2]
> > and vfio pci hot reset enhancements[3]. Per discussion[4], this series does not
> > support cdev for physical devices that do not have IOMMU. Such devices only
> > have group-centric user APIs.
> > 
> > This series is a prerequisite for iommu nesting for vfio device[5] [6].
> > 
> > The complete code can be found in below branch, simple tests done to the
> > legacy group path and the cdev path. QEMU changes are in upstreaming[7]
> > and the complete code can be found at[8]
> > 
> > https://github.com/yiliu1765/iommufd/tree/vfio_device_cdev_v15
> > (config CONFIG_IOMMUFD=y CONFIG_VFIO_DEVICE_CDEV=y)  
> 
> Alex, if you are still good with this lets make this into a shared
> branch, do you want to do it or would you like a PR from me?

Sorry, was out much of last week.  Yes, my intent would be to put this
both in a shared branch and my next branch for v6.6.  Given this is
mostly vfio, it seems like it'd make sense for me to provide that
branch but I may not get to it until tomorrow.  Thanks,

Alex

