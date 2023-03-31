Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB29AC6FD18
	for <linux-s390@archiver.kernel.org>; Fri, 31 Mar 2023 13:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjCaNZa (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 31 Mar 2023 09:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjCaNZ3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 31 Mar 2023 09:25:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B301D2C6
        for <linux-s390@vger.kernel.org>; Fri, 31 Mar 2023 06:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680269084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+8R/ww5NOtTKrVVMJPiSWlsWr2SqxpSfsL4A0mGzuN8=;
        b=f3TOej65joYJnKO8kvSN83V4kQXyTw9O0kzc0Y23gonUHXICeH080TWqYGCo87er2BupM7
        uVfX9Yha2DgkexqBKW4rSs/XiojvOdIiwe5eIl2V8CY1h/PZVOzXZmWYUsNRbLVCKacXe/
        GoDm4nrJj5sYY8zkUAuB9b7Jg+t683Y=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-W3-zIPjaPKqWqGqS-w_gTA-1; Fri, 31 Mar 2023 09:24:43 -0400
X-MC-Unique: W3-zIPjaPKqWqGqS-w_gTA-1
Received: by mail-il1-f200.google.com with SMTP id n9-20020a056e02148900b003263d81730aso3101873ilk.0
        for <linux-s390@vger.kernel.org>; Fri, 31 Mar 2023 06:24:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680269082;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+8R/ww5NOtTKrVVMJPiSWlsWr2SqxpSfsL4A0mGzuN8=;
        b=oD/3npe8RQ6zsP6Xv3bZu1/SrAnzV+fryTQ8UPP+VDAyH/urOGB20YKvR4Z6BLswB4
         ZFjFfhDrJ5CnhzbJ7ehP/Q86LBPj2snJoB7iEO3CvoUJGto7gj/mIISvDLJCTgxy1Yua
         6tyiVoF0kDZc0iQmt/eSPc1FjEEtwk5Kc/v+bji1m3x1MvBqOREUTS8fjS698cZUnC1I
         A//vsQW5laZCfb47qCw8DOpj+i420PXbQQEpm9gcjcsO3SMERgPhdC+xejhRHduIAq6z
         q4QS39ELzhPj67pyTvSga4gyga0A01q4X+AqQedN4Ujlq9QC46DPnrzBmRKWV171tzyk
         aInA==
X-Gm-Message-State: AAQBX9cuNFVciYmizyehkNe99au6jTwGQOHhqIP0YMHkR47SYHDlx0fN
        7DZ3jvsdBi4mEmv41KDO3XT/PZIpuCcMgxcvX8HRGkJAmKUeqSeDD7eeY/uE/mcA2+CT9JDELiL
        g1dfz0y5sirZ8JBr+H7K1/w==
X-Received: by 2002:a92:d991:0:b0:316:e39f:1212 with SMTP id r17-20020a92d991000000b00316e39f1212mr19103841iln.4.1680269082223;
        Fri, 31 Mar 2023 06:24:42 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZYiLus2ZjBk8rYsb82E2FTq2uUos7BcYFTyirHTyJsodUs0w1TIkUKf/w5l3uKHhzr7I1mnQ==
X-Received: by 2002:a92:d991:0:b0:316:e39f:1212 with SMTP id r17-20020a92d991000000b00316e39f1212mr19103815iln.4.1680269081970;
        Fri, 31 Mar 2023 06:24:41 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id x11-20020a92300b000000b00325daf836fdsm617030ile.17.2023.03.31.06.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 06:24:41 -0700 (PDT)
Date:   Fri, 31 Mar 2023 07:24:38 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Jiang, Yanting" <yanting.jiang@intel.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
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
        "Xu, Terrence" <terrence.xu@intel.com>
Subject: Re: [PATCH v2 00/10] Introduce new methods for verifying ownership
 in vfio PCI hot reset
Message-ID: <20230331072438.21c9243b.alex.williamson@redhat.com>
In-Reply-To: <MW4PR11MB6763D4F64127A5205D3B6567E88F9@MW4PR11MB6763.namprd11.prod.outlook.com>
References: <20230327093458.44939-1-yi.l.liu@intel.com>
        <MW4PR11MB6763D4F64127A5205D3B6567E88F9@MW4PR11MB6763.namprd11.prod.outlook.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 31 Mar 2023 03:14:23 +0000
"Jiang, Yanting" <yanting.jiang@intel.com> wrote:

> > 
> > VFIO_DEVICE_PCI_HOT_RESET requires user to pass an array of group fds to
> > prove that it owns all devices affected by resetting the calling device. This series
> > introduces several extensions to allow the ownership check better aligned with
> > iommufd and coming vfio device cdev support.
> > 
> > First, resetting an unopened device is always safe given nobody is using it. So
> > relax the check to allow such devices not covered by group fd array. [1]
> > 
> > When iommufd is used we can simply verify that all affected devices are bound
> > to a same iommufd then no need for the user to provide extra fd information.
> > This is enabled by the user passing a zero-length fd array and moving forward
> > this should be the preferred way for hot reset. [2]
> > 
> > However the iommufd method has difficulty working with noiommu devices
> > since those devices don't have a valid iommufd, unless the noiommu device is in
> > a singleton dev_set hence no ownership check is required. [3]
> > 
> > For noiommu backward compatibility a 3rd method is introduced by allowing the
> > user to pass an array of device fds to prove ownership. [4]
> > 
> > As suggested by Jason [5], we have this series to introduce the above stuffs to
> > the vfio PCI hot reset. Per the dicussion in [6], this series also adds a new _INFO
> > ioctl to get hot reset scope for given device.
> >   
> Tested NIC passthrough on Intel platform.
> Result looks good hence, 
> Tested by: Jiang, Yanting <yanting.jiang@intel.com>

I'm not aware of any userspace that exercises this reset ioctl in cdev
mode.  Is this regression testing only?  Thanks,

Alex

