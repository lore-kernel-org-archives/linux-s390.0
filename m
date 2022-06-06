Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDACC433EF
	for <linux-s390@archiver.kernel.org>; Mon,  6 Jun 2022 23:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235328AbiFFXqN (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 6 Jun 2022 19:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbiFFXqM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Jun 2022 19:46:12 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77622C039E
        for <linux-s390@vger.kernel.org>; Mon,  6 Jun 2022 16:46:11 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id o68so12081818qkf.13
        for <linux-s390@vger.kernel.org>; Mon, 06 Jun 2022 16:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F3hOH9RA5JoblI2pxUlcLp6jn6iFgdYtxKJdEXArLz8=;
        b=H4hdQBXcoHuewS6bMmzTaq4Gi46SWkQGuA+7UxvO61phStKl3JgqnymllrkMmhexSP
         dLWLsx3WY0TdjatRyvhQoRXXax2GfIDXfrFQwQ+jlZwwk4ewAKjtmikJRqr4MMOKwpQh
         +ooX9uHqlT4o1HAJ/XreaoYzR0uC67Hi+rLGCgt7+kskip/KVVuAB1HFaptGPaj4fh7C
         e6ngIUJIIOaFVhWkjQQB4UKzxypeniGWdibGtKORusraOMk42575Og1/cAFZKn3cJ/ys
         FINhuHpisIRcMnxUJjsOoT2Jxo1H86pe4P1ZB6rp/lSPDNDJhxff9ViRq1na/nZTlz8a
         a2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F3hOH9RA5JoblI2pxUlcLp6jn6iFgdYtxKJdEXArLz8=;
        b=XYyzJMOxhWUmjyk7q6jtMNcZOjMicZ5EtQuGgf3w55GycyZAj3oAP/p1VKKKMCzF4N
         ahHGWw7tQ1bBBBPYOV+dF3xU2lPzTzYJb9E/c3OilrFfQMYUGeaxbOf9IfoOTTV6+ei6
         ZwUc5gPrEwAJP+jk3zbWm34JRIZpY7t/WwwQSpxrQRB+NvxwTpNX4DWQwzPMl5CMZZSH
         et9WQEIi5/DppRMRbsXcHxIFAAviow5ec0yOqkRK0DT01vdde5Ne0CFXGnkjpn0k3TFT
         yC22nlF2cfEHdlJ52zBeCvnTEIEc1a7wJxbRuomsZMB9TiTGlfNm96CTJXP4FrPINRwG
         M5mg==
X-Gm-Message-State: AOAM5312MK+Cy+DCgcvpEW8yUow9lhf8TDN8mF/Toj8wVfFh2GbyUNOH
        C2Dk2CLXh1ZPjWPcWCCB+EpRgw==
X-Google-Smtp-Source: ABdhPJz7BqWVlzqnzkNXKYLIBTQBhbYjjkh0W7sn7nsw4vknSF/ZFvjraLVZBw3KVNYyzDf0OrFGDQ==
X-Received: by 2002:a05:620a:298c:b0:6a0:94d2:2e39 with SMTP id r12-20020a05620a298c00b006a094d22e39mr18203085qkp.278.1654559170649;
        Mon, 06 Jun 2022 16:46:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id 10-20020ac8570a000000b00304e5839734sm6340649qtw.55.2022.06.06.16.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 16:46:10 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nyMQD-002q2l-Lj; Mon, 06 Jun 2022 20:46:09 -0300
Date:   Mon, 6 Jun 2022 20:46:09 -0300
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
Subject: Re: [PATCH 6/8] vfio/mdev: unexport mdev_bus_type
Message-ID: <20220606234609.GG3932382@ziepe.ca>
References: <20220603063328.3715-1-hch@lst.de>
 <20220603063328.3715-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603063328.3715-7-hch@lst.de>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Jun 03, 2022 at 08:33:26AM +0200, Christoph Hellwig wrote:
> mdev_bus_type is only used in mdev.ko now, so unexport it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/vfio/mdev/mdev_driver.c  | 1 -
>  drivers/vfio/mdev/mdev_private.h | 1 +
>  include/linux/mdev.h             | 2 --
>  3 files changed, 1 insertion(+), 3 deletions(-)

Yay, people trying to sneak in tests of this bus type in platform code
has been a problem in the past

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
