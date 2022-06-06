Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4216C433EF
	for <linux-s390@archiver.kernel.org>; Mon,  6 Jun 2022 23:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbiFFXpl (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 6 Jun 2022 19:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235321AbiFFXpk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Jun 2022 19:45:40 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDB4C039E
        for <linux-s390@vger.kernel.org>; Mon,  6 Jun 2022 16:45:38 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id 15so6895583qki.6
        for <linux-s390@vger.kernel.org>; Mon, 06 Jun 2022 16:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7eRK9Jzco6zaNzKezRSe21QtwINuCVoa5KXsUQC3180=;
        b=jAX96k1SfIBELpO/UdAggYmzm0dmWWLs4cZGxrIiYnFWe9BunBdImD3qE8GX5/n5oS
         XCx/pwFQWFciiYl4z+k/bYiShg6+7bYd46TLVpcKqAV/kIMY3GwAk/gtb4ydf738iOPy
         coh732bxpVTleJJieq3gSkDgOl405aKGul1zSi/Yc+iyGBgb3W5EzPgSgYW1tWmI9sis
         Efyc9Ocfdj8n9hPJeLOeHaYPboTVJVoA7aZu6izJFJxfqJCMMREhWrXbTmoBoble+zA8
         p7JMHKmke/sKbHKTqw6HuH48Mq8ZhtHTheLgBXknvv53yCbIYAvg7TdJve9La6ZRWbua
         oJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7eRK9Jzco6zaNzKezRSe21QtwINuCVoa5KXsUQC3180=;
        b=s6VUovGZH2chVdr0Vyrpwza8tlA5lbqeyt6UwHszibAv6n5gt1cn9478eNWjdeLs0J
         bgbzBMv8G3xN70ZQux03JDPzCGfJO9vlCZaYY2LqHUYBsMKPRo8LjM4AdWeTeTTe8zLH
         U4LPpXpoXTXwk1vXi/bSLmsPTU9DJW7Kc1A3FnG4bCDOnC+YK3W3oFhtjUO3PF1dFzwK
         30e6J1rpcjGlkjzH12LKoWDMgnSURJymevfK1y/OzAApiqBxHUFIx8TZNEOC2kHXV0ws
         hd65VkSN0HTuiyUTeC/GJJkeQKSpzXHI+GQfbzFwPex8QJDAesTicn7L2KUOLzGgStIS
         u+nw==
X-Gm-Message-State: AOAM5316zIFeTZ0Hbr5vmseAAdSwndXmuMJeK1IKgwOc/PQ5LRkB29zt
        EbzaIrmY6qmW52AQgNbdGsNeSQ==
X-Google-Smtp-Source: ABdhPJxcfjZTvFvT18Z5mBZR5Sa0iKO+ftAmalw28pYUIVYuQcvulbwp+qhNES3flaj709o81mFsqg==
X-Received: by 2002:a37:2750:0:b0:6a6:9ee2:5f5c with SMTP id n77-20020a372750000000b006a69ee25f5cmr12669209qkn.558.1654559137777;
        Mon, 06 Jun 2022 16:45:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id s126-20020a375e84000000b0069fcc501851sm11986621qkb.78.2022.06.06.16.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 16:45:37 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nyMPg-002q1q-O1; Mon, 06 Jun 2022 20:45:36 -0300
Date:   Mon, 6 Jun 2022 20:45:36 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Kirti Wankhede <kwankhede@nvidia.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        intel-gvt-dev@lists.freedesktop.org
Subject: Re: [PATCH 5/8] vfio/mdev: remove mdev_from_dev
Message-ID: <20220606234536.GF3932382@ziepe.ca>
References: <20220603063328.3715-1-hch@lst.de>
 <20220603063328.3715-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603063328.3715-6-hch@lst.de>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Jun 03, 2022 at 08:33:25AM +0200, Christoph Hellwig wrote:
> Just open code it in the only caller.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/vfio/mdev/mdev_core.c | 6 ++----
>  include/linux/mdev.h          | 4 ----
>  2 files changed, 2 insertions(+), 8 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
