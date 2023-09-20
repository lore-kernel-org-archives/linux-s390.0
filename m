Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B9AC05025
	for <linux-s390@archiver.kernel.org>; Wed, 20 Sep 2023 20:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjITUlW (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 20 Sep 2023 16:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjITUlV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 20 Sep 2023 16:41:21 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76748B9
        for <linux-s390@vger.kernel.org>; Wed, 20 Sep 2023 13:41:14 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-414b3b65e85so1145191cf.1
        for <linux-s390@vger.kernel.org>; Wed, 20 Sep 2023 13:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1695242473; x=1695847273; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gWfoV3C+7YSBwabU1RrTm8uXi7/h5S313DOQ9XVA4fs=;
        b=ll42s7Zw90tsjWd0E2BU7/7sJ/jiJ+kxuR6GFEOw+jkTvDFcUtLYINP90IDwFI4hGV
         K+egE2k1NR89tBtiCbQz56anRWdpdVnb3WhCAS+MYPgYFdNEAUUvZdkwmC39fRwhpwvw
         US8TD28CfIt17GPAIZX/QAfwB5tR56/VKTvtOP3ByJhwPdKhImi6c3AfR0dAEpGbVY7o
         utZXJAWfqc4nnPAEYdg7FIAlaRvflddvaNzNElUYC9f0aJVODyT9AtcqCBZvNwYnzBAH
         wnFo6DcKdcXIEW302r60Wqhv1STdkIVnEFj8FadghQLRyYnhvi4VTELZNbEW2W8IMIN9
         lwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695242473; x=1695847273;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gWfoV3C+7YSBwabU1RrTm8uXi7/h5S313DOQ9XVA4fs=;
        b=v9bcEaQ1ZJj63OrAxwvMm7uTNsvwAcFQq9YsORndbG1ZQoEXe8hf/7py47o9gk/sw3
         lNuYSke/ah/Jq2D5T5EtkviPcqvR6G9x3Wz+XV9PyRt0FfvvasLpuMrStfCIRUP0uCJZ
         Xzb7GPO910o/nRLpBqd+WRJ4QQpB+reB6PNMIuZfdu/3bnOxhzuHgQr6Z3kSzEOohZlT
         YUCebWI+j/22Mkagk54vPtgfTPfhu7o0MsXogetamVUh3WPfPn2ouNwe/IkVNxIZ8UK6
         oDG+tvOa/ghz3/C9hKkPUxqgP67IXVnM+330LE8ecgCiZgMJvsKgLGOWhp6L6E8L6D8X
         cQ6g==
X-Gm-Message-State: AOJu0YwTc5rvatU0VFjqu24Tv1S527SZdpxC1/aw2GI7sL/GG5chAgez
        DV1b81M3ucJ9MQxy0uVn9FLjSA==
X-Google-Smtp-Source: AGHT+IHCzJajQHoo4ag+MBSCuMbz+nBgjUOKbqVuICXRsb6shtfJZIsUaiffrvD5xvp+3k7IrE2ufA==
X-Received: by 2002:a05:622a:551:b0:412:1163:1d20 with SMTP id m17-20020a05622a055100b0041211631d20mr4219646qtx.48.1695242473530;
        Wed, 20 Sep 2023 13:41:13 -0700 (PDT)
Received: from ?IPV6:2600:1700:2000:b002:104:ea12:bd23:169? ([2600:1700:2000:b002:104:ea12:bd23:169])
        by smtp.gmail.com with ESMTPSA id c17-20020a05622a025100b004166905aa2asm1690qtx.28.2023.09.20.13.41.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 13:41:13 -0700 (PDT)
Message-ID: <79af9398-167f-440e-a493-390dc4ccbd85@sifive.com>
Date:   Wed, 20 Sep 2023 15:41:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/17] nbd: call blk_mark_disk_dead in
 nbd_clear_sock_ioctl
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Denis Efremov <efremov@linux.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "Darrick J . Wong" <djwong@kernel.org>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-s390@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20230811100828.1897174-1-hch@lst.de>
 <20230811100828.1897174-8-hch@lst.de>
From:   Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20230811100828.1897174-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 2023-08-11 5:08 AM, Christoph Hellwig wrote:
> nbd_clear_sock_ioctl kills the socket and with that the block
> device.  Instead of just invalidating file system buffers,
> mark the device as dead, which will also invalidate the buffers
> as part of the proper shutdown sequence.  This also includes
> invalidating partitions if there are any.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/nbd.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 8576d696c7a221..42e0159bb258fa 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -1434,12 +1434,10 @@ static int nbd_start_device_ioctl(struct nbd_device *nbd)
>  	return ret;
>  }
>  
> -static void nbd_clear_sock_ioctl(struct nbd_device *nbd,
> -				 struct block_device *bdev)
> +static void nbd_clear_sock_ioctl(struct nbd_device *nbd)
>  {
> +	blk_mark_disk_dead(nbd->disk);
>  	nbd_clear_sock(nbd);
> -	__invalidate_device(bdev, true);
> -	nbd_bdev_reset(nbd);

This change breaks nbd-client, which calls the NBD_CLEAR_SOCK ioctl during
device setup and socket reconnection. After merging this series (bisected to
511fb5bafed1), all NBD devices are immediately dead on arrival:

[   14.605849] nbd0: detected capacity change from 0 to 4194304

[   14.606211] Buffer I/O error on dev nbd0, logical block 0, async page read
[   14.619101] Buffer I/O error on dev nbd0, logical block 0, async page read

[   14.630490]  nbd0: unable to read partition table

I wonder if disk_force_media_change() is the right thing to call here instead.

Regards,
Samuel

>  	if (test_and_clear_bit(NBD_RT_HAS_CONFIG_REF,
>  			       &nbd->config->runtime_flags))
>  		nbd_config_put(nbd);
> @@ -1465,7 +1463,7 @@ static int __nbd_ioctl(struct block_device *bdev, struct nbd_device *nbd,
>  	case NBD_DISCONNECT:
>  		return nbd_disconnect(nbd);
>  	case NBD_CLEAR_SOCK:
> -		nbd_clear_sock_ioctl(nbd, bdev);
> +		nbd_clear_sock_ioctl(nbd);
>  		return 0;
>  	case NBD_SET_SOCK:
>  		return nbd_add_socket(nbd, arg, false);

