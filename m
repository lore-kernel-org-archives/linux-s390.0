Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21027C433EF
	for <linux-s390@archiver.kernel.org>; Wed,  6 Jul 2022 06:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiGFG5M (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 6 Jul 2022 02:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiGFG5L (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 Jul 2022 02:57:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB091D0D5;
        Tue,  5 Jul 2022 23:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=nqKbk1UlEewvZP+vqUJW8uTo8i
        ZudlE5mJHs0GiUKJzeWrxuJLt1S0VH6qI4pXliPMFL8PRZBpw/xHTiurL8AVISlyOdyyoglpcG4r2
        NZz7H5iFDgsxHbtzF1QGEnA3O4PyOa50x2Eq9aTnCR9QLFlkqY0unaTxBeki417LyDI+j93M8+uDX
        qO0J3gGGRdgFSL/IVBFHNnQM5c+VJnkXR/RvdzbkSP8pICPfEPjgKpCBafV8ctXvQHiL2H9Vbr1Al
        5Ohz/6aUmBkaN/K4f3bthIE0T3bZlNp2xP66HEC5CVuUkWW2p9Nli3DPyQ8l3BTmd19sby4ECXWzn
        6RIGsQ4Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8yy7-006s5y-Jq; Wed, 06 Jul 2022 06:57:03 +0000
Date:   Tue, 5 Jul 2022 23:57:03 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     kwankhede@nvidia.com, corbet@lwn.net, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        zhenyuw@linux.intel.com, zhi.a.wang@intel.com,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@linux.ie, daniel@ffwll.ch, farman@linux.ibm.com,
        mjrosato@linux.ibm.com, pasic@linux.ibm.com, vneethv@linux.ibm.com,
        oberpar@linux.ibm.com, freude@linux.ibm.com,
        akrowiak@linux.ibm.com, jjherne@linux.ibm.com,
        alex.williamson@redhat.com, cohuck@redhat.com, jgg@nvidia.com,
        kevin.tian@intel.com, hch@infradead.org, jchrist@linux.ibm.com,
        kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [RFT][PATCH v2 7/9] vfio: Rename user_iova of vfio_dma_rw()
Message-ID: <YsUyP8zcjtaMp5y1@infradead.org>
References: <20220706062759.24946-1-nicolinc@nvidia.com>
 <20220706062759.24946-8-nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706062759.24946-8-nicolinc@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
