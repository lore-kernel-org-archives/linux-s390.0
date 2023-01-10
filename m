Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5EDC46467
	for <linux-s390@archiver.kernel.org>; Tue, 10 Jan 2023 16:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238433AbjAJQMr (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 10 Jan 2023 11:12:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238466AbjAJQMq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 10 Jan 2023 11:12:46 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966FF54D9B
        for <linux-s390@vger.kernel.org>; Tue, 10 Jan 2023 08:12:45 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-4d19b2686a9so32862517b3.6
        for <linux-s390@vger.kernel.org>; Tue, 10 Jan 2023 08:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MgwAknOlctLrMePUkU2P1GVEL5JmSpDoBM+ewSVabLo=;
        b=Ykez1Dv/5AXnlGRthGgQGK7VkSC+/gF2BPHJE3Y/bgrRyksdD9EBdP6lYPu6qVEBzt
         w2lvoH+Xi5o/C6w7XHUlhiIsSmnmOUXE1BkcMkugRd9OXUzTMIzMf09cbA1pTrMC1jLZ
         Sg1fYWy1wF7qZaj+eEMVxAWcw2CwMsoJvCge/cfnm1rc5h5DFN5Vvlz13fITfa8HlDSD
         pYTo2fE6t4umSph1jPPwqESiuKCCWmbP4b7TVEHh5I5xMLNgL83ZeeE12TNpqRnnUSuc
         5Mx29/H9Z24Y1tyTAtFWsM9c4HelvnMUL/ztyFac8DyGMr6KsOj2YFYpEYrKYDyUjGoA
         jtHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MgwAknOlctLrMePUkU2P1GVEL5JmSpDoBM+ewSVabLo=;
        b=MrnKa3MGOJcVkN05ajINtWU+rZq+KU2RCDCjIaaClej9//h3xyfq7Y7HLDI0d5rglE
         jjidt+/4GlNmhXaBcXytWNweMmf4GD3PxG4fa2L0Z5C9DyZIWS9E3tiHGbOFGgBLg+Ep
         50V63BYGgIyXA7zNo3X3AKC8KN9WuIoZXR+5Qk7OFXu7glDV1UCyNeE3cy1At8bGxVry
         3YRJRns7TX2ofDqwixYFH1E0tvDTjIv0suVHl8i3QbWDD77dx2o5JfObRYmf/ilhfjEj
         b0D3vhrBmxfqfp9ccV/QCeYx6QIxKt7FmTK8VYIJvuOJxSuyAKTEug1UdWvyL0A17NcG
         RnWA==
X-Gm-Message-State: AFqh2kqKLweXYpga0bUJFNnpvpLQxeVEevUL0zZ7WvfgiJvYFqWzxHIE
        f8pIf5/EqFZmzMzzT0tRUs1opg==
X-Google-Smtp-Source: AMrXdXsuSEzI44k2qcLpE72UZZhdBtulKRMTc8zthZKV8IXvS0s88CzrCP5eZzn+A17YdxSUVPnA8A==
X-Received: by 2002:a05:7500:6a06:b0:ef:bcca:6a03 with SMTP id jv6-20020a0575006a0600b000efbcca6a03mr3043243gab.52.1673367164756;
        Tue, 10 Jan 2023 08:12:44 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-50-193.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.50.193])
        by smtp.gmail.com with ESMTPSA id l23-20020a37f917000000b006fc2b672950sm7352446qkj.37.2023.01.10.08.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 08:12:44 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pFHEx-008QMx-MO;
        Tue, 10 Jan 2023 12:12:43 -0400
Date:   Tue, 10 Jan 2023 12:12:43 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH 3/4] vfio-mdev: move the mtty usage documentation
Message-ID: <Y72Oe//xESaLdTLn@ziepe.ca>
References: <20230110091009.474427-1-hch@lst.de>
 <20230110091009.474427-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110091009.474427-4-hch@lst.de>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Jan 10, 2023 at 10:10:08AM +0100, Christoph Hellwig wrote:
> Move the documentation on how to use mtty to samples/vfio-mdev/README.rst
> as it is in no way related to the vfio API.  This matches how the bpf
> and pktgen samples are documented.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  .../driver-api/vfio-mediated-device.rst       | 100 ------------------
>  samples/vfio-mdev/README.rst                  | 100 ++++++++++++++++++
>  2 files changed, 100 insertions(+), 100 deletions(-)
>  create mode 100644 samples/vfio-mdev/README.rst

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
