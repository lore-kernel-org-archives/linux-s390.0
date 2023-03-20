Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79994C6FD1C
	for <linux-s390@archiver.kernel.org>; Mon, 20 Mar 2023 22:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjCTWxI (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 20 Mar 2023 18:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjCTWxH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 20 Mar 2023 18:53:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0474A10413
        for <linux-s390@vger.kernel.org>; Mon, 20 Mar 2023 15:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679352742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7y/3HAZ3wfAvPwVJ/7JyA9v2d7U1+6FVR3qfhwvOp+k=;
        b=gRS3z03ddpBN7UevJCxf8QhqcGv/xrD1lZOypFia33udc8Migj9ghYYJ2NAyc7ym3dXt5W
        UZ0hLhclVfZL9rQWTfawx/W8ohL7EiLSmQrXgFf9y6MBHtF2KmQfZsHFVqIUKhc8FrrTqp
        D2iV1jzyRQ8251m7tM0z2aiBwCrScbM=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-6U5ZimixPJa02zJvGSAotg-1; Mon, 20 Mar 2023 18:52:20 -0400
X-MC-Unique: 6U5ZimixPJa02zJvGSAotg-1
Received: by mail-io1-f70.google.com with SMTP id h7-20020a5d9707000000b00752fe6c68d1so6841416iol.13
        for <linux-s390@vger.kernel.org>; Mon, 20 Mar 2023 15:52:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679352740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7y/3HAZ3wfAvPwVJ/7JyA9v2d7U1+6FVR3qfhwvOp+k=;
        b=6jrOi3hErHHuTBR9kl4Zmojb8vP5wgTiyiy3biKMMFUap4bBuQZUwhiRkPsrwJ3bxP
         jVb9jWKFeN2S2p9wFz0toNQcqic3shvOtjgQqCmDMmpNULJws/5iO/a53eMi1pVhtW13
         2qggt38DXd1OvZxr/WKaVnIrNruom4PhlF1E2jjTAyjf0bOjZYQv6ceUweZVh3nUo40N
         UmbKxjeMiXO7g28EteMq89ofrAGtUlvwYYdAWl5if8Jpk+dTGwnzcK2LZ+ABgGHLDs5O
         AskMFCikO5KPxVCkUuz5Zh/guEIPDz3doXMM6MnddDWK9GeLD4/rfYLvZp/0JLUAabtD
         ArUQ==
X-Gm-Message-State: AO0yUKXZ/NaWlt7+ZJhWbcVGCf6DPDQMKgnk8E9wIgcjBbOZfeZ/u9Q+
        PfQSE4q+ri1gsXKRyo5cZkSUUNtTinQ/pBcE6KExilHSa9KlqeWg/LELgZas7U9rqZI9IYq4UbF
        N9PxzChSaOFJko3UDP1XX2Q==
X-Received: by 2002:a92:d0c5:0:b0:315:4b70:8376 with SMTP id y5-20020a92d0c5000000b003154b708376mr147243ila.29.1679352740093;
        Mon, 20 Mar 2023 15:52:20 -0700 (PDT)
X-Google-Smtp-Source: AK7set+//D7ynk55WQbxx3kMdwYsMpYqnO34ebRyHnzzvy+2P9QDQRcsbaasFIm+/n0ZluW7NpmwqQ==
X-Received: by 2002:a92:d0c5:0:b0:315:4b70:8376 with SMTP id y5-20020a92d0c5000000b003154b708376mr147215ila.29.1679352739744;
        Mon, 20 Mar 2023 15:52:19 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id h24-20020a056602009800b00743fe29dd56sm3188905iob.4.2023.03.20.15.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 15:52:19 -0700 (PDT)
Date:   Mon, 20 Mar 2023 16:52:17 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "Hao, Xudong" <xudong.hao@intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "Xu, Terrence" <terrence.xu@intel.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
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
Subject: Re: [PATCH v6 12/24] vfio/pci: Allow passing zero-length fd array
 in VFIO_DEVICE_PCI_HOT_RESET
Message-ID: <20230320165217.5b1019a4.alex.williamson@redhat.com>
In-Reply-To: <ZBiUiEC8Xj9sOphr@nvidia.com>
References: <20230308132903.465159-1-yi.l.liu@intel.com>
        <20230308132903.465159-13-yi.l.liu@intel.com>
        <20230315165311.01f32bfe.alex.williamson@redhat.com>
        <BN9PR11MB5276300FCAAF8BF7B4E03BA48CBF9@BN9PR11MB5276.namprd11.prod.outlook.com>
        <20230316124532.30839a94.alex.williamson@redhat.com>
        <BN9PR11MB5276F7879E428080D2B214D98CBC9@BN9PR11MB5276.namprd11.prod.outlook.com>
        <20230316182256.6659bbbd.alex.williamson@redhat.com>
        <BN9PR11MB5276D5A71E43EA4CDD1C960A8CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
        <20230317091557.196638a6.alex.williamson@redhat.com>
        <ZBiUiEC8Xj9sOphr@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 20 Mar 2023 14:14:48 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Fri, Mar 17, 2023 at 09:15:57AM -0600, Alex Williamson wrote:
> > > If that is the intended usage then I don't see why this proposal will
> > > promote userspace to ignore the _INFO ioctl. It should be always
> > > queried no matter how the reset ioctl itself is designed. The motivation
> > > of calling _INFO is not from the reset ioctl asking for an array of fds.  
> > 
> > The VFIO_DEVICE_PCI_HOT_RESET ioctl requires a set of group (or cdev)
> > fds that encompass the set of affected devices reported by the
> > VFIO_DEVICE_GET_PCI_HOT_RESET_INFO ioctl, so I don't agree with the
> > last sentence above.  
> 
> There are two things going on - VFIO_DEVICE_PCI_HOT_RESET requires to
> prove security that the userspace is not attempting to reset something
> that it does not have ownership over. Eg a reset group that spans
> multiple iommu groups.
> 
> The second is for userspace to discover the reset group so it can
> understand what is happening.
> 
> IMHO it is perfectly fine for each API to be only concerned with its
> own purpose.
> 
> VFIO_DEVICE_PCI_HOT_RESET needs to check security, which the
> iommufd_ctx check does just fine
> 
> VFIO_DEVICE_GET_PCI_HOT_RESET_INFO needs to convey the reset group
> span so userspace can do something with this.
> 
> I think confusing security and scope and "acknowledgment" is not a
> good idea.
> 
> The APIs are well defined and userspace can always use them wrong. It
> doesn't need to call RESET_INFO even today, it can just trivially pass
> every group FD it owns to meet the security check.

That's not actually true, in order to avoid arbitrarily large buffers
from the user, the ioctl won't accept an array greater than the number
of devices affected by the reset.

> It is much simpler if VFIO_DEVICE_PCI_HOT_RESET can pass the security
> check without code marshalling fds, which is why we went this
> direction.

I agree that nullifying the arg makes the ioctl easier to use, but my
hesitation is whether it makes it more difficult to use correctly,
which includes resetting devices unexpectedly.

We're talking about something that's a relatively rare event, so I
don't see that time overhead is a factor, nor has the complexity
overhead in the QEMU implementation ever been raised as an issue
previously.

We can always blame the developer for using an interface incorrectly,
but if we make it easier to use incorrectly in order to optimize
something that doesn't need to be optimized, does that make it a good
choice for the uAPI?  Thanks,

Alex

