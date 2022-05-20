Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AA8C433F5
	for <linux-s390@archiver.kernel.org>; Fri, 20 May 2022 05:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345596AbiETFdq (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 20 May 2022 01:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243365AbiETFdp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 20 May 2022 01:33:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53511F137D;
        Thu, 19 May 2022 22:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=iTRcYTOvhEdVV51lLDf6QZYcjj
        FcqmaXZnopcFHUJw9Dh/KCjy4JXxOX3g6wOK7BWkoPbuqAEOMh9lmKWSSa/lbfHOAo6WDGbEc0eJu
        GvXENhFDPGBOT3j8PhAvYulPs1/uB7pCAKWtd4PsRD+h/GR73uZi7ZvQE/+pRPIScsIfknh+XPkit
        bxGvFELHkQnZ2mbuoNLoz3Dogoue0FU4lc1t94t85qnQrvvrWJenQF3chMlGiDC0Fp/y9LdSGhaxf
        6FBrmE6lR/sCBYCQmIkaxAB0som6zb5Vtd1s3Y2pnjF+D2q2JAy/HLGY+s23cr/2UyZ8mVnw7rdXN
        +zEA27mg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrvGb-00AciW-D8; Fri, 20 May 2022 05:33:37 +0000
Date:   Thu, 19 May 2022 22:33:37 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Rosato <mjrosato@linux.ibm.com>
Cc:     jgg@nvidia.com, alex.williamson@redhat.com, cohuck@redhat.com,
        borntraeger@linux.ibm.com, jjherne@linux.ibm.com,
        akrowiak@linux.ibm.com, pasic@linux.ibm.com,
        zhenyuw@linux.intel.com, zhi.a.wang@intel.com, hch@infradead.org,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kevin Tian <kevin.tian@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 1/1] vfio: remove VFIO_GROUP_NOTIFY_SET_KVM
Message-ID: <YocoMdqLv0s3GV2f@infradead.org>
References: <20220519183311.582380-1-mjrosato@linux.ibm.com>
 <20220519183311.582380-2-mjrosato@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519183311.582380-2-mjrosato@linux.ibm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
