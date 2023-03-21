Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF210C76195
	for <linux-s390@archiver.kernel.org>; Tue, 21 Mar 2023 22:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjCUWsb (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 21 Mar 2023 18:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjCUWsa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 21 Mar 2023 18:48:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C2558C02
        for <linux-s390@vger.kernel.org>; Tue, 21 Mar 2023 15:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679438861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pkqj6f0mmvcRZY6WGcLhSYjSkEneOC6n3/87lujTtak=;
        b=E/FN7OSole7Ev8l7nlXxXfiOv+0BvbSYc0EIFq1PIkn6bKG/NGYVO7AVFL+JDEM9fHaOEF
        Qt+aI69yOjwrKhArt1HQf/3oVL8wb3E4KrPaS2GNccCm3guPPAuKP7BWE7ifAf41pquv1D
        ekDDyxBxu+wibL72FNvulsJWoDrsJkU=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-5UyHH4pAOcmvMn5PROCuWg-1; Tue, 21 Mar 2023 18:47:40 -0400
X-MC-Unique: 5UyHH4pAOcmvMn5PROCuWg-1
Received: by mail-il1-f200.google.com with SMTP id l10-20020a056e0205ca00b00322fdda7261so8516169ils.6
        for <linux-s390@vger.kernel.org>; Tue, 21 Mar 2023 15:47:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679438859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pkqj6f0mmvcRZY6WGcLhSYjSkEneOC6n3/87lujTtak=;
        b=K2Qe4GVn8WkjqDyaLwR/qlItOlkH9AvctGdppMOOCioODnGC9UZDjXvUuxA7AH4t/H
         Qfgpyrdu8Eqm0xo3qFeR2lG/MkqkYEOhOgdJ3uni8OKMiPRSOJKWCzRLnmScgvvBICcT
         i13xXmraZGdqDyZhXu7XiJ8BTAgFcKWALwXveml4nb+Y6ZS/3p0DEGlv/Ro8I4zZ/le0
         ZKz8ORJyaJHn9RogCOz3DnDz/vvDoF8Pvchnt2+o+835JSau5qtWu+9Ljn0A/mDFYNIf
         FBoRYF61eeI4vwmLHmY/dqGBWSrXX8m9WdFQCFTmduoWm7vyICXLxNTsmOfoFFVO6zWm
         KaEw==
X-Gm-Message-State: AO0yUKXm8GHSbZGKkP4oPqQhNmEB2LSXdu5xMCrxIy19lvxgG3L9L/At
        9mItJ71b6d5+O2SVDw4s/IHa09XpIc+G3JiOiV6FkIVZ3r3bbeCb3fFluM29qJoVxZG260zF8z0
        l7EsOP+XuEfuJig2gY0j51Q==
X-Received: by 2002:a6b:db09:0:b0:74c:bc54:def6 with SMTP id t9-20020a6bdb09000000b0074cbc54def6mr3056443ioc.16.1679438859338;
        Tue, 21 Mar 2023 15:47:39 -0700 (PDT)
X-Google-Smtp-Source: AK7set9EbNNXSPjEUSnoMvgIPdEGf1CXd6ABSfzKBINcdwi6xMSz3jsAv4ymlWXyfvMVdfEnqs2RsA==
X-Received: by 2002:a6b:db09:0:b0:74c:bc54:def6 with SMTP id t9-20020a6bdb09000000b0074cbc54def6mr3056419ioc.16.1679438859071;
        Tue, 21 Mar 2023 15:47:39 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id y16-20020a027310000000b004061d6abcd1sm4452110jab.162.2023.03.21.15.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 15:47:38 -0700 (PDT)
Date:   Tue, 21 Mar 2023 16:47:37 -0600
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
Message-ID: <20230321164737.62b45132.alex.williamson@redhat.com>
In-Reply-To: <ZBottXxBlOsXmnmX@nvidia.com>
References: <BN9PR11MB5276F7879E428080D2B214D98CBC9@BN9PR11MB5276.namprd11.prod.outlook.com>
        <20230316182256.6659bbbd.alex.williamson@redhat.com>
        <BN9PR11MB5276D5A71E43EA4CDD1C960A8CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
        <20230317091557.196638a6.alex.williamson@redhat.com>
        <ZBiUiEC8Xj9sOphr@nvidia.com>
        <20230320165217.5b1019a4.alex.williamson@redhat.com>
        <ZBjum1wQ1L2AIfhB@nvidia.com>
        <20230321143122.632f7e63.alex.williamson@redhat.com>
        <ZBoYgNq60eDpV9Un@nvidia.com>
        <20230321150112.1c482380.alex.williamson@redhat.com>
        <ZBottXxBlOsXmnmX@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 21 Mar 2023 19:20:37 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Mar 21, 2023 at 03:01:12PM -0600, Alex Williamson wrote:
> 
> > > Though it would be nice if qemu didn't need two implementations so Yi
> > > I'd rather see a new info in this series as well and qemu can just
> > > consistently use dev_id and never bdf in iommufd mode.  
> > 
> > We also need to consider how libvirt determines if QEMU has the kernel
> > support it needs to pass file descriptors.  It'd be a lot cleaner if
> > this aligned with the introduction of vfio cdevs.  
> 
> Yes, that would be much better if it was one package.
> 
> But this is starting to grow and we have so many threads that need to
> progress blocked on this cdev enablement :(
> 
> Could we go forward with the cdev main patches and kconfig it to
> experimental or something while the rest of the parts are completed
> and tested through qemu? ie move the vfio-pci reset enablment to after
> the cdev patches?

We need to be able to guarantee that there cannot be any significant
builds of the kernel with vfio cdev support if our intention is to stage
it for libvirt.  We don't have a global EXPERIMENTAL config option any
more.  Adding new code under BROKEN seems wrong.  Fedora ships with
STAGING enabled.  A sternly worded Kconfig entry is toothless.  What is
the proposed mechanism to make this not look like a big uncompiled code
dump?  Thanks,

Alex

