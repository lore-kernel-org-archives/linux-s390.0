Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15960C76196
	for <linux-s390@archiver.kernel.org>; Thu,  6 Apr 2023 14:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238356AbjDFOO1 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 6 Apr 2023 10:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237769AbjDFOO0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 6 Apr 2023 10:14:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3617DBF
        for <linux-s390@vger.kernel.org>; Thu,  6 Apr 2023 07:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680790420;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4ZqDQDqjyds8VPlocoEi3C0IrbNugg8tUJmM/qJ6sTM=;
        b=S5Kfq8NeSog+d2TVKLXTitAhYu5QW//Je7mJe03PTvtWEd4hoKbhyjQLCAuf27LrJCNTQO
        o3Mk9RG0w77voM8q2q5EUGzNaM0YNNw6Px7Msl2ccKXE4UaSHdmd3ojStn4kCObGv0bn07
        SsMh3qo+r1OLOoQbAbrKQn1wAF4FDMA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-vXt60PhANBii6Z8x3qCFZg-1; Thu, 06 Apr 2023 10:13:39 -0400
X-MC-Unique: vXt60PhANBii6Z8x3qCFZg-1
Received: by mail-qv1-f69.google.com with SMTP id l15-20020a0cd6cf000000b005df451a51ddso13759614qvi.9
        for <linux-s390@vger.kernel.org>; Thu, 06 Apr 2023 07:13:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680790419;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ZqDQDqjyds8VPlocoEi3C0IrbNugg8tUJmM/qJ6sTM=;
        b=69ni5/OQ/Lh8S6P39dFbSMhoagv74a6KUu4nUrV1td5KKmQv1cTbkzFpGVPyaQlgTE
         mYfJFrmrrEbkzoj6J7+cbE5j2ow+iLNeYs46RJk/RriLPOn/YOBMdg/spFHS+Jj0y0jT
         R8FSBlfMeBU5+b19PDvFXL8RsmrShikDj9kyOm7d83hu+tb3GwSsH6l1ZSlzhpczB20a
         jbTcqc2mjwUrapyQ4oYJtgg9ndNTLd2x6tCN3s8qjZjct5hlZkdlIlorZpwKokMwBgOu
         4pERTPWruvPwhb0Vl9b5xyIUtLmgelvBmxdqzom168wKqh2hsDyp5UVNd5w8nZiWj1Bu
         OLoQ==
X-Gm-Message-State: AAQBX9fCdemnC1ly9jTb2M5YunqkyymkRU7MzJYfPWbnOBG/mxWiIEVG
        m5kmJo1gHrUNc05UT2ldA3YvXcPDW8l0EO6erMXfJ7xQZldyIw0PkRCoZShSelm3vLBU79xOFGt
        hoVi8TgmKo0ASWQ7YUCThyg==
X-Received: by 2002:a05:6214:2aab:b0:5ce:7b40:89bd with SMTP id js11-20020a0562142aab00b005ce7b4089bdmr4087287qvb.18.1680790418948;
        Thu, 06 Apr 2023 07:13:38 -0700 (PDT)
X-Google-Smtp-Source: AKy350bO91aKaALXlf/32wwODUUkbjJFfCvulNU+0tH+77KwqRdD7uBXiKVvaUVXOK53XyO/yxSRcA==
X-Received: by 2002:a05:6214:2aab:b0:5ce:7b40:89bd with SMTP id js11-20020a0562142aab00b005ce7b4089bdmr4087239qvb.18.1680790418519;
        Thu, 06 Apr 2023 07:13:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id lv6-20020a056214578600b005dd8b9345cbsm534712qvb.99.2023.04.06.07.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 07:13:37 -0700 (PDT)
Message-ID: <0c51b289-4393-46d5-fb05-a4fc6de92e7b@redhat.com>
Date:   Thu, 6 Apr 2023 16:13:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v9 09/25] vfio: Add cdev_device_open_cnt to vfio_group
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
 <20230401151833.124749-10-yi.l.liu@intel.com>
From:   Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230401151833.124749-10-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Yi,

On 4/1/23 17:18, Yi Liu wrote:
> for counting the devices that are opened via the cdev path. This count
> is increased and decreased by the cdev path. The group path checks it
> to achieve exclusion with the cdev path. With this, only one path (group
> path or cdev path) will claim DMA ownership. This avoids scenarios in
> which devices within the same group may be opened via different paths.
>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Tested-by: Terrence Xu <terrence.xu@intel.com>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Tested-by: Yanting Jiang <yanting.jiang@intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  drivers/vfio/group.c | 33 +++++++++++++++++++++++++++++++++
>  drivers/vfio/vfio.h  |  3 +++
>  2 files changed, 36 insertions(+)
>
> diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
> index 71f0a9a4016e..d55ce3ca44b7 100644
> --- a/drivers/vfio/group.c
> +++ b/drivers/vfio/group.c
> @@ -383,6 +383,33 @@ static long vfio_group_fops_unl_ioctl(struct file *filep,
>  	}
>  }
>  
> +int vfio_device_block_group(struct vfio_device *device)
> +{
> +	struct vfio_group *group = device->group;
> +	int ret = 0;
> +
> +	mutex_lock(&group->group_lock);
> +	if (group->opened_file) {
> +		ret = -EBUSY;
> +		goto out_unlock;
> +	}
> +
> +	group->cdev_device_open_cnt++;
> +
> +out_unlock:
> +	mutex_unlock(&group->group_lock);
> +	return ret;
> +}
> +
> +void vfio_device_unblock_group(struct vfio_device *device)
> +{
> +	struct vfio_group *group = device->group;
> +
> +	mutex_lock(&group->group_lock);
> +	group->cdev_device_open_cnt--;
> +	mutex_unlock(&group->group_lock);
> +}
> +
>  static int vfio_group_fops_open(struct inode *inode, struct file *filep)
>  {
>  	struct vfio_group *group =
> @@ -405,6 +432,11 @@ static int vfio_group_fops_open(struct inode *inode, struct file *filep)
>  		goto out_unlock;
>  	}
>  
> +	if (group->cdev_device_open_cnt) {
> +		ret = -EBUSY;
> +		goto out_unlock;
> +	}
> +
>  	/*
>  	 * Do we need multiple instances of the group open?  Seems not.
>  	 */
> @@ -479,6 +511,7 @@ static void vfio_group_release(struct device *dev)
>  	mutex_destroy(&group->device_lock);
>  	mutex_destroy(&group->group_lock);
>  	WARN_ON(group->iommu_group);
> +	WARN_ON(group->cdev_device_open_cnt);
>  	ida_free(&vfio.group_ida, MINOR(group->dev.devt));
>  	kfree(group);
>  }
> diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> index 854f2c97cb9a..b2f20b78a707 100644
> --- a/drivers/vfio/vfio.h
> +++ b/drivers/vfio/vfio.h
> @@ -83,8 +83,11 @@ struct vfio_group {
>  	struct blocking_notifier_head	notifier;
>  	struct iommufd_ctx		*iommufd;
>  	spinlock_t			kvm_ref_lock;
> +	unsigned int			cdev_device_open_cnt;
>  };
>  
> +int vfio_device_block_group(struct vfio_device *device);
> +void vfio_device_unblock_group(struct vfio_device *device);
>  int vfio_device_set_group(struct vfio_device *device,
>  			  enum vfio_group_type type);
>  void vfio_device_remove_group(struct vfio_device *device);

