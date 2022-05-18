Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33655C433F5
	for <linux-s390@archiver.kernel.org>; Wed, 18 May 2022 07:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbiERHj5 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 18 May 2022 03:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbiERHjy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 18 May 2022 03:39:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9C0106A47;
        Wed, 18 May 2022 00:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=P5UqBAHM0WQnE0g9GWkUw6qeNdkfJBe6hJymXR6R360=; b=zP2u3zx4Nqx82fjyBoNHLz6AOY
        fHpXQJ24sWyjJtbHiAfCUHkKqWlu+/N5+S0QbL3dxp8min4ZnwWiMdlFcvfoW1l3rHL6lvSU8JyPu
        tI3TV57NNnj4Bq/keqxZOTeeF9+9ZA4sWjS7BtUPWhT9DC+xFJLcsYPpuaji0p2/Oxwir7jvsuX/U
        y9dpkmCJOjq2ER5XK5/faIeJxiQU9bZ+mnUsplo/ChCMm+unL1KWLS94bBjJDlzxjHqeD1l6dxzdJ
        VudQgLy9jb8GOsrg3Fazw16gK5iNYGZFgwlNxo8CYGkPD+FAuZ8uZSZp9jKMhuX8XVLWsUSQokF10
        K34xQl0g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrEHV-00084D-Sx; Wed, 18 May 2022 07:39:41 +0000
Date:   Wed, 18 May 2022 00:39:41 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>,
        alex.williamson@redhat.com, cohuck@redhat.com,
        borntraeger@linux.ibm.com, jjherne@linux.ibm.com,
        akrowiak@linux.ibm.com, pasic@linux.ibm.com,
        zhenyuw@linux.intel.com, zhi.a.wang@intel.com, hch@infradead.org,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] vfio: remove VFIO_GROUP_NOTIFY_SET_KVM
Message-ID: <YoSivTU7nivO9FMD@infradead.org>
References: <20220517180851.166538-1-mjrosato@linux.ibm.com>
 <20220517180851.166538-2-mjrosato@linux.ibm.com>
 <20220517185643.GY1343366@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517185643.GY1343366@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

>  	if (device->ops->flags & VFIO_DEVICE_NEEDS_KVM)
>  	{

Nit: this is not the normal brace placement.

But what is you diff against anyway?  The one Matthew sent did away
with the VFIO_DEVICE_NEEDS_KVM flags, which does the wrong thing for
zpci, so it can't be that..

Also if we want to do major code movement, it really needs to go into
a separate patch or patches, as the combinations of all these moves
with actual code changes is almost unreadable.
