Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD6CC6FD1F
	for <linux-s390@archiver.kernel.org>; Fri, 17 Mar 2023 00:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjCQAXv (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 16 Mar 2023 20:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCQAXu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 16 Mar 2023 20:23:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1073B06F0
        for <linux-s390@vger.kernel.org>; Thu, 16 Mar 2023 17:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679012581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XSyAHP79zbLTHByO1UMWkwG5VhqMvodcFmqqMUfSNXU=;
        b=G5iAY90fvDh3VZrLRrZDMlpBWYaAHZtVo9BYOHAk3hCzxfL97jt4niJ/Xg1wpgYrKE3DYu
        VU/dj5pMr65G4JCUBy8jkTJeqQmt/0U5XgaP5l0Ca87bKYncW58F0ueeln28aQilXD6FLO
        YEEBYTy4Pef/W3x0+uVlvnL5M08YvAc=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-I-rpp-WrOJK-nUc6cFEl5g-1; Thu, 16 Mar 2023 20:23:00 -0400
X-MC-Unique: I-rpp-WrOJK-nUc6cFEl5g-1
Received: by mail-il1-f198.google.com with SMTP id c9-20020a929409000000b0032307610dfaso1629099ili.5
        for <linux-s390@vger.kernel.org>; Thu, 16 Mar 2023 17:23:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679012579;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XSyAHP79zbLTHByO1UMWkwG5VhqMvodcFmqqMUfSNXU=;
        b=NRzSIKqoucoE5MFckn5LfUhhckSJ3NJynErTRyxFrtNdKH8vckmqtJTTUGLZfIgvFb
         sJivMezxQuZX6Cer9hGak5P3D8wKZ4jX1jzSCh6fRPrpcohMjCra1QW7WniJlo0Xxb2T
         t82hoqzBYjrKQ8j1nUXqoB8zoJvIGrPdnMxj6ha6x7Uo+yDpi3oUIhHzH6a4SobPb9py
         20xlo1ElSxWaluOzEVf/bjH+AZRNDrZHvksUjbh3WYP8Fk52zKxLPBqxfCshjsv3EdAw
         yBknfoDrAjEIvz6zKMnjzzd3It1EBsW5Ia86Cqh1f9E/uD1qzvXWYhptbwrKllNAX/x5
         BeuQ==
X-Gm-Message-State: AO0yUKW8u4rUU62qH1Su6CP6FY6n2Ei9CPPdIEbsFe1bLR+7kuYCIHx1
        RIaSTdzUGwCQMtcRXRi//OG8J/PJ/AKWKJu4EiHmHyeIWZtYtUY2TK+PFaznAPjsDQydJS4dJt+
        BH3QlmP755IPUtTQltHREpUSTfGLA0Q==
X-Received: by 2002:a05:6e02:1151:b0:317:eef2:f5cc with SMTP id o17-20020a056e02115100b00317eef2f5ccmr8697407ill.10.1679012579506;
        Thu, 16 Mar 2023 17:22:59 -0700 (PDT)
X-Google-Smtp-Source: AK7set/iT+8IeRFfmQPOt1YsJVElfStX87uq3MIp8yFcWKSg+oPhoPMe5gX/E9CYwiObV9svKZZ9jA==
X-Received: by 2002:a05:6e02:1151:b0:317:eef2:f5cc with SMTP id o17-20020a056e02115100b00317eef2f5ccmr8697382ill.10.1679012579260;
        Thu, 16 Mar 2023 17:22:59 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id q16-20020a0566380d1000b003c2b76fcdf2sm230584jaj.52.2023.03.16.17.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 17:22:58 -0700 (PDT)
Date:   Thu, 16 Mar 2023 18:22:56 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "Hao, Xudong" <xudong.hao@intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "Xu, Terrence" <terrence.xu@intel.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
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
Message-ID: <20230316182256.6659bbbd.alex.williamson@redhat.com>
In-Reply-To: <BN9PR11MB5276F7879E428080D2B214D98CBC9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230308132903.465159-1-yi.l.liu@intel.com>
        <20230308132903.465159-13-yi.l.liu@intel.com>
        <20230315165311.01f32bfe.alex.williamson@redhat.com>
        <BN9PR11MB5276300FCAAF8BF7B4E03BA48CBF9@BN9PR11MB5276.namprd11.prod.outlook.com>
        <20230316124532.30839a94.alex.williamson@redhat.com>
        <BN9PR11MB5276F7879E428080D2B214D98CBC9@BN9PR11MB5276.namprd11.prod.outlook.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 16 Mar 2023 23:29:21 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Alex Williamson
> > Sent: Friday, March 17, 2023 2:46 AM
> > 
> > On Wed, 15 Mar 2023 23:31:23 +0000
> > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> >   
> > > > From: Alex Williamson <alex.williamson@redhat.com>
> > > > Sent: Thursday, March 16, 2023 6:53 AM
> > > > I'm afraid this proposal reduces or eliminates the handshake we have
> > > > with userspace between VFIO_DEVICE_GET_PCI_HOT_RESET_INFO and
> > > > VFIO_DEVICE_PCI_HOT_RESET, which could promote userspace to ignore  
> > the  
> > > > _INFO ioctl altogether, resulting in drivers that don't understand the
> > > > scope of the reset.  Is it worth it?  What do we really gain?  
> > >
> > > Jason raised the concern whether GET_PCI_HOT_RESET_INFO is actually
> > > useful today.
> > >
> > > It's an interface on opened device. So the tiny difference is whether the
> > > user knows the device is resettable when calling GET_INFO or later when
> > > actually calling PCI_HOT_RESET.  
> > 
> > No, GET_PCI_HOT_RESET_INFO conveys not only whether a PCI_HOT_RESET
> > can
> > be performed, but equally important the scope of the reset, ie. which
> > devices are affected by the reset.  If we de-emphasize the INFO
> > portion, then this easily gets confused as just a variant of
> > VFIO_DEVICE_RESET, which is explicitly a device-level cscope reset.  In
> > fact, I'd say the interface is not only trying to validate that the
> > user has sufficient privileges for the reset, but that they explicitly
> > acknowledge the scope of the reset.
> >   
> 
> IMHO the usefulness of scope is if it's discoverable by the management
> stack which then can try to assign devices with affected reset to a same
> user.

Disagree, the user needs to know the scope of reset.  Take for instance
two function of a device configured onto separate buses within a VM.
The VMM needs to know that a hot-reset of one will reset the other.
That's not obvious to the VMM without some understanding of PCI/e
topology and analysis of the host system.  The info ioctl simplifies
that discovery for the VMM and the handshake of passing the affected
groups makes sure that the info ioctl remains relevant.

OTOH, I really haven't seen any evidence that the null-array concept
provides significant simplification for userspace, especially without
compromising the user's understanding of the scope of the provided
reset.  Thanks,

Alex

