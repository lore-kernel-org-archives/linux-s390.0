Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3B0C7EE23
	for <linux-s390@archiver.kernel.org>; Wed, 17 May 2023 18:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjEQSlX (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 17 May 2023 14:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjEQSlV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 17 May 2023 14:41:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EB7524E
        for <linux-s390@vger.kernel.org>; Wed, 17 May 2023 11:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684348836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G48bN8NGBWygIugoTzRlRFImF/dJtXKz4qEWAAyIYjw=;
        b=Yogg+UTLW2NG67uVUGScGt/8/93KhSm7tkuRhSUDBDItxdMTj3K1E5rdfM4LT6n7vUM8Lh
        h18hCdWH1rjm/riLIUktScxvk8GgCLLim7GDzEgVCx6v8Ej8zrI/gw6ZLEoO58yd9mkyII
        rraLM8AuMTK9ZH2a/Q6NrUHDutbvBqo=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-w5JPcZSLOhuG6f9UEoXG_A-1; Wed, 17 May 2023 14:40:35 -0400
X-MC-Unique: w5JPcZSLOhuG6f9UEoXG_A-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-335526b351eso16671665ab.2
        for <linux-s390@vger.kernel.org>; Wed, 17 May 2023 11:40:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684348834; x=1686940834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G48bN8NGBWygIugoTzRlRFImF/dJtXKz4qEWAAyIYjw=;
        b=YVtXs8AcO9zXifoqPmsX7o1+BOTeZjE1UqAkxPJGfxIQiEvE7RWfMc3AgI+J/5drIi
         WDZvy5OAHI2QfFGWMZ35pzbp1iTUKTCUPCnPkhlqdZN91FRkddhJN/ucdFyZRsmuxRRT
         aYAaUPHrOXXIbhYxEdrXulgC3I6C+H6DNWruUHxAuX56BRh/KuIyEi6UOBUqUXLjLLvQ
         d1k2O4eoEGancFrLbATMLBdqbkF3dZP9lQKrnJ+NCw6FndmTkTnrTJq3I6N/V6jzeIUY
         gDb8+PE47rYj7HV9b7OKIz1hcOfMYTsaZRn9Qg1nHGvrHuQU+cCm+47U7B7Fr5dILqS/
         p4jg==
X-Gm-Message-State: AC+VfDyIDZxesWtuZunD9/QARjJhFkvb0BRNowzyGe4R05fzM+NF6+O5
        Q4fSVjV/76KbwGzQBujeEK59I0L3j0ny5qZQoxbzNMzkuyULIK7Sy5jFy1tVqOf738MG83k9aaj
        71QE03X+BdY6YI4MrkCBa9w==
X-Received: by 2002:a92:d142:0:b0:335:c544:a1a2 with SMTP id t2-20020a92d142000000b00335c544a1a2mr3012043ilg.0.1684348834640;
        Wed, 17 May 2023 11:40:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4J9s6ZhInpKVnoJzYNMp1MQQnmbMgUJVkyPpcx6aNR0Viq1l1HNls0cAZuhx154qPo2ZXLvg==
X-Received: by 2002:a92:d142:0:b0:335:c544:a1a2 with SMTP id t2-20020a92d142000000b00335c544a1a2mr3012011ilg.0.1684348834418;
        Wed, 17 May 2023 11:40:34 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id q7-20020a92c007000000b0032b54912651sm8328134ild.5.2023.05.17.11.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 11:40:33 -0700 (PDT)
Date:   Wed, 17 May 2023 12:40:32 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Yi Liu <yi.l.liu@intel.com>, kevin.tian@intel.com, joro@8bytes.org,
        robin.murphy@arm.com, cohuck@redhat.com, eric.auger@redhat.com,
        nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-s390@vger.kernel.org,
        xudong.hao@intel.com, yan.y.zhao@intel.com, terrence.xu@intel.com,
        yanting.jiang@intel.com, zhenzhong.duan@intel.com,
        clegoate@redhat.com
Subject: Re: [PATCH v5 06/10] vfio-iommufd: Add helper to retrieve
 iommufd_ctx and devid for vfio_device
Message-ID: <20230517124032.4bac8e0e.alex.williamson@redhat.com>
In-Reply-To: <ZGUbY6yVfbd3hRxY@nvidia.com>
References: <20230513132136.15021-1-yi.l.liu@intel.com>
        <20230513132136.15021-7-yi.l.liu@intel.com>
        <20230517121517.4b7ceb52.alex.williamson@redhat.com>
        <ZGUbY6yVfbd3hRxY@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 17 May 2023 15:22:27 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, May 17, 2023 at 12:15:17PM -0600, Alex Williamson wrote:
> 
> > > +int vfio_iommufd_physical_devid(struct vfio_device *vdev)
> > > +{
> > > +	if (vdev->iommufd_device)
> > > +		return iommufd_device_to_id(vdev->iommufd_device);
> > > +	if (vdev->noiommu_access)
> > > +		return iommufd_access_to_id(vdev->noiommu_access);
> > > +	return -EINVAL;
> > > +}
> > > +EXPORT_SYMBOL_GPL(vfio_iommufd_physical_devid);  
> > 
> > I think these exemplify that it would be better if both emulated and
> > noiommu use the same iommufd_access pointer.  Thanks,  
> 
> Oh, I mis understood your other remark.. Yeah good question I have to
> study this also

I guess I also missed that this wasn't iommufd_access vs
noiommu_access, it's device vs access, but shouldn't any iommufd_access
pointer provide the devid?  I need to go look why we need two different
methods to get a devid...  Thanks,

Alex

