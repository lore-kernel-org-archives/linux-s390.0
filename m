Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837D4C43219
	for <linux-s390@archiver.kernel.org>; Mon,  9 May 2022 06:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbiEIGqa (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 9 May 2022 02:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235520AbiEIGgK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 May 2022 02:36:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6933142836;
        Sun,  8 May 2022 23:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=jDAHALn3z0Emv+RGmX479eTK4G
        TkPNPwyX6ucjzOI85+8H3QueAzXGbLUYDfEaUHHVsbZU/e0hr1Lz5vXKUYhR7P+cl+7ZL12iDj6Y5
        OkOaOgHGZDQCx4NrGi7cbp/uecHLpDTMZqNd54+eNuluCp93IsXuau33dF9WDqqvECfh/pBWHktN5
        H64KFA8elJFZUtTvkUZPQfodC94Gu76Tv121FTsCCfmYmcht3AXwhyx1oM48WCaP3EOI2k4IIGMA4
        DAfYiU10yoTxDec4sp6qN+OfqhCT06RbgLPuydxhAf7Na+/KLsXuOktEYqlZSkyuPfaXFRejdTgEE
        8bFe3qVQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnwve-00Ch7b-DM; Mon, 09 May 2022 06:31:34 +0000
Date:   Sun, 8 May 2022 23:31:34 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, x86@kernel.org,
        linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Oleksandr Tyshchenko <olekstysh@gmail.com>
Subject: Re: [PATCH v3 2/2] virtio: replace
 arch_has_restricted_virtio_memory_access()
Message-ID: <Yni1RtXtEQPwD5NZ@infradead.org>
References: <20220504155703.13336-1-jgross@suse.com>
 <20220504155703.13336-3-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504155703.13336-3-jgross@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
