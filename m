Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A85C433EF
	for <linux-s390@archiver.kernel.org>; Mon,  6 Jun 2022 23:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbiFFXV2 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 6 Jun 2022 19:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbiFFXV1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Jun 2022 19:21:27 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC175DA59
        for <linux-s390@vger.kernel.org>; Mon,  6 Jun 2022 16:21:25 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id bi27so5486163qkb.10
        for <linux-s390@vger.kernel.org>; Mon, 06 Jun 2022 16:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v5vcjjBO5Hf7YQjGIjjL9G5k1C6N2WYoLNXXwX5nxBQ=;
        b=WBSJSZBieh+Cj1oFaheiZ15LpB3nTTuTiYVUhSHgCo9F/SI8JUFSktbhiOxMhmiZiJ
         pE4vzWpBbzJbHq4rm3An0RyNSSWcTLQivvbwhdDcFxpyp96ObudXGn27dCtWY5ABCPzh
         6ftMcfcswU1+p3ZmDVnFj5j94FDg/+MwixwnJ2TH/uRwux2ZDaCHa41ND8fsoLoETLof
         SrX1xpQ3j6bViqbX0vdWrjApj/OIAA4iscB0JUGHffSuETDo3gyqOKRB6qSbc5mbFpQY
         p4ZbXHr9l4gqYY3i/gWg/buCdVYtU9GocYXQhSeYhwqRCtQ/G8Tt9ZKYWWox4s0fszRL
         6vDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v5vcjjBO5Hf7YQjGIjjL9G5k1C6N2WYoLNXXwX5nxBQ=;
        b=pbieTMt8qXMr1yMGq7j9F38fK4ODKCcRLpCPPgsWEqUq+6gtcSBWYenuy4hyyr1vCs
         lTXWymCHtJY7KPciqM1xE27F22e8DAPE1x3UwMbowPvWUDw8JnzPrqjFc/4LRyv3LeMC
         N4idY1NNW20mmVh5xS3GdRLgwWo1tj4iK1VnAn/jbo2/x5r3Y5I8EojJ3wv63hS55vs1
         Jhp/juMqip5u6UekmqG5rgim9wQVvtBIxqL1wF1UkqmZHRpbZf9Pj9yh014TYNRJBCBZ
         TcbF2DTwaz5ywYwAYrihp5SooB6LFeFEMcDvuVUldyePz8sDtIew3ZBxS5iNv9e8BTmL
         Mx4w==
X-Gm-Message-State: AOAM531Y/q4GDi6rs2xZQ7YazjIhyTyqhYaFg0bQa+tcdoJiZsTmEfg0
        9279bjja8BLQuTVjbIXn2H963A==
X-Google-Smtp-Source: ABdhPJwa4cdiCcTjwM0PprUnLIbY2ss8Gs7aLyp/S9zRUiWanpo7k2O0otOSWKDRr/Dg++yAS4D4Jg==
X-Received: by 2002:ae9:f20d:0:b0:6a6:ab5e:33ca with SMTP id m13-20020ae9f20d000000b006a6ab5e33camr9918929qkg.176.1654557685060;
        Mon, 06 Jun 2022 16:21:25 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id z19-20020ac87f93000000b002f936bae288sm11751235qtj.87.2022.06.06.16.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 16:21:24 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nyM2F-002pag-P1; Mon, 06 Jun 2022 20:21:23 -0300
Date:   Mon, 6 Jun 2022 20:21:23 -0300
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
Subject: Re: [PATCH 1/8] vfio/mdev: make mdev.h standalone includable
Message-ID: <20220606232123.GC3932382@ziepe.ca>
References: <20220603063328.3715-1-hch@lst.de>
 <20220603063328.3715-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603063328.3715-2-hch@lst.de>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Jun 03, 2022 at 08:33:21AM +0200, Christoph Hellwig wrote:
> Include <linux/device.h> and <linux/uuid.h> so that users of this headers
> don't need to do that.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/mdev.h | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
