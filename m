Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA08C433EF
	for <linux-s390@archiver.kernel.org>; Mon,  6 Jun 2022 23:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235332AbiFFXq3 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 6 Jun 2022 19:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbiFFXq2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Jun 2022 19:46:28 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3073BC039C
        for <linux-s390@vger.kernel.org>; Mon,  6 Jun 2022 16:46:28 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id br33so10366138qkb.0
        for <linux-s390@vger.kernel.org>; Mon, 06 Jun 2022 16:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BobLl+SlFstwFdCAgot2j19OhmEJmjKMcmrAyX++IpQ=;
        b=nTfkLS746hnRkFmQz8zZo7fxRpg63kXstyT8r7gW9PDX8jfk8n9wPYN+FQ0XgmC9fz
         nii/p1w15omesttBp8810sHQEh+P+NwdH+lOHKg2lWA3f2I8rz+/LiPoLfY9Uf3zExmn
         lZvIKLet/yrIs+LRJwbHr5A1+ceMHQeE50rVoUBTkrXSrBNNMbtbnb9Nvh3bdrFCuqce
         GrOxC1ZVY9FnqjAoPe7//ERX/vTKxps9R4em/RHDci4XEK17vekdDuvS/NZ2BAnQli9z
         Q3lznZLbcnaaLSm+/994C56wGWaJJmwTkCqSGQ7EQ/olGImF4gaBV85YzOVtWO4suYRA
         k0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BobLl+SlFstwFdCAgot2j19OhmEJmjKMcmrAyX++IpQ=;
        b=10O7pSCEqTHau5mZXKFvNwDAUfVEcBkQmiYdbcqn0QRN8QpJIMrVIeXDa6vxCV68Iu
         D7KrzXNhTyxOKOAZ92ij1pVkEmkjc6yq7iwo+SesX7ldvt1Zi/Q4vk1qsIekNmHzhpSA
         uA+dNzumIMQBC9qzOiyeK1gsTsJpCUpoEB7cTGWWjjnT5X6gaoFtkrdBWEPsre5GIpJM
         7qDEm9d8O+3IZZQ3fiWXx0wlx5HQ+xUvBHVbUisR0nhCOvRyhXwWM83KtU2yU8aqJLm8
         9SjyOoqzZ/iSQ5IqqajnGpZKEYs2cO2hFPPUL2uPYeWaH54+rX/UBO5BPF8fKkokyZQR
         r6jg==
X-Gm-Message-State: AOAM530Gj20LmegRxr9jGmsA/cy3mUSeha+q1fuXEhQUjmtE9Qsg5cyy
        MEztWW8SqdJQFLQA0oC7G+7DpQ==
X-Google-Smtp-Source: ABdhPJxdw6L/xOuwADspsqstoD5nz7gt8vQH/za9tZhkeo/mqgj+nrGe6IzJ+9V9rqmxQ7fk9+5a4w==
X-Received: by 2002:ae9:eb88:0:b0:6a6:b3e3:4c44 with SMTP id b130-20020ae9eb88000000b006a6b3e34c44mr6995123qkg.83.1654559187889;
        Mon, 06 Jun 2022 16:46:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id g16-20020ac85810000000b002f906fc8530sm2525617qtg.46.2022.06.06.16.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 16:46:27 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nyMQU-002q3M-Lz; Mon, 06 Jun 2022 20:46:26 -0300
Date:   Mon, 6 Jun 2022 20:46:26 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Kirti Wankhede <kwankhede@nvidia.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        intel-gvt-dev@lists.freedesktop.org
Subject: Re: [PATCH 7/8] vfio/mdev: remove mdev_parent_dev
Message-ID: <20220606234626.GH3932382@ziepe.ca>
References: <20220603063328.3715-1-hch@lst.de>
 <20220603063328.3715-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603063328.3715-8-hch@lst.de>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Jun 03, 2022 at 08:33:27AM +0200, Christoph Hellwig wrote:
> Just open code the dereferences in the only user.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  Documentation/driver-api/vfio-mediated-device.rst | 3 ---
>  drivers/gpu/drm/i915/gvt/kvmgt.c                  | 2 +-
>  drivers/vfio/mdev/mdev_core.c                     | 6 ------
>  include/linux/mdev.h                              | 1 -
>  4 files changed, 1 insertion(+), 11 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
