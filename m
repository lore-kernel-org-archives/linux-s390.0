Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B29AC433EF
	for <linux-s390@archiver.kernel.org>; Tue,  5 Oct 2021 05:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F93361222
	for <linux-s390@archiver.kernel.org>; Tue,  5 Oct 2021 05:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhJEFSw (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 5 Oct 2021 01:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbhJEFSs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 Oct 2021 01:18:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD91C061745
        for <linux-s390@vger.kernel.org>; Mon,  4 Oct 2021 22:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=pDHDPRb1cV5wLjHf0HUfnEwHldmE44D4P4bF7kopTGE=; b=Fkq6CHQ4R3OWyJ6XNRWS31bF3H
        Yf492U9uvyfNN7Eaex9jhzkybH2Q5UmHHWzXtn7hVg4qRQOxQAMZhsw80rmKDLU+Tl4rBgdJUL4x5
        8uLo+yTwhUU83akRS/jxnTF0xlNDqpi97L8nCYIyC4Dvzp0XGL4jSjUtgk8h1ZNSKp5HDWWKtfEgn
        1eOEtxR/bPg9yqX4fTlUQOSe5x/w+whn9a+XEimfzGX+rJtiUraJENxgkapxO8t9qVM6pZ8tl+142
        0HqHnYbS2TVpmEpzTGLPagu3WgCyUttkNvW5Vf6skJBamOSuez7gud6xLjsuSkzzfW2/BwVaJJ1dw
        rnOiL7+Q==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXcp0-008xFc-E9; Tue, 05 Oct 2021 05:16:58 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Subject: [PATCH] s390/debug: fix kernel-doc warnings
Date:   Mon,  4 Oct 2021 22:16:57 -0700
Message-Id: <20211005051657.16714-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Fix kernel-doc warning due to incorrect parameter name in
kernel-doc function notation:

../arch/s390/include/asm/debug.h:484: warning: Function parameter or member 'pages' not described in 'DEFINE_STATIC_DEBUG_INFO'
../arch/s390/include/asm/debug.h:484: warning: Excess function parameter 'pages_per_area' description in 'DEFINE_STATIC_DEBUG_INFO'

Fixes: d72541f94512 ("s390/debug: add early tracing support")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
---
 arch/s390/include/asm/debug.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-515-rc4.orig/arch/s390/include/asm/debug.h
+++ lnx-515-rc4/arch/s390/include/asm/debug.h
@@ -462,7 +462,7 @@ arch_initcall(VNAME(var, reg))
  *
  * @var: Name of debug_info_t variable
  * @name: Name of debug log (e.g. used for debugfs entry)
- * @pages_per_area: Number of pages per area
+ * @pages: Number of pages per area
  * @nr_areas: Number of debug areas
  * @buf_size: Size of data area in each debug entry
  * @view: Pointer to debug view struct
