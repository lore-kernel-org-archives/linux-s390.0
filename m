Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD88C54EBE
	for <linux-s390@archiver.kernel.org>; Tue, 10 Jan 2023 16:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbjAJQMQ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 10 Jan 2023 11:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbjAJQMO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 10 Jan 2023 11:12:14 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE4153729
        for <linux-s390@vger.kernel.org>; Tue, 10 Jan 2023 08:12:14 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id j15so5803937qtv.4
        for <linux-s390@vger.kernel.org>; Tue, 10 Jan 2023 08:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eUQYg3dBDnO89rOefi3wBE7nm9H0hG8wxIWiNipOYyk=;
        b=JPGEBvzlxBAbSi/AHoIpkV9vr/mdXPT3xHGGLmduIDko5fsMh1fXMQwNszCP2YkP5F
         NSu9akVDPKRz2H/6Cqt6A6GMwgtTwgcjsAJ0DeHgBiMf1aws6o3OpvC2j1CDQrRa4H/e
         ld4YkRI5GSKBZt0YGU3CERDvSrF7xATImPdr3N4wh2laFOCK57nypcg4ltkOmalWR16+
         Qx2DeG9o5NCHdOFpb5G4EBvPK+DfNMS9Avii+DQ2B4exeKfOwRg0RBibRoVdABWGMv/p
         nKjS+L4ygThbMwD0p+bLtDIzqGxI4zvDjYdKh5Y36k3BpVPdSBVLNbyN8Mi8r1YiDNer
         oxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eUQYg3dBDnO89rOefi3wBE7nm9H0hG8wxIWiNipOYyk=;
        b=2PICL3CSrq14de7Pq30gcJ3J8gMthlv25K6rX6XQSTlbos3mrOEm9zMaYpA+kNOLbj
         l6E7yH/L9rl3pZdcIZnmdTQ/ub2jpKCAVngcOn5gzlrOtsDXS2M8/02YC3SQi2ivf6/Q
         b3FX8Fx2Sxm57rzDU0/eoKViCBfO4twsgDdE9BvoHAtZfqiC7JdFmuGYKAoJw7CZK4my
         3BVFmbbnt7l8yd56eQu3d6FaZbYRmzQSpyHP6B9BTRuu/SlmA3rqlDcruqguEs6dyRia
         7y8XpaPeaQmTqpDFGBJq1WZGoS0xu7HQr7+FKhG0Knn9kb+rdguErHPay1nkWNpCDOPx
         rd5A==
X-Gm-Message-State: AFqh2kqIDY79GHG5Zq8nUAKZaicGQatj4B+iC/teupun18WN4aQlybh2
        MLh1nd8T5v1Bjt3rtbUkn13h1Q==
X-Google-Smtp-Source: AMrXdXuELvPZIEFqhFQ2jC/MpgC7MDU3Amu0QT95WZLi9x/ENgvf1dLev0KIaL0jB3Y0XEeWikzHxw==
X-Received: by 2002:a05:622a:4188:b0:3a7:e4ae:7937 with SMTP id cd8-20020a05622a418800b003a7e4ae7937mr100629467qtb.6.1673367133440;
        Tue, 10 Jan 2023 08:12:13 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-50-193.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.50.193])
        by smtp.gmail.com with ESMTPSA id t13-20020ac8738d000000b003434d3b5938sm6223850qtp.2.2023.01.10.08.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 08:12:12 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pFHES-008QM4-8B;
        Tue, 10 Jan 2023 12:12:12 -0400
Date:   Tue, 10 Jan 2023 12:12:12 -0400
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
Subject: Re: [PATCH 2/4] vfio-mdev: turn VFIO_MDEV into a selectable symbol
Message-ID: <Y72OXIQJI6yE60i6@ziepe.ca>
References: <20230110091009.474427-1-hch@lst.de>
 <20230110091009.474427-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110091009.474427-3-hch@lst.de>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Jan 10, 2023 at 10:10:07AM +0100, Christoph Hellwig wrote:
> VFIO_MDEV is just a library with helpers for the drivers.  Stop making
> it a user choice and just select it by the drivers that use the helpers.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  Documentation/s390/vfio-ap.rst    | 1 -
>  arch/s390/Kconfig                 | 6 ++++--
>  arch/s390/configs/debug_defconfig | 1 -
>  arch/s390/configs/defconfig       | 1 -
>  drivers/gpu/drm/i915/Kconfig      | 2 +-
>  drivers/vfio/mdev/Kconfig         | 8 +-------
>  samples/Kconfig                   | 6 +++---
>  7 files changed, 9 insertions(+), 16 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
