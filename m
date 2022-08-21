Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B82C00140
	for <linux-s390@archiver.kernel.org>; Sun, 21 Aug 2022 07:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiHUHFp (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 21 Aug 2022 03:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiHUHFo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 21 Aug 2022 03:05:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73B9F32;
        Sun, 21 Aug 2022 00:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=c/jrfAPZ5uKkxcDwWOy7Ka9+HHLqiSxehrttZm3hA/Y=; b=ybuNNkflPH7tbvDDltPJb+xko4
        r5yfhRLO4SQw6ISzt0vZrQllqdGDNelLKvMenkvn28QaUnx9crNeUYM88rQHXtmQp0sBe15pfCLT6
        R8a9y6Cnx0V8nDPSQP57/kSiQZpuOCdvFUTkrMQHqTUvcM0quxPaYKl5+zWfob7Rdv7nWvKm8TKAz
        nEabX3Khe4YjLusuoJjlT/0R3w2Q62E91ONDG+6BB53sTiUObyE40GdVIb6AJvjAPjVjQX3Yr+7fR
        dXGaZLjnYmUUPHS+65FUfdQz5FQQKcD0C5+ZTG4a+IoG+DCpDqa8OMHBVfnxkLWS9jpcYtijUepdx
        ZR3t3Tzw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oPf1i-0077qS-9B; Sun, 21 Aug 2022 07:05:42 +0000
Date:   Sun, 21 Aug 2022 00:05:42 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hch@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        linux-arm-kernel@lists.infradead.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 09/11] s390: mm: Convert to GENERIC_IOREMAP
Message-ID: <YwHZRhpwL37yLb/o@infradead.org>
References: <20220820003125.353570-1-bhe@redhat.com>
 <20220820003125.353570-10-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220820003125.353570-10-bhe@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

> +void __iomem *
> +arch_ioremap(phys_addr_t *paddr, size_t size, unsigned long *prot_val)
>  {
>  	if (!static_branch_unlikely(&have_mio))
> +		return (void __iomem *) *paddr;
> +	return NULL;

This logic isn't new in the patch, but it could really use a comment
as it is rather non-obvious.
