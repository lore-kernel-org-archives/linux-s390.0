Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E32AC43334
	for <linux-s390@archiver.kernel.org>; Thu,  7 Jul 2022 13:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235484AbiGGNk5 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 7 Jul 2022 09:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234799AbiGGNkz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 7 Jul 2022 09:40:55 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBA718349;
        Thu,  7 Jul 2022 06:40:54 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4EC6668AA6; Thu,  7 Jul 2022 15:40:52 +0200 (CEST)
Date:   Thu, 7 Jul 2022 15:40:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Kirti Wankhede <kwankhede@nvidia.com>,
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
Subject: Re: [PATCH 15/15] vfio/mdev: remove an extra parent kobject
 reference
Message-ID: <20220707134052.GC19060@lst.de>
References: <20220706074219.3614-1-hch@lst.de> <20220706074219.3614-16-hch@lst.de> <20220706143833.GD693670@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706143833.GD693670@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Jul 06, 2022 at 11:38:33AM -0300, Jason Gunthorpe wrote:
> On Wed, Jul 06, 2022 at 09:42:19AM +0200, Christoph Hellwig wrote:
> > The mdev_type already holds a reference to the parent through
> > mdev_types_kset, so drop the extra reference.
> 
> I would drop this patch, but at least the explanation needs tweaking..

I'm fine with that.  Alex, any preferences?
