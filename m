Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4324C6FD18
	for <linux-s390@archiver.kernel.org>; Tue, 28 Mar 2023 14:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbjC1Ori (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 28 Mar 2023 10:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjC1Ord (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 28 Mar 2023 10:47:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AD7DBF7
        for <linux-s390@vger.kernel.org>; Tue, 28 Mar 2023 07:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680014782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/pgdm+jy/b4Tdk4we3XCQptlzzAEZ6DctjGUY0MhFMw=;
        b=KOCapyVmcbiEosfdXxsaoqc+WfuFVRGus0p2a3cWAxJOelC3kEE3uXH3tTJ96CIJvLPpLm
        FW2Fq7zJC2KEdnFjj+5PhkY7j53VMpAJt9xe6UmTC9YR1Yjn4pKYI0kC66v4+qTRf0fdgo
        o7S7BLm62L4wO7bCh4CBDSBCKh5jEcI=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-Ke9Y_uIHNamduQVu7Rzhig-1; Tue, 28 Mar 2023 10:46:20 -0400
X-MC-Unique: Ke9Y_uIHNamduQVu7Rzhig-1
Received: by mail-il1-f199.google.com with SMTP id h1-20020a92d841000000b0031b4d3294dfso8179827ilq.9
        for <linux-s390@vger.kernel.org>; Tue, 28 Mar 2023 07:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680014779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/pgdm+jy/b4Tdk4we3XCQptlzzAEZ6DctjGUY0MhFMw=;
        b=3Z2lt1o+zhjNRUWNLtsxCyiP8ABr4CEHPUYb/jLvH3Cb7Oo+exB8ss8Zf33P+aH5cU
         Mo0N2EjurtMAqc+oP9KqpuviB5QDdhEDxLzrB9Fm+4FJeO4EeUyQYaNFrTYrDZBzO/Nr
         bVLCMpawCHr7KqzboIUj9zLlkrIIvnwTMujmBi8uQuLLM7Zfeg3ff9fTrBZ6/68bbDvR
         snuZs9yOf05o8bdfgpQnljP84pFY2cnbPMafbEapSSLiVAaxBbTOmovGh6/PxZndljax
         N/ceJceNyB4Td74WPkUnmOs7BZQiGfot0N2gWdX8btt+end56bAnbVsCNoNPc0G+5Lpi
         YjrA==
X-Gm-Message-State: AAQBX9dsLpZ30Nsds2VsalVp7uGa2Kn/xswosGrQAWmhGwWu6dinPrKF
        K35NbVFLmzLVpAxTnUHAl0EAd80IoOhf6GopHhWfSRGSihEcn/Orap15WCRD8ZK01dc0xalZvYP
        hqaE4FDVyj0NLqRF2i70+Kw==
X-Received: by 2002:a92:cb03:0:b0:316:ac37:1692 with SMTP id s3-20020a92cb03000000b00316ac371692mr11709224ilo.1.1680014778766;
        Tue, 28 Mar 2023 07:46:18 -0700 (PDT)
X-Google-Smtp-Source: AKy350aTliduwAnIwWl0SZjOQEj8WhTrU9CjmbJwxlCOGlgjQmiDfHr6STEw1BtQugPCCt1EmjAPaA==
X-Received: by 2002:a92:cb03:0:b0:316:ac37:1692 with SMTP id s3-20020a92cb03000000b00316ac371692mr11709198ilo.1.1680014778463;
        Tue, 28 Mar 2023 07:46:18 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id m16-20020a056e020df000b003261b677e09sm661997ilj.33.2023.03.28.07.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 07:46:17 -0700 (PDT)
Date:   Tue, 28 Mar 2023 08:46:16 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
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
        "Jiang, Yanting" <yanting.jiang@intel.com>
Subject: Re: [PATCH v2 10/10] vfio/pci: Add
 VFIO_DEVICE_GET_PCI_HOT_RESET_GROUP_INFO
Message-ID: <20230328084616.3361a293.alex.williamson@redhat.com>
In-Reply-To: <DS0PR11MB7529B6782565BE8489D922F9C3889@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230327093458.44939-1-yi.l.liu@intel.com>
        <20230327093458.44939-11-yi.l.liu@intel.com>
        <20230327132619.5ab15440.alex.williamson@redhat.com>
        <DS0PR11MB7529E969C27995D535A24EC0C3889@DS0PR11MB7529.namprd11.prod.outlook.com>
        <BL1PR11MB52717FB9E6D5C10BF4B7DA0A8C889@BL1PR11MB5271.namprd11.prod.outlook.com>
        <20230328082536.5400da67.alex.williamson@redhat.com>
        <DS0PR11MB7529B6782565BE8489D922F9C3889@DS0PR11MB7529.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 28 Mar 2023 14:38:12 +0000
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Tuesday, March 28, 2023 10:26 PM
> > 
> > On Tue, 28 Mar 2023 06:19:06 +0000
> > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> >   
> > > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > > Sent: Tuesday, March 28, 2023 11:32 AM
> > > >  
> > > > > From: Alex Williamson <alex.williamson@redhat.com>
> > > > > Sent: Tuesday, March 28, 2023 3:26 AM
> > > > >
> > > > > Additionally, VFIO_DEVICE_GET_PCI_HOT_RESET_INFO has a flags arg  
> > that  
> > > > > isn't used, why do we need a new ioctl vs defining
> > > > > VFIO_PCI_HOT_RESET_FLAG_IOMMUFD_DEV_ID.  
> > > >
> > > > Sure. I can follow this suggestion. BTW. I have a doubt here. This new  
> > flag  
> > > > is set by user. What if in the future kernel has new extensions and needs
> > > > to report something new to the user and add new flags to tell user? Such
> > > > flag is set by kernel. Then the flags field may have two kinds of flags  
> > (some  
> > > > set by user while some set by kernel). Will it mess up the flags space?
> > > >  
> > >
> > > flags in a GET_INFO ioctl is for output.
> > >
> > > if user needs to use flags as input to select different type of info then it  
> > should  
> > > be split into multiple GET_INFO cmds.  
> > 
> > I don't know that that's actually a rule, however we don't currently
> > test flags is zero for input, so in this case I think we are stuck with
> > it only being for output.
> > 
> > Alternatively, should VFIO_DEVICE_GET_PCI_HOT_RESET_INFO
> > automatically
> > return the dev_id variant of the output and set a flag to indicate this
> > is the case when called on a device fd opened as a cdev?  Thanks,  
> 
> Personally I prefer that user asks for dev_id info explicitly. The major reason
> that we return dev_id is that the group/bdf info is not enough for the device
> fd passing case. But if qemu opens device by itself, the group/bdf info is still
> enough. So a device opened as a cdev doesn't mean it should return dev_id,
> it depends on if user has the bdf knowledge.

But if QEMU opens the cdev, vs getting it from the group, does it make
any sense to return a set of group-ids + bdf in the host-reset info?
I'm inclined to think the answer is no.

Per my previous suggestion, I think we should always return the bdf. We
can't know if the user is accessing through an fd they opened
themselves or were passed, but it allows an actually useful debugging
report if userspace can know "I can't perform a hot reset of this
device because my iommufd context doesn't know about device <bdf>", vs
an opaque -EPERM.  Therefore I think we're only discussing the data
conveyed in the u32, a group-id or dev_id.  Thanks,

Alex

