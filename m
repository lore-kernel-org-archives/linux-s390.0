Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EBFC433F5
	for <linux-s390@archiver.kernel.org>; Thu,  7 Apr 2022 22:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbiDGWkR (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 7 Apr 2022 18:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbiDGWjs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 7 Apr 2022 18:39:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 37F5C137036
        for <linux-s390@vger.kernel.org>; Thu,  7 Apr 2022 15:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649371063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NOIZSnS98gQ3xydj16FHLPEIjDJjA+ZwlFfjRBiVUDY=;
        b=Vk4Z+reM9UdPsG+8dZ1C3F/AjQTFreZkPTuV6839sN4FXsLPsA9fW2h/IMln7jazNvZ4AM
        lgCWKwkPQX3WoxaTV71WS29cLgCYbnQ/W43o2Adhy7v7Qow+tcKvTBfrhh+OEonmBVKKe/
        SCj/WtKJk/MVseHX/M2ZWmf16lrJPDc=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-344-MGQH0ucwOniH0i64mW5CiQ-1; Thu, 07 Apr 2022 18:37:42 -0400
X-MC-Unique: MGQH0ucwOniH0i64mW5CiQ-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-e26cee694fso1435749fac.7
        for <linux-s390@vger.kernel.org>; Thu, 07 Apr 2022 15:37:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=NOIZSnS98gQ3xydj16FHLPEIjDJjA+ZwlFfjRBiVUDY=;
        b=amvf9pUV3yRJuRdKfuCb7S6xfvgjFwW/pLiXtix3e7BKIeRY1Ai3ecJ1hSvYI29Oz5
         nTCNc7DQI0xadutYP1RRzhyZhrAxshzMdFtkayqqI53zuK0zJMurPBuRj/pa1moFO66m
         t5G7Ka43LPKeUFpsMucS5G8mLpzZMy1oqWR57JQxAjMaw1oX0lu9kPrLjokkvmtAyCDL
         Vi0dX5w/SZXWWefnEHtTTUaL1CzjZKPnLYqr3QSpcPwtvyvmFXwfoYyyVLrWspjgWGdB
         +t2J4rbxndfPZA9SWteM22EzEAilu+4TGs0sWQs26crJ54eywfwXNSfSvL8nwq6UxlxZ
         08vw==
X-Gm-Message-State: AOAM530IOa+ykrxvnpfnUgp1ZoUX+Mb7aXCcKA4bUugqGmWn6XA5vrcY
        stgmEi+qgf62v+Szr/bz5C7/jBudsYCPo8w62JNBq8a7xeJiY0rXJwXBRnU1jFibSn5yRXq5ima
        trLeHAW8NXmrHj/YpaIda5g==
X-Received: by 2002:a9d:ee7:0:b0:5cd:feb9:66b5 with SMTP id 94-20020a9d0ee7000000b005cdfeb966b5mr5515094otj.216.1649371061198;
        Thu, 07 Apr 2022 15:37:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxcVZwyerJlnB50z195byTw9JBG/9w1iOCvt6QyoKpKsIz/rFvJndsMgHRlm6GD1Fo6Sk8OMg==
X-Received: by 2002:a9d:ee7:0:b0:5cd:feb9:66b5 with SMTP id 94-20020a9d0ee7000000b005cdfeb966b5mr5515064otj.216.1649371060962;
        Thu, 07 Apr 2022 15:37:40 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id c8-20020a4ad788000000b0031ce69b1640sm7642523oou.10.2022.04.07.15.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 15:37:40 -0700 (PDT)
Date:   Thu, 7 Apr 2022 16:37:37 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Christian Benvenuti <benve@cisco.com>,
        Cornelia Huck <cohuck@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Jason Wang <jasowang@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nelson Escobar <neescoba@cisco.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/5] iommu: Replace uses of IOMMU_CAP_CACHE_COHERENCY
 with dev_is_dma_coherent()
Message-ID: <20220407163737.2a7ccd7a.alex.williamson@redhat.com>
In-Reply-To: <20220407152331.GN2120790@nvidia.com>
References: <db5a6daa-bfe9-744f-7fc5-d5167858bc3e@arm.com>
        <20220406142432.GF2120790@nvidia.com>
        <20220406151823.GG2120790@nvidia.com>
        <20220406155056.GA30433@lst.de>
        <20220406160623.GI2120790@nvidia.com>
        <20220406161031.GA31790@lst.de>
        <20220406171729.GJ2120790@nvidia.com>
        <BN9PR11MB5276F9CEA2B01B3E75094B6D8CE69@BN9PR11MB5276.namprd11.prod.outlook.com>
        <20220407135946.GM2120790@nvidia.com>
        <fb55a025-348e-800c-e368-48be075d8e9c@arm.com>
        <20220407152331.GN2120790@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 7 Apr 2022 12:23:31 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Thu, Apr 07, 2022 at 04:17:11PM +0100, Robin Murphy wrote:
> 
> > For the specific case of overriding PCIe No Snoop (which is more problematic
> > from an Arm SMMU PoV) when assigning to a VM, would that not be easier
> > solved by just having vfio-pci clear the "Enable No Snoop" control bit in
> > the endpoint's PCIe capability?  
> 
> Ideally.
> 
> That was rediscussed recently, apparently there are non-compliant
> devices and drivers that just ignore the bit. 
> 
> Presumably this is why x86 had to move to an IOMMU enforced feature..

I considered this option when implementing the current solution, but
ultimately I didn't have confidence in being able to prevent drivers
from using device specific means to effect the change anyway.  GPUs
especially have various back channels to config space.  Thanks,

Alex

