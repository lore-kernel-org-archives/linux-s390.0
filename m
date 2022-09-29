Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43F5C04A95
	for <linux-s390@archiver.kernel.org>; Thu, 29 Sep 2022 07:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbiI2HLX (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 29 Sep 2022 03:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235004AbiI2HLW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 29 Sep 2022 03:11:22 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B208712262D;
        Thu, 29 Sep 2022 00:11:21 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id F33C168BFE; Thu, 29 Sep 2022 09:11:17 +0200 (CEST)
Date:   Thu, 29 Sep 2022 09:11:17 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, intel-gvt-dev@lists.freedesktop.org
Subject: Re: simplify the mdev interface v8
Message-ID: <20220929071117.GA32553@lst.de>
References: <20220923092652.100656-1-hch@lst.de> <20220927140737.0b4c9a54.alex.williamson@redhat.com> <20220927155426.23f4b8e9.alex.williamson@redhat.com> <20220928121110.GA30738@lst.de> <20220928125650.0a2ea297.alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928125650.0a2ea297.alex.williamson@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Sep 28, 2022 at 12:56:50PM -0600, Alex Williamson wrote:
> That fixes the crash, but available_instances isn't working:

I see the same behavior both with and without my series.  Given that
the code to report it didn't change that is also very much expected.

So something in i915 fails to update the resources when deleting
instances, but it is an existing issue.
