Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602DCC433EF
	for <linux-s390@archiver.kernel.org>; Wed, 20 Jul 2022 05:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiGTFGg (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 20 Jul 2022 01:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiGTFGf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 20 Jul 2022 01:06:35 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEC550066;
        Tue, 19 Jul 2022 22:06:34 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4294868BEB; Wed, 20 Jul 2022 07:06:30 +0200 (CEST)
Date:   Wed, 20 Jul 2022 07:06:29 +0200
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
Message-ID: <20220720050629.GA6076@lst.de>
References: <20220709045450.609884-1-hch@lst.de> <20220718054348.GA22345@lst.de> <20220718153331.18a52e31.alex.williamson@redhat.com> <1f945ef0eb6c02079700a6785ca3dd9864096b82.camel@linux.ibm.com> <20220719144928.GB21431@lst.de> <20220719092644.3db1ceee.alex.williamson@redhat.com> <20cba66846a011e2fe8885f15def6ec837d12d0b.camel@linux.ibm.com> <29248eb6e20ef5990d3189ba5468fe4d8bada61a.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29248eb6e20ef5990d3189ba5468fe4d8bada61a.camel@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Jul 19, 2022 at 10:41:49PM -0400, Eric Farman wrote:
> I suspect the second item (or something similar) is needed anyway,
> because Alex' tree + this series crashes frequently in (usually)
> mdev_remove. I haven't found an explanation for how we get in this
> state, but admittedly didn't spent a lot of time on them since the
> proposed changes to struct subchannel are a non-starter. The other
> crashes were always in something that's almost certainly a victim of
> something else, like kmalloc-related stuff in net/skbuff.
> 
> With the above, the crashes out of the vfio-ccw stack disappear, and
> things work a bit better. But those random kmalloc-related crashes
> persist. I guess I'll pick those up tomorrow.

Ok, I think I'll just wait for this to fan out, no need to rush in
known broken code.
