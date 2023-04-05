Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FBBC7619A
	for <linux-s390@archiver.kernel.org>; Wed,  5 Apr 2023 12:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237704AbjDEMVN (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 5 Apr 2023 08:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjDEMVM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 5 Apr 2023 08:21:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C2F40D3
        for <linux-s390@vger.kernel.org>; Wed,  5 Apr 2023 05:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680697226;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=erf4UNO3fNS9mv22A+JjIcgyW6S0YpQ5DUbNcYGvtZ0=;
        b=d4yA661qnRn2LGS7FAqq7W6eZB6ZsKg11JAitg/jr+pWs1d9mO2SQ1BMDNXnvPSF+64R/P
        8gK1XSvxFhJ0PPQD1wXzn7X+0CfqtcHAnJhdiMSqHU6oMf/BqFCwxV4uyWDKlAYwYVNEf2
        sHKZgyv/qI7HpUjbc7X2etqkAGnGVSs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-4DJcRtIBMOCghguY6J686A-1; Wed, 05 Apr 2023 08:20:14 -0400
X-MC-Unique: 4DJcRtIBMOCghguY6J686A-1
Received: by mail-qt1-f198.google.com with SMTP id a11-20020ac85b8b000000b003e3979be6abso24044892qta.12
        for <linux-s390@vger.kernel.org>; Wed, 05 Apr 2023 05:20:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680697213;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=erf4UNO3fNS9mv22A+JjIcgyW6S0YpQ5DUbNcYGvtZ0=;
        b=61JUKaKXnKc3yXw5IMwMXYvXaK0lvVvGzNCHbt1cTq+0E5HhYicHW6/XWy8nwfMD/b
         KfGFDN59VDIBkay8UhOEeDtUHgYqGYJyEr/LETG6nXAri5kz6fu4qzxq1FqssSpOUfCw
         zYLTASmzvOYX3B1ncPxOgxCZwexWXWwxrvs2MjvhGdUkyAK5GUs9DetfsHTs2PU37jj9
         c8eqPIZwlOkAAh7yxJsB3wFCenwqJhYMRG02StcomxnQA1iHNoPAk/nyRquzE71S5jP6
         qYIQfysCJgTa/ucmFWbUSE1QnM84otf1v5n1eUw4Awce1nJpFydDLToTUqSj5LA8GmzV
         qWvQ==
X-Gm-Message-State: AAQBX9d18vOmJ7vN7e21+HNqv6GdmGzJMtsdSvGVFuXuVwy+ekgpLTfI
        UM9Gm8oQu0lXx2J7ONZKD4KDXPQRN+eWS44lVVzm88yW6JEdxf1cWpcjHITdbAxXISUhcMxPgrl
        tZj1pMsQKIXy16EF6FASJxA==
X-Received: by 2002:a05:6214:e6e:b0:56e:f9a2:1aff with SMTP id jz14-20020a0562140e6e00b0056ef9a21affmr7785861qvb.35.1680697213737;
        Wed, 05 Apr 2023 05:20:13 -0700 (PDT)
X-Google-Smtp-Source: AKy350YufqLIW4kTurRmpoStx2boSEtRlVeqT/uSnU6kdOvvAZfwzmAklgvT9NeSB7a7bO7FCPIIzA==
X-Received: by 2002:a05:6214:e6e:b0:56e:f9a2:1aff with SMTP id jz14-20020a0562140e6e00b0056ef9a21affmr7785819qvb.35.1680697213472;
        Wed, 05 Apr 2023 05:20:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id l8-20020a0cc208000000b005dd8b9345a2sm4164191qvh.58.2023.04.05.05.20.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 05:20:12 -0700 (PDT)
Message-ID: <f90410e0-96f1-9719-9d83-f7caa5992d6d@redhat.com>
Date:   Wed, 5 Apr 2023 14:20:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v9 03/25] vfio: Remove vfio_file_is_group()
Content-Language: en-US
To:     Yi Liu <yi.l.liu@intel.com>, alex.williamson@redhat.com,
        jgg@nvidia.com, kevin.tian@intel.com
Cc:     joro@8bytes.org, robin.murphy@arm.com, cohuck@redhat.com,
        nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-s390@vger.kernel.org,
        xudong.hao@intel.com, yan.y.zhao@intel.com, terrence.xu@intel.com,
        yanting.jiang@intel.com
References: <20230401151833.124749-1-yi.l.liu@intel.com>
 <20230401151833.124749-4-yi.l.liu@intel.com>
From:   Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230401151833.124749-4-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Yi,

On 4/1/23 17:18, Yi Liu wrote:
> since no user of vfio_file_is_group() now.
>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Tested-by: Terrence Xu <terrence.xu@intel.com>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Tested-by: Yanting Jiang <yanting.jiang@intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  drivers/vfio/group.c | 10 ----------
>  include/linux/vfio.h |  1 -
>  2 files changed, 11 deletions(-)
>
> diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
> index ede4723c5f72..4f937ebaf6f7 100644
> --- a/drivers/vfio/group.c
> +++ b/drivers/vfio/group.c
> @@ -792,16 +792,6 @@ struct iommu_group *vfio_file_iommu_group(struct file *file)
>  }
>  EXPORT_SYMBOL_GPL(vfio_file_iommu_group);
>  
> -/**
> - * vfio_file_is_group - True if the file is a vfio group file
> - * @file: VFIO group file
> - */
> -bool vfio_file_is_group(struct file *file)
> -{
> -	return vfio_group_from_file(file);
> -}
> -EXPORT_SYMBOL_GPL(vfio_file_is_group);
> -
>  bool vfio_group_enforced_coherent(struct vfio_group *group)
>  {
>  	struct vfio_device *device;
> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index d9a0770e5fc1..7519ae89fcd6 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h
> @@ -264,7 +264,6 @@ int vfio_mig_get_next_state(struct vfio_device *device,
>   * External user API
>   */
>  struct iommu_group *vfio_file_iommu_group(struct file *file);
> -bool vfio_file_is_group(struct file *file);
>  bool vfio_file_is_valid(struct file *file);
>  bool vfio_file_enforced_coherent(struct file *file);
>  void vfio_file_set_kvm(struct file *file, struct kvm *kvm);

