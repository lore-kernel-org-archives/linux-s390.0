Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3875DC433F5
	for <linux-s390@archiver.kernel.org>; Wed, 13 Apr 2022 16:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbiDMQJ0 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 13 Apr 2022 12:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbiDMQJZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 13 Apr 2022 12:09:25 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412486472D;
        Wed, 13 Apr 2022 09:07:04 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2166F68BEB; Wed, 13 Apr 2022 18:07:01 +0200 (CEST)
Date:   Wed, 13 Apr 2022 18:07:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        David Airlie <airlied@linux.ie>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
        linux-doc@vger.kernel.org, linux-s390@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH 9/9] vfio: Remove calls to
 vfio_group_add_container_user()
Message-ID: <20220413160700.GB29631@lst.de>
References: <0-v1-a8faf768d202+125dd-vfio_mdev_no_group_jgg@nvidia.com> <9-v1-a8faf768d202+125dd-vfio_mdev_no_group_jgg@nvidia.com> <20220413061105.GA32701@lst.de> <20220413140305.GD368031@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413140305.GD368031@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Apr 13, 2022 at 11:03:05AM -0300, Jason Gunthorpe wrote:
> On Wed, Apr 13, 2022 at 08:11:05AM +0200, Christoph Hellwig wrote:
> > On Tue, Apr 12, 2022 at 12:53:36PM -0300, Jason Gunthorpe wrote:
> > > +	if (WARN_ON(!READ_ONCE(vdev->open_count)))
> > > +		return -EINVAL;
> > 
> > I think all the WARN_ON()s in this patch need to be WARN_ON_ONCE,
> > otherwise there will be too many backtraces to be useful if a driver
> > ever gets the API wrong.
> 
> Sure, I added a wrapper to make that have less overhead and merged it
> with the other 'driver is calling this correctly' checks:

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
