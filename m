Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1573C77B6F
	for <linux-s390@archiver.kernel.org>; Wed, 12 Apr 2023 17:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjDLRDj (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 12 Apr 2023 13:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbjDLRDf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 12 Apr 2023 13:03:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7DB7698
        for <linux-s390@vger.kernel.org>; Wed, 12 Apr 2023 10:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681318912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JeneufXpiEYUuGyGZ8Q8ABZcDJsC9i3M9esfSkLThDs=;
        b=LfI3UIymZgjSh3YYBAff3uH7XOLoq5ob1GhO9HJ8A8A+7ChuHR9YymLVOiBJbKAJwXDvmt
        bfJ1bQi364PjtpQdybdkvMkMagADOv5QPFYwbA3D5kD/B8ES1vHzwTXt98Ehyj/ZkLXSKM
        tV6kLTBx/oumG14h6Kcm3aV+7LsJkWM=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-91epAnmEN4qE3mx7jTl90A-1; Wed, 12 Apr 2023 13:01:50 -0400
X-MC-Unique: 91epAnmEN4qE3mx7jTl90A-1
Received: by mail-io1-f69.google.com with SMTP id y74-20020a6bc84d000000b00758ac1b67f8so7879605iof.17
        for <linux-s390@vger.kernel.org>; Wed, 12 Apr 2023 10:01:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681318910; x=1683910910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JeneufXpiEYUuGyGZ8Q8ABZcDJsC9i3M9esfSkLThDs=;
        b=FIIjcpWSSEL4pwAfqnrOyD9Sd6a0UxnBbLpaZaMv7DiKBNEWjCd8pipi/ZuXtYggr3
         EzN/aaRkGTGF6+1ngR3yZ4LUxASNlDw4iWAghE0wTo99UXJB7P/aibdBh+QS6j2YKU92
         6onkh8LaKZTzkro0UL6cdqfhGYHczhvGkMpJakeKAYcjID1cphnXt4+2kISYUHQE8uxo
         mQ60oXtMuSXXmYdsS7ICJqCa3G1/MmdBYelXKPOZl59l+R9PLGcTN8uX0Q//n5dDURUl
         jTwswcEZfZrCgMFkVpVCet40pe9Vjj88PQZgDMaPkOAHgToCSvZ7SiMfvV3y0z4vaXux
         DfPQ==
X-Gm-Message-State: AAQBX9d6oz74DfR2sUmP+PRAI0zj2NoP+Z2L1xvP19NE3HmpcQSnIePh
        Ce+G0hmMpfBLDC9cEnBTgnSVwyPq9WYLZ2oV57tmwltHu6/5OxIRt1rRLmhBIoFy7PUv+y5ztWP
        gzKTEFtVL+9E4x2SPATjVtA==
X-Received: by 2002:a92:ce45:0:b0:317:eef2:f5cc with SMTP id a5-20020a92ce45000000b00317eef2f5ccmr1867120ilr.10.1681318909827;
        Wed, 12 Apr 2023 10:01:49 -0700 (PDT)
X-Google-Smtp-Source: AKy350bmLI/n5FzFmQ15lqziDjlrAa04nLOH96tqFhO3CiJ/t4ZshQUfj7wCR54qShlH2HyBk5wL5Q==
X-Received: by 2002:a92:ce45:0:b0:317:eef2:f5cc with SMTP id a5-20020a92ce45000000b00317eef2f5ccmr1867093ilr.10.1681318909541;
        Wed, 12 Apr 2023 10:01:49 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id a10-20020a5d9eca000000b007587774bec7sm4503807ioe.54.2023.04.12.10.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 10:01:48 -0700 (PDT)
Date:   Wed, 12 Apr 2023 11:01:47 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "Hao, Xudong" <xudong.hao@intel.com>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "Xu, Terrence" <terrence.xu@intel.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "Jiang, Yanting" <yanting.jiang@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "Zhao, Yan Y" <yan.y.zhao@intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
Subject: Re: [PATCH v3 12/12] vfio/pci: Report dev_id in
 VFIO_DEVICE_GET_PCI_HOT_RESET_INFO
Message-ID: <20230412110147.5883582b.alex.williamson@redhat.com>
In-Reply-To: <ZDbIzvawep4Sk+0M@nvidia.com>
References: <ZC4CwH2ouTfZ9DNN@nvidia.com>
        <DS0PR11MB75292DA91ED15AE94A85EB3DC3919@DS0PR11MB7529.namprd11.prod.outlook.com>
        <20230406115347.7af28448.alex.williamson@redhat.com>
        <ZDVfqpOCnImKr//m@nvidia.com>
        <20230411095417.240bac39.alex.williamson@redhat.com>
        <20230411111117.0766ad52.alex.williamson@redhat.com>
        <ZDWph7g0hcbJHU1B@nvidia.com>
        <20230411155827.3489400a.alex.williamson@redhat.com>
        <ZDX0wtcvZuS4uxmG@nvidia.com>
        <BN9PR11MB52761A24E435E9EF910766E28C9B9@BN9PR11MB5276.namprd11.prod.outlook.com>
        <ZDbIzvawep4Sk+0M@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 12 Apr 2023 12:05:50 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Apr 12, 2023 at 07:27:43AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe
> > > Sent: Wednesday, April 12, 2023 8:01 AM
> > > 
> > > I see this problem as a few basic requirements from a qemu-like
> > > application:
> > > 
> > >  1) Does the configuration I was given support reset right now?
> > >  2) Will the configuration I was given support reset for the duration
> > >     of my execution?
> > >  3) What groups of the devices I already have open does the reset
> > >     effect?
> > >  4) For debugging, report to the user the full list of devices in the
> > >     reset group, in a way that relates back to sysfs.
> > >  5) Away to trigger a reset on a group of devices
> > > 
> > > #1/#2 is the API I suggested here. Ask the kernel if the current
> > > configuration works, and ask it to keep it working.
> > > 
> > > #3 is either INFO and a CAP for BDF or INFO2 reporting dev_id
> > > 
> > > #4 is either INFO and print the BDFs or INFO2 reporting the struct
> > > vfio_device IDR # (eg /sys/class/vfio/vfioXXX/).  
> > 
> > mdev doesn't have BDF. Of course it doesn't support hot_reset either.  
> 
> It should support a reset.. Maybe idxd doesn't, but it should be part
> of the SIOV model. Our SIOV devices would need it for instance.

IIRC we require mdev devices to support VFIO_DEVICE_RESET, hot-reset is
a different beast.  I assume SIOV device support would also require
VFIO_DEVICE_RESET support and hot-reset would also be irrelevant to
them.

> > but it's presented to userspace as a pci device. Is it weird for a pci
> > device which doesn't provide a BDF cap?  
> 
> It is weird for a PCI device, but it is not weird for a VFIO
> device. Leaking the physical labels out of the uAPI is not clean,
> IMHO.
> 
> > from this point the vfio_device IDR# sounds more generic.  
> 
> Yes, I was thinking about this for the SIOV model.

Seems like we're off on a tangent, the hot-reset ioctl is not relevant
to devices simply because they expose a vfio-pci API, there is any
underlying hardware aspect that anything that is only virtualizing a
vfio-pci API shouldn't be concerned with.  Thanks,

Alex

