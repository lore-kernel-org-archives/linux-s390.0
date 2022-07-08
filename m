Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C29CC43334
	for <linux-s390@archiver.kernel.org>; Fri,  8 Jul 2022 05:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237332AbiGHFsn (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 8 Jul 2022 01:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237327AbiGHFsm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 8 Jul 2022 01:48:42 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095A318B25;
        Thu,  7 Jul 2022 22:48:41 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3E3A867373; Fri,  8 Jul 2022 07:48:37 +0200 (CEST)
Date:   Fri, 8 Jul 2022 07:48:36 +0200
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
Subject: Re: [PATCH 14/15] vfio/mdev: add mdev available instance checking
 to the core
Message-ID: <20220708054836.GA16300@lst.de>
References: <20220706074219.3614-1-hch@lst.de> <20220706074219.3614-15-hch@lst.de> <488e7a98426dc64a53864ca302f7c32627a070fd.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <488e7a98426dc64a53864ca302f7c32627a070fd.camel@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Jul 06, 2022 at 11:08:57PM -0400, Eric Farman wrote:
> If I read this right, .get_available and .max_instances are mutually
> exclusive.

Yes.

> Which means that available_instances_show() from patch 12
> would need to emit parent->available_instances if .get_available is
> NULL.

Indeed.
