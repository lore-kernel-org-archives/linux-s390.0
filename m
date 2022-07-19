Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE70CCA481
	for <linux-s390@archiver.kernel.org>; Tue, 19 Jul 2022 14:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236217AbiGSOsP (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 19 Jul 2022 10:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235040AbiGSOsP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 19 Jul 2022 10:48:15 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BB3FD9;
        Tue, 19 Jul 2022 07:48:12 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7060668AFE; Tue, 19 Jul 2022 16:48:08 +0200 (CEST)
Date:   Tue, 19 Jul 2022 16:48:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Eric Farman <farman@linux.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, intel-gvt-dev@lists.freedesktop.org,
        Kevin Tian <kevin.tian@intel.com>
Subject: Re: [PATCH 14/14] vfio/mdev: add mdev available instance checking
 to the core
Message-ID: <20220719144808.GA21431@lst.de>
References: <20220709045450.609884-1-hch@lst.de> <20220709045450.609884-15-hch@lst.de> <c4c14deebf82cd2497fd9ebd0c3f321e9089b7ce.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4c14deebf82cd2497fd9ebd0c3f321e9089b7ce.camel@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Jul 18, 2022 at 10:00:26PM -0400, Eric Farman wrote:
> > +	if (!drv->get_available) {
> > +		if (atomic_dec_and_test(&parent->available_instances))
> > {
> 
> Ah, subtle change between v5 and v6 to use atomics. As vfio-ccw only
> has 1 available instance per mdev, this breaks us. Did you mean
> atomic_dec_if_positive() ?

Yes, this should have been atomic_dec_if_positive.  Or just an open
coded atomic_dec + atomic_read a the only reason to use an atomic is
for the sysfs file that reads it outside the lock.
