Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A87C636CC
	for <linux-s390@archiver.kernel.org>; Wed, 15 Feb 2023 17:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjBORZA (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 15 Feb 2023 12:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjBORYt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 15 Feb 2023 12:24:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4E13865B
        for <linux-s390@vger.kernel.org>; Wed, 15 Feb 2023 09:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676481841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f8VA1c6iZtz7FGtZvF7i96siVIEbaGum/570KUL8JYQ=;
        b=e3dJdPxx8e3HvFhOzBxBxiG2ZB0nq27PJocz6RNEvvNcPbBHz0cD79LhHGDhAv40xyXSVk
        8cKPwrPUoqTIYZbJhsKQNGZX5l93UihyEG8Lk+uqmnun1n70cZ1PP3UXUmQkz6J8KVv/s0
        7fPxcxMt9ok/k766uMyQw1ljkrjo/EQ=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-629-dfTUeMjvOdKoUBFKI6bpRw-1; Wed, 15 Feb 2023 12:19:39 -0500
X-MC-Unique: dfTUeMjvOdKoUBFKI6bpRw-1
Received: by mail-io1-f70.google.com with SMTP id f14-20020a5d858e000000b00743613be020so225745ioj.4
        for <linux-s390@vger.kernel.org>; Wed, 15 Feb 2023 09:19:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f8VA1c6iZtz7FGtZvF7i96siVIEbaGum/570KUL8JYQ=;
        b=qDQBDmmNJ4Ml1KD5Jo7g38OZ2gGOkhrTFsEwrW+oia88dZG55glKgSABsJ6W95iHwV
         HQSrga8VTf9469DN1vK/wGy2gWVjHowLDRlkLNa3737QPr/90p9xUiyI15o6Aijm5mg6
         HqdbhxnsYhAl2SCGT4Sfm4OgoRmnqIEBnDDIRFcyKAf6rgzfLOlatJuL2e0aXi0IEk5B
         /hYNxRUbxvgfOx/jNtNU9t51oFof+UnBiHp2jLMZQUGpxh0UyXrI8MkkZ6N076xU/3pk
         7Bp9zDztHGJh3bDluOMHt6tFSGtn9ko/f1Wb2gkrOIQkvWF9oEHu/2NkJVsV0Kaew/sz
         ioaw==
X-Gm-Message-State: AO0yUKUi5qpUL5pUqp5j/YVSQGLkZJwPGZbF2MJgkz/9dTvysiZVnhOE
        kRspYXWab9/tqSKgKyiJpyH6DHzpSlae9g3Z++HzzkqDhElRc+shtLWKqartgt0xqyogjv+7Ydc
        Mt/76I01xmDHrSwY/7s5Q4A==
X-Received: by 2002:a92:c264:0:b0:314:5aa:94ba with SMTP id h4-20020a92c264000000b0031405aa94bamr3025116ild.9.1676481578281;
        Wed, 15 Feb 2023 09:19:38 -0800 (PST)
X-Google-Smtp-Source: AK7set8JFQMg3wd2K4N1A/L6AEEoJSZuErtZEgPbOjbAIunGxdN2sZ5/fVleX+GPj5DIkwZFSCFuTg==
X-Received: by 2002:a92:c264:0:b0:314:5aa:94ba with SMTP id h4-20020a92c264000000b0031405aa94bamr3025097ild.9.1676481577996;
        Wed, 15 Feb 2023 09:19:37 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id q6-20020a02c8c6000000b00374fa5b600csm5932699jao.0.2023.02.15.09.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 09:19:37 -0800 (PST)
Date:   Wed, 15 Feb 2023 10:19:35 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
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
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 03/15] vfio: Accept vfio device file in the driver
 facing kAPI
Message-ID: <20230215101935.6416b39c.alex.williamson@redhat.com>
In-Reply-To: <Y+0QjaIWr84eVzsp@nvidia.com>
References: <20230213151348.56451-1-yi.l.liu@intel.com>
        <20230213151348.56451-4-yi.l.liu@intel.com>
        <Y+rLKvCMivND0izd@nvidia.com>
        <DS0PR11MB7529B43C7D357D8A0C2438C7C3A29@DS0PR11MB7529.namprd11.prod.outlook.com>
        <Y+zSRklKkL3rc2FB@nvidia.com>
        <DS0PR11MB75299F5D92AAC33FD8690694C3A39@DS0PR11MB7529.namprd11.prod.outlook.com>
        <Y+zwSn63eA7HrefO@nvidia.com>
        <20230215083234.194d07a9.alex.williamson@redhat.com>
        <Y+0QjaIWr84eVzsp@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 15 Feb 2023 13:04:13 -0400
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Feb 15, 2023 at 08:32:34AM -0700, Alex Williamson wrote:
> 
> > We've discussed this with Paolo before and I believe the bar of proof
> > is not very high.  I suspect it's not a problem that the device itself
> > is not yet accessible, so long as the user can prove they have the
> > ability to access the device, such as access to a restricted file.  In
> > most cases this isn't going to turn on wbinvd anyway since DMA will be
> > coherent.  Thanks,  
> 
> Isn't that a second problem, we don't know if the device is coherent
> until it is bound?

I think this is already accounted for in the conversion to device level
IOMMU ops, ie. device_iommu_capable() follows the
dev->iommu->iommu_dev->ops, where for example intel_iommu_capable() is
only looking at the capabilities of the IOMMU managing the device.  We
did some hand waving simplifications that was sufficient at some point,
IIRC.  Thanks,

Alex

