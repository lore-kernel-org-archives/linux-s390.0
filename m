Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91E3C7619A
	for <linux-s390@archiver.kernel.org>; Wed,  5 Apr 2023 11:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237990AbjDELtJ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 5 Apr 2023 07:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237987AbjDELtD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 5 Apr 2023 07:49:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E1C30DF
        for <linux-s390@vger.kernel.org>; Wed,  5 Apr 2023 04:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680695296;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XUJMq3feSTxr1yNCi3lubHcB7k2hxhsRP2VpHbgXdR4=;
        b=Uo8Mz5vQJFgOPbHUx5or2s54W6y1gzbZ6AI2rexAMjA5ylR4BvRH3+9bOOdcD45L4bB/gk
        AomUtM4DvncSzq4qIFWoeU7iRD13bcLgE33LTflpFtrPC1StsvDVoHJjjo+6jQYEt9IemA
        p/41oRMFpOyf10xqLP2Wk7fjeboB+Ps=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-OUKFLApiMUqnWb7JeR9BRQ-1; Wed, 05 Apr 2023 07:48:15 -0400
X-MC-Unique: OUKFLApiMUqnWb7JeR9BRQ-1
Received: by mail-qt1-f200.google.com with SMTP id a19-20020a05622a02d300b003e4ecb5f613so18683316qtx.21
        for <linux-s390@vger.kernel.org>; Wed, 05 Apr 2023 04:48:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680695295;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XUJMq3feSTxr1yNCi3lubHcB7k2hxhsRP2VpHbgXdR4=;
        b=of0U9O9cfSQr2F5XneGaXQzNdt1aAmnU6qhrbSoUNkL7fNsrGWdQx8f/SEUWsejD7l
         mYdG2owtJrtbbcX2FeIrtiZJByAabFMY4uE7Szue6ULCZR8cimq213VgMsgMZzXLLfrB
         hk25tfdsmSrvO6taHaDz3dLsY+MVLhiD99ljHgJFdlbFZN0Y/gzIYe6cFG09+Q5VsNzN
         fnj8ENNtugCZyLk2G+feLFRKs2Cj54Cxj9pTubXjHzReDk/64iDFRqoP4KLCgrr89NLE
         tY70NMzuuijZntcs0A//qq0TKJ6r9wEIXx09yN5xnDnRnCBBPfreInlQwZxN0DsE/wB4
         ESeQ==
X-Gm-Message-State: AAQBX9cVrAa99QNVLlPF406VStClGez8dpk5anGU27//APGteosAdsPf
        qCj2XM4alS0N9In93DQcngT8wzh6sA40zxUXehlw/Xm7f4CT5Az//Srs+sYvrTF9wVQ+75p8dNT
        2GDJoJcRZ89nH0RRIcNAWXA==
X-Received: by 2002:a05:622a:24e:b0:3e4:6329:448e with SMTP id c14-20020a05622a024e00b003e46329448emr4707895qtx.16.1680695294884;
        Wed, 05 Apr 2023 04:48:14 -0700 (PDT)
X-Google-Smtp-Source: AKy350bTRAqI88LX9VbFNvjBJctHF4npfJOcif6/mBvLLVP/bBAY1tjUITSIzECLh8nneassa2qYIw==
X-Received: by 2002:a05:622a:24e:b0:3e4:6329:448e with SMTP id c14-20020a05622a024e00b003e46329448emr4707845qtx.16.1680695294510;
        Wed, 05 Apr 2023 04:48:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id f24-20020ac84658000000b003b9a73cd120sm3923853qto.17.2023.04.05.04.48.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 04:48:13 -0700 (PDT)
Message-ID: <42a1dd97-a95e-d5a6-ad6e-d87373111bd2@redhat.com>
Date:   Wed, 5 Apr 2023 13:48:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v3 10/12] vfio: Mark cdev usage in vfio_device
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
References: <20230401144429.88673-1-yi.l.liu@intel.com>
 <20230401144429.88673-11-yi.l.liu@intel.com>
From:   Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230401144429.88673-11-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 4/1/23 16:44, Yi Liu wrote:
> There are users that need to check if vfio_device is opened as cdev.
> e.g. vfio-pci. This adds a flag in vfio_device, it will be set in the
> cdev path when device is opened. This is not used at this moment, but
> a preparation for vfio device cdev support.

better to squash this patch with the patch setting cdev_opened then?

Thanks

Eric
>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  include/linux/vfio.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index f8fb9ab25188..d9a0770e5fc1 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h
> @@ -62,6 +62,7 @@ struct vfio_device {
>  	struct iommufd_device *iommufd_device;
>  	bool iommufd_attached;
>  #endif
> +	bool cdev_opened;
>  };
>  
>  /**
> @@ -151,6 +152,12 @@ vfio_iommufd_physical_devid(struct vfio_device *vdev, u32 *id)
>  	((int (*)(struct vfio_device *vdev, u32 *pt_id)) NULL)
>  #endif
>  
> +static inline bool vfio_device_cdev_opened(struct vfio_device *device)
> +{
> +	lockdep_assert_held(&device->dev_set->lock);
> +	return device->cdev_opened;
> +}
> +
>  /**
>   * @migration_set_state: Optional callback to change the migration state for
>   *         devices that support migration. It's mandatory for

