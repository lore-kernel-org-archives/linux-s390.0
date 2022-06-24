Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0C0CCA480
	for <linux-s390@archiver.kernel.org>; Fri, 24 Jun 2022 05:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiFXFIw (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 24 Jun 2022 01:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiFXFIv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 24 Jun 2022 01:08:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B2F2A725;
        Thu, 23 Jun 2022 22:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=4bN1q5MSAmhJBVSkMIF1AEFBH6
        osYQjeZT9Gm0eNWvIbr6B5A/hfaU7gDlqGDQvFES8oJLhbDSSPdBVAor+f7KOu2jd+T9PRseXXMG/
        B1jAfzmeEKECOOhsQCVHYgtA+0hlcZt5rHStrIJcKwF1UBeCpWbKKklcsctJ9/DgWVM2Aqo5ITIL7
        17jxscatHbqSMl+uzXLGWcirWTk7/WN3VPgeGrh+4kuVJzRZnIticTFn9dPhbXjUiW9uBbgpXoECi
        zqJmt28nR7/TwYIBVozsSEQPahUuBKL1P7p8RimKEZzD9F8c0vlY8PJvBsKm4xpBLhXNk5V+tyCpS
        c/6nVhbg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o4bYc-000Ths-6G; Fri, 24 Jun 2022 05:08:38 +0000
Date:   Thu, 23 Jun 2022 22:08:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, hch@infradead.org, christophe.leroy@csgroup.eu,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        x86@kernel.org, openrisc@lists.librecores.org,
        linux-xtensa@linux-xtensa.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-um@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 01/26] mm/mmap: Build protect protection_map[] with
 __P000
Message-ID: <YrVG1hohcGD56pwV@infradead.org>
References: <20220624044339.1533882-1-anshuman.khandual@arm.com>
 <20220624044339.1533882-2-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624044339.1533882-2-anshuman.khandual@arm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
