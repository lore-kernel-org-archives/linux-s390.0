Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F05AC433EF
	for <linux-s390@archiver.kernel.org>; Fri, 10 Sep 2021 12:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFD9F61041
	for <linux-s390@archiver.kernel.org>; Fri, 10 Sep 2021 12:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbhIJM2J (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 10 Sep 2021 08:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbhIJM2I (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 10 Sep 2021 08:28:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3453C061574;
        Fri, 10 Sep 2021 05:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RDyvMseb2Bkzro22vkhqZsceh+xbxJTDG5PRR8Lbxx0=; b=Rl+Sy+UebBP9yP14VD/gPw9OAR
        1u/6oalgYhfbmXdc8yHe2trMFiwCxPJNcmZFkJ/ugbVmWp8KIB2AdUlDrrWv6VLmlUgh5Jr7+MHnL
        vdCzTgjysCr4HC0eocLCv9Hn8bJPogbqQlWB0y4S/aqT8dG0ZQFz7zjgpfppcmunFHEnSg8PP3C3Y
        l6fStyVIwrGHSxExYvgzxSWgsbl2quBuf8NfjXfJZpYV+X2Ngc9Z52QCjR43Dchq8OkQ01CmP54Eb
        xoNqkmPFkQSDnylgrEzA2HWk47M1E4Q+/jz7amEoKOsD9midbgUk411L6Rpxi5ze1G3mIohBUSOYb
        AUKFUF8w==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOfae-00AzYg-HZ; Fri, 10 Sep 2021 12:25:16 +0000
Date:   Fri, 10 Sep 2021 13:25:08 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     David Airlie <airlied@linux.ie>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Eric Farman <farman@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        kvm@vger.kernel.org, Kirti Wankhede <kwankhede@nvidia.com>,
        linux-s390@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 6/9] vfio/mdev: Add mdev available instance checking
 to the core
Message-ID: <YTtOpDTGHEplvRrB@infradead.org>
References: <0-v2-7d3a384024cf+2060-ccw_mdev_jgg@nvidia.com>
 <6-v2-7d3a384024cf+2060-ccw_mdev_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6-v2-7d3a384024cf+2060-ccw_mdev_jgg@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Sep 09, 2021 at 04:38:46PM -0300, Jason Gunthorpe wrote:
> Many of the mdev drivers use a simple counter for keeping track of the
> available instances. Move this code to the core code and store the counter
> in the mdev_type. Implement it using correct locking, fixing mdpy.
> 
> Drivers provide a get_available() callback to set the number of available
> instances for their mtypes which is fixed at registration time. The core
> provides a standard sysfs attribute to return the available_instances.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
