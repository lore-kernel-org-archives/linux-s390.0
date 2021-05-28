Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5D4C4707F
	for <linux-s390@archiver.kernel.org>; Fri, 28 May 2021 00:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA47A613BA
	for <linux-s390@archiver.kernel.org>; Fri, 28 May 2021 00:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbhE1AZ5 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 27 May 2021 20:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbhE1AZ5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 27 May 2021 20:25:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EFFC061574;
        Thu, 27 May 2021 17:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=rlpGn++d9tstEjDDHdqw3SW5bi3c66Txwye4h8Wez14=; b=waOZezbtkVwHCYhEn2aNH/3u5J
        PHQwZ7V5EoXl2Cb6KjaZpkCgxXjabD88x0fFvzgI0fDVCm/CImtxRIpoCA/Av1ObaZ3yuJNVh3wb0
        VUBAYnrJzFEGO1202+dHTjWrbZkAv/6b524oT9yPSm2bF2KZ8uLMpP7IRO/26NbeFxyQ9W/7epLNb
        vqfXyVc3UO2r26f9EM4wsq79o6J813JQjVNiy/MvG/T3t+OBif9Rdn0wfXNe+q8axm1W+EI150ndQ
        jx+tAaVzKHeVfQeQOFSgBwbznkFcdB+C5mJ1T3MTffKHvevULjXKNTsz2L75x1O3VsWrO5ileZ0BM
        ey7nXToA==;
Received: from [2601:1c0:6280:3f0::ce7d] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lmQIY-00AYmZ-Kb; Fri, 28 May 2021 00:24:22 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH] S390: appldata depends on PROC_SYSCTL
Date:   Thu, 27 May 2021 17:24:20 -0700
Message-Id: <20210528002420.17634-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

APPLDATA_BASE should depend on PROC_SYSCTL instead of PROC_FS.
Building with PROC_FS but not PROC_SYSCTL causes a build error,
since appldata_base.c uses data and APIs from fs/proc/proc_sysctl.c.

arch/s390/appldata/appldata_base.o: in function `appldata_generic_handler':
appldata_base.c:(.text+0x192): undefined reference to `sysctl_vals'

Fixes: c185b783b099 ("[S390] Remove config options.")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org
---
 arch/s390/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20210526.orig/arch/s390/Kconfig
+++ linux-next-20210526/arch/s390/Kconfig
@@ -853,7 +853,7 @@ config CMM_IUCV
 config APPLDATA_BASE
 	def_bool n
 	prompt "Linux - VM Monitor Stream, base infrastructure"
-	depends on PROC_FS
+	depends on PROC_SYSCTL
 	help
 	  This provides a kernel interface for creating and updating z/VM APPLDATA
 	  monitor records. The monitor records are updated at certain time
