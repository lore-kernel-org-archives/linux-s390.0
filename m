Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B56C433F5
	for <linux-s390@archiver.kernel.org>; Tue,  8 Feb 2022 19:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386018AbiBHT0c (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 8 Feb 2022 14:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377242AbiBHT0b (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Feb 2022 14:26:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F48FC0612C0
        for <linux-s390@vger.kernel.org>; Tue,  8 Feb 2022 11:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644348389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BzqMej504HP9iJS26N5AKS3nCldBmiZ0Bk7bJi7wixc=;
        b=RmoyzLXqo4DUs4vw4ZYtopPTtOwntxKaWLfCgeDMnbIseMNDwgphby0KWNSquMZ7bo7ht0
        NlvIkYloQJTJg1Ae6EeS/wX3y2htT2HSCZn4i7oIfi4oTdF9IeJ1RuFuMfqUMDvbsagmig
        CmkEZ+2IjgSVurEYKOwR1hep+Cg0pEk=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-527-4nlzkMe7Pbqnkrq8DseC4g-1; Tue, 08 Feb 2022 14:26:28 -0500
X-MC-Unique: 4nlzkMe7Pbqnkrq8DseC4g-1
Received: by mail-ot1-f71.google.com with SMTP id w16-20020a056830111000b005a3e1a958ccso8850713otq.11
        for <linux-s390@vger.kernel.org>; Tue, 08 Feb 2022 11:26:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=BzqMej504HP9iJS26N5AKS3nCldBmiZ0Bk7bJi7wixc=;
        b=qslqlN3aHhIyF+5EetfwGhEpMSlwWWmIX7shPaiom1EskhPXA2LMRgbUOs0J+7GawK
         SUyM1Lfdgpplg2w08wINaU32Q5VgZUo8rKXYXldImqbd/+f0lzEurbawwSFHWqCasyqJ
         mVX1mfz1i7SRYQWKx7HRnI6CL4zSbP+UY42S7DfL7YUkNbNJPu83TIBj6/LlqKsNSJsZ
         bmCL7weQQgoO6OqKrQT6+DHSMmy6/w4JVXq6gathTe9DqpKuM0V/Pimhk7tKCbrlcmvh
         /ZY1xGddMiRIIc6Z+sj7khPj99+InHiqbsZc3iIdfRPjqLR2pl1Z5D0MXmVrH520i18n
         /OUQ==
X-Gm-Message-State: AOAM531ygMDt+Lo8U9EcCUQr6u59zGgCZEo/GvDusuGTX2hhOIq8whXQ
        BptamhmnL0QRN2RH3xbmdN41B7a8FImOZtu/A/6IGRkQKcKf7iP3Nnz/Adg+qyBydPrvsgTPeWg
        JZJN8OI6GKRtmMWk+pJS7sA==
X-Received: by 2002:a05:6870:11c1:: with SMTP id 1mr944380oav.286.1644348387627;
        Tue, 08 Feb 2022 11:26:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxozP1hWgXUYydn68daJSy4EUKr1ufMvAvNN9PlT+7UezgHFd+TWBMnVCP4EGJT5Ova2FoujA==
X-Received: by 2002:a05:6870:11c1:: with SMTP id 1mr944375oav.286.1644348387346;
        Tue, 08 Feb 2022 11:26:27 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id 23sm3718740oac.20.2022.02.08.11.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 11:26:27 -0800 (PST)
Date:   Tue, 8 Feb 2022 12:26:24 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>,
        linux-s390@vger.kernel.org, cohuck@redhat.com,
        schnelle@linux.ibm.com, farman@linux.ibm.com, pmorel@linux.ibm.com,
        borntraeger@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        vneethv@linux.ibm.com, oberpar@linux.ibm.com, freude@linux.ibm.com,
        thuth@redhat.com, pasic@linux.ibm.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 24/30] vfio-pci/zdev: wire up group notifier
Message-ID: <20220208122624.43ad52ef.alex.williamson@redhat.com>
In-Reply-To: <20220208185141.GH4160@nvidia.com>
References: <20220204211536.321475-1-mjrosato@linux.ibm.com>
        <20220204211536.321475-25-mjrosato@linux.ibm.com>
        <20220208104319.4861fb22.alex.williamson@redhat.com>
        <20220208185141.GH4160@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 8 Feb 2022 14:51:41 -0400
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Feb 08, 2022 at 10:43:19AM -0700, Alex Williamson wrote:
> > On Fri,  4 Feb 2022 16:15:30 -0500
> > Matthew Rosato <mjrosato@linux.ibm.com> wrote:
> >   
> > > KVM zPCI passthrough device logic will need a reference to the associated
> > > kvm guest that has access to the device.  Let's register a group notifier
> > > for VFIO_GROUP_NOTIFY_SET_KVM to catch this information in order to create
> > > an association between a kvm guest and the host zdev.
> > > 
> > > Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> > >  arch/s390/include/asm/kvm_pci.h  |  2 ++
> > >  drivers/vfio/pci/vfio_pci_core.c |  2 ++
> > >  drivers/vfio/pci/vfio_pci_zdev.c | 46 ++++++++++++++++++++++++++++++++
> > >  include/linux/vfio_pci_core.h    | 10 +++++++
> > >  4 files changed, 60 insertions(+)
> > > 
> > > diff --git a/arch/s390/include/asm/kvm_pci.h b/arch/s390/include/asm/kvm_pci.h
> > > index e4696f5592e1..16290b4cf2a6 100644
> > > +++ b/arch/s390/include/asm/kvm_pci.h
> > > @@ -16,6 +16,7 @@
> > >  #include <linux/kvm.h>
> > >  #include <linux/pci.h>
> > >  #include <linux/mutex.h>
> > > +#include <linux/notifier.h>
> > >  #include <asm/pci_insn.h>
> > >  #include <asm/pci_dma.h>
> > >  
> > > @@ -32,6 +33,7 @@ struct kvm_zdev {
> > >  	u64 rpcit_count;
> > >  	struct kvm_zdev_ioat ioat;
> > >  	struct zpci_fib fib;
> > > +	struct notifier_block nb;
> > >  };
> > >  
> > >  int kvm_s390_pci_dev_open(struct zpci_dev *zdev);
> > > diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> > > index f948e6cd2993..fc57d4d0abbe 100644
> > > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > > @@ -452,6 +452,7 @@ void vfio_pci_core_close_device(struct vfio_device *core_vdev)
> > >  
> > >  	vfio_pci_vf_token_user_add(vdev, -1);
> > >  	vfio_spapr_pci_eeh_release(vdev->pdev);
> > > +	vfio_pci_zdev_release(vdev);
> > >  	vfio_pci_core_disable(vdev);
> > >  
> > >  	mutex_lock(&vdev->igate);
> > > @@ -470,6 +471,7 @@ EXPORT_SYMBOL_GPL(vfio_pci_core_close_device);
> > >  void vfio_pci_core_finish_enable(struct vfio_pci_core_device *vdev)
> > >  {
> > >  	vfio_pci_probe_mmaps(vdev);
> > > +	vfio_pci_zdev_open(vdev);
> > >  	vfio_spapr_pci_eeh_open(vdev->pdev);
> > >  	vfio_pci_vf_token_user_add(vdev, 1);
> > >  }  
> > 
> > If this handling were for a specific device, I think we'd be suggesting
> > this is the point at which we cross over to a vendor variant making use
> > of vfio-pci-core rather than hooking directly into the core code.   
> 
> Personally, I think it is wrong layering for VFIO to be aware of KVM
> like this. This marks the first time that VFIO core code itself is
> being made aware of the KVM linkage.

I agree, but I've resigned that I've lost that battle.  Both mdev vGPU
vendors make specific assumptions about running on a VM.  VFIO was
never intended to be tied to KVM or the specific use case of a VM.

> It copies the same kind of design the s390 specific mdev use of
> putting VFIO in charge of KVM functionality. If we are doing this we
> should just give up and admit that KVM is a first-class part of struct
> vfio_device and get rid of the notifier stuff too, at least for s390.

Euw.  You're right, I really don't like vfio core code embracing this
dependency for s390, device specific use cases are bad enough.

> Reading the patches and descriptions pretty much everything is boiling
> down to 'use vfio to tell the kvm architecture code to do something' -
> which I think needs to be handled through a KVM side ioctl.

AIF at least sounds a lot like the reason we invented the irq bypass
mechanism to allow interrupt producers and consumers to register
independently and associate to each other with a shared token.

Is the purpose of IOAT to associate the device to a set of KVM page
tables?  That seems like a container or future iommufd operation.  I
read DTSM as supported formats for the IOAT.

> Or, at the very least, everything needs to be described in some way
> that makes it clear what is happening to userspace, without kvm,
> through these ioctls.

As I understand the discussion here:

https://lore.kernel.org/all/20220204211536.321475-15-mjrosato@linux.ibm.com/

The assumption is that there is no non-KVM userspace currently.  This
seems like a regression to me.

> This seems especially true now that it seems s390 PCI support is
> almost truely functional, with actual new userspace instructions to
> issue MMIO operations that work outside of KVM. 
> 
> I'm not sure how this all fits together, but I would expect an outcome
> where DPDK could run on these new systems and not have to know
> anything more about s390 beyond using the proper MMIO instructions via
> some compilation time enablement.

Yes, fully enabling zPCI with vfio, but only for KVM is not optimal.

> (I've been reviewing s390 patches updating rdma for a parallel set of
> stuff)
> 
> > this is meant to extend vfio-pci proper for the whole arch.  Is there a
> > compromise in using #ifdefs in vfio_pci_ops to call into zpci specific
> > code that implements these arch specific hooks and the core for
> > everything else?  SPAPR code could probably converted similarly, it
> > exists here for legacy reasons. [Cc Jason]  
> 
> I'm not sure I get what you are suggesting? Where would these ifdefs
> be?

Essentially just:

static const struct vfio_device_ops vfio_pci_ops = {
        .name           = "vfio-pci",
#ifdef CONFIG_S390
        .open_device    = vfio_zpci_open_device,
        .close_device   = vfio_zpci_close_device,
        .ioctl          = vfio_zpci_ioctl,
#else
        .open_device    = vfio_pci_open_device,
        .close_device   = vfio_pci_core_close_device,
        .ioctl          = vfio_pci_core_ioctl,
#endif
        .read           = vfio_pci_core_read,
        .write          = vfio_pci_core_write,
        .mmap           = vfio_pci_core_mmap,
        .request        = vfio_pci_core_request,
        .match          = vfio_pci_core_match,
};

It would at least provide more validation/exercise of the core/vendor
split.  Thanks,

Alex

