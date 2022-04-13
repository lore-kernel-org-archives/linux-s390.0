Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07AC6C433FE
	for <linux-s390@archiver.kernel.org>; Wed, 13 Apr 2022 05:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbiDMF7m (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 13 Apr 2022 01:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbiDMF7m (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 13 Apr 2022 01:59:42 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6564969A;
        Tue, 12 Apr 2022 22:57:22 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3F38868B05; Wed, 13 Apr 2022 07:57:18 +0200 (CEST)
Date:   Wed, 13 Apr 2022 07:57:17 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
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
        Christoph Hellwig <hch@lst.de>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH 3/9] vfio/mdev: Pass in a struct vfio_device * to
 vfio_pin/unpin_pages()
Message-ID: <20220413055717.GC32092@lst.de>
References: <0-v1-a8faf768d202+125dd-vfio_mdev_no_group_jgg@nvidia.com> <3-v1-a8faf768d202+125dd-vfio_mdev_no_group_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3-v1-a8faf768d202+125dd-vfio_mdev_no_group_jgg@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

> -	extern int vfio_pin_pages(struct device *dev, unsigned long *user_pfn,
> +	extern int vfio_pin_pages(struct vfio_device *vdev, unsigned long *user_pfn,
>  				  int npage, int prot, unsigned long *phys_pfn);
>  
> -	extern int vfio_unpin_pages(struct device *dev, unsigned long *user_pfn,
> +	extern int vfio_unpin_pages(struct vfio_device *vdev, unsigned long *user_pfn,

Please drop the externs when you touch this (also for the actual
header).

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
