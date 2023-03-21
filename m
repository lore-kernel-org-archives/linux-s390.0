Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8011AC6FD20
	for <linux-s390@archiver.kernel.org>; Tue, 21 Mar 2023 20:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjCUUcT (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 21 Mar 2023 16:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCUUcS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 21 Mar 2023 16:32:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10C11E1EA
        for <linux-s390@vger.kernel.org>; Tue, 21 Mar 2023 13:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679430687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3SoZAa/8xF1VxHMtjBD+X/WJ+O7TFOveLIe/Nw8esJs=;
        b=RUv7FU2mKF8CkSP0kantWhnTHD8PvMatCJcK9EMa0wB2dTWB+l078euvqo5JuleG0ARaat
        7wANsKn0H68FgIDAu/bqxtlktrF6mKEJNwcIHTaInHf1yGug704xC+BqVX2pBKJbprq7Dh
        ePNRrFgcTJK8nNd2QEQjPFCnImNPn4w=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-QvURixRIMTqjCf65ybbb3w-1; Tue, 21 Mar 2023 16:31:26 -0400
X-MC-Unique: QvURixRIMTqjCf65ybbb3w-1
Received: by mail-io1-f71.google.com with SMTP id c83-20020a6bb356000000b00758333e1ddfso2112629iof.14
        for <linux-s390@vger.kernel.org>; Tue, 21 Mar 2023 13:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679430686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3SoZAa/8xF1VxHMtjBD+X/WJ+O7TFOveLIe/Nw8esJs=;
        b=BxA2OR3M6bjw6IsvvebkiRwTknpKB4PMbOngbNeUpNYg3fQMQy36VaIIGejt+siAg9
         E8PQGVaQFaEJZimBz8INg9yQo+N/AVpXNxuTbtbHwmbk8+MqwSaIBQA5q3lOLvnpwwEK
         TjgQrfrPdp2YXdE4m2RcWye20DYiSUBKegYWJ9PyG4y5JJBzAZoO1uAecyufkiaFsAWJ
         IdZZO9sp1g9BZMFHPYDlkUxZGly3m8c6Y0FNAv2jE53Scgl/uHMW7KC+Kl84N2ICaTYD
         8IqwKrmD4X78KfIpoz589+JZnecnY4BqBDhhbFWfoMtdt4i9JKjFqh5usY7bt7nQvYty
         0hsw==
X-Gm-Message-State: AO0yUKW7AsWPtk//QcnSptcNh5vJb3jCsTsBjw/z5G0cyZ+mBPFpc2jg
        KZLmOvr0bJUX9FTjgtvm2LGrLxz6i7HrQd9OC0klazthUDg4BIfxtpkMwAXW7B4DTLELhZ12k3s
        YUwn/Cemk1ojg/Sz3qwUr4w==
X-Received: by 2002:a92:c503:0:b0:323:2c83:3064 with SMTP id r3-20020a92c503000000b003232c833064mr2697667ilg.31.1679430685831;
        Tue, 21 Mar 2023 13:31:25 -0700 (PDT)
X-Google-Smtp-Source: AK7set8RsLy22yUQqFdiRovisP4m8BeCD6yBQhPuFmJnLrNBzHBGAk/zi9QQ6dulBCbOIg4UjodPLA==
X-Received: by 2002:a92:c503:0:b0:323:2c83:3064 with SMTP id r3-20020a92c503000000b003232c833064mr2697633ilg.31.1679430685539;
        Tue, 21 Mar 2023 13:31:25 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id dl9-20020a056638278900b004051a7ef7f3sm4305251jab.71.2023.03.21.13.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 13:31:24 -0700 (PDT)
Date:   Tue, 21 Mar 2023 14:31:22 -0600
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
Message-ID: <20230321143122.632f7e63.alex.williamson@redhat.com>
In-Reply-To: <ZBjum1wQ1L2AIfhB@nvidia.com>
References: <20230308132903.465159-13-yi.l.liu@intel.com>
        <20230315165311.01f32bfe.alex.williamson@redhat.com>
        <BN9PR11MB5276300FCAAF8BF7B4E03BA48CBF9@BN9PR11MB5276.namprd11.prod.outlook.com>
        <20230316124532.30839a94.alex.williamson@redhat.com>
        <BN9PR11MB5276F7879E428080D2B214D98CBC9@BN9PR11MB5276.namprd11.prod.outlook.com>
        <20230316182256.6659bbbd.alex.williamson@redhat.com>
        <BN9PR11MB5276D5A71E43EA4CDD1C960A8CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
        <20230317091557.196638a6.alex.williamson@redhat.com>
        <ZBiUiEC8Xj9sOphr@nvidia.com>
        <20230320165217.5b1019a4.alex.williamson@redhat.com>
        <ZBjum1wQ1L2AIfhB@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 20 Mar 2023 20:39:07 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Mar 20, 2023 at 04:52:17PM -0600, Alex Williamson wrote:
> 
> > > The APIs are well defined and userspace can always use them wrong. It
> > > doesn't need to call RESET_INFO even today, it can just trivially pass
> > > every group FD it owns to meet the security check.  
> > 
> > That's not actually true, in order to avoid arbitrarily large buffers
> > from the user, the ioctl won't accept an array greater than the number
> > of devices affected by the reset.  
> 
> Oh yuk!
> 
> > > It is much simpler if VFIO_DEVICE_PCI_HOT_RESET can pass the security
> > > check without code marshalling fds, which is why we went this
> > > direction.  
> > 
> > I agree that nullifying the arg makes the ioctl easier to use, but my
> > hesitation is whether it makes it more difficult to use correctly,
> > which includes resetting devices unexpectedly.  
> 
> I don't think it makes it harder to use correctly. It maybe makes it
> easier to misuse, but IMHO not too much.
> 
> If the desire was to have an API that explicitly acknowledged the
> reset scope then it should have taken in a list of device FDs and
> optimally reset all of them or fail EPERM.
> 
> What is going to make this hard to use is the _INFO IOCTL, it returns
> basically the BDF string, but I think we effectively get rid of this
> in the new model. libvirt will know the BDF and open the cdev, then fd
> pass the cdev to qemu. Qemu shouldn't also have to know the sysfs
> path..
> 
> So we really want a new _INFO ioctl to make this easier to use..

I think this makes it even worse.  If userspace cannot match BDFs from
the _INFO ioctl to devices files, for proof of ownership or scope, then
the answer is clearly not "get rid of the device files".

> > We can always blame the developer for using an interface incorrectly,
> > but if we make it easier to use incorrectly in order to optimize
> > something that doesn't need to be optimized, does that make it a good
> > choice for the uAPI?  
> 
> IMHO the API is designed around a security proof. Present some groups
> and a subset of devices in those groups will be reset. You can't know
> the subset unless you do the _INFO thing.
> 
> If we wanted it to be clearly linked to scope it should have taken in
> a list of device FDs, and reset those devices FDs optimally or
> returned -EPERM. Then the reset scope is very clearly connected to the
> API.

This just seems like nit-picking that the API could have accomplished
this more concisely.  Probably that's true, but I think you've
identified a gap above that amplifies the issue.  If the user cannot
map BDFs to cdevs because the cdevs are passed as open fds to the user
driver, the _INFO results become meaningless and by removing the fds
array, that becomes the obvious choice that a user presented with this
dilemma would take.  We're skipping past easier to misuse, difficult to
use correctly, and circling around no obvious way to use correctly.

Unfortunately the _INFO ioctl does presume that userspace knows the BDF
to device mappings today, so if we are attempting to pre-enable a case
with cdev support where that is not the case, then there must be
something done with the _INFO ioctl to provide scope.  Thanks,

Alex

