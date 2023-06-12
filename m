Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D45C7EE2E
	for <linux-s390@archiver.kernel.org>; Mon, 12 Jun 2023 22:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbjFLWie (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 12 Jun 2023 18:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbjFLWie (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 12 Jun 2023 18:38:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1F219C
        for <linux-s390@vger.kernel.org>; Mon, 12 Jun 2023 15:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686609468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OlsJhktWOpnOGrwPLFGfPFUUuk70SiPk0xbup/yE/10=;
        b=Oa8moIuWV14Z2U84au3INqetjkSlFkfGH2MazcLyAMraEJn1LFzc6KT/wAwfkQZQDJvCq5
        ND5vcewOkvfi855lHxpnQbTBZtHQ8v5mxpVC+NTXiZ8nu53uT6J6AwoTmO4MyOUxIrLu+a
        vfVhzK913Q3k1YMur+ylrWNqAHp4whk=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-mO3LEYV-OJ2sVeuDQNdpPw-1; Mon, 12 Jun 2023 18:37:45 -0400
X-MC-Unique: mO3LEYV-OJ2sVeuDQNdpPw-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-769036b47a7so560237739f.0
        for <linux-s390@vger.kernel.org>; Mon, 12 Jun 2023 15:37:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686609464; x=1689201464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OlsJhktWOpnOGrwPLFGfPFUUuk70SiPk0xbup/yE/10=;
        b=M/O24Ni4eer+xwx+VIAiMkvcbThP/C/egO9hh/GDnyyhVPMGu4o7+5daftJbHLt4hi
         gtWWFiKJlnPFn0UbBhFglNm8N/vCBL7/E7xM8+z4g9Nz+zZyBAnp+Thv3Xl59GwhvHJa
         a3X6I9ZSXeXwCC5lIOHe9giqLYqKJJmw5e1XXxv9IpJ3TBJjocOgn6RX8OBBDyYxr92x
         RzFsMkToenCgytu4Qo0jPtZ/8Ker3nBxgn1WuFDPOsYmJAU8OWFL6B0Ylzf1b4WeT6Ex
         xO9r3kyGLVEvIgQQ3xclHD5qgpLZzIEm1gKJd1pmsNXFpXcvS/x191M4K0ZEggAFiKcu
         irlg==
X-Gm-Message-State: AC+VfDwNlVudtbP9xmdCkHahecE5YGFrQ8lMkicIaVKzp5W1T1D8WgDF
        Lg+Dr1h2aeIBBqHaVNf5hukmZyALO/m3uNCb/kJ9WDGpIPD6Jk61e/U3Tv9W8BKGktvaQFSh1Db
        QZEsvqr2TOoJe4H/e3EVcrw==
X-Received: by 2002:a5d:9ad3:0:b0:769:bdaa:a4d9 with SMTP id x19-20020a5d9ad3000000b00769bdaaa4d9mr8400456ion.12.1686609464335;
        Mon, 12 Jun 2023 15:37:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Q/YdMzaOFvhmUbJ9Qg8ZlVUIaIY3sDJYl5DoaZ6J+wwRakiDgr+MX4WPTG6XR/j4s9Jvayw==
X-Received: by 2002:a5d:9ad3:0:b0:769:bdaa:a4d9 with SMTP id x19-20020a5d9ad3000000b00769bdaaa4d9mr8400441ion.12.1686609464083;
        Mon, 12 Jun 2023 15:37:44 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id ep27-20020a0566384e1b00b0041855b3a685sm2990490jab.150.2023.06.12.15.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 15:37:43 -0700 (PDT)
Date:   Mon, 12 Jun 2023 16:37:42 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Yi Liu <yi.l.liu@intel.com>
Cc:     jgg@nvidia.com, kevin.tian@intel.com, joro@8bytes.org,
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
Subject: Re: [PATCH v12 20/24] vfio: Only check group->type for noiommu test
Message-ID: <20230612163742.215eabde.alex.williamson@redhat.com>
In-Reply-To: <20230602121653.80017-21-yi.l.liu@intel.com>
References: <20230602121653.80017-1-yi.l.liu@intel.com>
        <20230602121653.80017-21-yi.l.liu@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri,  2 Jun 2023 05:16:49 -0700
Yi Liu <yi.l.liu@intel.com> wrote:

> group->type can be VFIO_NO_IOMMU only when vfio_noiommu option is true.
> And vfio_noiommu option can only be true if CONFIG_VFIO_NOIOMMU is enabled.
> So checking group->type is enough when testing noiommu.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/vfio/group.c | 3 +--
>  drivers/vfio/vfio.h  | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
> index 41a09a2df690..653b62f93474 100644
> --- a/drivers/vfio/group.c
> +++ b/drivers/vfio/group.c
> @@ -133,8 +133,7 @@ static int vfio_group_ioctl_set_container(struct vfio_group *group,
>  
>  	iommufd = iommufd_ctx_from_file(f.file);
>  	if (!IS_ERR(iommufd)) {
> -		if (IS_ENABLED(CONFIG_VFIO_NOIOMMU) &&
> -		    group->type == VFIO_NO_IOMMU)
> +		if (group->type == VFIO_NO_IOMMU)
>  			ret = iommufd_vfio_compat_set_no_iommu(iommufd);
>  		else
>  			ret = iommufd_vfio_compat_ioas_create(iommufd);
> diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> index 5835c74e97ce..1b89e8bc8571 100644
> --- a/drivers/vfio/vfio.h
> +++ b/drivers/vfio/vfio.h
> @@ -108,8 +108,7 @@ void vfio_group_cleanup(void);
>  
>  static inline bool vfio_device_is_noiommu(struct vfio_device *vdev)
>  {
> -	return IS_ENABLED(CONFIG_VFIO_NOIOMMU) &&
> -	       vdev->group->type == VFIO_NO_IOMMU;
> +	return vdev->group->type == VFIO_NO_IOMMU;
>  }
>  
>  #if IS_ENABLED(CONFIG_VFIO_CONTAINER)

This patch should be dropped.  It's logically correct, but ignores that
the config option can be determined at compile time and therefore the
code can be better optimized based on that test.  I think there was a
specific case where I questioned it, but this drops an otherwise valid
compiler optimization.  Thanks,

Alex

