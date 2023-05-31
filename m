Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522E6C7EE23
	for <linux-s390@archiver.kernel.org>; Wed, 31 May 2023 13:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbjEaNJR (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 31 May 2023 09:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236333AbjEaNJH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 31 May 2023 09:09:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73165186
        for <linux-s390@vger.kernel.org>; Wed, 31 May 2023 06:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685538447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XR1Y7uTlBlZpPpTqhSt6hoa8GuKCXSWN+tjCf5DVvbw=;
        b=U2h07tnOx3HpOkg4cefMeKx6sibOUzTRBwfGYMH8ukOvaZp7NOhC/ePdORYapC/O7girDn
        cdR3F5n7X8dMrXkfk0Tjnxh2fVA0v6roz2U29dXf76SA5Jj6+vgEWA4aoEHIBPZGLyWI2i
        134yFkk9lniN8Di0MqfahSxmEnnyvYw=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-JFHPd8ZjOQW4oWzDEgAYpQ-1; Wed, 31 May 2023 09:01:23 -0400
X-MC-Unique: JFHPd8ZjOQW4oWzDEgAYpQ-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2af2f4e71a2so30119981fa.1
        for <linux-s390@vger.kernel.org>; Wed, 31 May 2023 06:01:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685538074; x=1688130074;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XR1Y7uTlBlZpPpTqhSt6hoa8GuKCXSWN+tjCf5DVvbw=;
        b=T1B1xUxEx2eGqFD+eJVzpSzz3BBdhKcyFm04JbpsfH772IQ3335JwkR90FY35oYLzw
         z2edg200BmxLPU8U9/bBs75rMsySlisFXTWWId+sIWGaTARUdDXbe2kOtvPyKzn06XOZ
         /U2u4CSre1f667hFTzcO908SyZAZzi2BqrSIBL+sT/eOcIRF0fX8BrpvJYorE7gOLGIi
         cjRDjd5XuMtA3tgsx7JmLcql5wWX6Nj2Db/M4GkHI4E34E/KuSAsVO9HZmdtRJT+WEH8
         s2CAo7N+lTvLV28YpT6KU9XXFSe3+/PG3SRz+A7JfO+iZ6t1MwqQdfSxmJX1F2+BJikW
         bJ7Q==
X-Gm-Message-State: AC+VfDw1Fq+0cHMgdeR7mEt31ajWzdftyaWgZnB0SchjnWYe1k9BV7XV
        UnvtIgXrA82swryk96l6066aCUnArCUtaOxbZcTK3dTeHpS1dB/rAaNYj/NSg6Eq8laRmIY4LND
        5sVcw2WquBxsj/+Ty+cykog==
X-Received: by 2002:ac2:4d16:0:b0:4e7:dd1e:e521 with SMTP id r22-20020ac24d16000000b004e7dd1ee521mr2699474lfi.9.1685538074048;
        Wed, 31 May 2023 06:01:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6YCZxJTTNZh6g/t1HiIjoxj6FPMPoopmQRHMqaYgGBEE8GvCQf77HNrvRfeg62Qi4NfxTyQQ==
X-Received: by 2002:ac2:4d16:0:b0:4e7:dd1e:e521 with SMTP id r22-20020ac24d16000000b004e7dd1ee521mr2699467lfi.9.1685538073855;
        Wed, 31 May 2023 06:01:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:eb4a:c9d8:c8bb:c0b0? ([2a01:e0a:280:24f0:eb4a:c9d8:c8bb:c0b0])
        by smtp.gmail.com with ESMTPSA id o19-20020a05600c059300b003f60119ee08sm24268206wmd.43.2023.05.31.06.01.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 06:01:13 -0700 (PDT)
Message-ID: <e7ec6a4c-2eeb-3a08-5add-a06e250162b6@redhat.com>
Date:   Wed, 31 May 2023 15:01:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/3] s390/vfio-ap: Wire in the vfio_device_ops request
 callback
Content-Language: en-US
To:     Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     jjherne@linux.ibm.com, pasic@linux.ibm.com, farman@linux.ibm.com,
        mjrosato@linux.ibm.com, alex.williamson@redhat.com,
        borntraeger@linux.ibm.com
References: <20230530223538.279198-1-akrowiak@linux.ibm.com>
 <20230530223538.279198-4-akrowiak@linux.ibm.com>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <20230530223538.279198-4-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 5/31/23 00:35, Tony Krowiak wrote:
> The mdev device is being removed, so pass the request to userspace to
> ask for a graceful cleanup. This should free up the thread that
> would otherwise loop waiting for the device to be fully released.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   drivers/s390/crypto/vfio_ap_ops.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 44f159136891..a8f58e133e6e 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -1736,6 +1736,26 @@ static void vfio_ap_mdev_close_device(struct vfio_device *vdev)
>   	vfio_ap_mdev_unset_kvm(matrix_mdev);
>   }
>   
> +static void vfio_ap_mdev_request(struct vfio_device *vdev, unsigned int count)
> +{
> +	struct device *dev = vdev->dev;
> +	struct ap_matrix_mdev *matrix_mdev;
> +
> +	matrix_mdev = container_of(vdev, struct ap_matrix_mdev, vdev);
> +
> +	if (matrix_mdev->req_trigger) {
> +		if (!(count % 10))
> +			dev_notice_ratelimited(dev,
> +					       "Relaying device request to user (#%u)\n",
> +					       count);
> +
> +		eventfd_signal(matrix_mdev->req_trigger, 1);
> +	} else if (count == 0) {
> +		dev_notice(dev,
> +			   "No device request registered, blocked until released by user\n");
> +	}
> +}
> +
>   static int vfio_ap_mdev_get_device_info(unsigned long arg)
>   {
>   	unsigned long minsz;
> @@ -1955,6 +1975,7 @@ static const struct vfio_device_ops vfio_ap_matrix_dev_ops = {
>   	.bind_iommufd = vfio_iommufd_emulated_bind,
>   	.unbind_iommufd = vfio_iommufd_emulated_unbind,
>   	.attach_ioas = vfio_iommufd_emulated_attach_ioas,
> +	.request = vfio_ap_mdev_request
>   };
>   
>   static struct mdev_driver vfio_ap_matrix_driver = {

