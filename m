Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46649C433ED
	for <linux-s390@archiver.kernel.org>; Sat, 24 Apr 2021 00:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18D29613D8
	for <linux-s390@archiver.kernel.org>; Sat, 24 Apr 2021 00:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbhDXAJL (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 23 Apr 2021 20:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbhDXAJJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 23 Apr 2021 20:09:09 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63359C061574;
        Fri, 23 Apr 2021 17:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=jZ0JGW4AdikCiQSQF+QylhizTZCJYUc5d0ULmwp16B8=; b=hzjWyBj0HLDPun/nggIhfnYrva
        W/nOYte1rH5HIK0GVaXIDplkgTTP+z5L2OMSQPJ3FYQg9YTi67XAq5s/zce8xIlPASCBA6njDVqQo
        rsLyEdPDXaS3DvrmupDDdXY2lBu7BEtQpGB3AKvCGimW9LPTQheJ9FtqGzLVBGrc5P83jJUj1BMhZ
        2YZbetvu7mDmgxxqbKtF7wpyAjHqnah8s8PVBQ90B6Vt7drof2FU+X53+cUeFfmBL8E2y/CeaMe2y
        n7luXklZgzHXVQRcvJIrL+bOpgye5LzxzoveUr3i14QYbH0J2Ks5WoAQHKaYke5eMOu/VmFoBMDw4
        hCPX7uMA==;
Received: from [2601:1c0:6280:3f0::df68]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1la5qK-002dNr-O1; Sat, 24 Apr 2021 00:08:17 +0000
Subject: Re: [PATCH 01/12] vfio/mdev: Remove CONFIG_VFIO_MDEV_DEVICE
To:     Jason Gunthorpe <jgg@nvidia.com>, David Airlie <airlied@linux.ie>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        kvm@vger.kernel.org, Kirti Wankhede <kwankhede@nvidia.com>,
        linux-doc@vger.kernel.org, linux-s390@vger.kernel.org,
        Halil Pasic <pasic@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     "Raj, Ashok" <ashok.raj@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Leon Romanovsky <leonro@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Tarun Gupta <targupta@nvidia.com>
References: <1-v1-d88406ed308e+418-vfio3_jgg@nvidia.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d058f9ad-7ce1-c1b3-19cd-5f625ef4c670@infradead.org>
Date:   Fri, 23 Apr 2021 17:08:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <1-v1-d88406ed308e+418-vfio3_jgg@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 4/23/21 4:02 PM, Jason Gunthorpe wrote:
> @@ -171,7 +171,7 @@ config SAMPLE_VFIO_MDEV_MDPY_FB
>  
>  config SAMPLE_VFIO_MDEV_MBOCHS
>  	tristate "Build VFIO mdpy example mediated device sample code -- loadable modules only"

You can drop the ending of the prompt string.

> -	depends on VFIO_MDEV_DEVICE && m
> +	depends on VFIO_MDEV
>  	select DMA_SHARED_BUFFER
>  	help
>  	  Build a virtual display sample driver for use as a VFIO


-- 
~Randy

