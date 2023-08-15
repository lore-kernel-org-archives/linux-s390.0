Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA6EC0015E
	for <linux-s390@archiver.kernel.org>; Tue, 15 Aug 2023 08:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjHOIJJ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 15 Aug 2023 04:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235543AbjHOII4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 15 Aug 2023 04:08:56 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F12E1733
        for <linux-s390@vger.kernel.org>; Tue, 15 Aug 2023 01:08:53 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RQ3lm2ByHz1GDdB;
        Tue, 15 Aug 2023 16:07:32 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 15 Aug
 2023 16:08:50 +0800
From:   Li Zetao <lizetao1@huawei.com>
To:     <schnelle@linux.ibm.com>, <gerald.schaefer@linux.ibm.com>,
        <hca@linux.ibm.com>, <gor@linux.ibm.com>, <agordeev@linux.ibm.com>,
        <borntraeger@linux.ibm.com>, <svens@linux.ibm.com>
CC:     <lizetao1@huawei.com>, <linux-s390@vger.kernel.org>
Subject: [PATCH -next] s390/pci: Use builtin_misc_device macro to simplify the code
Date:   Tue, 15 Aug 2023 16:08:33 +0800
Message-ID: <20230815080833.1103609-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Use the builtin_misc_device macro to simplify the code, which is the same
as declaring with device_initcall().

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 arch/s390/pci/pci_clp.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/s390/pci/pci_clp.c b/arch/s390/pci/pci_clp.c
index ee367798e388..ee90a91ed888 100644
--- a/arch/s390/pci/pci_clp.c
+++ b/arch/s390/pci/pci_clp.c
@@ -666,9 +666,4 @@ static struct miscdevice clp_misc_device = {
 	.fops = &clp_misc_fops,
 };
 
-static int __init clp_misc_init(void)
-{
-	return misc_register(&clp_misc_device);
-}
-
-device_initcall(clp_misc_init);
+builtin_misc_device(clp_misc_device);
-- 
2.34.1

