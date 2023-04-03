Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E1BC76196
	for <linux-s390@archiver.kernel.org>; Mon,  3 Apr 2023 15:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbjDCPCv (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 3 Apr 2023 11:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbjDCPCu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 3 Apr 2023 11:02:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DEEF76E
        for <linux-s390@vger.kernel.org>; Mon,  3 Apr 2023 08:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680534116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LDT5Lf+qM0AXT+Qr2m1vjFVPSH4VkpP6LN6DDAc5Ys4=;
        b=cPdhHpDtKZ4UPsPdXz/WVSWYZpTVeNx3t2sefMGfnpFc1kyD4HiZgwxZM2/Z4f2gPzE9w+
        WvMfU86ekfF0TsNUVsED+kFZfsVrFudfbyGPAZ8B+66euaUGzbgrsDf72EIJI2/+wLQb0B
        Eh54As+dbKFL+Chy03J0U1Gn7v/qqhY=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-aLTKqIcdMlCbaLhsGY_Esw-1; Mon, 03 Apr 2023 11:01:55 -0400
X-MC-Unique: aLTKqIcdMlCbaLhsGY_Esw-1
Received: by mail-il1-f199.google.com with SMTP id d11-20020a056e020c0b00b00326156e3a8bso13753694ile.3
        for <linux-s390@vger.kernel.org>; Mon, 03 Apr 2023 08:01:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680534114;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LDT5Lf+qM0AXT+Qr2m1vjFVPSH4VkpP6LN6DDAc5Ys4=;
        b=sFZzepqHyhvEQytkzxlG9mTiUSb6iRMuxKnGM/o7ECWORzyQdRSenkLaCoZCVDNSPn
         EXTqgKKfyMTC27bOUJCwJgCoyjSClMFaqfmeSsNX+Xja1R+gQMLZzpa/m2020uodccKh
         n4UJY6E0NPDynOo2x76g3+1qIIwPL/H67ReRg3GJq16GkCZLt29Rh4kWDOUemegdv5UO
         1HFahk1MrbZZlKs3fUPOHO+ih1q4GIohKhbMGrKig3AGqb3YFdIv8GoR0xQPRoNukd3p
         G/toTTg2jgPgNblMARCqBQX2ZWu0q95sb/yGxhY9cfSNdFTvN+WoBI+Vga+tyTxIzC06
         EHuQ==
X-Gm-Message-State: AO0yUKWrsK7KDr5TZUwYS5fs55Wl1wfZTzNkAnvk2A0bsxTXGcxUnBYb
        exNF8i+JPRODizAfZANWK9mi+2cLowb5Y4G9+0LMKIRIiQccEeHZ6NBBj9GQ93SsBLagWN/6/o6
        V4Phlbf/buUBPkYxjeqQAbQ==
X-Received: by 2002:a5d:8142:0:b0:74c:e456:629d with SMTP id f2-20020a5d8142000000b0074ce456629dmr25003483ioo.7.1680534114161;
        Mon, 03 Apr 2023 08:01:54 -0700 (PDT)
X-Google-Smtp-Source: AK7set+kaGi07I/wH0q13cJZHTVv8M0jb8SFu1aYqy0WHHoYlpxzwPnYGZcVa2Sxzy5OzWM2Y+hdQQ==
X-Received: by 2002:a5d:8142:0:b0:74c:e456:629d with SMTP id f2-20020a5d8142000000b0074ce456629dmr25003444ioo.7.1680534113860;
        Mon, 03 Apr 2023 08:01:53 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id q49-20020a056638347100b00408b3bc8061sm2735465jav.43.2023.04.03.08.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 08:01:53 -0700 (PDT)
Date:   Mon, 3 Apr 2023 09:01:51 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>
Cc:     "jgg@nvidia.com" <jgg@nvidia.com>,
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
        "Jiang, Yanting" <yanting.jiang@intel.com>
Subject: Re: [PATCH v3 12/12] vfio/pci: Report dev_id in
 VFIO_DEVICE_GET_PCI_HOT_RESET_INFO
Message-ID: <20230403090151.4cb2158c.alex.williamson@redhat.com>
In-Reply-To: <DS0PR11MB752996A6E6B3263BAD01DAC2C3929@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230401144429.88673-1-yi.l.liu@intel.com>
        <20230401144429.88673-13-yi.l.liu@intel.com>
        <DS0PR11MB752996A6E6B3263BAD01DAC2C3929@DS0PR11MB7529.namprd11.prod.outlook.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 3 Apr 2023 09:25:06 +0000
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> > From: Liu, Yi L <yi.l.liu@intel.com>
> > Sent: Saturday, April 1, 2023 10:44 PM  
> 
> > @@ -791,7 +813,21 @@ static int vfio_pci_fill_devs(struct pci_dev *pdev, void *data)
> >  	if (!iommu_group)
> >  		return -EPERM; /* Cannot reset non-isolated devices */  
> 
> Hi Alex,
> 
> Is disabling iommu a sane way to test vfio noiommu mode?

Yes

> I added intel_iommu=off to disable intel iommu and bind a device to vfio-pci.
> I can see the /dev/vfio/noiommu-0 and /dev/vfio/devices/noiommu-vfio0. Bind
> iommufd==-1 can succeed, but failed to get hot reset info due to the above
> group check. Reason is that this happens to have some affected devices, and
> these devices have no valid iommu_group (because they are not bound to vfio-pci
> hence nobody allocates noiommu group for them). So when hot reset info loops
> such devices, it failed with -EPERM. Is this expected?

Hmm, I didn't recall that we put in such a limitation, but given the
minimally intrusive approach to no-iommu and the fact that we never
defined an invalid group ID to return to the user, it makes sense that
we just blocked the ioctl for no-iommu use.  I guess we can do the same
for no-iommu cdev.

BTW, what does this series apply on?  I'm assuming[1], but I don't see
a branch from Jason yet.  Thanks,

Alex

[1]https://lore.kernel.org/all/20230327093351.44505-1-yi.l.liu@intel.com/

