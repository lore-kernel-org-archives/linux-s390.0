Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84479C761AF
	for <linux-s390@archiver.kernel.org>; Tue,  4 Apr 2023 14:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235539AbjDDOCB (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 4 Apr 2023 10:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235759AbjDDOBp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 4 Apr 2023 10:01:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5B05BB3
        for <linux-s390@vger.kernel.org>; Tue,  4 Apr 2023 07:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680616783;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CiA47gAN7qT+ZNDZD32w5M0yj6bHGU0l8msuusUTdoo=;
        b=PIzXbAegx7NKJKIBbKTxlUVhl+vi67eAKvpg/F6amSdverJs1ittWMY82RaL9nlckN26MW
        Rh8zWLq750gH5igtI9CvPeFrn8KRcjph9aTaLdbnWRtTJ1SWIsce1NvWe9Xbk+SaLoIuy/
        2q9kdjc4x9xbVrxECAyXdEYLQLYzuLs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-zl0RFV6QP9SfYTFHua3RWQ-1; Tue, 04 Apr 2023 09:59:41 -0400
X-MC-Unique: zl0RFV6QP9SfYTFHua3RWQ-1
Received: by mail-qv1-f70.google.com with SMTP id p14-20020a0cc3ce000000b005e14204a86bso6564488qvi.10
        for <linux-s390@vger.kernel.org>; Tue, 04 Apr 2023 06:59:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680616780;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CiA47gAN7qT+ZNDZD32w5M0yj6bHGU0l8msuusUTdoo=;
        b=VSiphL5nEJC13WsLVRgsLxa2z+RGQ46LFqh9qd2lG0NmFC6XwzBsVZS/7XN84zQ4A0
         I8wg/hVELkJQwalmVOldUrQ81jSMOkuAfJu6Ttoj7APUR8TyGXKirNd2Z0L1DLEuC7v/
         W97ceR25PShtHK5zN6aWIk5GRaoVVizpGenhZ6jeVj//MDZ74ZghvPdmAgNUX965nwL8
         46hAphK0xnvquU6g2VNmhRwaoqDAUU4/eHVkN79YHaSPCzmrd7r4WfcXhkml/lDpqChg
         yG4TM86PKQqF3gXuhOJpdQahjfbwhT3pcIQs6d5v4DuLSmfKKf/+9ufSnWKhIwAswJHU
         rhig==
X-Gm-Message-State: AAQBX9e1sLcD/7iRFG1XnJgErForBLO4OnOx2fh+II8B9gWTWPDIyjph
        atJ1vq4bor+sCxMA/FdvpaRvflRmieuSh/8luta4RxrZy352Lvs3fxJ7O1YXfTxEsQyDVdxw9Rj
        1gjCm0XWUkUlnYqXNXH+0yw==
X-Received: by 2002:a05:622a:d4:b0:3e6:518e:20d2 with SMTP id p20-20020a05622a00d400b003e6518e20d2mr3799512qtw.38.1680616780147;
        Tue, 04 Apr 2023 06:59:40 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZZL+oXCfUUoM6pdP+baT0sl47qwZv5PYyBbT4M9DCOsE5FKMGPzd9k7TGNiSfdXRQRCW7Zbg==
X-Received: by 2002:a05:622a:d4:b0:3e6:518e:20d2 with SMTP id p20-20020a05622a00d400b003e6518e20d2mr3799466qtw.38.1680616779762;
        Tue, 04 Apr 2023 06:59:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id t7-20020a37aa07000000b0074a0a47a1f3sm3647912qke.5.2023.04.04.06.59.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 06:59:38 -0700 (PDT)
Message-ID: <844faa5c-2968-2a4f-8a70-900f359be1a0@redhat.com>
Date:   Tue, 4 Apr 2023 15:59:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v3 02/12] vfio/pci: Only check ownership of opened devices
 in hot reset
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
 <20230401144429.88673-3-yi.l.liu@intel.com>
From:   Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230401144429.88673-3-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi YI,

On 4/1/23 16:44, Yi Liu wrote:
> If the affected device is not opened by any user, it's safe to reset it
> given it's not in use.
>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Tested-by: Yanting Jiang <yanting.jiang@intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 14 +++++++++++---
>  include/uapi/linux/vfio.h        |  8 ++++++++
>  2 files changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 65bbef562268..5d745c9abf05 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -2429,10 +2429,18 @@ static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
>  
>  	list_for_each_entry(cur_vma, &dev_set->device_list, vdev.dev_set_list) {
>  		/*
> -		 * Test whether all the affected devices are contained by the
> -		 * set of groups provided by the user.
> +		 * Test whether all the affected devices can be reset by the
> +		 * user.
> +		 *
> +		 * Resetting an unused device (not opened) is safe, because
> +		 * dev_set->lock is held in hot reset path so this device
> +		 * cannot race being opened by another user simultaneously.
> +		 *
> +		 * Otherwise all opened devices in the dev_set must be
> +		 * contained by the set of groups provided by the user.
>  		 */
> -		if (!vfio_dev_in_groups(cur_vma, groups)) {
> +		if (cur_vma->vdev.open_count &&
> +		    !vfio_dev_in_groups(cur_vma, groups)) {
>  			ret = -EINVAL;
>  			goto err_undo;
>  		}
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 0552e8dcf0cb..f96e5689cffc 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -673,6 +673,14 @@ struct vfio_pci_hot_reset_info {
>   * VFIO_DEVICE_PCI_HOT_RESET - _IOW(VFIO_TYPE, VFIO_BASE + 13,
>   *				    struct vfio_pci_hot_reset)
>   *
> + * Userspace requests hot reset for the devices it uses.  Due to the
> + * underlying topology, multiple devices can be affected in the reset
by the reset
> + * while some might be opened by another user.  To avoid interference
s/interference/hot reset failure?
> + * the calling user must ensure all affected devices, if opened, are
> + * owned by itself.
> + *
> + * The ownership is proved by an array of group fds.
> + *
>   * Return: 0 on success, -errno on failure.
>   */
>  struct vfio_pci_hot_reset {
Thanks

Eric

