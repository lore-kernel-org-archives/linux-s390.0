Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C66C54EE9
	for <linux-s390@archiver.kernel.org>; Tue, 20 Sep 2022 19:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbiITTRd (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 20 Sep 2022 15:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiITTRb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 20 Sep 2022 15:17:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFFC61D68
        for <linux-s390@vger.kernel.org>; Tue, 20 Sep 2022 12:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663701450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=48Tp1la85hsdqkGfG0YxmrPZH84TL2fOAb8LsP1PYSg=;
        b=IaeMw3J8SCXVxvvcRiEidd5N4PdnoGYODSopHiJRbcMT/vtqLniDRhVlEFZQZm/pkQ69yB
        A5IJWzYPwqehHL1PnO8xp+zRDPTb2RuC9UkOxFZeEl2GyHNvv55A9R//XlHMq+MbZMcfLy
        qvyTw2toxSjtpFF7ztgFqlCYFVhxSak=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-654-5JAR6YMcPKGHgYXV7tiZEg-1; Tue, 20 Sep 2022 15:17:27 -0400
X-MC-Unique: 5JAR6YMcPKGHgYXV7tiZEg-1
Received: by mail-il1-f199.google.com with SMTP id i13-20020a056e02152d00b002f58aea654fso2207228ilu.20
        for <linux-s390@vger.kernel.org>; Tue, 20 Sep 2022 12:17:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=48Tp1la85hsdqkGfG0YxmrPZH84TL2fOAb8LsP1PYSg=;
        b=Z0ydtw4fOv7ZQ3w6ZtjY96t+XH8CZBv2mTSAE98OsvC3+Q6+Li8Dcn65wT446ujrz/
         faFQQprwZ/NNIA9FipzNoduBeD2FywNsMvFn1NgF1znrZSFSc8AB2YrdgGmEnm8MkEFi
         iboih5w2IflVOIAxU3vA0DS5Ro/uhB+TDVP3rVOZmsMDp2O+mz9x1J6I58bSE2qnG1UX
         tJeACZqCqpMRH+Trk8rajlDYBY+J+or8XVK7T6js81nF+Rcfy2gE9tyyRYU8KQN+TiEu
         FzdzGoI2+PFRtCG9OH2+6gyUBg1dWQHeaTZY3rGLdpVcNL3JvGRHAdqLu+nqMgh9H5vE
         NQ5A==
X-Gm-Message-State: ACrzQf1r489wBG5bnzRs+Q+uNp9oFMtYppMcq3RJoElpB1GvfLBtuzzm
        +OzhSPkO/vSAOkV88QVX4Z0db57Q6tXTNWZILZCfr/AoLiUS/FwzKBy3R+oFmuGCX+cw7eU+5pg
        AJ6IaM/AsAR6me4/rQehDEg==
X-Received: by 2002:a6b:670e:0:b0:6a0:cffe:5c44 with SMTP id b14-20020a6b670e000000b006a0cffe5c44mr9830955ioc.74.1663701447141;
        Tue, 20 Sep 2022 12:17:27 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5Jz+PJQhyf25QQiv7P7Dcvr+B3WKZW0Zx0uCADBWPkyugzHyErwfotGdnRZ3kL/bsX2pQ9HA==
X-Received: by 2002:a6b:670e:0:b0:6a0:cffe:5c44 with SMTP id b14-20020a6b670e000000b006a0cffe5c44mr9830947ioc.74.1663701446917;
        Tue, 20 Sep 2022 12:17:26 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id b27-20020a026f5b000000b00349d4ee2a4asm215964jae.91.2022.09.20.12.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 12:17:26 -0700 (PDT)
Date:   Tue, 20 Sep 2022 13:17:23 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Kevin Tian <kevin.tian@intel.com>
Cc:     Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Longfang Liu <liulongfang@huawei.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@nvidia.com>,
        Eric Auger <eric.auger@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Abhishek Sahu <abhsahu@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v3 06/15] vfio/mtty: Use the new device life cycle
 helpers
Message-ID: <20220920131723.2541b7e8.alex.williamson@redhat.com>
In-Reply-To: <20220909102247.67324-7-kevin.tian@intel.com>
References: <20220909102247.67324-1-kevin.tian@intel.com>
        <20220909102247.67324-7-kevin.tian@intel.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri,  9 Sep 2022 18:22:38 +0800
Kevin Tian <kevin.tian@intel.com> wrote:

> From: Yi Liu <yi.l.liu@intel.com>
> 
> and manage available ports inside @init/@release.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  samples/vfio-mdev/mtty.c | 67 +++++++++++++++++++++++-----------------
>  1 file changed, 39 insertions(+), 28 deletions(-)
> 
> diff --git a/samples/vfio-mdev/mtty.c b/samples/vfio-mdev/mtty.c
> index f42a59ed2e3f..41301d50b247 100644
> --- a/samples/vfio-mdev/mtty.c
> +++ b/samples/vfio-mdev/mtty.c
...
> +static int mtty_probe(struct mdev_device *mdev)
> +{
> +	struct mdev_state *mdev_state;
> +	int ret;
> +
> +	mdev_state = vfio_alloc_device(mdev_state, vdev, &mdev->dev,
> +				       &mtty_dev_ops);
> +	if (IS_ERR(mdev_state))
> +		return PTR_ERR(mdev_state);
>  
>  	ret = vfio_register_emulated_iommu_dev(&mdev_state->vdev);
>  	if (ret)
> -		goto err_vconfig;
> +		goto err_put_vdev;
>  	dev_set_drvdata(&mdev->dev, mdev_state);
>  	return 0;
>  
> -err_vconfig:
> -	kfree(mdev_state->vconfig);
> -err_state:
> -	vfio_uninit_group_dev(&mdev_state->vdev);
> -	kfree(mdev_state);
> -err_nr_ports:
> -	atomic_add(nr_ports, &mdev_avail_ports);
> +err_put_vdev:
> +	vfio_put_device(&mdev_state->vdev);
>  	return ret;
>  }
>  
> +static void mtty_release_dev(struct vfio_device *vdev)
> +{
> +	struct mdev_state *mdev_state =
> +		container_of(vdev, struct mdev_state, vdev);
> +
> +	kfree(mdev_state->vconfig);
> +	vfio_free_device(vdev);
> +	atomic_add(mdev_state->nr_ports, &mdev_avail_ports);

I must be missing something, isn't this a use-after-free?

mdev_state is allocated via vfio_alloc_device(), where vdev is the
first entry in that structure, so this is equivalent to
kvfree(mdev_state).  mbochs has the same issue.  mdpy and vfio-ap
adjust global counters after vfio_free_device(), which I think muddies
the situation.  Shouldn't we look suspiciously at any .release callback
where vfio_free_device() isn't the last thing executed?  Thanks,

Alex

