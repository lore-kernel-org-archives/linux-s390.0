Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3D2C433EF
	for <linux-s390@archiver.kernel.org>; Tue,  7 Jun 2022 05:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiFGF46 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 7 Jun 2022 01:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiFGF46 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 7 Jun 2022 01:56:58 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A501D4A32;
        Mon,  6 Jun 2022 22:56:57 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5C86E68AFE; Tue,  7 Jun 2022 07:56:53 +0200 (CEST)
Date:   Tue, 7 Jun 2022 07:56:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@ziepe.ca>
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
Subject: Re: [PATCH 3/8] vfio/mdev: simplify mdev_type handling
Message-ID: <20220607055653.GA8848@lst.de>
References: <20220603063328.3715-1-hch@lst.de> <20220603063328.3715-4-hch@lst.de> <20220606233808.GD3932382@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606233808.GD3932382@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Jun 06, 2022 at 08:38:08PM -0300, Jason Gunthorpe wrote:
> Maybe we need a 'finish register' call to trigger the uevent? Or
> perhaps trigger the uevent when each add_type is done?

The finish version would keep the existing behavior as-is, so that
might be a good idea, I'll look into that.
