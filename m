Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9B9C43334
	for <linux-s390@archiver.kernel.org>; Mon,  4 Jul 2022 06:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiGDGSt (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 4 Jul 2022 02:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiGDGSs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Jul 2022 02:18:48 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA2D267E;
        Sun,  3 Jul 2022 23:18:48 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A857C68AA6; Mon,  4 Jul 2022 08:18:43 +0200 (CEST)
Date:   Mon, 4 Jul 2022 08:18:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, intel-gvt-dev@lists.freedesktop.org,
        Kevin Tian <kevin.tian@intel.com>
Subject: Re: [PATCH 04/13] vfio/mdev: simplify mdev_type handling
Message-ID: <20220704061843.GA29047@lst.de>
References: <20220628051435.695540-1-hch@lst.de> <20220628051435.695540-5-hch@lst.de> <20220628155915.060ba2d9.alex.williamson@redhat.com> <20220629121709.GI693670@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629121709.GI693670@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Jun 29, 2022 at 09:17:09AM -0300, Jason Gunthorpe wrote:
> On Tue, Jun 28, 2022 at 03:59:15PM -0600, Alex Williamson wrote:
> > > +	strcpy(matrix_dev->mdev_type.sysfs_name, VFIO_AP_MDEV_TYPE_HWVIRT);
> > 
> > And then this might as well be an snprintf() as well too.
> 
> Kees has setup FORTIFY so the above will actually throw a compile
> warning in build bots if the array size is too small. Changing it to
> snprintf would loose this and cause undetected string truncation.

I think I have an idea how to do away with these arrays entirely,
and just use pointers to sting literals.
