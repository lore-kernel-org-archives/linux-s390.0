Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6EA0C433EF
	for <linux-s390@archiver.kernel.org>; Fri, 29 Oct 2021 00:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3CD96103B
	for <linux-s390@archiver.kernel.org>; Fri, 29 Oct 2021 00:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhJ2A3D (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 28 Oct 2021 20:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhJ2A3D (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 28 Oct 2021 20:29:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40CBC061570;
        Thu, 28 Oct 2021 17:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=UveeGpRLd5fGY8r9sRKn/+epHdsqzILjhPdQR1yYPFs=; b=4pfK0r5VWKZeMqkQzaVcqy5dnJ
        EsS6+yw1M0W7eITgqAH9AYTp09xC2WfgGpqPv8ARBih1apWjCPQIzELJKD/EfcyQ0k1Q99LhNT8xm
        tT5P8+9F1dQ/0GrDF6Mtp8BvBDS4xFyBW8Fvw4omuipqkIC5+mf3grfIJdlUpRqf/oeJMusALXF3L
        DjPSDcBeOK3R1WuFxVO2fQEoYUZDcprICblegZyGunyWmX8f702Pmmuy9OmHNSAKgVtWwpeIGsEeF
        EzaOu5I1zhp5/1ij3VqWYD6Xa7hD0+hhqPWKTFV4nHN0xFcRiobS37gs1On5i88Pc0Ou8dPVdTr+Z
        KQufX/oQ==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mgFj8-009NDe-26; Fri, 29 Oct 2021 00:26:34 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH] s390: add <linux/minmax.h> to <asm/facility.h>
Date:   Thu, 28 Oct 2021 17:26:33 -0700
Message-Id: <20211029002633.31323-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

S390's <asm/facility.h> uses the min_t() macro, so it should
include <linux/minmax.h> to avoid build errors.

In file included from arch/s390/pci/pci_insn.c:12:
arch/s390/include/asm/facility.h: In function '__stfle':
arch/s390/include/asm/facility.h:98:22: error: implicit declaration of
function 'min_t' [-Werror=implicit-function-declaration]
   98 |                 nr = min_t(unsigned long, (nr + 1) * 8, size * 8);
arch/s390/include/asm/facility.h:98:28: error: expected expression
before 'unsigned'
   98 |                 nr = min_t(unsigned long, (nr + 1) * 8, size * 8);


Fixes: 4f18d869ffd0 ("s390: fix stfle zero padding")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org
---
 arch/s390/include/asm/facility.h |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20211028.orig/arch/s390/include/asm/facility.h
+++ linux-next-20211028/arch/s390/include/asm/facility.h
@@ -9,6 +9,7 @@
 #define __ASM_FACILITY_H
 
 #include <asm/facility-defs.h>
+#include <linux/minmax.h>
 #include <linux/string.h>
 #include <linux/preempt.h>
 #include <asm/lowcore.h>
