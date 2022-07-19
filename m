Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6030FC43334
	for <linux-s390@archiver.kernel.org>; Tue, 19 Jul 2022 14:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236884AbiGSOtn (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 19 Jul 2022 10:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239760AbiGSOtb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 19 Jul 2022 10:49:31 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C6B5F4D;
        Tue, 19 Jul 2022 07:49:30 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 561FC68AFE; Tue, 19 Jul 2022 16:49:28 +0200 (CEST)
Date:   Tue, 19 Jul 2022 16:49:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Eric Farman <farman@linux.ibm.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, intel-gvt-dev@lists.freedesktop.org,
        Vineeth Vijayan <vneethv@linux.ibm.com>
Subject: Re: simplify the mdev interface v6
Message-ID: <20220719144928.GB21431@lst.de>
References: <20220709045450.609884-1-hch@lst.de> <20220718054348.GA22345@lst.de> <20220718153331.18a52e31.alex.williamson@redhat.com> <1f945ef0eb6c02079700a6785ca3dd9864096b82.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f945ef0eb6c02079700a6785ca3dd9864096b82.camel@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Jul 18, 2022 at 10:01:40PM -0400, Eric Farman wrote:
> I'll get the problem with struct subchannel [1] sorted out in the next
> couple of days. This series breaks vfio-ccw in its current form (see
> reply to patch 14), but even with that addressed the placement of all
> these other mdev structs needs to be handled differently.

Alex, any preference if I should just fix the number instances checking
with either an incremental patch or a resend, or wait for this ccw
rework?
