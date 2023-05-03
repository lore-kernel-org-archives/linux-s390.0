Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7589C77B78
	for <linux-s390@archiver.kernel.org>; Wed,  3 May 2023 22:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjECWuM (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 3 May 2023 18:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjECWuL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 3 May 2023 18:50:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF63468C
        for <linux-s390@vger.kernel.org>; Wed,  3 May 2023 15:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683154163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pZKMay62CKj/rRkV21aMrRSKMlokKOiJJhw6mGzAbD4=;
        b=hvDFiQUCEqzES4Q03V8rYtRFkv/ROJs+dj7h1rrHX5RxRG6cIJ05ZDjDKqn22JEKGIL1gh
        ZYjiabcyTWwUh5P+Vd0DHVlCbwHEDew5Uhq9EeWdOBQ+sJbeT1Egfc5RHbwlyCPj2LMI0b
        oFxyLes+MS++3aeu4Q583iLBAZXP4SQ=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-6h3KzJ1XOBeiGBX7yNjgzQ-1; Wed, 03 May 2023 18:49:21 -0400
X-MC-Unique: 6h3KzJ1XOBeiGBX7yNjgzQ-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-32b42b751bcso36907605ab.3
        for <linux-s390@vger.kernel.org>; Wed, 03 May 2023 15:49:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683154161; x=1685746161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZKMay62CKj/rRkV21aMrRSKMlokKOiJJhw6mGzAbD4=;
        b=di2FO+HTLIRxkxBlFSc4uDA6jMgT7l2aUIw6ojDlqEuunTHVkEdo7ovRt0jCsQGkXm
         Kbjm88F9uAqlKXXRVZAZgf20aTCljo3Bx+wXQvXrE7XGdJbjiTr6C/ehwjRPTHIRfk67
         ekEDBnpqNeV7Fk4iNMJ75Kt4O8Rcb2lhaZxuFdtpcKjCuqyNh0uQdNwgzEIb7TLsmGXz
         8fGDorAaI+/+ELPCWvkO8H+U84l/YsYJ43brRwZs/lW75LPv74OqAS4Xt+sWGg+FvgGe
         2X4znCkxshkvBE9GbSaVZ+LA/tG5KwDHdLEgy7qrSIn8Hiw8swyfDOCAY/0LMa07MMG4
         HWjQ==
X-Gm-Message-State: AC+VfDycp1Iy6Wlpo6reHayMUwAc18OukN9M4cbAsyz6uzl2Xmj9rDMp
        js8ikNq9Hzk0pd1YQAh372YForgc71N6R+9yRM2Ec6d0c9P2qVMXVW+liRR+eejE319Er7FB7I4
        DjNNRuJuzE/ad/6wzu0pSPg==
X-Received: by 2002:a92:c84d:0:b0:318:ab40:4e9b with SMTP id b13-20020a92c84d000000b00318ab404e9bmr15017945ilq.2.1683154161176;
        Wed, 03 May 2023 15:49:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ntpPSWb/poW4t0J5+ldQYO37YiiaPp9DXn+9xjK5dBx+7eAyDqpM0q/3zcX+WxbzjTaBu6Q==
X-Received: by 2002:a92:c84d:0:b0:318:ab40:4e9b with SMTP id b13-20020a92c84d000000b00318ab404e9bmr15017917ilq.2.1683154160924;
        Wed, 03 May 2023 15:49:20 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id g8-20020a056e020d0800b0032c9da1d89csm9093182ilj.78.2023.05.03.15.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 15:49:20 -0700 (PDT)
Date:   Wed, 3 May 2023 16:49:16 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
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
        "Xu, Terrence" <terrence.xu@intel.com>,
        "Jiang, Yanting" <yanting.jiang@intel.com>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v4 2/9] vfio-iommufd: Create iommufd_access for noiommu
 devices
Message-ID: <20230503164916.652d7779.alex.williamson@redhat.com>
In-Reply-To: <ZFK5AJxhMBGKqWaH@nvidia.com>
References: <20230426145419.450922-1-yi.l.liu@intel.com>
        <20230426145419.450922-3-yi.l.liu@intel.com>
        <BN9PR11MB52768AF474FAB2AF36AC00508C6A9@BN9PR11MB5276.namprd11.prod.outlook.com>
        <DS0PR11MB752972AC1A6030CB442ACF3FC36A9@DS0PR11MB7529.namprd11.prod.outlook.com>
        <20230427123203.22307c4f.alex.williamson@redhat.com>
        <c203f11f-4d9f-cf43-03ab-e41a858bdd92@intel.com>
        <ZFFUyhqID+LtUB/D@nvidia.com>
        <DS0PR11MB7529B4E4513B1A56A90F111DC36C9@DS0PR11MB7529.namprd11.prod.outlook.com>
        <ZFK5AJxhMBGKqWaH@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 3 May 2023 16:41:52 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> > > My general idea to complete the no-iommu feature is to add a new IOCTL
> > > to VFIO that is 'pin iova and return dma addr' that no-iommu userspace
> > > would call instead of trying to abuse mlock and /proc/ to do it. That
> > > ioctl would use the IOAS attached to the access just like a mdev would
> > > do, so it has a real IOVA, but it is not a mdev.  
> > 
> > This new ioctl may be IOMMUFD ioctl since its input is the IOAS and
> > addr, nothing related to the device. Is it?  
> 
> No, definately a VFIO special ioctl for VFIO no-iommu mode.

This seems like brushing off the dirty work to vfio.  Userspace drivers
relying on no-iommu are in pretty questionable territory already, do we
care if they don't have a good means to pin pages and derive the DMA
address of those pinned pages?  As I noted earlier, I'm really not
interested in expanding no-iommu, it's less important now than when it
was added (we have vIOMMUs in VMs now and more platforms with IOMMUs)
and we shouldn't be encouraging its use by further developing the
interface.  Thanks,

Alex

