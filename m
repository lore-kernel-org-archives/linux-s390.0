Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B1AC6FD1D
	for <linux-s390@archiver.kernel.org>; Tue,  4 Apr 2023 14:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbjDDOHY (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 4 Apr 2023 10:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjDDOHX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 4 Apr 2023 10:07:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36D755B2
        for <linux-s390@vger.kernel.org>; Tue,  4 Apr 2023 07:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680617170;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ykhmPw67VbhDtXPSpfVmWbPSuu2IMuu2dxGXXWfzz7E=;
        b=RnoHLL4klP/tiVEk23JUOrJQZINHL+lC0w+SEygWdK7zceJSmR+HsFBxUIB/lOpyja4ify
        1aCcYCMZbBtoB+ijVZQI+1p85Ll6UzcYu8mecX9gFpHSbhiWWOODWTS83HNmr9xfyoKavP
        mf3RkWsrKuLqGsYO1RCYtKubKTW21xs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-iQcAmChzPDu3BKLvf2OJcQ-1; Tue, 04 Apr 2023 10:00:03 -0400
X-MC-Unique: iQcAmChzPDu3BKLvf2OJcQ-1
Received: by mail-qv1-f71.google.com with SMTP id p14-20020a0cc3ce000000b005e14204a86bso6565016qvi.10
        for <linux-s390@vger.kernel.org>; Tue, 04 Apr 2023 07:00:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680616802;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ykhmPw67VbhDtXPSpfVmWbPSuu2IMuu2dxGXXWfzz7E=;
        b=JdUVgIEk9PoTcWWJgn8vEACBh+FBT1Yuhzbin23BDKcQuolM7DuTvBg5iR6lWf9lob
         KS71vD4i4scfsC+Loy3evFNbU1jPFq+wViZJzP2Q1a+ZtRqTVgaFXc/0OTw+laZWP6q6
         Ox4SJxdWBT31htO3yLvxHNBTeomuRExThmZHEt8EPtCb4JiHnm9Bziv6L9Xdcfh4QLa1
         RRoEtgAUMew2vrSf6AqwX4Ffwx5C81Gv+hHAMGkR22G6nCmQ/rEmzuynm5eWanutgu1F
         TH1SdZ80k+pfgsbWEhx0/s/I93CEmMx6idMU2V0MsKuPwpfFWLbDXfjDyGzE09Rkm8Z7
         tInQ==
X-Gm-Message-State: AAQBX9fPvgmikKmHiNKDoZy0jBHdo+wKXM+0c/w2VJmn/+n/6F0mjBxn
        VuuUT0+VYUEddF50iZm2Z5tAu3RIrYWXaLpdndh00HOAWGYYSrEM6PtxDHiN3sv6sqbdbEuep8Y
        feb6u71MHrFjE/0PsipAXWA==
X-Received: by 2002:ad4:5b87:0:b0:5e2:1381:6105 with SMTP id 7-20020ad45b87000000b005e213816105mr3459187qvp.18.1680616802057;
        Tue, 04 Apr 2023 07:00:02 -0700 (PDT)
X-Google-Smtp-Source: AKy350bJCynXCOrEKhxb44G8d+k4Dr+19c9yImUsR/GZAakKp2zi913dOKWU2dCtLWnBy7YVL0UkpQ==
X-Received: by 2002:ad4:5b87:0:b0:5e2:1381:6105 with SMTP id 7-20020ad45b87000000b005e213816105mr3459060qvp.18.1680616801354;
        Tue, 04 Apr 2023 07:00:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id jy1-20020a0562142b4100b005dd8b9345ebsm3412112qvb.131.2023.04.04.06.59.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 07:00:00 -0700 (PDT)
Message-ID: <1f8ddafd-6fad-aff6-5dc7-9d67f89eea73@redhat.com>
Date:   Tue, 4 Apr 2023 15:59:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v3 01/12] vfio/pci: Update comment around group_fd get in
 vfio_pci_ioctl_pci_hot_reset()
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
 <20230401144429.88673-2-yi.l.liu@intel.com>
From:   Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230401144429.88673-2-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Yi,

On 4/1/23 16:44, Yi Liu wrote:
> this suits more on what the code does.
>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Tested-by: Yanting Jiang <yanting.jiang@intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index a5ab416cf476..65bbef562268 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1308,9 +1308,8 @@ static int vfio_pci_ioctl_pci_hot_reset(struct vfio_pci_core_device *vdev,
>  	}
>  
>  	/*
> -	 * For each group_fd, get the group through the vfio external user
> -	 * interface and store the group and iommu ID.  This ensures the group
> -	 * is held across the reset.
> +	 * Get the group file for each fd to ensure the group held across
to ensure the group is held

Besides

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric


> +	 * the reset
>  	 */
>  	for (file_idx = 0; file_idx < hdr.count; file_idx++) {
>  		struct file *file = fget(group_fds[file_idx]);

