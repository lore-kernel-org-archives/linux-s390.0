Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C87C54EBE
	for <linux-s390@archiver.kernel.org>; Tue, 10 Jan 2023 16:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbjAJQLj (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 10 Jan 2023 11:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjAJQLi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 10 Jan 2023 11:11:38 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E01544CA
        for <linux-s390@vger.kernel.org>; Tue, 10 Jan 2023 08:11:37 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-4d19b2686a9so32798687b3.6
        for <linux-s390@vger.kernel.org>; Tue, 10 Jan 2023 08:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LuLL/xW/bc4GjQaeQyZKueQ0wk66WBE0L/jRgACLBJI=;
        b=JwtYIwPX0X6DrJYSYColvSL1d2HfNydQu1+JZAeEN5VHCL87Y+lZBYkXaOeT3Bzkkx
         7NlPUmjOhXtWUcEwWIIEdQbkg5zsfAnNYcM3+Si2VPv5rYvKie8aJW9pSM9IYRan9IWL
         fKAFA3Tp45mugqQ9tkrjUe3JhSDAec0ThFPGG8l3T/9VLLHQ9W0h1+RRZZxzGkJdipy5
         72RaNXLZ3a4hh27GQRToUGeAoKlFIg8BnJXve3ioNV+raiiWr5y3TBMWQXmF6TPNPFsX
         mN1ZlQ4FuZisyh1ZfUm0E2KMdkcpSnkJS2I/U4/NDMsNXeKL+n97dgaf7suk2GAtwJrd
         wKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LuLL/xW/bc4GjQaeQyZKueQ0wk66WBE0L/jRgACLBJI=;
        b=Adw2vRRCf9w7J/jkT5ic4dK9u76kouCJq7dBzfK4QgbvxP1dtwsfxJv60/yG1jaeyN
         qejDAbiFjisv6Ot2tUS2rxfo05PbjHBV4WARRzva0sWWrFlsztiRr9NgO4PGsbFj7Qrj
         eIS5WhoRDXCNaehd4bBV3YBxMORAEFfo4BY0QYY9aTZDgAIf5FsaLoOsK3kwaBD1Z+oi
         DFzF595n9qFGB73T83vvM9vrfW4KCoyG77aQ3Ew0oagHDUEbv2Q3OJ5GqtivDTp/WUq+
         lvNZXer3o906PolnVEu2W2FcqHeMiqNTgkYL1Xd/N/4BOjrtmfD1LbJBezhoJAsTYdIu
         YHXw==
X-Gm-Message-State: AFqh2kp487xY0l+W/etcIN9/AUzcL6QhTcrxWVCDIKQOYJPs5OwrLs6Y
        eDYZ1RBwuUAptljn8uMS/jMA0A==
X-Google-Smtp-Source: AMrXdXtfmrz3fXJ9b7HUyCfXVFfON5rLhQo9Xkp7TZG+Th/gH6Ar4roPtsB5A+UiEgJBmqGqhmUlAQ==
X-Received: by 2002:a05:7500:6583:b0:f0:3a58:7714 with SMTP id iq3-20020a057500658300b000f03a587714mr1169364gab.65.1673367096237;
        Tue, 10 Jan 2023 08:11:36 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-50-193.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.50.193])
        by smtp.gmail.com with ESMTPSA id v1-20020a05620a0f0100b006faf76e7c9asm7451630qkl.115.2023.01.10.08.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 08:11:35 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pFHDq-008QLA-Ro;
        Tue, 10 Jan 2023 12:11:34 -0400
Date:   Tue, 10 Jan 2023 12:11:34 -0400
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
Subject: Re: [PATCH 1/4] vfio-mdev: allow building the samples into the kernel
Message-ID: <Y72ONmN9vaxOiuYh@ziepe.ca>
References: <20230110091009.474427-1-hch@lst.de>
 <20230110091009.474427-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110091009.474427-2-hch@lst.de>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Jan 10, 2023 at 10:10:06AM +0100, Christoph Hellwig wrote:
> There is nothing in the vfio-mdev sample drivers that requires building
> them as modules, so remove that restriction.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  samples/Kconfig | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
