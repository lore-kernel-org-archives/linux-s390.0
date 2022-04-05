Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1297C433EF
	for <linux-s390@archiver.kernel.org>; Tue,  5 Apr 2022 22:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbiDEWd4 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 5 Apr 2022 18:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573496AbiDETMt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 Apr 2022 15:12:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8C7DE885A
        for <linux-s390@vger.kernel.org>; Tue,  5 Apr 2022 12:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649185848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ufYYfNJ31ZxJiptHxZVI0cJDY245GxkfqBFvOLAxMek=;
        b=Z9xUuWIFR1s5Ev4w2nyOD2v0z3fHci6g13TOV980JOAop8ZJh1B/KGPbUnOLPzwiod2D5n
        zR9KVBTDx3Z1Fn096cuMlF3ritv9wL0sh6HY7KAWGny3m03LjZYEBUy5itgGqEsLKTFi79
        JEkrQ5Axjt92XOV3XQSYNJdJKHT4Qkg=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-492-vESckv_5M1CyrRh24ZfuJw-1; Tue, 05 Apr 2022 15:10:47 -0400
X-MC-Unique: vESckv_5M1CyrRh24ZfuJw-1
Received: by mail-io1-f71.google.com with SMTP id w28-20020a05660205dc00b00645d3cdb0f7so131230iox.10
        for <linux-s390@vger.kernel.org>; Tue, 05 Apr 2022 12:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=ufYYfNJ31ZxJiptHxZVI0cJDY245GxkfqBFvOLAxMek=;
        b=HJtDYbCUYf1IUDh+ho2ERHKYoNaPdV4Y2kPfvxthrJM+MED0jtY8BGPXHsXUmX7TxN
         DB0MntywVX8sp46RHdyYC2OJxY2D7EOdQOIl31kvcE+778hoitftHRkMX9uv7OmncCRj
         1Q7/xFIj9kyQqmjwU0i0JimWdX8kfiLo77E7iGaLNmqbnkCz7TjsSQBwj0rpNhL8N/sm
         PstCZg9bAhoo6kin6XdHEHpjZx48KUCfPNCK/sd7gq10ORbN7azXddXYJIpZBAf8pN85
         nmleRoTqdTkhWHkVqFNWUSncsg6K3w3BQT+18Asl9bSOyqjyvItQRne1zzNYzlBEHGEO
         jAbQ==
X-Gm-Message-State: AOAM530f22rj+eiZGERQHMItug2mM3Lkbx6hVkhQhu5PtuyCRvV1S6A3
        8JMfXH99lNYqC51BITwevJE92Mch5XDb7IaGJ2RKJxfdIKskChFO79/PdBRSCq33cEhlt+l5+NU
        B1Ur6dg5jEAu/ygPPiX65gw==
X-Received: by 2002:a92:cdad:0:b0:2c6:7b76:a086 with SMTP id g13-20020a92cdad000000b002c67b76a086mr2568135ild.5.1649185846542;
        Tue, 05 Apr 2022 12:10:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxocs2ZVaXF5YVJwjGBcLRqnK5UBIr3mQlWSQgNmkFdgGBC2rjlpWZLrLl9AI2wrgBUaUJw1w==
X-Received: by 2002:a92:cdad:0:b0:2c6:7b76:a086 with SMTP id g13-20020a92cdad000000b002c67b76a086mr2568112ild.5.1649185846282;
        Tue, 05 Apr 2022 12:10:46 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id x2-20020a056602160200b006463c1977f9sm9314961iow.22.2022.04.05.12.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 12:10:45 -0700 (PDT)
Date:   Tue, 5 Apr 2022 13:10:44 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Christian Benvenuti <benve@cisco.com>,
        Cornelia Huck <cohuck@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        iommu@lists.linux-foundation.org, Jason Wang <jasowang@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nelson Escobar <neescoba@cisco.com>, netdev@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        virtualization@lists.linux-foundation.org,
        Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
        "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH 2/5] vfio: Require that devices support DMA cache
 coherence
Message-ID: <20220405131044.23910b77.alex.williamson@redhat.com>
In-Reply-To: <2-v1-ef02c60ddb76+12ca2-intel_no_snoop_jgg@nvidia.com>
References: <0-v1-ef02c60ddb76+12ca2-intel_no_snoop_jgg@nvidia.com>
        <2-v1-ef02c60ddb76+12ca2-intel_no_snoop_jgg@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue,  5 Apr 2022 13:16:01 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> dev_is_dma_coherent() is the control to determine if IOMMU_CACHE can be
> supported.
> 
> IOMMU_CACHE means that normal DMAs do not require any additional coherency
> mechanism and is the basic uAPI that VFIO exposes to userspace. For
> instance VFIO applications like DPDK will not work if additional coherency
> operations are required.
> 
> Therefore check dev_is_dma_coherent() before allowing a device to join a
> domain. This will block device/platform/iommu combinations from using VFIO
> that do not support cache coherent DMA.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/vfio/vfio.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> index a4555014bd1e72..2a3aa3e742d943 100644
> --- a/drivers/vfio/vfio.c
> +++ b/drivers/vfio/vfio.c
> @@ -32,6 +32,7 @@
>  #include <linux/vfio.h>
>  #include <linux/wait.h>
>  #include <linux/sched/signal.h>
> +#include <linux/dma-map-ops.h>
>  #include "vfio.h"
>  
>  #define DRIVER_VERSION	"0.3"
> @@ -1348,6 +1349,11 @@ static int vfio_group_get_device_fd(struct vfio_group *group, char *buf)
>  	if (IS_ERR(device))
>  		return PTR_ERR(device);
>  
> +	if (group->type == VFIO_IOMMU && !dev_is_dma_coherent(device->dev)) {
> +		ret = -ENODEV;
> +		goto err_device_put;
> +	}
> +

Failing at the point where the user is trying to gain access to the
device seems a little late in the process and opaque, wouldn't we
rather have vfio bus drivers fail to probe such devices?  I'd expect
this to occur in the vfio_register_group_dev() path.  Thanks,

Alex

>  	if (!try_module_get(device->dev->driver->owner)) {
>  		ret = -ENODEV;
>  		goto err_device_put;

