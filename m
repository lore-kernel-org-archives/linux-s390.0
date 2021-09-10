Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3E0C433F5
	for <linux-s390@archiver.kernel.org>; Fri, 10 Sep 2021 10:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55C2C6103D
	for <linux-s390@archiver.kernel.org>; Fri, 10 Sep 2021 10:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbhIJKWQ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 10 Sep 2021 06:22:16 -0400
Received: from verein.lst.de ([213.95.11.211]:47751 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232094AbhIJKWQ (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 10 Sep 2021 06:22:16 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8BAF867357; Fri, 10 Sep 2021 12:21:02 +0200 (CEST)
Date:   Fri, 10 Sep 2021 12:21:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        linux-s390@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Christoph Hellwig <hch@lst.de>, kvm@vger.kernel.org
Subject: Re: [PATCH] vfio/ap_ops: Add missed vfio_uninit_group_dev()
Message-ID: <20210910102102.GA13722@lst.de>
References: <0-v1-3a05c6000668+2ce62-ap_uninit_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-3a05c6000668+2ce62-ap_uninit_jgg@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Sep 09, 2021 at 02:24:00PM -0300, Jason Gunthorpe wrote:
> Without this call an xarray entry is leaked when the vfio_ap device is
> unprobed. It was missed when the below patch was rebased across the
> dev_set patch.
> 
> Fixes: eb0feefd4c02 ("vfio/ap_ops: Convert to use vfio_register_group_dev()")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
