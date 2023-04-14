Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64471C77B72
	for <linux-s390@archiver.kernel.org>; Fri, 14 Apr 2023 16:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjDNQfU (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 14 Apr 2023 12:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjDNQfT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 14 Apr 2023 12:35:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790C6106
        for <linux-s390@vger.kernel.org>; Fri, 14 Apr 2023 09:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681490076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TiyXITH53RukNzpnNNOFUR8woLiThj9fzrzbqNxJCOE=;
        b=IVaro9Sz7icBGw9Od7m692bidJsEBeOFvr3YHqd0CBjTs+HiZyp+9ZHBmAtzPgGkYc2oLB
        zEEelq1jcAKytH4olKx/sqkwLQu+Y4WZmAuAQelLGvTbFU6e1gLj15Bzdod0aiwvPfWZl6
        EzAfiypRAuc935QEUXXJasHXLK288Xk=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-vpS0mTdyOiOTM2xXowXyKw-1; Fri, 14 Apr 2023 12:34:34 -0400
X-MC-Unique: vpS0mTdyOiOTM2xXowXyKw-1
Received: by mail-il1-f197.google.com with SMTP id z18-20020a921a52000000b003293147d824so4324670ill.18
        for <linux-s390@vger.kernel.org>; Fri, 14 Apr 2023 09:34:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681490074; x=1684082074;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TiyXITH53RukNzpnNNOFUR8woLiThj9fzrzbqNxJCOE=;
        b=fOGsr+TiI+qJaKsLMOFjVTSg7aL/aBlfSP7RoBQGnK4mAaH6+Xf/Ku6k3wHbRW+EcT
         GC4ykh3jSSKEPSPfI0f1MOHdJFOaCYIorrXEM0izwrJtvFskTEoccf+vccGkyQZJmFcL
         Sl6sPhmxjQmj+v6WELyb9MfYvHgKT/agRbjc1LEdO27jskevmaGxN9Ok2FJy/JhAwTkv
         g7wdKKaVfWysTwkgzuNSfX03FgA1x/aofFIS29gg0vuTPCnaNMccFdJ27v9P9mFSXmzI
         H63MAr5XXFIKE5r4Fs/XSPT1ZEj/OSrR1HY45Tcm2t/zsZsLoQOsSLEKdTPY4UMwA5nt
         UPVQ==
X-Gm-Message-State: AAQBX9dWAQZYeg2cfb+ZnYgdlR0LRqRs1ufzNyntOE5RdmQEoaj2zZuq
        se9fgEZq/NAVHsUyUkE/Ly1o1fCK5HK+MzpTbm0BnkD/JqTJ2uHfHuz7VzTUAyZCi0shaCRB4G6
        68/jonlpoE8WvVGtExhV/Mw==
X-Received: by 2002:a5d:8d0d:0:b0:760:b591:e651 with SMTP id p13-20020a5d8d0d000000b00760b591e651mr3935777ioj.13.1681490074065;
        Fri, 14 Apr 2023 09:34:34 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y4xZd31W2OHtW31atCrSCtoyPH5rds55etIE3WyFmBagEgjbWM4ZMraJRpXtYloWSVQYhCKA==
X-Received: by 2002:a5d:8d0d:0:b0:760:b591:e651 with SMTP id p13-20020a5d8d0d000000b00760b591e651mr3935754ioj.13.1681490073788;
        Fri, 14 Apr 2023 09:34:33 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id w23-20020a056638379700b0040bbee466a4sm1288919jal.72.2023.04.14.09.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 09:34:33 -0700 (PDT)
Date:   Fri, 14 Apr 2023 10:34:28 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v3 12/12] vfio/pci: Report dev_id in
 VFIO_DEVICE_GET_PCI_HOT_RESET_INFO
Message-ID: <20230414103428.20d390a2.alex.williamson@redhat.com>
In-Reply-To: <BN9PR11MB5276A160CA699933B897C8C18C999@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230406115347.7af28448.alex.williamson@redhat.com>
        <ZDVfqpOCnImKr//m@nvidia.com>
        <20230411095417.240bac39.alex.williamson@redhat.com>
        <20230411111117.0766ad52.alex.williamson@redhat.com>
        <ZDWph7g0hcbJHU1B@nvidia.com>
        <20230411155827.3489400a.alex.williamson@redhat.com>
        <ZDX0wtcvZuS4uxmG@nvidia.com>
        <20230412105045.79adc83d.alex.williamson@redhat.com>
        <ZDcPTTPlni/Mi6p3@nvidia.com>
        <BN9PR11MB5276782DA56670C8209470828C989@BN9PR11MB5276.namprd11.prod.outlook.com>
        <ZDfslVwqk6JtPpyD@nvidia.com>
        <20230413120712.3b9bf42d.alex.williamson@redhat.com>
        <BN9PR11MB5276A160CA699933B897C8C18C999@BN9PR11MB5276.namprd11.prod.outlook.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 14 Apr 2023 09:11:30 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Friday, April 14, 2023 2:07 AM
> > 
> > We had already iterated a proposal where the group-id is replaced with
> > a dev-id in the existing ioctl and a flag indicates when the return
> > value is a dev-id vs group-id.  This had a gap that userspace cannot
> > determine if a reset is available given this information since un-owned
> > devices report an invalid dev-id and userspace can't know if it has
> > implicit ownership.
> > 
> > It seems cleaner to me though that we would could still re-use INFO in
> > a similar way, simply defining a new flag bit which is valid only in
> > the case of returning dev-ids and indicates if the reset is available.
> > Therefore in one ioctl, userspace knows if hot-reset is available
> > (based on a kernel determination) and can pull valid dev-ids from the  
> 
> So the kernel needs to compare the group id between devices with
> valid dev-ids and devices with invalid dev-ids to decide the implicit
> ownership. For noiommu device which has no group_id when
> VFIO_GROUP is off then it's resettable only if having a valid dev_id.

With no-iommu and VFIO_GROUP on, each no-iommu device gets it's own
group and the user must have ownership of each affected group, so
there's really no difference here.  Every affected no-iommu device must
be owned in either case.
 
> The only corner case with this option is when a user mixes group
> and cdev usages. iirc you mentioned it's a valid usage to be supported.
> In that case the kernel doesn't have sufficient knowledge to judge
> 'resettable' as it doesn't know which groups are opened by this user.

So for example we might have a 2-function device, fn0 is opened via
cdev and part of an iommufd ctx and fn1 is opened via the group
interface and potentially bound to a type1 container context.

In the INFO/INFO2 proposal, the INFO ioctl would return an array
reporting the group and BDF for each function.  The INFO ioctl is
callable from either device (aiui).  The INFO2 ioctl would fail on the
group opened device because it doesn't have an iommufd_ctx.  When
called on the cdev opened device, INFO2 would fail because the dev-set
is not represented within the iommufd_ctx.  Is this right?

In my proposal, the INFO ioctl can also be called on either device.
When called on the cdev opened device, the return structure provides
dev-ids with a flag indicating such in the return structure.  The cdev
device has a valid dev-id, the group device invalid.  The
reset-available flag is clear because the kernel cannot infer ownership
of the group opened device.  When called on the group opened device, the
IOMMU group and BDF are returned for each device.

So both approaches have similar issues here, but I think there's an
advantage to the approach of extending INFO.  In that case, the user
still gets the dev-id of the affected cdev device and therefore could
build a hot-reset ioctl call using a combination of groupfds and
devicefds, even if the cdev opened device are passed by fd.  Perhaps
it's obvious that the hot-reset device is itself affected by the reset,
but I think the example scenario could be extended to one where there
are multiple cdev opened devices and one or more group opened devices.
AIUI, the INFO2 proposal essentially only returns success if the
null-array approach is supported, ie. the kernel can infer the full
ownership of the dev-set.  However, I think we could still support a
proof-of-ownership based hot-reset with devicefds and groupfds provide
by the user.

I think what this means is that the flag we're exposing is not
"hot-reset available", but really whether the kernel can infer
ownership and the ownership conditions are satisfied.  Therefore it
essentially only flags the availability of the null-array interface
while the proof-of-ownership approach is always available.

> Not sure whether we can leave it in a ugly way so INFO may not tell
> 'resettable' accurately in that weird scenario.

Is it still ugly with the above design?  Thanks,

Alex

